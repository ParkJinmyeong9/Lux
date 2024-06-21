// ReviewMgr.java
package shopper.admin;

import java.sql.*;
import java.util.Vector;

public class ReviewMgr {
    private DBConnectionMgr pool;
    
    public ReviewMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    
    //전체 리뷰 SELECT
    public Vector<ReviewBean> getReview() {
    	
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT r.*, p.Name, u.Username, p.productID " +
		             "FROM reviews r " +
		             "INNER JOIN products p ON r.ProductID = p.ProductID " +
		             "INNER JOIN users u ON r.AuthorID = u.UserID " +
		             "ORDER BY ReviewID DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean rBean = new ReviewBean();
				rBean.setReviewID(rs.getInt("ReviewID"));
				rBean.setName(rs.getString("Name"));
				rBean.setUserName(rs.getString("Username"));
				rBean.setRating(rs.getInt("Rating"));
				rBean.setContent(rs.getString("Content"));
				rBean.setCreatedAt(rs.getString("CreatedAt"));
				rBean.setProductID(rs.getInt("productID"));
				vlist.addElement(rBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("ReviewMgr -> getReview 에서 문제 발생");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return vlist;
	
    }
    
    public boolean deleteReview(int reviewId) {
    	
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM reviews WHERE ReviewID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reviewId);
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
    }
}
