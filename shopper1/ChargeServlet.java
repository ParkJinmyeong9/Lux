package shopper;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject; // JSON 라이브러리 추가 필요

@WebServlet("/shopper/charge")
public class ChargeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");
        

        
        JSONObject jsonResponse = new JSONObject();
       
        if (loggedInUser == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "로그인이 필요합니다.");
            response.getWriter().write(jsonResponse.toString());
        } else {
            int amount;
            try {
                amount = Integer.parseInt(request.getParameter("amount"));
                if (amount <= 0) {
                    throw new IllegalArgumentException("충전 금액은 0보다 커야 합니다.");
                }
                

                UserManager userManager = new UserManager();
                boolean success = userManager.updateUserBalance(loggedInUser.getUserID(), amount);

                jsonResponse.put("success", success);
                if (success) {
                    jsonResponse.put("message", "잔액이 성공적으로 업데이트 되었습니다.");
                } else {
                    jsonResponse.put("message", "잔액 업데이트에 실패했습니다.");
                }
                response.getWriter().write(jsonResponse.toString());
            } catch (NumberFormatException e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "유효하지 않은 숫자 형식입니다.");
                response.getWriter().write(jsonResponse.toString());
            } catch (IllegalArgumentException e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", e.getMessage());
                response.getWriter().write(jsonResponse.toString());
            } catch (Exception e) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "서버 오류가 발생했습니다.");
                response.getWriter().write(jsonResponse.toString());
                e.printStackTrace();
            }
            
        }
        
    }
}
