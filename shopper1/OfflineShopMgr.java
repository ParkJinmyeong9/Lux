package shopper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class OfflineShopMgr {
	
	private DBConnectionMgr pool;
    
    public OfflineShopMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    
    public Vector<OfflineShopBean> getOfflineShop() {
    	
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OfflineShopBean> vlist = new Vector<OfflineShopBean>();
		try {
			con = pool.getConnection();
			sql = "select * from offlineshops";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				OfflineShopBean bean = new OfflineShopBean();
				bean.setShopID(rs.getInt("ShopID"));
				bean.setLocation(rs.getString("Location"));
				bean.setLatitude(rs.getString("Latitude"));
				bean.setLongitude(rs.getString("Longitude"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
    }
}
