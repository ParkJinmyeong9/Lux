package shopper.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class UserMgr {
	
	private DBConnectionMgr pool;
	
	public UserMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//전체 유저 SELECT
	public Vector<UserBean> getUser() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserBean> vlist = new Vector<UserBean>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT userID, username, email, name, gender, "
					+ "phone, created_at, birthdate, balance "
					+ "FROM users "
					+ "ORDER BY userID DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserBean uBean = new UserBean();
				uBean.setUserID(rs.getInt("userID"));
				uBean.setUsername(rs.getString("Username"));
				uBean.setEmail(rs.getString("email"));
				uBean.setName(rs.getString("name"));
				uBean.setGender(rs.getString("gender"));
				uBean.setPhone(rs.getString("phone"));
				uBean.setCreated_at(rs.getString("created_at"));
				uBean.setBirthdate(rs.getString("birthdate"));
				uBean.setBalance(rs.getInt("balance"));
				vlist.addElement(uBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("UserMgr -> getUser 에서 문제 발생");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//유저 정보 수정(Update) !!!!!!!!!!미완!!!!!!!!!!!!!
	public boolean userUpdate(int UserID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update users set ";
			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public int countUser() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxUser = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(UserID) FROM users";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
	            maxUser = rs.getInt(1);
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxUser;
	}
	
	public boolean deleteUser(int userId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM users WHERE UserID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userId);
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
	
	public int countWeekUser() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxWeekUser = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(UserID) "
					+ "FROM users "
					+ "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 WEEK)";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				maxWeekUser = rs.getInt(1);
	        }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxWeekUser;
	
	}
}
