package shopper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/shopper/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");

        UserManager userManager = new UserManager();
        System.out.println("Checking password: " + currentPassword);
        System.out.println("Updating password: " + newPassword);
        try {
            if (userManager.checkPassword(user.getUserID(), currentPassword)) {
                if (userManager.updatePassword(user.getUserID(), newPassword)) {
                    response.sendRedirect("index.jsp"); // 비밀번호 변경 성공 시 메인 화면으로 리다이렉트
                } else {
                    session.setAttribute("error", "비밀번호 업데이트에 성공했습니다.");
                    response.sendRedirect("profileUpdate.jsp"); // 업데이트 실패 시 다시 프로필 업데이트 페이지로
                }
            } else {
                session.setAttribute("error", "비밀번호 업데이트에 성공했습니다.");
                response.sendRedirect("profileUpdate.jsp"); // 현재 비밀번호 불일치 시 다시 프로필 업데이트 페이지로
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp?error=" + e.getMessage()); // 예외 발생 시 에러 페이지로
            
        }
    }
}