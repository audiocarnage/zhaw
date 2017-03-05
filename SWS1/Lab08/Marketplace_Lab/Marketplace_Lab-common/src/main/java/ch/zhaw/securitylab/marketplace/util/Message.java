package ch.zhaw.securitylab.marketplace.util;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

public class Message {

    public static void setMessage(String message) {
        FacesContext facesContext = FacesContext.getCurrentInstance();
        FacesMessage facesMessage = new FacesMessage(message);
        facesContext.addMessage(null, facesMessage);
    }
}
