package shopper;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/shopper/roleSelection")
public class RoleSelectionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");

        if ("admin".equals(role)) {
            // 관리자용 회원가입 페이지로 리디렉션
            response.sendRedirect("registerAdmin.jsp");
        } else {
            // 일반 사용자용 회원가입 페이지로 리디렉션
            response.sendRedirect("register.html");
        }
    }
}
