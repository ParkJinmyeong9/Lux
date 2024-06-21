package shopper;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate; // LocalDate 임포트

@WebServlet("/shopper/adminRegister")
public class AdminRegisterServlet extends HttpServlet {
    private static final String APPROVAL_CODE = "ADMIN123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String approvalCode = request.getParameter("approvalCode");
        if (!APPROVAL_CODE.equals(approvalCode)) {
            response.sendRedirect("adminRegisterFail.jsp?error=invalidCode");
            return;
        }
        
        // 요청으로부터 사용자 정보 파라미터 추출
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // 평문 비밀번호
        String hashedPassword = hashPassword(password); // 비밀번호 해싱
        String email = request.getParameter("email");
        String name = request.getParameter("fullname"); // 'fullname' 파라미터 확인
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phoneNumber"); // 'phoneNumber' 파라미터 확인
        LocalDate birthdate = LocalDate.parse(request.getParameter("birthdate"));
        String address = request.getParameter("address");
        String postcode = request.getParameter("postcode");
        String detailAddress = request.getParameter("detailAddress");
        String extraAddress = request.getParameter("extraAddress");

        // User 객체 생성 및 파라미터로 초기화
        User user = new User();
        user.setUsername(username);
        user.setPassword(hashedPassword); // 해싱된 비밀번호를 저장
        user.setEmail(email);
        user.setName(name);
        user.setGender(gender);
        user.setPhone(phone);
        user.setBirthdate(birthdate);
        user.setAddress(address);
        user.setPostcode(postcode);
        user.setDetailAddress(detailAddress);
        user.setExtraAddress(extraAddress);
        user.setAdmin(true); // 관리자로 설정

        // UserManager를 통해 사용자 추가
        UserManager userManager = new UserManager();
        boolean success = userManager.addUser(user);

        if (success) {
            // 등록 성공
            response.sendRedirect("adminRegisterSuccess.jsp"); // 성공 페이지로 리다이렉션 (상대 경로 수정)
        } else {
            // 등록 실패
            response.sendRedirect("adminRegisterFail.jsp"); // 실패 페이지로 리다이렉션 (상대 경로 수정)
        }
    }
    
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
