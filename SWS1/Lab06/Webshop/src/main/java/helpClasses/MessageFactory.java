package helpClasses;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

public class MessageFactory {
	
	public final static String ERRORLIST = "errorList";
	public final static String INFOLIST = "infoList";
		
	public static void addToErrorList(String errorMsg, ArrayList<String> errorList) {	
		errorList.add(errorMsg);
	}
	
	public static ArrayList<String> setErrorList(String errorMsg, HttpServletRequest request) {
		ArrayList<String> errorList = new ArrayList<String>();
		errorList.add(errorMsg);
		request.setAttribute(ERRORLIST, errorList);
		return errorList;
	}
	
	public static void addToInfo(String infoMsg, ArrayList<String> infoList) {	
		infoList.add(infoMsg);
	}
	
	public static ArrayList<String> setInfoList(String infoMsg, HttpServletRequest request) {
		ArrayList<String> infoList = new ArrayList<String>();
		infoList.add(infoMsg);
		request.setAttribute(INFOLIST, infoList);
		return infoList;
	}
}
