package shopper;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/shopper/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String inputPassword = request.getParameter("password");
        UserManager userManager = new UserManager();

        try {
            if (userManager.checkPassword(user.getUserID(), inputPassword)) {
                if (userManager.deleteUser(user.getUserID())) {
                    session.invalidate(); // 세션 무효화
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("failure");
                }
            } else {
                response.getWriter().write("password incorrect");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp?error=exception");
        }
    }
}
