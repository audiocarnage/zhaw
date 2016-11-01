package ch.zhaw.securitylab.simplewebserver;

import java.io.*;
import java.net.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SimpleWebServer {

    // Run the HTTP server on this TCP port
    private static final int PORT = 8080;

    // Some HTTP status messages
    private static final String STATUS_200 = "HTTP/1.0 200 OK\n\n";
    private static final String STATUS_201 = "HTTP/1.0 201 Created\n\n";
    private static final String STATUS_400 = "HTTP/1.0 400 Bad Request\n\n";
    private static final String STATUS_403 = "HTTP/1.0 403 Forbidden\n\n";
    private static final String STATUS_404 = "HTTP/1.0 404 Not Found\n\n";
    private static final String STATUS_500 = "HTTP/1.0 500 Internal Error\n\n";
    private static final String STATUS_501 = "HTTP/1.0 501 Not Implemented\n\n";

    // The maximum length for requests and downloaded files
    private static final int MAX_REQUEST_LENGTH = 8192;
    private static final int MAX_DOWNLOAD_LENGTH = 10000000;

    // The directory that contains the web resources
    private static final String WEBROOT = "data";

    // The upload directory
    private static String UPLOAD_DIR = "upload";

    // The socket used to process incoming connections from web clients
    private static ServerSocket dServerSocket;

    /* Constructor */
    public SimpleWebServer() throws IOException {
        dServerSocket = new ServerSocket(PORT);
    }

    /* This method starts the actual web server */
    private void run() throws IOException {
        while (true) {

            // Wait for a connection from a client
            Socket s = dServerSocket.accept();

            // Process the client's request
            processRequest(s);
        }
    }

    /* Reads the HTTP request from the client and responds with the file
    the user requested or a HTTP error code. */
    private void processRequest(Socket s) throws IOException {

        // Used to read data from the client
        BufferedReader br = new BufferedReader(
                new InputStreamReader(s.getInputStream()));

        // Read the HTTP request from the client
        /*
            covers DoS attack with long request (5)
            read up to MAX_REQUEST_LENGTH bytes
            
            this code fails:
            String request = br.readLine();
        */
        char[] buf = new char[MAX_REQUEST_LENGTH];
        br.read(buf, 0, MAX_REQUEST_LENGTH);
                        
        if (buf[0] == '\0') {

            // Apparently, the client disconnected without sending anything, return
            return;
        }
        
        String request = String.valueOf(buf);
        
        System.out.println(request);

        // Used to write data to the client
        OutputStreamWriter osw
                = new OutputStreamWriter(s.getOutputStream());

        // Parse the HTTP request
        String command = null;
        String pathname = null;
        String[] tokens = request.split(" ");
        
        System.out.println("tokens length: " + tokens.length);
        System.out.println("content tokens array: " + Arrays.asList(tokens));
        
        /*
            covers attacks:
            DoS attack with empty request (3) and 
            DoS attack with malformed request (4)
            => return status bad request
        */
        
        if (tokens.length <= 1)
            osw.write(STATUS_400);
        else {
            command = tokens[0];
            pathname = tokens[1];
            
            System.out.println("command: " + command);
            System.out.println("pathname: " + pathname);
            System.out.println("pathname length: " + pathname.length());
            
            if (pathname.charAt(0) < 0x21)
                osw.write(STATUS_400);
            else {
                /* If the request is a GET, try to respond with the file
                   the user is requesting. If it's a PUT, store the file. */
                if (command.equals("GET")) {
                    serveFile(osw, pathname);
                } else if (command.equals("PUT")) {
                    storeFile(br, osw, pathname);
                } else {
                    /* If the request is neither GET nor PUT, return an error saying 
                       this server does not implement the requested command */
                    osw.write(STATUS_501);
                }
            }
        }
    
        // Close the connection to the client
        osw.close();
    }

    /* serveFile is used to return a requested resource */
    private void serveFile(OutputStreamWriter osw,
            String pathname) throws IOException {
        FileReader fr = null;
        StringBuilder sb = new StringBuilder();
        
        // Remove the initial slash at the beginning of the pathname in the request
        if (pathname.charAt(0) == '/') {
            pathname = pathname.substring(1);
        }

        // If there was no filename specified by the client, serve the "index.html" file
        if (pathname.equals("")) {
            pathname = "index.html";
        }

        // Make sure that the file is read from the webroot directory
        pathname = WEBROOT + "/" + pathname;
        
        /* Return status 404 if the path of the requested resource 
           isn't below the the webroot path. No subdirectory necessary. */
        if (!checkPath(pathname, null)) {
            osw.write(STATUS_404);
            return;
        }      

        // Try to open file specified by pathname
        try {
            fr = new FileReader(pathname);
            /*
                covers DoS attack by requesting an overly large resource (6)
                read one byte at a time, but not more than
                MAX_DOWNLOAD_LENGTH bytes.
            */
            int c = fr.read();
            while (c != -1 && sb.length() < MAX_DOWNLOAD_LENGTH) {
                sb.append((char) c);
                c = fr.read();
            }           
            
            /* If the requested file can be successfully opened and read, then 
                return an OK response code and send the contents of the file */
            if (sb.length() > 0) {
                osw.write(STATUS_200);
                osw.write(sb.toString());
            } else {
                // If the file is not found, return the appropriate HTTP response code
                osw.write(STATUS_400);
            }
        } catch (Exception e) {
            // If the file is not found, return the appropriate HTTP response code
            osw.write(STATUS_404);
        } finally {
            if (fr != null)
                fr.close();
        }
        
    }

    /* storeFile is used to store a resource */
    private void storeFile(BufferedReader br, OutputStreamWriter osw,
            String pathname) throws IOException {
        FileWriter fw = null;

        // Remove the initial slash at the beginning of the pathname in the request
        if (pathname.charAt(0) == '/') {
            pathname = pathname.substring(1);
        }
        
        System.out.println(pathname);

        /* If there was no filename specified by the client, store the file 
        with file name default */
        if (pathname.equals("")) {
            pathname = "default";
        }
        
        /* Make sure that the file is written below the webroot directory */
        pathname = WEBROOT + "/" + UPLOAD_DIR + "/" + pathname;
        
                
        /* Return status 403 Forbidden if an attempt to write a resource
           that is not below webroot/subdir is made. 
           A subdirectory must be specified; do not write data to webroot. */
        if (!checkPath(pathname, UPLOAD_DIR)) {
            osw.write(STATUS_403);
            return;
        }

        // Try to write the file
        try {
            fw = new FileWriter(pathname);

            // Absorb input until there's an empty line
            String s = br.readLine();
            while ((s != null) && (!s.equals(""))) {
                s = br.readLine();
            }

            // Read file content
            s = br.readLine();
            while ((s != null) && (!s.equals(""))) {
                fw.write(s + "\n");
                s = br.readLine();
            }
            fw.close();
            osw.write(STATUS_201);
        } catch (Exception e) {
            osw.write(STATUS_500);
        }
    }
    
    /**
	 * Covers attacks Directory traversal (7) and Website defacement (8)
	 * 
     * Checks if the submitted pathname is below the webroot.
     * 
     * @param pathname the pathname in the client request
     * @param subdir the legitimate subdir of webroot, e.g. upload subdirectory
     * @return boolean true if specified pathname is below webroot
     */ 
    private boolean checkPath(String pathname, String subdir) {
        /* Get the absolute path of the user's current working directory.
           Returns the pathname where the JVM was started. */
        String wd = System.getProperty("user.dir");
        wd = appendSlashToDirectory(wd);
        wd += WEBROOT + "/";
        
        if (subdir != null && !subdir.equals("")) {
            wd += subdir;
            wd = appendSlashToDirectory(wd);
        }
                
        System.out.println("current working dir: " + wd);
        
        /* Creates a File object (file handle) from the specified pathname
           that represents the pathname (client's resource request)
           relative to the current working directory.
           Make sure that the file is written below the webroot directory */
        File file = new File(pathname);
        String normalisedPathname = "";
        
        try {
            /* Get the absolute and normalised pathname of the File object.
               This is the absolute pathname of the resource requested by 
               the client. */
            normalisedPathname = file.getCanonicalPath();
            
            System.out.println("normalised path: " + normalisedPathname);
        } catch (IOException ex) {
            Logger.getLogger(SimpleWebServer.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        /* The requested resource should be below the webroot */
        if (!normalisedPathname.startsWith(wd))
            return false;
        return true;
    }
    
    /**
     * Checks whether or the pathname ends with the character '/' or not.
     * 
     * @param pathname the pathname to check 
     * @return the pathname
     */
    private String appendSlashToDirectory(String pathname) {
        if (!pathname.equals("") 
                    && pathname.charAt(pathname.length()-1) != '/')
                return String.valueOf(pathname) + "/";
        return pathname;
    }

    /* main method */
    public static void main(String argv[]) throws IOException {

        // Create directories
        File dir = new File(WEBROOT);
        dir.mkdir();
        dir = new File(WEBROOT + "/upload");
        dir.mkdir();
        
        // Create the symbolic link to /dev/urandom
        try {
            Path link = Paths.get(WEBROOT + "/endless_file");
            Path target = Paths.get("/dev/urandom");
            Files.createSymbolicLink(link, target);
        } catch (Exception e) {
            // Ignore
        }

        // Reset index.html
        Path file = Paths.get(WEBROOT + "/index.html");
        Files.write(file, "Hello".getBytes());

        // Create a SimpleWebServer object and run it
        SimpleWebServer sws = new SimpleWebServer();
        sws.run();
    }
}
