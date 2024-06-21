package shopper;

public class ReviewBean {
	   private int reviewID;
	    private Integer productID; // Integer to allow null
	    private Integer authorID; // Integer to allow null
	    private Integer rating; // Integer to allow null
	    private String content;
	    private String createdAt;
	    private String RPhoto;
	    private String ReviewName;
	    
		public String getReviewName() {
			return ReviewName;
		}
		public void setReviewName(String reviewName) {
			ReviewName = reviewName;
		}
		public String getRPhoto() {
			return RPhoto;
		}
		public void setRPhoto(String rPhoto) {
			RPhoto = rPhoto;
		}
		public int getReviewID() {
			return reviewID;
		}
		public void setReviewID(int reviewID) {
			this.reviewID = reviewID;
		}
		public Integer getProductID() {
			return productID;
		}
		public void setProductID(Integer productID) {
			this.productID = productID;
		}
		public Integer getAuthorID() {
			return authorID;
		}
		public void setAuthorID(Integer authorID) {
			this.authorID = authorID;
		}
		public Integer getRating() {
			return rating;
		}
		public void setRating(Integer rating) {
			this.rating = rating;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public String getCreatedAt() {
			return createdAt;
		}
		public void setCreatedAt(String createdAt) {
			this.createdAt = createdAt;
		}
	    
}
