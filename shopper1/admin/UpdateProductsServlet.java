package shopper.admin;

import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/shopper/admin/UpdateProductsServlet")
public class UpdateProductsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        try {
	            BufferedReader reader = request.getReader();
	            StringBuilder jsonInput = new StringBuilder();
	            String line;
	            while ((line = reader.readLine()) != null) {
	                jsonInput.append(line);
	            }

            Gson gson = new Gson();
            ProductBean[] products = gson.fromJson(jsonInput.toString(), ProductBean[].class);

            ProductMgr productMgr = new ProductMgr();
            StringBuilder message = new StringBuilder();
            AuctionsMgr auctionsMgr = new AuctionsMgr();
            for (ProductBean product : products) {
                boolean updatedStatus = productMgr.updateProducts(product.getProductID(), product.getStatus());
                if (updatedStatus) {
                    message.append("상품번호 ").append(product.getProductID()).append("의 상태를 업데이트하였습니다.\n");
                } else {
                    message.append("상품번호 ").append(product.getProductID()).append("의 상태 업데이트에 실패했습니다.\n");
                }
                
                // 검수중에서 경매중으로 상태가 변경된 경우, Auctions 테이블에 ProductID가 있는지 체크 후 시간 업데이트
                if (product.getStatus().equals("경매중")) {
                    boolean isAuctionExists = auctionsMgr.isAuctions(product.getProductID());
                    if (!isAuctionExists) {
                        boolean inserted = auctionsMgr.isAuctions(product.getProductID());
                        if (inserted) {
                            message.append("상품번호 ").append(product.getProductID()).append("의 경매 정보를 삽입하였습니다.\n");
                        } else {
                            message.append("상품번호 ").append(product.getProductID()).append("의 경매 정보 삽입에 실패했습니다.\n");
                        }
                    }
                    // updateAuctionsTime 실행
                    boolean updatedTime = auctionsMgr.updateAuctionsTime(product.getProductID());
                    if (updatedTime) {
                        message.append("상품번호 ").append(product.getProductID()).append("의 경매 시작 및 종료시간을 업데이트하였습니다.\n");
                    } else {
                        message.append("상품번호 ").append(product.getProductID()).append("의 경매 시작 및 종료시간 업데이트에 실패했습니다.\n");
                    }
                }
            }

            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(message.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("서버 오류가 발생했습니다.");
        }
    }
    
    
}
