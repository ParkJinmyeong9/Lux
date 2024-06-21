package shopper.admin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet("/shopper/admin/DeleteProductsServlet")
public class DeleteProductsServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	String jsonString = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));

    	// Gson 라이브러리를 사용하여 JSON 데이터를 자바 객체로 변환
    	Gson gson = new Gson();
    	String[] productIDs = gson.fromJson(jsonString, String[].class);
    	ProductMgr productMgr = new ProductMgr();
    	StringBuilder message = new StringBuilder();
    	System.out.println("응애");
    	// 각 상품의 ID에 대한 삭제 작업을 수행
    	for (String productID : productIDs) {
    	    // productID를 정수로 변환하여 사용
    	    int productId = Integer.parseInt(productID);
    	    // productId를 사용하여 상품 삭제 작업 수행
    	    boolean productDelete = productMgr.deleteProduct(productId);
    	    if(productDelete) {
    	    	message.append("상품번호 ").append(productID).append("를 삭제하였습니다.\n");
            } else {
                message.append("상품번호 ").append(productID).append("의 삭제를 실패했습니다.\n");
            }
    	}
    	response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(message.toString());
    }
}
