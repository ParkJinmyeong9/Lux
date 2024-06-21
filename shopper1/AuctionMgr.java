package shopper;
import java.sql.*;
import java.util.Vector;

public class AuctionMgr {
    private DBConnectionMgr pool;
    
    public AuctionMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    public Vector<MyPageBean> bidList(int userID){
        Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       Vector<MyPageBean> vlist = new Vector<MyPageBean>();
       try {
          con = pool.getConnection();
          sql = "SELECT p.ProductID, p.Name, MAX(c.WaybillNum) AS WaybillNum "
                + "FROM CURRENT c "
                + "LEFT JOIN products p ON c.CProductID = p.ProductID "
                + "LEFT JOIN users u ON u.userID = c.CUserID "
                + "WHERE c.CUserID = ? "
                + "GROUP BY p.ProductID, p.Name "
                + "ORDER BY MAX(c.WaybillNum) DESC ";
          pstmt = con.prepareStatement(sql);
          pstmt.setInt(1, userID);
          rs = pstmt.executeQuery();
          while(rs.next()) {
             MyPageBean mBean = new MyPageBean();
             mBean.setProductID(rs.getInt("ProductID"));
                 mBean.setName(rs.getString("Name"));
                 mBean.setWaybillNum(rs.getInt("WaybillNum"));
                 vlist.addElement(mBean);
          }
       } catch (Exception e) {
          e.printStackTrace();
       } finally {
          pool.freeConnection(con, pstmt, rs);
       }
       return vlist;
     }
    public int maxWaybill(int prouctID) {
        Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       int maxBill = 0;
       try {
          con = pool.getConnection();
          sql = "SELECT WaybillNum "
                + "FROM CURRENT "
                + "WHERE CProductID = ? "
                + "ORDER BY WaybillNum DESC "
                + "LIMIT 1";
          pstmt = con.prepareStatement(sql);
          pstmt.setInt(1, prouctID);
          rs = pstmt.executeQuery();
          if(rs.next()) {
             maxBill = rs.getInt(1);
          }
       } catch (Exception e) {
          e.printStackTrace();
       } finally {
          pool.freeConnection(con, pstmt, rs);
       }
       return maxBill;
    
     }
    public Vector<MyPageBean> outstandingList(int winnerID) {
        
        Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       Vector<MyPageBean> vlist = new Vector<MyPageBean>();
       try {
          con = pool.getConnection();
          sql = "SELECT u.username, p.Name, p.`Status`, a.FinalPrice, p.ProductID "
                + "FROM auctions a "
                + "LEFT JOIN products p "
                + "ON a.ProductID = p.ProductID "
                + "LEFT JOIN users u "
                + "ON u.userID = p.SellerID "
                + "WHERE STATUS = '낙찰' AND a.WinnerID = ?";
          pstmt = con.prepareStatement(sql);
          pstmt.setInt(1, winnerID);
          rs = pstmt.executeQuery();
          while (rs.next()) {
             MyPageBean mBean = new MyPageBean();
                 mBean.setUsername(rs.getString("username"));
                 mBean.setName(rs.getString("Name"));
                 mBean.setStatus(rs.getString("Status"));
                 mBean.setFinalPrice(rs.getInt("FinalPrice"));
                 mBean.setProductID(rs.getInt("ProductID"));
                 vlist.addElement(mBean);
             }
       } catch (Exception e) {
          e.printStackTrace();
          System.err.println("에러뜸 ㅅㄱ");
       } finally {
          pool.freeConnection(con, pstmt, rs);
       }
       return vlist;

     }
     
