package shopper;

import java.security.MessageDigest;
import java.time.LocalDate;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class UserManager {
	public boolean addUser(User user) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    try {
	        conn = DBConnectionMgr.getInstance().getConnection();
	        
	        // `isAdmin` 컬럼 추가
	        String sql = "INSERT INTO users(username, password, email, name, gender, phone, birthdate, address, postcode, detailAddress, extraAddress, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, user.getUsername());
	        pstmt.setString(2, user.getPassword()); // 비밀번호 해싱 적용 필요
	        pstmt.setString(3, user.getEmail());
	        pstmt.setString(4, user.getName());
	        pstmt.setString(5, user.getGender());
	        pstmt.setString(6, user.getPhone());
	        pstmt.setDate(7, Date.valueOf(user.getBirthdate()));
	        pstmt.setString(8, user.getAddress());
	        pstmt.setString(9, user.getPostcode());
	        pstmt.setString(10, user.getDetailAddress());
	        pstmt.setString(11, user.getExtraAddress());
	        pstmt.setBoolean(12, user.isAdmin()); // `isAdmin` 값 설정

	        int result = pstmt.executeUpdate();
	        return result > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	        // 리소스 해제
	        try {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	public boolean updateUserAddress(int userId, String address, String detailAddress, String postcode, String extraAddress) {
	    boolean result = false;
	    
	    String sql = "UPDATE users SET address = ?, detailaddress = ?, postcode = ?, extraaddress = ? WHERE userID = ?";
	    
	    try (Connection conn = DBConnectionMgr.getInstance().getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        
	        pstmt.setString(1, address);
	        pstmt.setString(2, detailAddress);
	        pstmt.setString(3, postcode);
	        pstmt.setString(4, extraAddress);
	        pstmt.setInt(5, userId);

	        int updateCount = pstmt.executeUpdate();
	        result = updateCount > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}

	  public boolean deleteUser(int userId) throws Exception {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        try {
	            conn = DBConnectionMgr.getInstance().getConnection();
	            String sql = "DELETE FROM users WHERE userID = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, userId);
	            int affectedRows = pstmt.executeUpdate();
	            return affectedRows > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        } finally {
	            try {
	                if (pstmt != null) pstmt.close();
	                if (conn != null) conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    public boolean checkPassword(int userId, String inputPassword) {
	    	System.out.println("Checking password: " + inputPassword);
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        try {
	            conn = DBConnectionMgr.getInstance().getConnection();
	            String sql = "SELECT password FROM users WHERE userID = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, userId);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                String storedPassword = rs.getString("password"); // 데이터베이스에 저장된 해시
	                String hashedInputPassword = hashPassword(inputPassword); // 입력된 비밀번호 해시
	                return storedPassword.equals(hashedInputPassword);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();  // 예외 로깅
	        } finally {
	            try {
	                if (rs != null) rs.close();
	                if (pstmt != null) pstmt.close();
	                if (conn != null) conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();  // 예외 로깅
	            }
	        }
	        return false;  // 기본 반환 값은 false로 설정, 적절한 예외 처리 후 반환
	    }

	    public boolean updatePassword(int userId, String newPassword) throws Exception {
	    	System.out.println("Updating password: " + newPassword); // 로그 추가
	        Connection conn = null;
	        PreparedStatement pstmt = null;

	        try {
	            conn = DBConnectionMgr.getInstance().getConnection();
	            String hashedNewPassword = hashPassword(newPassword); // Hash the new password
	            String sql = "UPDATE users SET password = ? WHERE userID = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, hashedNewPassword);
	            pstmt.setInt(2, userId);

	            int result = pstmt.executeUpdate();
	            return result > 0;
	        } finally {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        }
	    }
	public User authenticateUser(String username, String password) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	        conn = DBConnectionMgr.getInstance().getConnection();
	        String hashedPassword = hashPassword(password); // 암호 해싱 로직은 별도로 정의되어야 합니다.

	        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, username);
	        pstmt.setString(2, hashedPassword);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            User user = new User();
	            user.setUserID(rs.getInt("userID"));
	            user.setUsername(rs.getString("username"));
	            user.setPassword(rs.getString("password")); // 비밀번호는 일반적으로 객체에 저장하지 않습니다.
	            user.setEmail(rs.getString("email"));
	            user.setName(rs.getString("name"));
	            user.setGender(rs.getString("gender"));
	            user.setPhone(rs.getString("phone"));
	            user.setBirthdate(rs.getDate("birthdate").toLocalDate()); // LocalDate 변환
	            user.setBalance(rs.getInt("balance"));
	            user.setAdmin(rs.getBoolean("isAdmin"));

	            // 주소 정보 설정
	            user.setAddress(rs.getString("address"));
	            user.setDetailAddress(rs.getString("detailaddress"));
	            user.setPostcode(rs.getString("postcode"));
	            user.setExtraAddress(rs.getString("extraaddress"));

	            return user;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
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
    public boolean updateUserBalance(int userId, String prize) {
        int amount = extractNumber(prize); // 숫자로만 이루어진 부분을 추출하여 정수로 변환
        return updateUserBalance(userId, amount);
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
    public boolean updateUserBalance(	int userId, int amount) {
        Connection conn = null;
        PreparedStatement pstmtSelect = null;
        PreparedStatement pstmtUpdate = null;
        ResultSet rs = null;
        boolean result = false;
        
        try {
            try {
				conn = DBConnectionMgr.getInstance().getConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
            conn.setAutoCommit(false); // 트랜잭션 시작
            
            // 기존 잔액 조회
            String selectSql = "SELECT balance FROM users WHERE UserID = ?";
            pstmtSelect = conn.prepareStatement(selectSql);
            pstmtSelect.setInt(1, userId);
            rs = pstmtSelect.executeQuery();
            if (!rs.next()) {
                System.out.println("No user found with ID: " + userId); // 유저가 없을 경우 로그
                return false; // 여기서 중단
            }
            
            int currentBalance = rs.getInt("balance");
            int newBalance = currentBalance + amount; // 새 잔액 계산
            System.out.println("Current balance: " + currentBalance + ", Amount: " + amount + ", New balance: " + newBalance);
            
            // 잔액 업데이트
            String updateSql = "UPDATE users SET balance = ? WHERE userID = ?";
            pstmtUpdate = conn.prepareStatement(updateSql);
            pstmtUpdate.setInt(1, newBalance);
            pstmtUpdate.setInt(2, userId);
            int updateCount = pstmtUpdate.executeUpdate();
            if (updateCount > 0) {
                conn.commit(); // 변경 사항 커밋
                result = true;
                System.out.println("Balance updated successfully for user ID: " + userId);
            } else {
                conn.rollback(); // 롤백
                System.out.println("Update failed, rolled back changes for user ID: " + userId);
            }
        } catch (SQLException e) {
            System.out.println("Error updating balance: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("Exception occurred, rolled back changes for user ID: " + userId);
                } catch (SQLException se) {
                    System.out.println("Error during rollback: " + se.getMessage());
                }
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmtSelect != null) pstmtSelect.close();
                if (pstmtUpdate != null) pstmtUpdate.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
        return result;
    }
    
    public boolean decreaseUserBalance(int userId, int amount) {
        Connection conn = null;
        PreparedStatement pstmtSelect = null;
        PreparedStatement pstmtUpdate = null;
        ResultSet rs = null;
        boolean result = false;

        try {
            conn = DBConnectionMgr.getInstance().getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 기존 잔액 조회
            String selectSql = "SELECT balance FROM users WHERE UserID = ?";
            pstmtSelect = conn.prepareStatement(selectSql);
            pstmtSelect.setInt(1, userId);
            rs = pstmtSelect.executeQuery();

            if (rs.next()) {
                int currentBalance = rs.getInt("balance");
                if (currentBalance >= amount) {
                    // 잔액이 충분한 경우, 잔액 업데이트
                    int newBalance = currentBalance - amount;
                    String updateSql = "UPDATE users SET balance = ? WHERE userID = ?";
                    pstmtUpdate = conn.prepareStatement(updateSql);
                    pstmtUpdate.setInt(1, newBalance);
                    pstmtUpdate.setInt(2, userId);
                    int updateCount = pstmtUpdate.executeUpdate();
                    if (updateCount > 0) {
                        conn.commit(); // 변경 사항 커밋
                        result = true;
                    } else {
                        conn.rollback(); // 롤백
                    }
                } else {
                    conn.rollback(); // 잔액 부족, 롤백
                }
            }
        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmtSelect != null) pstmtSelect.close();
                if (pstmtUpdate != null) pstmtUpdate.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    public int getUserBalance(int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT balance FROM users WHERE userID = ?";
        int balance = 0;
        
        try {
            conn = DBConnectionMgr.getInstance().getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            rs = pstmt.executeQuery();
            if(rs.next()) {
                balance = rs.getInt("balance");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return balance;
    }




}