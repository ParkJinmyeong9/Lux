package shopper.admin;

public class ProductBean {
	private int productID;
    private Integer sellerID; // Integer to allow null
    private String name;
    private String photo;
    private String modelNumber;
    private Integer startPrice; // Integer to allow null
    private Integer buyNowPrice; // Integer to allow null
    private Integer currentBid; // Integer to allow null
    private int bidCount;
    private String description;
    private String status;
    private String createdAt;
    private String gender;
    private String brand;
    private int auctionDuration;
    private int pwinnerID;
    
    public int getPwinnerID() {
		return pwinnerID;
	}
	public void setPwinnerID(int pwinnerID) {
		this.pwinnerID = pwinnerID;
	}
	private String startTime;
    private String endTime;
    
    
    public int getAuctionDuration() {
		return auctionDuration;
	}
	public void setAuctionDuration(int auctionDuration) {
		this.auctionDuration = auctionDuration;
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
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	/////////////////////////////////////////////////////
    private String username;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
    /////////////////////////////////////////////////////
	
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
	public Integer getSellerID() {
		return sellerID;
	}
	public void setSellerID(Integer sellerID) {
		this.sellerID = sellerID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getModelNumber() {
		return modelNumber;
	}
	public void setModelNumber(String modelNumber) {
		this.modelNumber = modelNumber;
	}
	public Integer getStartPrice() {
		return startPrice;
	}
	public void setStartPrice(Integer startPrice) {
		this.startPrice = startPrice;
	}
	public Integer getBuyNowPrice() {
		return buyNowPrice;
	}
	public void setBuyNowPrice(Integer buyNowPrice) {
		this.buyNowPrice = buyNowPrice;
	}
	public Integer getCurrentBid() {
		return currentBid;
	}
	public void setCurrentBid(Integer currentBid) {
		this.currentBid = currentBid;
	}
	public int getBidCount() {
		return bidCount;
	}
	public void setBidCount(int bidCount) {
		this.bidCount = bidCount;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
    
    
}
