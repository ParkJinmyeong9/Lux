package shopper;

public class ProductBean {
	private int productID;
    private Integer sellerID; // Integer to allow null
    private String name;
    private String photo;
    private String modelNumber;
    private Integer	startPrice; // Integer to allow null
    private Integer buyNowPrice; // Integer to allow null
    private Integer currentBid; // Integer to allow null
    private int bidCount;
    private String description;
    private String status;
    private String createdAt;
    private int AuctionDuration;
    private String Brand;
    private String gender;
    private int finalPrice;
    private int waybillNum;
    private AuctionBean auction;
    private CurrentBean current;
 // ProductBean 클래스 내부에 sellerName 필드를 추가합니다.
    private String sellerName;

    // sellerName 필드에 대한 setter 메서드를 추가합니다.
    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    // sellerName 필드에 대한 getter 메서드를 추가합니다.
    public String getSellerName() {
        return sellerName;
    }


    public void setAuction(AuctionBean auction) {
        this.auction = auction;
    }

    public void setCurrent(CurrentBean current) {
        this.current = current;
    }

    // getter 메서드들도 추가
    public AuctionBean getAuction() {
        return this.auction;
    }

    public CurrentBean getCurrent() {
        return this.current;
    }


    // 필요한 getter와 setter 추가
    public int getFinalPrice() {
        return this.finalPrice;
    }

    public void setFinalPrice(int finalPrice) {
        this.finalPrice = finalPrice;
    }

    public int getWaybillNum() {
        return this.waybillNum;
    }

    public void setWaybillNum(int waybillNum) {
        this.waybillNum = waybillNum;
    }

    
    public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBrand() {
		return Brand;
	}
	public void setBrand(String brand) {
		Brand = brand;
	}
	public int getAuctionDuration() {
		return AuctionDuration;
	}
	public void setAuctionDuration(int auctionDuration) {
		AuctionDuration = auctionDuration;
	}
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
