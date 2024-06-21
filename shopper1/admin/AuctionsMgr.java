package shopper.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class AuctionsMgr {
	
	private DBConnectionMgr pool;
    
	public AuctionsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean isAuctions(int productID) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    boolean flag = false;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT COUNT(*) FROM auctions WHERE ProductID = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, productID);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            int count = rs.getInt(1);
	            if (count > 0) {
	                flag = true;
	            } else {
	                sql = "INSERT INTO auctions (ProductID) VALUES (?)";
	                pstmt = con.prepareStatement(sql);
	                pstmt.setInt(1, productID);
	                int rowsAffected = pstmt.executeUpdate();
	                if (rowsAffected > 0) {
	                    flag = true;
	                }
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return flag;
	}


	
	//Status를 경매중으로 바꿨을때 EndTime 수정
	public boolean updateAuctionsTime(int productID) throws Exception {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    boolean flag = false;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT p.AuctionDuration, a.StartTime, a.EndTime " +
	              "FROM auctions a " +
	              "LEFT JOIN products p " +
	              "ON a.ProductID = p.ProductID " +
	              "WHERE p.ProductID = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, productID);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int auctionDuration = rs.getInt("AuctionDuration");

	            LocalDateTime currentDateTime = LocalDateTime.now();

	            LocalDateTime endTime = currentDateTime.plusHours(auctionDuration);

	            String endTimeStr = endTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            
	            String currentDateTimeStr = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            
	            sql = "UPDATE auctions SET EndTime = ?, StartTime = ? WHERE ProductID = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, endTimeStr);
	            pstmt.setString(2, currentDateTimeStr);
	            pstmt.setInt(3, productID);
	            pstmt.executeUpdate();
	            flag = true; // 업데이트 성공을 표시
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    return flag;
	}
	
	public boolean updateAuctionsTime2(int productID) throws Exception {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    boolean flag = false;
	    try {
	        con = pool.getConnection();
	        sql = "SELECT p.AuctionDuration, a.StartTime, a.EndTime " +
	              "FROM auctions a " +
	              "LEFT JOIN products p " +
	              "ON a.ProductID = p.ProductID " +
	              "WHERE p.ProductID = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, productID);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int auctionDuration = rs.getInt("AuctionDuration");

	            LocalDateTime currentDateTime = LocalDateTime.now();

	            LocalDateTime endTime = currentDateTime.plusHours(auctionDuration);

	            String endTimeStr = endTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            
	            String currentDateTimeStr = currentDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
	            
	            sql = "UPDATE auctions SET EndTime = ?, StartTime = ? WHERE ProductID = ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, endTimeStr);
	            pstmt.setString(2, currentDateTimeStr);
	            pstmt.setInt(3, productID);
	            pstmt.executeUpdate();
	            flag = true; // 업데이트 성공을 표시
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    return flag;
	}
	
	public boolean AuctionEnd(int FinalPrice, int WinnerID, int productID) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    boolean flag = false;
	    try {
	        con = pool.getConnection();
	        sql = "UPDATE auctions " +
	                "SET FinalPrice = ?, WinnerID = ? " +
	                "WHERE productID = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, FinalPrice);
	        pstmt.setInt(2, WinnerID);
	        pstmt.setInt(3, productID);
	        int rowsAffected = pstmt.executeUpdate();
	        if (rowsAffected > 0) {
	            flag = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    return flag;
	}

	public int weekSale() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int TotalSales = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT SUM(FinalPrice) AS TotalSales "
					+ "FROM auctions "
					+ "WHERE EndTime BETWEEN DATE_ADD(NOW(), INTERVAL -1 WEEK) AND NOW()";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				TotalSales = rs.getInt(1);
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return TotalSales;
	
	}
	
	public int lweekSale() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int lTotalSales = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT SUM(FinalPrice) AS TotalSales "
					+ "FROM auctions "
					+ "WHERE EndTime BETWEEN DATE_SUB(NOW(), INTERVAL 14 DAY) AND DATE_SUB(NOW(), INTERVAL 7 DAY);";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				lTotalSales = rs.getInt(1);
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lTotalSales;
	
	}
	
	public int weekBuy( ) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int TotalBuy = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(ProductID) AS TotalBuy "
					+ "FROM products "
					+ "WHERE STATUS = '낙찰' and CreatedAt BETWEEN DATE_ADD(NOW(), INTERVAL -1 WEEK) AND NOW()";
			pstmt = con.prepareStatement(sql);		
			rs = pstmt.executeQuery();
			if (rs.next()) {
				TotalBuy = rs.getInt(1);
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return TotalBuy;
	
	}
	
	public int lweekBuy( ) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int lTotalBuy = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(ProductID) AS TotalBuy "
					+ "FROM products "
					+ "WHERE STATUS = '낙찰' and CreatedAt BETWEEN DATE_SUB(NOW(), INTERVAL 14 DAY) AND DATE_SUB(NOW(), INTERVAL 7 DAY);";
			pstmt = con.prepareStatement(sql);		
			rs = pstmt.executeQuery();
			if (rs.next()) {
				lTotalBuy = rs.getInt(1);
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lTotalBuy;
	
	}
	
	public int weekUpload() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalUpload = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(ProductID) AS TotalUpload "
					+ "FROM products "
					+ "WHERE CreatedAt BETWEEN DATE_ADD(NOW(), INTERVAL -1 WEEK) AND NOW()";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalUpload = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalUpload;
	
	}
	
	public int lweekUpload() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int ltotalUpload = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(ProductID) AS TotalUpload "
					+ "FROM products "
					+ "WHERE CreatedAt BETWEEN DATE_SUB(NOW(), INTERVAL 14 DAY) AND DATE_SUB(NOW(), INTERVAL 7 DAY)";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ltotalUpload = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ltotalUpload;
	
	}
	
	public int weekMale() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalMale = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) "
					+ "FROM products "
					+ "WHERE STATUS = '낙찰' AND Gender = 'Male' "
					+ "AND CreatedAt BETWEEN DATE_ADD(NOW(), INTERVAL -1 WEEK) AND NOW()";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalMale = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalMale;
	
	}
	
	public int lweekMale() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int ltotalMale = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) "
					+ "FROM products "
					+ "WHERE STATUS = '낙찰' AND Gender = 'Male' "
					+ "AND CreatedAt BETWEEN DATE_SUB(NOW(), INTERVAL 14 DAY) AND DATE_SUB(NOW(), INTERVAL 7 DAY);";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ltotalMale = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ltotalMale;
	
	}
	
	public int weekFemale() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalFemale = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) "
					+ "FROM products "
					+ "WHERE STATUS = '낙찰' AND Gender = 'Female' "
					+ "AND CreatedAt BETWEEN DATE_ADD(NOW(), INTERVAL -1 WEEK) AND NOW()";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalFemale = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalFemale;
	}
	
	public int lweekFemale() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int ltotalFemale = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) "
					+ "FROM products "
					+ "WHERE STATUS = '낙찰' AND Gender = 'Female' "
					+ "AND CreatedAt BETWEEN DATE_SUB(NOW(), INTERVAL 14 DAY) AND DATE_SUB(NOW(), INTERVAL 7 DAY)";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ltotalFemale = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ltotalFemale;
	}
	
}
