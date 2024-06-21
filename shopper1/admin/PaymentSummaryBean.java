package shopper.admin;

public class PaymentSummaryBean {
	
    private String paymentMethod;
    private int totalAmount;
    private int totalFinalPrice;
    private String month;
    private int year;
    
    public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getTotalFinalPrice() {
		return totalFinalPrice;
	}

	public void setTotalFinalPrice(int totalFinalPrice) {
		this.totalFinalPrice = totalFinalPrice;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }
}
