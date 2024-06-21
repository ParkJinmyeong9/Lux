package shopper.admin;

public class AuctionsBean {
	
	private int AuctionID;
	private int ProductID;
	private String StartTime;
	private String EndTime;
	private int WinnerID;
	private int FinalPrice;
	
	//////////////////////////////////////////////////
	private int auctionDuration;
	public int getAuctionDuration() {
		return auctionDuration;
	}
	public void setAuctionDuration(int auctionDuration) {
		this.auctionDuration = auctionDuration;
	}
	//////////////////////////////////////////////////
	public int getAuctionID() {
		return AuctionID;
	}
	public void setAuctionID(int auctionID) {
		AuctionID = auctionID;
	}
	public int getProductID() {
		return ProductID;
	}
	public void setProductID(int productID) {
		ProductID = productID;
	}
	public String getStartTime() {
		return StartTime;
	}
	public void setStartTime(String startTime) {
		StartTime = startTime;
	}
	public String getEndTime() {
		return EndTime;
	}
	public void setEndTime(String endTime) {
		EndTime = endTime;
	}
	public int getWinnerID() {
		return WinnerID;
	}
	public void setWinnerID(int winnerID) {
		WinnerID = winnerID;
	}
	public int getFinalPrice() {
		return FinalPrice;
	}
	public void setFinalPrice(int finalPrice) {
		FinalPrice = finalPrice;
	}
	
	
}
