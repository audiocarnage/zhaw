package ch.zhaw.securitylab.slcrypt.decrypt;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.AlgorithmParameters;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.InvalidParameterSpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Arrays;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.Mac;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import ch.zhaw.securitylab.slcrypt.FileHeader;
import ch.zhaw.securitylab.slcrypt.Helpers;
import ch.zhaw.securitylab.slcrypt.InvalidFormatException;

public class HybridDecryptionImpl extends HybridDecryption {

    /**
     * Gets the file header object.
     *
     * @param headerEncryptedDocument The encrypted document, including the file
     * header
     * @return The file header object
     */
    @Override
    protected FileHeader getFileHeader(byte[] headerEncryptedDocument)
            throws InvalidFormatException {
        return new FileHeader(headerEncryptedDocument);
    }

    /**
     * Checks the HMAC over a byte array.
     *
     * @param decryptedDocument The object containing all results
     * @param input The input over which to compute the MAC
     * @param macAlgorithm The MAC algorithm to use
     * @param expectedMAC The expected MAC
     * @return The byte array that contains the MAC
     */
    @Override
    public boolean checkMAC(DecryptedDocument decryptedDocument, byte[] input,
            String macAlgorithm, byte[] expectedMAC, byte[] password) throws InvalidFormatException {
        try {
            SecretKeySpec keySpec = new SecretKeySpec(password, macAlgorithm);
            Mac hmac = Mac.getInstance(keySpec.getAlgorithm());
            hmac.init(keySpec);
            byte[] computedMAC = hmac.doFinal(input);
            decryptedDocument.setMacComp(computedMAC);
            return Arrays.equals(computedMAC, expectedMAC);
        } catch (NoSuchAlgorithmException e) {
            throw new InvalidFormatException("[MAC] No such algorithm: " + e.getMessage());
        } catch (InvalidKeyException e) {
            throw new InvalidFormatException("[MAC] Invalid Key: " + e.getMessage());
        }
    }

    /**
     * Gets the decrypted secret key.
     *
     * @param fileHeader The file header
     * @param privateKey The private key to decrypt the secret key
     * @return The decrypted secret key
     */
    protected byte[] getDecryptedSecretKey(FileHeader fileHeader,
            InputStream privateKey) throws InvalidFormatException {
        try {
            // Read the private key and generate a privateKey object
            ByteArrayOutputStream rawPrivateKey = new ByteArrayOutputStream();
            byte[] buffer = new byte[128];
            for (int len; (len = privateKey.read(buffer)) != -1;) {
                rawPrivateKey.write(buffer, 0, len);
            }
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(rawPrivateKey.toByteArray());
            KeyFactory kf = KeyFactory.getInstance("RSA");
            PrivateKey privKey = kf.generatePrivate(keySpec);

            // Create the RSA cipher with the private key 
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.DECRYPT_MODE, privKey);

            // Decrypt and return the header
            return cipher.doFinal(fileHeader.getEncryptedSecretKey());
        } catch (IOException e) {
            throw new InvalidFormatException("[Private Key] Cannot read: " + e.getMessage());
        } catch (NoSuchAlgorithmException e) {
            throw new InvalidFormatException("[Session Key] No such algorithm: " + e.getMessage());
        } catch (NoSuchPaddingException e) {
            throw new InvalidFormatException("[Session Key] No such padding: " + e.getMessage());
        } catch (InvalidKeySpecException e) {
            throw new InvalidFormatException("[Session Key] Invalid key spec: " + e.getMessage());
        } catch (InvalidKeyException e) {
            throw new InvalidFormatException("[Session Key] Invalid key: " + e.getMessage());
        } catch (IllegalBlockSizeException e) {
            throw new InvalidFormatException("[Session Key] Illegal block size: " + e.getMessage());
        } catch (BadPaddingException e) {
            throw new InvalidFormatException("[Session Key] Bad padding: " + e.getMessage());
        }
    }

    /**
     * Decrypts the document.
     *
     * @param encryptedDocument The document to decrypt
     * @param fileHeader The file header that contains information for
     * encryption
     * @param secretKey The secret key to decrypt the document
     * @return The decrypted document
     */
    protected byte[] decryptDocument(byte[] encryptedDocument,
            FileHeader fileHeader, byte[] secretKey) throws InvalidFormatException {
        try {
            // Get the used cipher and create the Cipher object
            String cipherName = fileHeader.getCipherAlgorithm();
            Cipher cipher = Cipher.getInstance(cipherName);
            SecretKeySpec skeySpec = new SecretKeySpec(secretKey,
                    Helpers.getCipherName(fileHeader.getCipherAlgorithm()));

            // Initialize the cipher, depending on the AES mode
            byte[] iv = fileHeader.getIV();
            if (Helpers.isCBC(fileHeader.getCipherAlgorithm())
                    || Helpers.isCTR(fileHeader.getCipherAlgorithm())) {

                // CBC or CTR mode, use an IV
                AlgorithmParameters algParam = AlgorithmParameters.
                        getInstance(Helpers.getCipherName(fileHeader.getCipherAlgorithm()));
                algParam.init(new IvParameterSpec(iv));
                cipher.init(Cipher.DECRYPT_MODE, skeySpec, algParam);
            } else if (Helpers.isGCM(fileHeader.getCipherAlgorithm())) {

                // GCM, use an IV, an auth tag length, and add the file header as additional
                // authenticated data
                GCMParameterSpec gcmParameters = new GCMParameterSpec(Helpers.AUTH_TAG_LENGTH, iv);
                cipher.init(Cipher.DECRYPT_MODE, skeySpec, gcmParameters);
                cipher.updateAAD(fileHeader.encode());
            } else {

                // Other modes (e.g. stream ciphers), don't use an IV
                cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            }

            // Decrypt the document and return the plaintext
            return cipher.doFinal(encryptedDocument);
        } catch (NoSuchAlgorithmException e) {
            throw new InvalidFormatException("[Document] No such algorithm: " + e.getMessage());
        } catch (InvalidParameterSpecException e) {
            throw new InvalidFormatException("[Document] Invalid parameter spec: " + e.getMessage());
        } catch (NoSuchPaddingException e) {
            throw new InvalidFormatException("[Document] No such padding: " + e.getMessage());
        } catch (InvalidKeyException e) {
            throw new InvalidFormatException("[Document] Invalid key: " + e.getMessage());
        } catch (InvalidAlgorithmParameterException e) {
            throw new InvalidFormatException("[Document] Invalid algorithm parameter: " + e.getMessage());
        } catch (BadPaddingException e) {
            throw new InvalidFormatException("[Document] Bad padding: " + e.getMessage());
        } catch (IllegalBlockSizeException e) {
            throw new InvalidFormatException("[Document] Illegal block size: " + e.getMessage());
        }
    }

}
