package ch.zhaw.securitylab.marketplace.service;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.AlgorithmParameters;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidParameterSpecException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.ShortBufferException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

public class AESCipherService {

    private final static String CIPHER_ALGORITHM = "AES";
    private final static String CIPHER_ALGORITHM_FULL = "AES/CBC/PKCS5Padding";
    private final static String PRNG_ALGORITHM = "SHA1PRNG";
    private final static int BLOCKSIZE = 16;
    private static SecretKeySpec keySpec;

    // Static initializer to read key from file system and set keyspec
    {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(Thread.currentThread().
                    getContextClassLoader().getResourceAsStream("db-key")));
            String hexKey = reader.readLine();
            byte[] byteKey = DatatypeConverter.parseHexBinary(hexKey);
            keySpec = new SecretKeySpec(byteKey, CIPHER_ALGORITHM);
            reader.close();
        } catch (IOException e) {
            // Do nothing
        }
    }
    
    /**
     * Encrypts the plaintext with AES in CBC mode, selecting a random IV.
     * 
     * @param plaintext The plaintext to encrypt
     * @return The IV and ciphertext (concatenated)
     */
    public byte[] encrypt(byte[] plaintext) {
        ByteArrayInputStream inputPlaintext = new ByteArrayInputStream(plaintext);
        ByteArrayOutputStream ciphertext = new ByteArrayOutputStream();
        try {
            SecureRandom rand = new SecureRandom();
            byte[] iv = new byte[BLOCKSIZE];
            rand.nextBytes(iv);
            Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM_FULL);
            AlgorithmParameters algoParams = AlgorithmParameters.getInstance(CIPHER_ALGORITHM);
            algoParams.init(new IvParameterSpec(iv));
            cipher.init(Cipher.ENCRYPT_MODE, keySpec, algoParams);
            
            // prepend IV to ciphertext
            ciphertext.write(iv);
            
            byte[] inBlock = new byte[BLOCKSIZE];
            byte[] outBlock = new byte[BLOCKSIZE];
            int inLength = 0;
            boolean more = true;
                            
            while (more) {
                inLength = inputPlaintext.read(inBlock);
                if (inLength == BLOCKSIZE) {
                    int outLength = cipher.update(inBlock, 0, BLOCKSIZE, outBlock);
                    ciphertext.write(outBlock, 0, outLength);
                } else {
                    more = false;
                }
            }
                
            // Process the final block
            if (inLength > 0)
                outBlock = cipher.doFinal(inBlock, 0, inLength);
            else
                outBlock = cipher.doFinal();
            
            ciphertext.write(outBlock);
        } catch (NoSuchAlgorithmException | NoSuchPaddingException | 
                InvalidParameterSpecException | InvalidKeyException | 
                InvalidAlgorithmParameterException | IOException | 
                ShortBufferException | IllegalBlockSizeException | 
                BadPaddingException ex) {
            Logger.getLogger(AESCipherService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ciphertext.toByteArray();
    }

    /**
     * Decrypts iv_ciphertext with AES in CBC mode.
     * 
     * @param iv_ciphertext The IV and ciphertext (concatenated)
     * @return The plaintext
     */
    public byte[] decrypt(byte[] iv_ciphertext) {
        try {
            // extract the IV and ciphertext
            byte[] iv = new byte[BLOCKSIZE];
            System.arraycopy(iv_ciphertext, 0, iv, 0, BLOCKSIZE);
            byte[] ciphertext = new byte[iv_ciphertext.length - BLOCKSIZE];
            System.arraycopy(iv_ciphertext, BLOCKSIZE, ciphertext, 0, ciphertext.length);
            
            Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM_FULL);
            AlgorithmParameters algoParams = AlgorithmParameters.getInstance(CIPHER_ALGORITHM);
            algoParams.init(new IvParameterSpec(iv));
            cipher.init(Cipher.DECRYPT_MODE, keySpec, algoParams);
            return cipher.doFinal(ciphertext);
        } catch (NoSuchAlgorithmException | NoSuchPaddingException 
                | InvalidParameterSpecException | InvalidKeyException 
                | InvalidAlgorithmParameterException | IllegalBlockSizeException 
                | BadPaddingException ex) {
            Logger.getLogger(AESCipherService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new byte[0];
    }
}
