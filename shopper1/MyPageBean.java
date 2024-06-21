package shopper;

public class MyPageBean {
   
   private String username;
   private String name;
   private String status;
   private int finalPrice;
   private int productID;
   
   private int currentID;
   private int userID;
   private int waybillNum;
   
   
   public int getCurrentID() {
      return currentID;
   }
   public void setCurrentID(int currentID) {
      this.currentID = currentID;
   }
   public int getUserID() {
      return userID;
   }
   public void setUserID(int userID) {
      this.userID = userID;
   }
   public int getWaybillNum() {
      return waybillNum;
   }
   public void setWaybillNum(int waybillNum) {
      this.waybillNum = waybillNum;
   }
   public int getProductID() {
      return productID;
   }
   public void setProductID(int productID) {
      this.productID = productID;
   }
   public String getUsername() {
      return username;
   }
   public void setUsername(String username) {
      this.username = username;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getStatus() {
      return status;
   }
   public void setStatus(String status) {
      this.status = status;
   }
   public int getFinalPrice() {
      return finalPrice;
   }
   public void setFinalPrice(int finalPrice) {
      this.finalPrice = finalPrice;
   }
   
   
}