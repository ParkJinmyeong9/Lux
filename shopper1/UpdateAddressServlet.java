package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateAddressServlet
 */
@WebServlet("/shopper/updateAddressServlet")
public class UpdateAddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 사용자 정보를 가져옴
        User loggedInUser = (User) request.getSession().getAttribute("user");
        
        // 입력된 새 주소 정보를 가져옴
        String address = request.getParameter("address");
        String detailAddress = request.getParameter("detailAddress");
        String postcode = request.getParameter("postcode");
        String extraAddress = request.getParameter("extraAddress");

        // UserManager 객체 생성
        UserManager userManager = new UserManager();

        // 사용자 주소 업데이트를 시도하고 결과를 반환
        boolean updateResult = userManager.updateUserAddress(loggedInUser.getUserID(), address, detailAddress, postcode, extraAddress);

        // 성공/실패에 따라 클라이언트에게 응답
        if(updateResult) {
            // 업데이트 성공 시
            response.getWriter().print("Success");
        } else {
            // 업데이트 실패 시
            response.getWriter().print("Fail");
        }
    }
}
