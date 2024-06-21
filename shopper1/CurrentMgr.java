package shopper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CurrentMgr {
    private DBConnectionMgr pool;
    
    public CurrentMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    
    // 현재 상태 정보 조회 메서드
    public CurrentBean getCurrentStatus(int CurrentID) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CurrentBean current = null;
        
        try {
            conn = pool.getConnection();
            String sql = "SELECT * FROM current WHERE CurrentID=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, CurrentID);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                current = new CurrentBean();
                current.setCurrentID(rs.getInt("currentID"));
                current.setCProductID(rs.getInt("cProductID"));
                current.setWaybillNum(rs.getInt("waybillNum"));
                current.setCUserID(rs.getInt("cuserID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(conn, pstmt, rs);
        }
        
        return current;
    }
    
    public void insertCurrent(int productId, int userId, int userBid) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = pool.getConnection();
            String sql = "INSERT INTO current (CProductID, CUserID, WaybillNum) VALUES (?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productId);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, userBid);
            
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    
}