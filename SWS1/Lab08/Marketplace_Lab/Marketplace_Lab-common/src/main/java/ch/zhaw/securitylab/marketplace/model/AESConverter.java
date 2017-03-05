package ch.zhaw.securitylab.marketplace.model;

import ch.zhaw.securitylab.marketplace.service.AESCipherService;
import java.util.Base64;
import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter
public class AESConverter implements AttributeConverter<String, String> {
    
    @Override
    public String convertToDatabaseColumn(String plainTextData) {
        byte[] encryptedData = ((new AESCipherService()).encrypt(plainTextData.getBytes()));
        return new String(Base64.getEncoder().encode(encryptedData));
    }

    @Override
    public String convertToEntityAttribute(String cipherTextData) {
        byte[] encryptedData = Base64.getDecoder().decode(cipherTextData);
        return new String((new AESCipherService()).decrypt(encryptedData));
    }
}
