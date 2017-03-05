package helpClasses;

import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import beans.BasketBean;

public class ActiveSessionsListener implements HttpSessionListener {

	/** Wird gerufen, wenn eine Session erzeugt wurde */
	public void sessionCreated(HttpSessionEvent event) {
		//Ermitteln der Session ID und Debug-Ausgabe auf der Kommandozeile
		//String sessionId = event.getSession().getId();
		//System.out.println("Session: " + sessionId + " erzeugt.");
	}

	/** Wird gerufen, wenn eine Session verfällt */
	public void sessionDestroyed(HttpSessionEvent event) {
		DBAccessClient access;
		// Ermitteln der Session ID und Debug-Ausgabe auf der Kommandozeile
		//String sessionId = event.getSession().getId();
		//System.out.println("Session: " + sessionId + " verfällt.");

		// Basket löschen und Produktanzahl wieder korrigieren
		BasketBean basketBean = (BasketBean) event.getSession().getAttribute(
				"basketBean");
		if (basketBean != null && basketBean.getReservedProducts() != null) {
			try {
				
				access = new DBAccessClient();
				Iterator<Product> iterator = basketBean.getReservedProducts()
						.values().iterator();
				while (iterator.hasNext()) {
					Product product = iterator.next();
					String productID = String.valueOf(product.getProductID());
					Integer quantity = product.getAmount();
					access.undoReserveProduct(productID, quantity);
				}
			} catch (ServletException e) {
				e.printStackTrace();
			}
		}
	}
}
