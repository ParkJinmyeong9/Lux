package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/shopper/rouletteResultServlet")
public class RouletteResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        
        if (loggedInUser != null) {
            int userId = loggedInUser.getUserID();
            String prizeString = request.getParameter("prize");
            int prize = Integer.parseInt(prizeString); // 문자열을 정수로 변환
            System.out.println(prize);
            UserManager userManager = new UserManager();

            // 클라이언트로부터 전송된 prize 값을 정수로 변환하여 updateUserBalance 메서드 호출
            boolean updateResult = userManager.updateUserBalance(userId, prize);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": " + updateResult + "}");
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
        }
    }

    // 숫자로만 이루어진 부분을 추출하는 메서드
    private int extractNumber(String prize) {
        StringBuilder number = new StringBuilder();
        for (char c : prize.toCharArray()) {
            if (Character.isDigit(c)) {
                number.append(c);
            }
        }
        return Integer.parseInt(number.toString());
    }

}
