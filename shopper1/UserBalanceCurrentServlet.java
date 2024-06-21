package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shopper/userBalanceCurrentServlet")
public class UserBalanceCurrentServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  ServletException, IOException {
	 int userId = Integer.parseInt(request.getParameter("userId"));
     int userBid = Integer.parseInt(request.getParameter("userBid"));
          System.out.println("입찰한 userID: " + userId);
          System.out.println("입찰금액 userBiD: " + userBid);
  // UserMgr를 사용하여 현재 사용자의 잔액 가져오기
     UserMgr userMgr = new UserMgr();
     UserBean user = userMgr.getUserBalance(userId);
     int currentBalance = user.getBalance();

     // 현재 잔액에서 userBid 차감
     int updatedBalance = currentBalance - userBid;

     // 변경된 잔액을 UserBean에 설정
     user.setBalance(updatedBalance);

     // UserMgr를 사용하여 잔액 업데이트
     userMgr.updateUserBalance(user);
     
     // ProductMgr를 사용하여 현재 입찰가 업데이트
     ProductMgr productMgr = new ProductMgr();
     int productId = Integer.parseInt(request.getParameter("productId")); // 상품 ID 가져오기
     productMgr.updateProductBid(productId, userBid);
     
 }
}
