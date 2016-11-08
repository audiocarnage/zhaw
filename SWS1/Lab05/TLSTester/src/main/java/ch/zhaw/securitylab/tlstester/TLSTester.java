package ch.zhaw.securitylab.tlstester;

import java.util.List;
import java.util.ArrayList;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.security.interfaces.RSAPublicKey;
import java.util.Iterator;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLHandshakeException;
import javax.net.ssl.SSLPeerUnverifiedException;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

/**
 * This class serves to test SSL/TLS servers.
 *
 * @author Marc Rennhard, Rémi Georgiou
 */
public class TLSTester {

    /* Variables specified via the command line parameters */
    private static String host;
    private static int port;
    private static String trustStore = null;
    private static String password = null;

    /**
     * The run method that executes all tests - Check if the server can be
     * reached - Print the highest TLS version supported by the server - Print
     * the certificate chain including details about the certificates - Check
     * which cipher suite the server supports and list the secure and insecure
     * ones
     *
     * @throws Exception An exception occurred
     */
    private void run() throws Exception {
        TrustManagerFactory tmf = getInitialisedTrustManagerFactory();
        SSLContext sslContext = SSLContext.getInstance("TLSv1.2");
        sslContext.init(null, tmf.getTrustManagers(), null);
        SSLSocketFactory sslSF = (SSLSocketFactory) sslContext.getSocketFactory();
        
        System.out.printf("Check connectivity to %s:%s", host, port);
        SSLSocket sslSocket = (SSLSocket) sslSF.createSocket(host, port);
        System.out.printf(" - OK\n\n");
        
        try {
            sslSocket.startHandshake();
        } catch(SSLHandshakeException e) {
            sslContext.init(null, 
                    new TrustManager[] {new CustomX509TrustManager()}, null);
            sslSF = (SSLSocketFactory) sslContext.getSocketFactory();
            sslSocket = (SSLSocket) sslSF.createSocket(host, port);
        }
        
        SSLSession session = sslSocket.getSession();
        if (isRootCATrusted(tmf, (X509Certificate[]) session.getPeerCertificates()))
            System.out.println("The root CA is trusted\n");
        else
            System.out.println("The root CA is not trusted, ignore root CA checks in this test\n");
        
        printHighestServerSupportedTLSVersion(session);
        printCertificateChain(session);
        printClientSupportedCipherSuites(sslSocket);
        printServerSupportedCipherSuites(getServerSupportedCipherSuites(sslSF, 
                sslSocket.getSupportedCipherSuites()));
    }
    
    private TrustManagerFactory getInitialisedTrustManagerFactory() 
            throws KeyStoreException, IOException, NoSuchAlgorithmException, 
            CertificateException {
        TrustManagerFactory tmf = null;
        if (trustStore == null) {
            // no custom truststore was supplied, therefore use the default one
            tmf = TrustManagerFactory.getInstance("SunX509");
            tmf.init((KeyStore) null);
            System.out.printf("Use default truststore with %s certificates\n\n", 
                    ((X509TrustManager)tmf.getTrustManagers()[0]).
                            getAcceptedIssuers().length);
        } else {
            // use custom truststore
            KeyStore ks = KeyStore.getInstance("JKS");
            ks.load(new FileInputStream(trustStore), password.toCharArray());
            tmf.init(ks);
            System.out.printf("Use specific truststore (%s) with %s certificate(s)\n\n", 
                    trustStore, ((X509TrustManager)tmf.getTrustManagers()[0]).
                            getAcceptedIssuers().length);
        }
        return tmf;
    }
    
    private boolean isRootCATrusted(TrustManagerFactory tmf, 
            X509Certificate[] peerCertificates) throws SSLPeerUnverifiedException {
        for (TrustManager tm : tmf.getTrustManagers()) {
            try {
                if (tm instanceof X509TrustManager) {
                    ((X509TrustManager) tm).checkServerTrusted(peerCertificates, "RSA");
                    return true;
                }
            } catch (CertificateException e) {
                return false;
            }
        }
        return false;
    }
    
    private void printHighestServerSupportedTLSVersion(SSLSession session) {
        System.out.printf("Highest TLS version supported by server: %s\n\n", 
                session.getProtocol());
    }
    
