package ch.zhaw.securitylab.slcrypt.encrypt;

/**
 * A concrete implementation of the abstract class HybridEncryption.
 */
import java.security.NoSuchAlgorithmException;
import java.io.InputStream;
import ch.zhaw.securitylab.slcrypt.FileHeader;
import ch.zhaw.securitylab.slcrypt.Helpers;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.AlgorithmParameters;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.InvalidParameterSpecException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.Mac;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.ShortBufferException;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class HybridEncryptionImpl extends HybridEncryption {

    /**
     * Creates a secret key.
     *
     * @param cipherAlgorithm The cipher algorithm to use
     * @param keyLength The key length in bits
     * @return The secret key
     */
    @Override
    protected byte[] generateSecretKey(String cipherAlgorithm, int keyLength) {
        try {
            KeyGenerator keygen = KeyGenerator.getInstance(
                    Helpers.getCipherName(cipherAlgorithm));
            SecureRandom random = new SecureRandom();
            keygen.init(keyLength, random);
            return keygen.generateKey().getEncoded();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(HybridEncryptionImpl.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Encrypts the secret key with a public key.
     *
     * @param secretKey The secret key to encrypt
     * @param certificate An input stream from which the certificate with the
     * public key can be read.
     * @return The encrypted secret key
     */
    @Override
    protected byte[] encryptSecretKey(byte[] secretKey, InputStream certificate) {
        try {
            // Read the public key from the certificate input stream
            CertificateFactory cf = CertificateFactory.getInstance("X.509");
            X509Certificate x509 = (X509Certificate) cf.generateCertificate(certificate);
            PublicKey publicKey = x509.getPublicKey();
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            return cipher.doFinal(secretKey);
        } catch (CertificateException | NoSuchAlgorithmException 
                | NoSuchPaddingException | InvalidKeyException 
                | IllegalBlockSizeException | BadPaddingException ex) {
            Logger.getLogger(HybridEncryptionImpl.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Creates a file header object and fills it with cipher and mac algorithms
     * names and an IV.
     *
     * @param cipherAlgorithm The cipher algorithm to use
     * @param macAlgorithm The MAC algorithm to use
     * @param encryptedSecretKey The encrypted secret key
     * @return The new file header object
     */
    @Override
    protected FileHeader generateFileHeader(String cipherAlgorithm, 
            String macAlgorithm, byte[] encryptedSecretKey) {
        FileHeader fh = new FileHeader();
        if (Helpers.isCBC(cipherAlgorithm) || Helpers.isCTR(cipherAlgorithm)
                || Helpers.isGCM(cipherAlgorithm)) {
            byte[] iv = new byte[Helpers.getIVLength(cipherAlgorithm)];
            SecureRandom random = new SecureRandom();
            random.nextBytes(iv);
            fh.setIV(iv);
        } else {
            /* ECB need no IV */
            fh.setIV(new byte[0]);
        }
        
        if (Helpers.isGCM(cipherAlgorithm))
            /* GCM no MAC */
            fh.setMACAlgorithm("");
        else
            fh.setMACAlgorithm(macAlgorithm);
        
        fh.setCipherAlgorithm(cipherAlgorithm);
        fh.setEncryptedSessionKey(encryptedSecretKey);
        return fh;
    }

    /**
     * Encrypts a document with a secret key. If GCM is used, the file header is
     * added as additionally encrypted data.
     *
     * @param document The document to encrypt
     * @param fileHeader The file header that contains information for
     * encryption
     * @param secretKey The secret key used for encryption
     * @return A byte array that contains the encrypted document
     */
    @Override
    protected byte[] encryptDocument(InputStream document, 
            FileHeader fileHeader, byte[] secretKey) {
        ByteArrayOutputStream encryptedDoc = new ByteArrayOutputStream();
        try {
            String cipherAlgo = fileHeader.getCipherAlgorithm();
            SecretKeySpec keySpec = new SecretKeySpec(secretKey, cipherAlgo);
            Cipher cipher = Cipher.getInstance(cipherAlgo);
            
            if (Helpers.isCBC(cipherAlgo) || Helpers.isCTR(cipherAlgo)) {
                // CBC or CTR mode, use an IV
                AlgorithmParameters algoParams = AlgorithmParameters.getInstance(
                        Helpers.getCipherName(cipherAlgo));
                algoParams.init(new IvParameterSpec(fileHeader.getIV()));
                cipher.init(Cipher.ENCRYPT_MODE, keySpec, algoParams);
                
                int blockSize = cipher.getBlockSize();
                byte[] inBlock = new byte[blockSize];
                byte[] outBlock = new byte[blockSize];
                int inLength = 0;
                boolean more = true;
                            
                while (more) {
                    inLength = document.read(inBlock);
                    if (inLength == blockSize) {
                        int outLength = cipher.update(inBlock, 0, blockSize, outBlock);
                        encryptedDoc.write(outBlock, 0, outLength);
                    } else {
                        more = false;
                    }
                }
                
                // Process the final block
                if (inLength > 0)
                    outBlock = cipher.doFinal(inBlock, 0, inLength);
                else
                    outBlock = cipher.doFinal();
                
                encryptedDoc.write(outBlock);
            } else if (Helpers.isGCM(cipherAlgo)) {
                // GCM, use an IV, an auth tag length, and add the file header as additional
                // authenticated data
                GCMParameterSpec gcmParams = new GCMParameterSpec(
                        Helpers.AUTH_TAG_LENGTH, fileHeader.getIV());
                cipher.init(Cipher.ENCRYPT_MODE, keySpec, gcmParams);
                cipher.updateAAD(fileHeader.encode());
                return cipher.doFinal(Helpers.inputStreamToByteArray(document));
            } else {
                // Other modes (e.g. stream ciphers), don't use an IV
                // NOT SUPPORTED !
                cipher.init(Cipher.ENCRYPT_MODE, keySpec);
            }
        } catch (NoSuchAlgorithmException | IOException | ShortBufferException 
                | InvalidKeyException | InvalidAlgorithmParameterException 
                | InvalidParameterSpecException | NoSuchPaddingException 
                | IllegalBlockSizeException | BadPaddingException ex) {
            Logger.getLogger(HybridEncryptionImpl.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
        return encryptedDoc.toByteArray();
    }

    /**
     * Computes the HMAC over a byte array.
     *
     * @param dataToProtect The input over which to compute the MAC
     * @param macAlgorithm The MAC algorithm to use
     * @param password The password to use for the MAC
     * @return The byte array that contains the MAC
     */
    @Override
    protected byte[] computeMAC(byte[] dataToProtect, String macAlgorithm, 
            byte[] password) {
        try {
            /* Only needed if another cipher mode than GCM was used */
            SecretKeySpec keySpec = new SecretKeySpec(password, macAlgorithm);
            Mac mac = Mac.getInstance(macAlgorithm);
            mac.init(keySpec);       
            mac.update(dataToProtect);
            return mac.doFinal();
        } catch (NoSuchAlgorithmException | InvalidKeyException ex) {
            Logger.getLogger(HybridEncryptionImpl.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
