package filters;

import helpClasses.MessageFactory;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminFilter implements Filter {

	public void init(FilterConfig config) throws ServletException {
		// configured in the deployment descriptor
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		String authorisation = null;
		HttpServletRequest servletRequest = null;
		HttpServletResponse servletResponse = null;
		if (request instanceof HttpServletRequest) {
			servletRequest = (HttpServletRequest) request;
		}
		if (response instanceof HttpServletResponse) {
			servletResponse = (HttpServletResponse) response;
		}
		authorisation = (String)servletRequest.getSession().getAttribute("authorisation");
		if (authorisation == null || !authorisation.equals("3")) {
			MessageFactory.setErrorList("No access rights for the requested page",
					servletRequest);
			servletRequest.getRequestDispatcher(
					servletResponse.encodeURL("/home.action")).forward(
					servletRequest, servletResponse);	
		} else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
	}
}
