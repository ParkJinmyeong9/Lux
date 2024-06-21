package shopper.admin;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/shopper/admin/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String jsonString = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));

    	// Gson 라이브러리를 사용하여 JSON 데이터를 자바 객체로 변환
    	Gson gson = new Gson();
    	String[] userIDs = gson.fromJson(jsonString, String[].class);
    	UserMgr userMgr = new UserMgr();
    	StringBuilder message = new StringBuilder();
    	// 각 상품의 ID에 대한 삭제 작업을 수행
    	for (String userID : userIDs) {
    	    // productID를 정수로 변환하여 사용
    	    int userId = Integer.parseInt(userID);
    	    
    	    boolean reviewDelete = userMgr.deleteUser(userId);
    	    if(reviewDelete) {
    	    	message.append("유저번호 ").append(userID).append("를 삭제하였습니다.\n");
            } else {
                message.append("유저번호 ").append(userID).append("의 삭제를 실패했습니다.\n");
            }
    	}
    	response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(message.toString());
		
		
	}

}
