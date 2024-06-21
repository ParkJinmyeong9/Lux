package shopper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/shopper/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserManager userManager = new UserManager();
        User user = userManager.authenticateUser(username, password); // UserManager의 메서드 사용

        if (user != null) {
            if(user.isAdmin() == true) {
               HttpSession session = request.getSession();
               session.setMaxInactiveInterval(1800);
                session.setAttribute("user", user); // User 객체 저장
               response.sendRedirect("admin/home.jsp"); // 관리자 로그인 성공
            } else {
               HttpSession session = request.getSession();
                session.setAttribute("user", user); // User 객체 저장
                response.sendRedirect("index.jsp"); // 로그인 성공
            }
         } else {
             response.sendRedirect("login.jsp?error=invalid"); // 로그인 실패
         }
    }



	public User authenticateUser(String username, String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnectionMgr.getInstance().getConnection();
			String hashedPassword = hashPassword(password); // 비밀번호 해싱

			String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, hashedPassword);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				User user = new User();
				// User 객체에 필요한 정보를 설정
				user.setUsername(rs.getString("username"));
				user.setName(rs.getString("name"));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return null;
	}

	private String hashPassword(String password) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(password.getBytes());
		byte[] bytes = md.digest();
		StringBuilder sb = new StringBuilder();
		for (byte b : bytes) {
			sb.append(String.format("%02x", b));
		}
		return sb.toString();
	}
}
