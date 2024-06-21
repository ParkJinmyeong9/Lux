package shopper.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DurationMgr {
	
	private DBConnectionMgr pool;
    
	public DurationMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//일간 매출
	public boolean DailyDuration(String date) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	
		
	}
	
}
