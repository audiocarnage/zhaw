package ch.zhaw.securitylab.tlstester;

/**
 * This class tests if a cipher suite is secure or insecure.
 * For a cipher suite to be secure, the following should apply:
 * • Length of the symmetric key is at least 128 bits (3DES is OK as well).
 * • The server must authenticate itself.
 * • RC4 should be considered as an insecure cipher.
 * • MD5 should be considered as an insecure hash function.
 * 
 * @author Rémi Georgiou
 * @version 1.0, November 2016
 */
public class CipherSuiteClassifier {
    private final int SECURE_SECRET_KEY_LENGTH = 128;
    
    public boolean isSecure(String cipherSuite) {
          return ((is3DES(cipherSuite) || isSecureSecretKeyLength(cipherSuite))
                && !isMD5(cipherSuite) && !isRC4(cipherSuite)
                  && !isAnonymous(cipherSuite));
    }
    
    private boolean isSecureSecretKeyLength(String cipherSuite) {
        String[] numbers = cipherSuite.trim().split("[A-Z_]+");
        for (String number : numbers) {
            char[] charArray = number.toCharArray();
            for (char c : charArray) {
                if (Character.isDigit(c)) {
                    return Integer.parseInt(number) >= SECURE_SECRET_KEY_LENGTH;        
                }
            }
        }
        return false;
    }
    
    private boolean is3DES(String cipherSuite) {
        return cipherSuite.toUpperCase().contains("3DES");
    }
    
    private boolean isRC4(String cipherSuite) {
        return cipherSuite.toUpperCase().contains("RC4");
    }
    
    private boolean isMD5(String cipherSuite) {
        return cipherSuite.toUpperCase().contains("MD5");
    }
    
    /*
        No authentication is performed, no certificates are exchanged --> RISK!
    */
    private boolean isAnonymous(String cipherSuite) {
        return cipherSuite.toUpperCase().contains("ANON");
    }
    
    private boolean isExport(String cipherSuite) {
        return cipherSuite.toUpperCase().contains("EXPORT");
    }
}