     public Vector<MyPageBean> orderList(int winnerID) {
        
        Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       Vector<MyPageBean> vlist = new Vector<MyPageBean>();
       try {
          con = pool.getConnection();
          sql = "SELECT u.username, p.Name, p.`Status`, a.FinalPrice, p.ProductID "
                + "FROM auctions a "
                + "LEFT JOIN products p "
                + "ON a.ProductID = p.ProductID "
                + "LEFT JOIN users u "
                + "ON u.userID = p.SellerID "
                + "WHERE a.WinnerID = ? "
                + "   AND p.`Status` = '배송준비중' "
                + "   OR p.`Status` = '배송 중'";
          pstmt = con.prepareStatement(sql);
          pstmt.setInt(1, winnerID);
          rs = pstmt.executeQuery();
          while(rs.next()) {
             MyPageBean mBean = new MyPageBean();
             mBean.setUsername(rs.getString("username"));
                 mBean.setName(rs.getString("Name"));
                 mBean.setStatus(rs.getString("Status"));
                 mBean.setFinalPrice(rs.getInt("FinalPrice"));
                 mBean.setProductID(rs.getInt("ProductID"));
                 vlist.addElement(mBean);
          }
       } catch (Exception e) {
          e.printStackTrace();
       } finally {
          pool.freeConnection(con, pstmt, rs);
       }
       return vlist;
    
        
     }
     //경매추가
     public boolean updateAuctionStatusAndUserBalance(int productId, int userId, String newStatus, int purchaseAmount) throws Exception {
    	    Connection con = null;
    	    PreparedStatement updateAuctionStmt = null;
    	    PreparedStatement updateBalanceStmt = null;
    	    boolean updateResult = false;

    	    try {
    	        con = pool.getConnection();

    	        
    	        // 트랜잭션 시작
    	        con.setAutoCommit(false);

    	        // 경매 상태를 업데이트하는 쿼리
    	        String sqlUpdateAuction = "UPDATE products p "
    	        		+ "LEFT JOIN auctions a ON p.ProductID = a.ProductID "
    	        		+ "SET p.`Status` = ? "
    	        		+ "WHERE p.ProductID = ? AND a.WinnerID = ?";
    	        updateAuctionStmt = con.prepareStatement(sqlUpdateAuction);
    	        updateAuctionStmt.setString(1, newStatus);
    	        updateAuctionStmt.setInt(2, productId);
    	        updateAuctionStmt.setInt(3, userId);
    	        int auctionRowsAffected = updateAuctionStmt.executeUpdate();

    	        // 사용자 잔액을 업데이트하는 쿼리
    	        String sqlUpdateBalance = "UPDATE users SET balance = balance - ? WHERE userID = ?";
    	        updateBalanceStmt = con.prepareStatement(sqlUpdateBalance);
    	        updateBalanceStmt.setInt(1, purchaseAmount);
    	        updateBalanceStmt.setInt(2, userId);
    	        int balanceRowsAffected = updateBalanceStmt.executeUpdate();

    	        // 두 쿼리 모두 성공적으로 실행되면
    	        if (auctionRowsAffected > 0 && balanceRowsAffected > 0) {
    	            // 변경사항 커밋
    	            con.commit();
    	            updateResult = true;
    	        } else {
    	            // 변동이 없으면 롤백
    	            con.rollback();
    	        }
    	    } catch (SQLException e) {
    	        // 오류 발생 시 롤백
    	        if (con != null) {
    	            try {
    	                con.rollback();
    	            } catch (SQLException ex) {
    	                ex.printStackTrace();
    	            }
    	        }
    	        e.printStackTrace();
    	    } finally {
    	        // 리소스 해제
    	        try {
    	            if (updateAuctionStmt != null) updateAuctionStmt.close();
    	            if (updateBalanceStmt != null) updateBalanceStmt.close();
    	            if (con != null) {
    	                con.setAutoCommit(true); // 자동 커밋 설정을 원래대로 돌려놓음
    	                con.close();
    	            }
    	        } catch (SQLException e) { e.printStackTrace(); }
    	    }

    	    return updateResult;
    	}



 // 경매 정보를 가져오는 메소드
    public AuctionBean getAuction(int ProductID) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        AuctionBean auctionBean = null;

        try {
            con = pool.getConnection();
            String query = "SELECT * FROM auctions WHERE ProductID = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, ProductID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                auctionBean = new AuctionBean();
                auctionBean.setAuctionID(rs.getInt("AuctionID"));
                auctionBean.setProductID(rs.getInt("ProductID"));
                auctionBean.setStartTime(rs.getString("StartTime"));
                auctionBean.setEndTime(rs.getString("EndTime"));
                auctionBean.setWinnerID(rs.getInt("WinnerID"));
                auctionBean.setFinalPrice(rs.getInt("FinalPrice"));
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
            if (con != null) {
                pool.freeConnection(con);
            }
        }

        return auctionBean != null ? auctionBean : new AuctionBean();
    }    
    
 // 경매에서 즉시 구매한 경우 Auction 테이블의 WinnerID와 FinalPrice를 업데이트하는 메서드
    public void updateAuctionForBuyNow(int productId, int userId, int buyNowPrice) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
        	con = pool.getConnection();
            // 해당 상품의 경매 정보를 가져오기 위해 ProductID를 사용하여 AuctionID를 검색합니다.
            String selectAuctionIdQuery = "SELECT AuctionID FROM auctions WHERE ProductID = ?";
            pstmt = con.prepareStatement(selectAuctionIdQuery);
            pstmt.setInt(1, productId);
            ResultSet rs = pstmt.executeQuery();
            
            int auctionId = 0;
            if (rs.next()) {
                auctionId = rs.getInt("AuctionID");
            }
            rs.close();
            pstmt.close();

            // WinnerID와 FinalPrice를 업데이트하는 쿼리를 실행합니다.
            String updateQuery = "UPDATE auctions SET WinnerID = ?, FinalPrice = ? WHERE AuctionID = ?";
            pstmt = con.prepareStatement(updateQuery);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, buyNowPrice);
            pstmt.setInt(3, auctionId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                pool.freeConnection(con);
            }
        }
    }
    
    
}