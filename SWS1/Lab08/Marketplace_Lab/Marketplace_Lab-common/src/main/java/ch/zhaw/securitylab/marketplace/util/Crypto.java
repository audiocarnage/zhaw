package ch.zhaw.securitylab.marketplace.util;

import com.lambdaworks.crypto.SCrypt;
import com.lambdaworks.crypto.SCryptUtil;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import javax.xml.bind.DatatypeConverter;

public class Crypto {

    private static final int SCRYPT_N = 16384;
    private static final int SCRYPT_R = 8;
    private static final int SCRYPT_P = 1;
    private static final int SCRYPT_LENGTH = 32;
    private static final SecureRandom PRNG = new SecureRandom();

    public static String createAuthenticationToken() {
        byte[] token = new byte[16];
        PRNG.nextBytes(token);
        return DatatypeConverter.printHexBinary(token);
    }

    public static String computeSHA256(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(input.getBytes());
            return DatatypeConverter.printHexBinary(md.digest());
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }

    public static String createScryptHash(String password) {
        return SCryptUtil.scrypt(password, SCRYPT_N, SCRYPT_R, SCRYPT_P);
    }

    public static String computeScryptHash(String password, String saltBase64) {
        try {
            byte[] hash = SCrypt.scrypt(password.getBytes(),
                    Base64.getDecoder().decode(saltBase64),
                    SCRYPT_N, SCRYPT_R, SCRYPT_P, SCRYPT_LENGTH);
            return Base64.getEncoder().encodeToString(hash);
        } catch (GeneralSecurityException e) {
            return null;
        }
    }
    
    public static String getScryptSalt(String scryptHash) {
        return scryptHash.split("\\$")[3];
    }
    
    public static String getScryptHash(String scryptHash) {
        return scryptHash.split("\\$")[4];
    }

    public static void main(String argv[]) {
        System.out.println("scrypt hash of '" + argv[0] + "': " + createScryptHash(argv[0]));
    }
}
