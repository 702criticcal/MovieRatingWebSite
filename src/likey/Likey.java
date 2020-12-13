package likey;

public class Likey {
	String userID;
	int ratingID;
	String userIP;
	
	public Likey() {
		
	}
	
	public Likey(String userID, int ratingID, String userIP) {
		super();
		this.userID = userID;
		this.ratingID = ratingID;
		this.userIP = userIP;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public int getRatingID() {
		return ratingID;
	}

	public void setRatingID(int ratingID) {
		this.ratingID = ratingID;
	}

	public String getUserIP() {
		return userIP;
	}

	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	
}
