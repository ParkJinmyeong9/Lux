package shopper;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

@WebServlet("/shopper/find-account")
public class FindAccountServlet extends HttpServlet {
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int PASSWORD_LENGTH = 10;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");

        try {
            if ("findId".equals(action)) {
                String username = findUsernameByEmail(email);
                if (username != null) {
                    sendEmail(email, "귀하의 아이디는 " + username + "입니다.");
                    request.setAttribute("message", "아이디가 이메일로 전송되었습니다.");
                } else {
                    request.setAttribute("message", "해당 이메일로 등록된 아이디가 없습니다.");
                }
            } else if ("resetPassword".equals(action)) {
                boolean success = resetPassword(email);
                if (success) {
                    request.setAttribute("message", "비밀번호 재설정 링크가 이메일로 전송되었습니다.");
                } else {
                    request.setAttribute("message", "해당 이메일로 등록된 계정이 없습니다.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "서비스 처리 중 오류가 발생했습니다.");
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        request.getRequestDispatcher("/shopper/find-account.jsp").forward(request, response);
    }


    private String findUsernameByEmail(String email) throws SQLException {
        String username = null;
        try (Connection conn = DBConnectionMgr.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT username FROM users WHERE email = ?")) {
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    username = rs.getString("username");
                }
            }
        } catch (Exception e) {
			e.printStackTrace();
		}
        return username;
    }

    private boolean resetPassword(String email) {
        // 임시 비밀번호 생성
        String tempPassword = generateTempPassword(PASSWORD_LENGTH);

        // 임시 비밀번호 해싱
        String hashedPassword = hashPassword(tempPassword);

        try (Connection conn = DBConnectionMgr.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE users SET password = ? WHERE email = ?")) {
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, email);

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                // 메일 전송 로직, 임시 비밀번호를 포함하여 메일 전송
                String emailContent = String.format("귀하의 임시 비밀번호는 %s 입니다. 로그인 후 비밀번호를 변경해 주세요.", tempPassword);
                sendEmail(email, emailContent);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    private void sendEmail(String to, String content) {
        final String username = "gusrb0004@naver.com"; // 실제 정보로 변경 필요
        final String password = "jhk789"; // 실제 정보로 변경 필요

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.naver.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("계정 정보 복구");
            message.setText(content);

            Transport.send(message);
            System.out.println("Email sent successfully to: " + to);
        } catch (Exception e) { // 여기서 Exception으로 모든 예외를 처리합니다.
            e.printStackTrace();
            System.out.println("Failed to send email to: " + to);
        }
    }

    private String generateTempPassword(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder builder = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            builder.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
        }
        return builder.toString();
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
            throw new RuntimeException("Hashing algorithm not found.", e);
        }
    }
}
