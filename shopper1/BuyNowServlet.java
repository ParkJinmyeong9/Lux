package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/shopper/buyNowServlet")
public class BuyNowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
	    int buyNowPrice = Integer.parseInt(request.getParameter("buyNowPrice"));
	    int productId = Integer.parseInt(request.getParameter("productId"));
	    System.out.println("//////////////즉시/////////////");
	    System.out.println("userId = " + userId + ",buyNowPrice : " + buyNowPrice);
	    System.out.println("//////////////구매/////////////");
	    // UserMgr를 사용하여 현재 사용자의 잔액 가져오기
	     UserMgr userMgr = new UserMgr();
	     UserBean user = userMgr.getUserBalance(userId);
	     int currentBalance = user.getBalance();

	     // 현재 잔액에서 userBid 차감
	     int updatedBalance = currentBalance - buyNowPrice;

	     // 변경된 잔액을 UserBean에 설정
	     user.setBalance(updatedBalance);

	     // UserMgr를 사용하여 잔액 업데이트
	     userMgr.updateUserBalance(user);
	     

	     ProductMgr productMgr = new ProductMgr();
	     // updateProductBid 메서드를 사용하여 currentbid를 buyNowPrice로 업데이트합니다.
	     productMgr.updateProductBid(productId, buyNowPrice);
     
         AuctionMgr auctionMgr = new AuctionMgr();
         // AuctionMgr 인스턴스를 생성하여 Auction 테이블의 WinnerID와 FinalPrice를 업데이트합니다.
         try {
			auctionMgr.updateAuctionForBuyNow(productId, userId, buyNowPrice);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	     
	}

}
