// ProductMgr.java
package shopper;

import java.sql.*;
import java.util.Random;
import java.util.ArrayList;
import java.util.List;

public class ProductMgr {
    private DBConnectionMgr pool;
    
    public ProductMgr() {
        pool = DBConnectionMgr.getInstance();
    }
    public List<ProductBean> getFailedAuctions(int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();

        try {
            conn = pool.getConnection();
            // 업데이트된 쿼리
            String sql = "SELECT p.ProductID, p.Name, a.FinalPrice, MAX(c.WaybillNum) AS WaybillNum " +
                         "FROM current c " +
                         "LEFT JOIN auctions a ON c.CProductID = a.ProductID " +
                         "LEFT JOIN products p ON p.ProductID = c.CProductID " +
                         "WHERE CUserID = ? " +
                         "GROUP BY p.Name, c.WaybillNum, a.FinalPrice, p.ProductID " +
                         "ORDER BY WaybillNum DESC " +
                         "LIMIT 1";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductBean product = new ProductBean();
                AuctionBean auction = new AuctionBean();
                CurrentBean current = new CurrentBean();

                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                auction.setFinalPrice(rs.getInt("FinalPrice"));
                current.setWaybillNum(rs.getInt("WaybillNum"));

                product.setAuction(auction);
                product.setCurrent(current);

                productList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return productList;
    }
   

    public List<ProductBean> getProductsBySeller(int sellerID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();

        try {
            conn = pool.getConnection();
            String sql = "SELECT * FROM products WHERE SellerID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, sellerID);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setStatus(rs.getString("Status"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setBuyNowPrice(rs.getInt("BuyNowPrice"));
                // ... 다른 상품 속성들을 여기에 추가 ...
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { pool.freeConnection(conn); } catch (Exception e) {}
        }

        return productList;
    }
    public List<ProductBean> getProductsByStatus(String status, int limit) {
        List<ProductBean> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM products WHERE Status = ? ORDER BY BidCount DESC LIMIT ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, status); // 상태를 동적으로 설정
            pstmt.setInt(2, limit);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                // ResultSet에서 Status 값을 가져와서 ProductBean에 설정
                product.setStatus(rs.getString("Status"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 정리
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) pool.freeConnection(con);
        }
        return productList;
    }
 // ProductMgr.java에서 남성 상품만 가져오는 메소드 추가
    public List<ProductBean> getProductsByGender(String gender, int limit) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        try {
            con = pool.getConnection();
            // Gender 조건과 "경매중" 상태 조건을 추가합니다.
            String sql = "SELECT ProductID, Name, CurrentBid, Photo, BidCount FROM products WHERE Gender=? AND Status='경매중' ORDER BY BidCount DESC LIMIT ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, gender); // 첫 번째 '?'에 성별 조건 설정
            pstmt.setInt(2, limit); // 두 번째 '?'에 limit 설정
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                // 상품 리스트에 추가
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 정리
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return productList;
    }

    
    public ProductBean getRandomMaleProduct(String Gender) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ProductBean product = null;
        try {
            con = pool.getConnection();
            // Status 조건을 추가하여 '경매중'인 남성 상품만 랜덤하게 가져옵니다.
            String sql = "SELECT * FROM products WHERE Gender= ? AND Status='경매중' ORDER BY RAND() LIMIT 1";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, Gender);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                product.setDescription(rs.getString("Description")); // Description 필드 설정
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return product;
    }
    //낙찰
    public List<ProductBean> getAuctionedProducts() {
        List<ProductBean> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM products WHERE STATUS='낙찰'";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setDescription(rs.getString("Description"));
                product.setStartPrice(rs.getInt("StartPrice")); // 'StartBid'를 'StartPrice'로 변경
                product.setCurrentBid(rs.getInt("CurrentBid")); // getFloat에서 getInt로 변경
                product.setBidCount(rs.getInt("BidCount"));
                product.setStatus(rs.getString("Status"));
                product.setPhoto(rs.getString("Photo")); // 이 부분은 이미 String 타입이므로 변경 불필요
                // 추가적인 필드 설정
                // ...
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return productList;
    }
    
    public List<ProductBean> getAllProducts(int page, int recordsPerPage) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        int start = (page - 1) * recordsPerPage;

        // 페이지 값이 1보다 작은 경우, start 값을 0으로 설정합니다.
        if (start < 0) {
            start = 0;
        }

        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM products ORDER BY ProductID LIMIT ?, ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, start);
            pstmt.setInt(2, recordsPerPage);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductBean product = new ProductBean();
                // 여기에서 각 필드를 채웁니다. 예를 들어:
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                // 기타 필요한 필드들...
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 오류 로깅 및 처리를 여기서 수행합니다.
        } finally {
            // 자원 정리
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return productList;
    }
    public ProductBean getRandomFemaleProduct() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ProductBean product = null;
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM products WHERE Gender='Female' ORDER BY RAND() LIMIT 1";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                product.setDescription(rs.getString("Description")); // Description 필드 설정
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) pool.freeConnection(con);
        }
        return product;
    }
    public List<ProductBean> getRandomProducts(int count) {
        List<ProductBean> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection();
            // 상품이 "경매중"인 것만 랜덤하게 선택하도록 SQL 쿼리 수정
            String sql = "SELECT * FROM products WHERE Status='경매중' ORDER BY RAND() LIMIT ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, count);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                product.setDescription(rs.getString("Description"));
                
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 정리
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return productList;
    }

 // ProductMgr.java의 기존 코드를 유지하면서 새로운 메소드 추가
    public List<ProductBean> getImpendingMaleAuctions() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT p.* " +
                         "FROM auctions a JOIN products p ON a.ProductID = p.ProductID " +
                         "WHERE p.Gender='Male' AND a.FinalPrice IS NULL AND a.EndTime > NOW() " +
                         "ORDER BY a.EndTime ASC " +
                         "LIMIT 4";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                product.setDescription(rs.getString("Description"));
                // 추가적으로 필요한 다른 필드도 여기서 설정할 수 있습니다.
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
 // ProductMgr.java의 기존 코드를 유지하면서 새로운 메소드 추가
    public List<ProductBean> getImpendingFeMaleAuctions() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT p.* " +
                         "FROM auctions a JOIN products p ON a.ProductID = p.ProductID " +
                         "WHERE p.Gender='Female' AND a.FinalPrice IS NULL AND a.EndTime > NOW() " +
                         "ORDER BY a.EndTime ASC";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                product.setDescription(rs.getString("Description"));
                // 추가적으로 필요한 다른 필드도 여기서 설정할 수 있습니다.
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

 // ProductMgr.java의 기존 코드에 이 메서드를 추가합니다.
    public List<ProductBean> getProductsByBrand(String brand, int limit, String status) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        try {
            con = pool.getConnection();
            // Status 조건을 추가하여 '경매중'인 상품만 가져옵니다.
            String sql = "SELECT * FROM products WHERE Brand=? AND Status=? ORDER BY BidCount DESC LIMIT ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, brand);
            pstmt.setString(2, status);
            pstmt.setInt(3, limit);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                product.setDescription(rs.getString("Description"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return productList;
    }
    
    public List<ProductBean> getProductsByBrand(String brand, int page, int limit) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        int start = (page - 1) * limit;

        if (start < 0) {
            start = 0;
        }

        try {
            con = pool.getConnection();
            // Status 조건을 '경매중'으로 추가
            String sql = "SELECT * FROM products WHERE Brand=? AND Status='경매중' ORDER BY BidCount DESC LIMIT ?, ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, brand);
            pstmt.setInt(2, start);
            pstmt.setInt(3, limit);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                // 상품 데이터 설정
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setPhoto(rs.getString("Photo"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setGender(rs.getString("Gender"));
                product.setDescription(rs.getString("Description"));
                // 여기서 Status 설정을 추가합니다.
                product.setStatus(rs.getString("Status"));
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // 예외를 던지거나 적절한 예외 처리를 수행합니다.
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return productList;
    }
    
    public List<ProductBean> searchProducts(String query, String status) { //검색기능
        List<ProductBean> productList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM products WHERE Name LIKE ? AND STATUS = '경매중' ORDER BY BidCount DESC";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + query + "%");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setPhoto(rs.getString("Photo"));
                product.setModelNumber(rs.getString("ModelNumber"));
                product.setStartPrice(rs.getInt("StartPrice"));
                product.setBuyNowPrice(rs.getInt("BuyNowPrice"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setBidCount(rs.getInt("BidCount"));
                product.setDescription(rs.getString("Description"));
                product.setStatus(rs.getString("Status"));
                product.setCreatedAt(rs.getString("CreatedAt"));
                product.setGender(rs.getString("Gender"));
                product.setBrand(rs.getString("Brand"));
                productList.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 정리
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        return productList;
    }
    public int getNoOfRecords(String brand) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;
        try {
        	 con = pool.getConnection();
             String sql = "SELECT COUNT(*) FROM products WHERE Brand=?";
             pstmt = con.prepareStatement(sql);
             pstmt.setString(1, brand);
             rs = pstmt.executeQuery();
             if (rs.next()) {
                 count = rs.getInt(1);
             }
         } catch (Exception e) {
             e.printStackTrace();
         } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) pool.freeConnection(con);
        }
        return count;
    }
    
    public void insertProduct(ProductBean product) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        try {
            con = pool.getConnection();
            sql = "INSERT INTO products (Name, Brand, StartPrice, BuyNowPrice, AuctionDuration, Description, Photo, SellerID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getBrand());
            pstmt.setInt(3, product.getStartPrice());
            pstmt.setInt(4, product.getBuyNowPrice());
            pstmt.setInt(5, product.getAuctionDuration());
            pstmt.setString(6, product.getDescription());
            pstmt.setString(7, product.getPhoto());
            pstmt.setInt(8, product.getSellerID());
            
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    public ProductBean getProductById(int productId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ProductBean product = null;
        try {
            con = pool.getConnection();
            String sql = "SELECT Name, Photo, ModelNumber, StartPrice, BuyNowPrice, Description, CurrentBid, CreatedAt, Status, Brand FROM products WHERE ProductID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                product = new ProductBean();
                product.setName(rs.getString("Name"));
                product.setPhoto(rs.getString("Photo"));
                product.setModelNumber(rs.getString("ModelNumber"));
                product.setStartPrice(rs.getInt("StartPrice"));
                product.setBuyNowPrice(rs.getInt("BuyNowPrice"));
                product.setDescription(rs.getString("Description"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setCreatedAt(rs.getString("CreatedAt"));
                product.setStatus(rs.getString("Status"));
                product.setBrand(rs.getString("Brand"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) pool.freeConnection(con);
        }
        return product;
    }

    public void updateProductStatus(ProductBean bean) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection();
            String sql = "UPDATE products SET Status = ? WHERE ProductID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, bean.getStatus());
            pstmt.setInt(2, bean.getProductID());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mgr문제" );
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    public void updateProductBid(int productId, int newBid) {
        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            con = pool.getConnection();
            String sql = "UPDATE products SET CurrentBid = ? WHERE ProductID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, newBid);
            pstmt.setInt(2, productId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    public List<ProductBean> getProductsBySellerId(int sellerId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> productList = new ArrayList<>();
        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM products WHERE SellerID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, sellerId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ProductBean product = new ProductBean();
                product.setProductID(rs.getInt("ProductID"));
                product.setName(rs.getString("Name"));
                product.setStatus(rs.getString("Status"));
                product.setCurrentBid(rs.getInt("CurrentBid"));
                product.setBuyNowPrice(rs.getInt("BuyNowPrice"));
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
    
}
