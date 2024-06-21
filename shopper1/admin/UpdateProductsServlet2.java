package shopper.admin;

import java.awt.Desktop.Action;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/shopper/admin/UpdateProductsServlet2")
public class UpdateProductsServlet2 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        StringBuilder message = new StringBuilder();
        // 1. 요청 파라미터 추출
        String Name = request.getParameter("Name");
        String modelNumber = request.getParameter("modelNumber");
        String brand = request.getParameter("brand");
        int startPrice = Integer.parseInt(request.getParameter("startPrice"));
        String status = request.getParameter("status");
      
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");

        // startTime과 endTime이 "null"인 경우 현재 날짜와 시간으로 대체
        if (startTime == null || startTime.isEmpty()) {
            startTime = "2001-01-01 00:00:00";
        }
        if (endTime == null || endTime.isEmpty()) {
            endTime = "2001-01-01 00:00:00";
        }

        int buyNowPrice = Integer.parseInt(request.getParameter("buyNowPrice"));
        int currentBid = Integer.parseInt(request.getParameter("currentBid"));
        int productID = Integer.parseInt(request.getParameter("productID"));
        int pwinnerID = 1;
        
        // 2. ProductBean 객체 생성
        ProductBean product = new ProductBean();
        product.setName(Name);
        product.setModelNumber(modelNumber);
        product.setBrand(brand);
        product.setStartPrice(startPrice);
        product.setStatus(status);
        product.setStartTime(startTime);
        product.setEndTime(endTime);
        product.setBuyNowPrice(buyNowPrice);
        product.setCurrentBid(currentBid);
        product.setProductID(productID);
        product.setPwinnerID(pwinnerID);
        
        // 3. ProductMgr 객체 생성 및 updateProduct2 메서드 호출
        ProductMgr productMgr = new ProductMgr();
        AuctionsMgr auctionsMgr = new AuctionsMgr();
        boolean isAuctionExists = auctionsMgr.isAuctions(product.getProductID());
        boolean isUpdated = productMgr.updateProduct2(product);
        boolean isAuctionEnd = auctionsMgr.AuctionEnd(currentBid, pwinnerID, productID);
        pwinnerID = productMgr.SelectPwinnerID(productID);
        // 4. 업데이트 결과 처리
        if (!isUpdated) { 
            // 업데이트 성공 시 처리
        	message.append("상품번호 ").append(product.getProductID()).append("의 정보를 업데이트하였습니다.\n");
            // 만약 상태가 "검수중"에서 "경매중"으로 변경되었다면 Auctions 테이블의 EndTime을 수정하고 StartTime을 현재 시간으로 업데이트합니다.
            if (status.equals("경매중")) {
            	if(!isAuctionExists) {
            		boolean inserted = auctionsMgr.isAuctions(product.getProductID());
            		if (inserted) {
                        message.append("상품번호 ").append(product.getProductID()).append("의 경매 정보를 삽입하였습니다.\n");
                    } else {
                        message.append("상품번호 ").append(product.getProductID()).append("의 경매 정보 삽입에 실패했습니다.\n");
                    }
            	}

                try {
                    boolean updatedTime = auctionsMgr.updateAuctionsTime(productID);
                    if (updatedTime) {
                        //message.append("상품번호 ").append(product.getProductID()).append("의 경매시각을 업데이트 하였습니다.\n");
                    } else {
                    	message.append("상품번호 ").append(product.getProductID()).append("의 정보를 업데이트를 실패하였습니다.\n");
                        message.append("상품번호 ").append(product.getProductID()).append("의 경매시각 업데이트에 실패했습니다.\n");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if(status.equals("낙찰")) {

        		if(isAuctionEnd) {
        			boolean isEnd = auctionsMgr.AuctionEnd(currentBid, pwinnerID, productID);
        			if (isEnd) {
                        message.append("상품번호 ").append(product.getProductID()).append("의 경매 정보를 삽입하였습니다.\n");
                    } else {
                        
                    }
        		} else {
        			
        		}

            } else {
	            // 업데이트 실패 시 처리
	            message.append("상품번호 ").append(product.getProductID()).append("의 정보를 업데이트에 실패하였습니다.\n");
	           // response.sendRedirect(productID + "업데이트에 실패했습니다.");
            }
        }
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(message.toString());
    }
}
