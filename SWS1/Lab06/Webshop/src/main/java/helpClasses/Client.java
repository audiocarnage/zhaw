package helpClasses;

public class Client {

	//Passwort später rauslöschen
	private int clientID, authorisation;
	private String clientName, clientPassword;
	
	public int getAuthorisation() {
		return authorisation;
	}
	public void setAuthorisation(int authorisation) {
		this.authorisation = authorisation;
	}
	public int getClientID() {
		return clientID;
	}
	public void setClientID(int clientID) {
		this.clientID = clientID;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getClientPassword() {
		return clientPassword;
	}
	public void setClientPassword(String clientPassword) {
		this.clientPassword = clientPassword;
	}

}