    private void printCertificateChain(SSLSession session) 
            throws SSLPeerUnverifiedException {
        X509Certificate[] certificates = 
                (X509Certificate[]) session.getPeerCertificates();
        System.out.printf("Information about certificates from %s:%s:\n\n", host, port);
        System.out.println(certificates.length + " certificates(s) in chain.\n");
        
        for (int i = certificates.length-1; i >= 0; i--) {
            System.out.printf("Certificate %s:\n", certificates.length - i);
            System.out.println("Subject: " + certificates[i].getSubjectX500Principal());
            System.out.println("Issuer: " + certificates[i].getIssuerX500Principal());
            System.out.printf("Validity: %s - %s\n", 
                    certificates[i].getNotBefore(), 
                    certificates[i].getNotAfter());
            System.out.println("Algorithm: " + certificates[i].getSigAlgName());
            PublicKey publicKey = certificates[i].getPublicKey();
            if (publicKey.getAlgorithm().equals("RSA")) {
                System.out.println("Public key length (modulus): " 
                        + ((RSAPublicKey)publicKey).getModulus().bitLength() 
                        + " bits");
            }
            System.out.println();
        }
    }
    
    private void printClientSupportedCipherSuites(SSLSocket sslSocket) {
        System.out.print("Check supported cipher suites");
        String[] cipherSuites = sslSocket.getSupportedCipherSuites();
        System.out.print(" (test program supports " + cipherSuites.length 
                + " cipher suites)\n");
        for (String suite : cipherSuites)
            System.out.print(".");
        System.out.print(" DONE, " + cipherSuites.length + " cipher suites tested\n");
        System.out.println();
    }
    
    private List<String> getServerSupportedCipherSuites(SSLSocketFactory sslSF, 
            String[] supportedCipherSuites) {
        List<String> serverSupportedCipherSuites = new ArrayList();
        for (String cipherSuite : supportedCipherSuites) {
            try {
                SSLSocket sslSocket = (SSLSocket) sslSF.createSocket(host, port);
                sslSocket.setEnabledCipherSuites(new String[] {cipherSuite});
                sslSocket.startHandshake();
                serverSupportedCipherSuites.add(cipherSuite);
            } catch (Exception ex) {
                
            }
        }
        return serverSupportedCipherSuites;
    }
    
    private void printServerSupportedCipherSuites(List<String> cipherSuites) {
        /*
            Test each cipher suite and classify it in either a
            secure or insecure cipher suite list.
        */
        List<String> secureCipherSuites = new ArrayList();
        List<String> insecureCipherSuites = new ArrayList();
        CipherSuiteClassifier csc = new CipherSuiteClassifier();
        
        for (String suite : cipherSuites) {
            if (csc.isSecure(suite))
                secureCipherSuites.add(suite);
            else
                insecureCipherSuites.add(suite);
        }
        
        if (secureCipherSuites.isEmpty()) {
            System.out.println("No SECURE cipher suites are supported by the server\n");
        } else {
            System.out.printf("The following %s SECURE cipher suites are supported by the server:\n\n",
                    secureCipherSuites.size());
            printCipherSuites(secureCipherSuites);
        }
        
        if (insecureCipherSuites.isEmpty()) {
            System.out.println("No INSECURE cipher suites are supported by the server\n");
        } else {
            System.out.printf("The following %s INSECURE cipher suites are supported by the server:\n\n", 
                    insecureCipherSuites.size());
            printCipherSuites(insecureCipherSuites);
        }
    }
    
    private void printCipherSuites(List<String> cipherSuites) {
        Iterator<String> iter = cipherSuites.iterator();
        while (iter.hasNext())
            System.out.println(iter.next());
        System.out.println();
    }

    /**
     * The main method.
     *
     * @param argv The command line parameters
     * @throws Exception If an exception occurred
     */
    public static void main(String argv[]) throws Exception {

        /* Create a TLSTester object, and execute the test */
        try {
            host = argv[0];
            port = Integer.parseInt(argv[1]);
            if ((port < 1) || (port > 65535)) {
                throw (new Exception());
            }
            if (argv.length > 2) {
                trustStore = argv[2];
                password = argv[3];
            }
        } catch (Exception e) {
            System.out.println("\nUsage: java TLSTester host port {truststore password}\n");
            System.exit(0);
        }
        TLSTester tlst = new TLSTester();
        tlst.run();
    }
}
