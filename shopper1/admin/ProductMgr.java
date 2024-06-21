// ProductMgr.java
package shopper.admin;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class ProductMgr {
    private DBConnectionMgr pool;
    
    public ProductMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    
    public List<ProductBean> getProducts() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT ProductID, Name, CurrentBid, Photo FROM products ORDER BY BidCount DESC";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name")); // 'setn'이 아니라 'setName'이 맞습니다.
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) pool.freeConnection(con);
        }
        return productList;
    }
    
    //상품관리페이지에 띄울거
    public Vector<ProductBean> productList() {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT p.ProductID, u.Username, p.Name, p.Photo, p.ModelNumber, p.StartPrice, "
                    + "p.BuyNowPrice, p.CurrentBid, p.BidCount, p.Description, p.`Status`, "
                    + "p.CreatedAt, p.Gender, p.Brand, a.StartTime, a.EndTime, p.ModelNumber, p.Brand "
                    + "FROM products p "
                    + "LEFT JOIN users u "
                    + "ON p.SellerID = u.UserID "
                    + "LEFT JOIN auctions a "
                    + "ON p.ProductID = a.ProductID "
					+ "ORDER BY ProductID DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean = new ProductBean();
				pBean.setProductID(rs.getInt("ProductID"));
				pBean.setUsername(rs.getString("Username"));
				pBean.setName(rs.getString("Name"));
				pBean.setPhoto(rs.getString("Photo"));
				pBean.setModelNumber(rs.getString("ModelNumber"));
				pBean.setStartPrice(rs.getInt("StartPrice"));
				pBean.setBuyNowPrice(rs.getInt("BuyNowPrice"));
				pBean.setCurrentBid(rs.getInt("CurrentBid"));
				pBean.setBidCount(rs.getInt("BidCount"));
				pBean.setDescription(rs.getString("Description"));
				pBean.setStatus(rs.getString("Status"));
				pBean.setCreatedAt(rs.getString("CreatedAt"));
				pBean.setGender(rs.getString("Gender"));
				pBean.setBrand(rs.getString("Brand"));
				pBean.setStartTime(rs.getString("StartTime"));
				pBean.setEndTime(rs.getString("EndTime"));
				pBean.setModelNumber(rs.getString("ModelNumber"));
				pBean.setBrand(rs.getString("Brand"));
				vlist.addElement(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("ProductMgr -> productList 에서 문제 발생");
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
    }
    
    public boolean updateProducts(int productId, String status) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        boolean flag = false;
        
        try {
            con = pool.getConnection();
            sql = "UPDATE products SET STATUS = ? WHERE ProductID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, productId);
            if(pstmt.executeUpdate() == 1) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("ProductMgr -> updateProducts에서 문제 발생");
        } finally {
            pool.freeConnection(con, pstmt);
        }
        return flag;
    }
    
    //상품 삭제
    public boolean deleteProduct(int productId) {
    	
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM products WHERE ProductID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productId);
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
            System.err.println("ProductMgr -> deleteProduct에서 문제 발생");
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
    	
    }
    
    //테이블 정보 수정 버튼
    public boolean updateProduct2(ProductBean product) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE products p " 
				+ "LEFT outer JOIN auctions a ON a.ProductID = p.ProductID " 
				+ "SET p.Name = ?, p.ModelNumber = ?, p.Brand = ?, p.StartPrice = ?, " 
				+ "p.STATUS = ?, a.StartTime = ?, a.EndTime = ?, p.BuyNowPrice = ?, p.CurrentBid = ? " 
				+ "WHERE p.ProductID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getModelNumber());
            pstmt.setString(3, product.getBrand());
            pstmt.setDouble(4, product.getStartPrice());
            pstmt.setString(5, product.getStatus());

           pstmt.setString(6, product.getStartTime());
            pstmt.setString(7, product.getEndTime());
            

            pstmt.setDouble(8, product.getBuyNowPrice());
            pstmt.setDouble(9, product.getCurrentBid());
            pstmt.setInt(10, product.getProductID());
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
    
    //pwinnerID 추출
    public int SelectPwinnerID(int productID) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int PwinnerId = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT PWinnerID FROM products WHERE ProductID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PwinnerId = rs.getInt("PWinnerID");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return PwinnerId;
	
    }
}
