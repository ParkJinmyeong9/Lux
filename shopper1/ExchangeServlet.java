package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet("/shopper/exchange")
public class ExchangeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        JSONObject jsonResponse = new JSONObject();

        if (loggedInUser == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "로그인이 필요합니다.");
        } else {
            int userId = loggedInUser.getUserID();
            int exchangeAmount = Integer.parseInt(request.getParameter("exchangeAmount"));

            UserManager userManager = new UserManager(); // UserManager는 사용자 관리를 담당하는 클래스라고 가정
            boolean success = userManager.decreaseUserBalance(userId, exchangeAmount);

            if (success) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "환전이 성공적으로 처리되었습니다.");
                session.setAttribute("exchangeResult", jsonResponse.toString());
                response.sendRedirect("Exchange.jsp"); // 성공 시 exchange.jsp로 리다이렉트
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "잔액이 부족하거나 환전 처리 중 오류가 발생했습니다.");
            }
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }
}
