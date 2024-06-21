package shopper.admin;

import com.google.gson.Gson;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PaymentsMgr {
	
	private DBConnectionMgr pool;
	    
	public PaymentsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<PaymentsBean> PaymentsList() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PaymentsBean> vlist = new Vector<PaymentsBean>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * from payments";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaymentsBean pBean = new PaymentsBean();
				pBean.setPaymentID(rs.getInt("PaymentID"));
				pBean.setUserID(rs.getInt("UserID"));
				pBean.setProductID(rs.getInt("ProductID"));
				pBean.setTransactionID(rs.getString("TransactionID"));
				pBean.setAmount(rs.getInt("Amount"));
				pBean.setPaymentMethod(rs.getString("PaymentMethod"));
				pBean.setPaymentStatus(rs.getString("PaymentStatus"));
				vlist.addElement(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("PaymentMgr -> PaymentList에서 문제 발생");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	
	}
	
	//saleFooter.jsp PieChart에 들어갈 데이터들
	public String sumAmount() {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    Vector<PaymentSummaryBean> summaryList = new Vector<PaymentSummaryBean>();
	    Gson gson = new Gson();
	    try {
	        con = pool.getConnection();
	        sql = "SELECT PaymentMethod, SUM(Amount) AS TotalAmount FROM payments GROUP BY PaymentMethod";
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            PaymentSummaryBean summaryBean = new PaymentSummaryBean();
	            summaryBean.setPaymentMethod(rs.getString("PaymentMethod"));
	            summaryBean.setTotalAmount(rs.getInt("TotalAmount"));
	            summaryList.addElement(summaryBean);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.err.println("PaymentMgr -> sumAmount에서 문제 발생");
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return gson.toJson(summaryList);
	}
	
	//올해 차트
	public String sumYearAmount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PaymentSummaryBean> summaryList = new Vector<PaymentSummaryBean>();
		Gson gson = new Gson();
		try {
			con = pool.getConnection();
			sql = "SELECT " +
                    "DATE_FORMAT(t.EndTime, '%Y') AS Year, " +
                    "DATE_FORMAT(t.EndTime, '%m') AS Month, " +
                    "CASE WHEN a.TotalFinalPrice IS NULL THEN 0 " +
                    "     ELSE a.TotalFinalPrice " +
                    "END AS TotalFinalPrice " +
                    "FROM ( " +
                    "  SELECT '2024-01-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-02-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-03-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-04-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-05-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-06-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-07-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-08-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-09-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-10-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-11-01' AS EndTime UNION ALL " +
                    "  SELECT '2024-12-01' AS EndTime " +
                    ") AS t " +
                    "LEFT JOIN ( " +
                    "  SELECT " +
                    "    DATE_FORMAT(EndTime, '%Y') AS Year, " +
                    "    DATE_FORMAT(EndTime, '%m') AS Month, " +
                    "    SUM(FinalPrice) AS TotalFinalPrice " +
                    "  FROM auctions " +
                    "  WHERE YEAR(EndTime) = YEAR(CURDATE()) " +
                    "  GROUP BY Year, Month " +
                    ") AS a ON a.Year = DATE_FORMAT(t.EndTime, '%Y') AND a.Month = DATE_FORMAT(t.EndTime, '%m') " +
                    "ORDER BY Month;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
	            PaymentSummaryBean sBean = new PaymentSummaryBean();
	            sBean.setYear(rs.getInt("Year"));
	            sBean.setMonth(rs.getString("Month"));
	            sBean.setTotalFinalPrice(rs.getInt("TotalFinalPrice"));
	            summaryList.addElement(sBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("PaymentMgr -> sumYearAmount에서 문제 발생");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return gson.toJson(summaryList);
	}
	
	//작년 차트
	public String sumLastYearAmount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PaymentSummaryBean> summaryList = new Vector<PaymentSummaryBean>();
		Gson gson = new Gson();
		try {
			con = pool.getConnection();
			sql = "SELECT " +
                    "DATE_FORMAT(t.EndTime, '%Y') AS Year, " +
                    "DATE_FORMAT(t.EndTime, '%m') AS Month, " +
                    "CASE WHEN a.TotalFinalPrice IS NULL THEN 0 " +
                    "     ELSE a.TotalFinalPrice " +
                    "END AS TotalFinalPrice " +
                    "FROM ( " +
                    "  SELECT '2023-01-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-02-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-03-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-04-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-05-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-06-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-07-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-08-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-09-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-10-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-11-01' AS EndTime UNION ALL " +
                    "  SELECT '2023-12-01' AS EndTime " +
                    ") AS t " +
                    "LEFT JOIN ( " +
                    "  SELECT " +
                    "    DATE_FORMAT(EndTime, '%Y') AS Year, " +
                    "    DATE_FORMAT(EndTime, '%m') AS Month, " +
                    "    SUM(FinalPrice) AS TotalFinalPrice " +
                    "  FROM auctions " +
                    "  WHERE YEAR(EndTime) = YEAR(CURDATE()) - 1 " +
                    "  GROUP BY Year, Month " +
                    ") AS a ON a.Year = DATE_FORMAT(t.EndTime, '%Y') AND a.Month = DATE_FORMAT(t.EndTime, '%m') " +
                    "ORDER BY Month;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
	            PaymentSummaryBean sBean = new PaymentSummaryBean();
	            sBean.setYear(rs.getInt("Year"));
	            sBean.setMonth(rs.getString("Month"));
	            sBean.setTotalFinalPrice(rs.getInt("TotalFinalPrice"));
	            summaryList.addElement(sBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("PaymentMgr -> sumYearAmount에서 문제 발생");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return gson.toJson(summaryList);
	}
	
}
