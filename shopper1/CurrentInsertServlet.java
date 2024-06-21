package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shopper/currentInsertServlet")
public class CurrentInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청에서 사용자 ID, 제품 ID, 사용자 입찰 가격을 가져옴
        int userID = Integer.parseInt(request.getParameter("userId"));
        int productID = Integer.parseInt(request.getParameter("productId"));
        int userBid = Integer.parseInt(request.getParameter("userBid"));
        
     
        // CurrentMgr 객체 생성
        CurrentMgr currentMgr = new CurrentMgr();
        
        // insertCurrent 메서드 호출하여 현재 테이블에 데이터 삽입
        currentMgr.insertCurrent(productID, userID, userBid);
        
        System.out.println("pid : " + productID);
        System.out.println("uid : " + userID);
        System.out.println("bid : " + userBid);
    }
}