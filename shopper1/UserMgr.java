package shopper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserMgr {
    private DBConnectionMgr pool;
    
    public UserMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    public String getUsernameById(int userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String username = "";

        try {
            con = pool.getConnection();
            String sql = "SELECT username FROM users WHERE userID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                username = rs.getString("username");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return username;
    }

    public UserBean getUserBalance(int userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        UserBean user = null;

        try {
            con = pool.getConnection(); // 데이터베이스 연결 풀에서 연결 가져오기
            String sql = "SELECT * FROM users WHERE userID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	 user = new UserBean();
                 user.setUserID(rs.getInt("userID"));
                 user.setUsername(rs.getString("username"));
                 user.setPassword(rs.getString("password"));
                 user.setEmail(rs.getString("email"));
                 user.setPhone(rs.getString("phone"));
                 user.setName(rs.getString("name"));
                 user.setAddress(rs.getString("address"));
                 user.setAdmin(rs.getBoolean("isAdmin"));
                 user.setBalance(rs.getInt("balance"));
                 user.setName(rs.getString("name"));
                 user.setGender(rs.getString("gender"));
                 user.setPostcode(rs.getString("postcode"));
                 user.setDetailAddress(rs.getString("detailaddress"));
                 user.setExtraAddress(rs.getString("extraaddress"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }
    
    public void updateUserBalance(UserBean user) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection(); // 데이터베이스 연결 풀에서 연결 가져오기
            String sql = "UPDATE users SET balance = ? WHERE userID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, user.getBalance());
            pstmt.setInt(2, user.getUserID());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	pool.freeConnection(con, pstmt);
        }
    }   

}
