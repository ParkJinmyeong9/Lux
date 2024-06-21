package shopper;

public class AuctionBean {
		private int auctionID;
		private int productID;
	    private String startTime;
	    private String endTime;
	    private Integer winnerID; // Integer to allow null
	    private Integer finalPrice; // Integer to allow null
	    private int bidPrice;

	    // ... other properties and methods ...

	    public int getBidPrice() {
	        return this.bidPrice;
	    }

	    public void setBidPrice(int bidPrice) {
	        this.bidPrice = bidPrice;
	    }
	    public int getAuctionID() {
			return auctionID;
		}
		public void setAuctionID(int auctionID) {
			this.auctionID = auctionID;
		}
		public int getProductID() {
			return productID;
		}
		public void setProductID(int productID) {
			this.productID = productID;
		}
		public String getStartTime() {
			return startTime;
		}
		public void setStartTime(String startTime) {
			this.startTime = startTime;
		}
		public String getEndTime() {
			return endTime;
		}
		public void setEndTime(String endTime) {
			this.endTime = endTime;
		}
		public Integer getWinnerID() {
			return winnerID;
		}
		public void setWinnerID(Integer winnerID) {
			this.winnerID = winnerID;
		}
		public Integer getFinalPrice() {
			return finalPrice;
		}
		public void setFinalPrice(Integer finalPrice) {
			this.finalPrice = finalPrice;
		}
		
}
