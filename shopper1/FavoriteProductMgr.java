package shopper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FavoriteProductMgr {
    
    private DBConnectionMgr pool;

    public FavoriteProductMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    public boolean addFavoriteProduct(int userId, int productId) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean isAdded = false;

        try {
            con = pool.getConnection();
            String sql = "INSERT INTO favoriteproducts (UserID, ProductID) VALUES (?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            
            int rowsAffected = pstmt.executeUpdate();
            isAdded = rowsAffected > 0;

        } catch (SQLException e) {
            // 필요에 따라 예외를 처리하거나 사용자 정의 예외로 다시 던질 수 있습니다.
            e.printStackTrace();
        } finally {
            // 자원을 안전하게 닫습니다.
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) pool.freeConnection(con);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isAdded;
    }

    public boolean removeFavoriteProduct(int userId, int productId) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean isRemoved = false;

        try {
            con = pool.getConnection();
            String sql = "DELETE FROM favoriteproducts WHERE UserID = ? AND ProductID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            
            int rowsAffected = pstmt.executeUpdate();
            isRemoved = rowsAffected > 0;

        } catch (SQLException e) {
            // 필요에 따라 예외를 처리하거나 사용자 정의 예외로 다시 던질 수 있습니다.
            e.printStackTrace();
        } finally {
            // 자원을 안전하게 닫습니다.
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) pool.freeConnection(con);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isRemoved;
    }

}
