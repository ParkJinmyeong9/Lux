package shopper;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate; // LocalDate 임포트

@WebServlet("/shopper/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 폼에서 입력된 데이터를 추출합니다.
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String name = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phoneNumber");
    	LocalDate birthdate = LocalDate.parse(request.getParameter("birthdate"));// 생년월일 처리
        boolean isAdmin = Boolean.parseBoolean(request.getParameter("isAdmin")); // 관리자 여부 추가
        String address = request.getParameter("address");
        String postcode = request.getParameter("postcode");
        String detailAddress = request.getParameter("detailAddress");
        String extraAddress = request.getParameter("extraAddress");

        // 비밀번호 해싱
        String hashedPassword = hashPassword(password);

        // User 객체를 생성하고 폼 데이터로 초기화합니다.
        User user = new User();
        user.setUsername(username);
        user.setPassword(hashedPassword); // 해싱된 비밀번호 설정
        user.setEmail(email);
        user.setName(name);
        user.setGender(gender);
        user.setPhone(phone);
        user.setBirthdate(birthdate); // 생년월일 설정
        user.setAdmin(isAdmin); // 관리자 여부 설정
        user.setAddress(address);
        user.setPostcode(postcode);
        user.setDetailAddress(detailAddress);
        user.setExtraAddress(extraAddress);
        


        // UserManager를 사용하여 사용자를 추가합니다.
        UserManager userManager = new UserManager();
        boolean success = userManager.addUser(user);

        // 등록 성공 여부에 따라 적절한 JSP 페이지로 리디렉션합니다.
        if (success) {
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("registerFail.jsp");
        }
    }

    // 비밀번호를 해싱하는 메소드
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("해싱 알고리즘이 존재하지 않습니다.", e);
        }
    }
}
