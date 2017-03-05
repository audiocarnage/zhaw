package ch.zhaw.securitylab.marketplace.backing;

import ch.zhaw.securitylab.marketplace.facade.UserInfoFacade;
import ch.zhaw.securitylab.marketplace.model.UserInfo;
import ch.zhaw.securitylab.marketplace.service.LoginThrottlingService;
import ch.zhaw.securitylab.marketplace.util.Crypto;
import java.io.Serializable;
import javax.inject.Named;
import javax.servlet.http.HttpServletRequest;
import javax.enterprise.context.SessionScoped;
import javax.faces.context.FacesContext;
import ch.zhaw.securitylab.marketplace.util.Message;
import javax.inject.Inject;
import javax.servlet.ServletException;

@Named
@SessionScoped
public class AuthenticationBacking implements Serializable {

    private static final long serialVersionUID = 1L;
    @Inject
    private LoginThrottlingService loginThrottlingService;
    @Inject
    private UserInfoFacade userInfoFacade;
    private String username;
    private String password;

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

    public String login() {
        FacesContext context = FacesContext.getCurrentInstance();
        HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
        if (loginThrottlingService.isBlocked(username)) {
            Message.setMessage("User " + username + " is temporarily blocked, try again in one minute");
            return "/view/public/secure/login";
        }
        UserInfo userInfo = userInfoFacade.findByUsername(username);
        if (userInfo == null) {
            return loginFailed();
        }
        String salt = userInfo.getSaltScrypt();
        String scryptHash = Crypto.computeScryptHash(password, salt);
        try {
            request.login(username, scryptHash);
            loginThrottlingService.loginSuccessful(username);
            return "/view/admin/admin";
        } catch (ServletException e) {
            loginThrottlingService.loginFailed(username);
            return loginFailed();
        }
    }

    private String loginFailed() {
        Message.setMessage("Username or password wrong");
        return "/view/public/secure/login";
    }

    public String logout() {
        FacesContext context = FacesContext.getCurrentInstance();
        HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
        try {
            request.logout();
        } catch (ServletException e) {
            // Do nothing
        }
        Message.setMessage("You have been logged off");
        return "/view/public/search";
    }
}
