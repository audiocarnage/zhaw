package ch.zhaw.securitylab.marketplace.service;

import java.io.Serializable;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.ejb.Singleton;

@Singleton
public class LoginThrottlingService implements Serializable {

    private static final long serialVersionUID = 1L;
    private final Map<String,Integer> USER_LOGINS = new ConcurrentHashMap();
    private final Map<String,Long> BLOCKED_USERS = new ConcurrentHashMap();
    public static final int BLOCKING_TIME = 60;
    public static final int BLOCKING_LIMIT = 3;

    /**
     * Is called to inform that the login with username has failed.
     * 
     * @param username The username for which the login failed
     */
    public void loginFailed(String username) {
        if (USER_LOGINS.containsKey(username)) {
            USER_LOGINS.put(username, USER_LOGINS.get(username) + 1);
            if (USER_LOGINS.get(username) >= BLOCKING_LIMIT) {
                BLOCKED_USERS.put(username, System.nanoTime());
            }
        } else {
            USER_LOGINS.put(username, 1);
        }
    }

    /**
     * Is called to inform that the login with username has succeeded.
     * 
     * @param username The username for which the login succeeded
     */
    public void loginSuccessful(String username) {
        BLOCKED_USERS.remove(username);
        USER_LOGINS.put(username, 0);
    }

    /**
     * Returns whether the user username is blocked.
     * 
     * @param username The username to check
     * @return true if the user is blocked, false otherwise
     */
    public boolean isBlocked(String username) {
        if (BLOCKED_USERS.get(username) != null) {
            long blockedSince = BLOCKED_USERS.get(username);
            if (blockedSince + (BLOCKING_TIME * 1e9) < System.nanoTime())
                BLOCKED_USERS.remove(username);
            if (BLOCKED_USERS.containsKey(username))
                return true;
        }
        return false;
    }
}
