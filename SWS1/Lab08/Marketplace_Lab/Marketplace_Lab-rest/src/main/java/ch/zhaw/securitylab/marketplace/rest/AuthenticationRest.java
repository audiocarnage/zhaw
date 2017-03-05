package ch.zhaw.securitylab.marketplace.rest;

import ch.zhaw.securitylab.marketplace.dto.AuthenticationTokenDto;
import ch.zhaw.securitylab.marketplace.dto.CredentialDto;
import ch.zhaw.securitylab.marketplace.facade.UserInfoFacade;
import ch.zhaw.securitylab.marketplace.model.UserInfo;
import ch.zhaw.securitylab.marketplace.service.LoginThrottlingService;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import ch.zhaw.securitylab.marketplace.util.Crypto;
import ch.zhaw.securitylab.marketplace.util.Message;
import java.security.InvalidParameterException;
import javax.enterprise.context.RequestScoped;
import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.SecurityContext;

@RequestScoped
@Path("authenticate")
public class AuthenticationRest {

    @Inject
    private LoginThrottlingService loginThrottlingService;
    @Inject
    private UserInfoFacade userInfoFacade;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public AuthenticationTokenDto createAuthenticationToken(CredentialDto credentialDto) {
        String username = credentialDto.getUsername();
        if (loginThrottlingService.isBlocked(username)) {
            throw new IllegalArgumentException("User " + username + " is temporarily blocked, try again in one minute");
        }
        UserInfo userInfo = userInfoFacade.findByUsername(username);
        if (userInfo == null) {
            throw new IllegalArgumentException("Username or password wrong");
        }
        String salt = userInfo.getSaltScrypt();
        String scryptHash = Crypto.computeScryptHash(credentialDto.getPassword(), salt);
        if (scryptHash.equals(userInfo.getPasswordScrypt())) {
            String authenticationToken = Crypto.createAuthenticationToken();
            userInfo.setAuthenticationTokenSHA256(Crypto.computeSHA256(authenticationToken));
            userInfoFacade.edit(userInfo);
            AuthenticationTokenDto authenticationTokenDto = new AuthenticationTokenDto();
            authenticationTokenDto.setAuthenticationToken(authenticationToken);
            loginThrottlingService.loginSuccessful(username);
            return authenticationTokenDto;
        } else {
            loginThrottlingService.loginFailed(username);
            throw new IllegalArgumentException("Username or password wrong");
        }
    }

    @DELETE
    @Consumes(MediaType.APPLICATION_JSON)
    public void removeAuthenticationToken(@Context SecurityContext securityContext) {
        String username = securityContext.getUserPrincipal().getName();
        UserInfo userInfo = userInfoFacade.findByUsername(username);
        if (userInfo != null) {
            userInfo.setAuthenticationTokenSHA256(null);
            userInfoFacade.edit(userInfo);
        }
    }
}
