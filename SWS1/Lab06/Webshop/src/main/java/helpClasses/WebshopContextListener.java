package helpClasses;

import javax.servlet.*;
import java.util.*;

public class WebshopContextListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent event)
	{
		ServletContext sc = event.getServletContext();      

		// initialize the current year that's used in the copyright notice
		GregorianCalendar currentDate = new GregorianCalendar();
		int currentYear = currentDate.get(Calendar.YEAR);
		sc.setAttribute("currentYear", currentYear);	        
	}

	public void contextDestroyed(ServletContextEvent event) {
		// no cleanup necessary
	}    
}
