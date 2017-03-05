package ch.zhaw.securitylab.marketplace.model;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Table(name = "UserInfo")
@NamedQuery(name = "UserInfo.findByUsername", query = "SELECT u FROM UserInfo u WHERE u.username = :username")
public class UserInfo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    private String username;
    private String password;
    private String passwordSHA256;
    private String saltScrypt;
    private String passwordScrypt;
    private String authenticationTokenSHA256;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordSHA256() {
        return passwordSHA256;
    }

    public void setPasswordSHA256(String passwordSHA256) {
        this.passwordSHA256 = passwordSHA256;
    }

    public String getSaltScrypt() {
        return saltScrypt;
    }

    public void setSaltScrypt(String saltScrypt) {
        this.saltScrypt = saltScrypt;
    }

    public String getPasswordScrypt() {
        return passwordScrypt;
    }

    public void setPasswordScrypt(String passwordScrypt) {
        this.passwordScrypt = passwordScrypt;
    }

    public String getAuthenticationTokenSHA256() {
        return authenticationTokenSHA256;
    }

    public void setAuthenticationTokenSHA256(String authenticationTokenSHA256) {
        this.authenticationTokenSHA256 = authenticationTokenSHA256;
    }
}
