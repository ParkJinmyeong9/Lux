package shopper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewMgr {
    private DBConnectionMgr pool;
    private int noOfRecords; // 전체 레코드 수를 저장하는 변수
    
    public ReviewMgr() {
        pool = DBConnectionMgr.getInstance();
    }

    public ReviewBean getAuction(int ReviewID) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReviewBean reviewBean = null;

        try {
            con = pool.getConnection();
            String query = "SELECT * FROM reviews WHERE ReviewID = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, ReviewID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	reviewBean = new ReviewBean();
            	reviewBean.setReviewID(rs.getInt("ReviewID"));
            	reviewBean.setProductID(rs.getInt("ProductID"));
            	reviewBean.setAuthorID(rs.getInt("authorID"));
            	reviewBean.setRating(rs.getInt("rating"));
            	reviewBean.setContent(rs.getString("content"));
            	reviewBean.setCreatedAt(rs.getString("createdAt"));
            	reviewBean.setRPhoto(rs.getString("RPhoto"));
            	reviewBean.setReviewName(rs.getString("ReviewName"));
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

        return reviewBean != null ? reviewBean : new ReviewBean();
    }    

    public void insertReview(ReviewBean review) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = null;
        try {
            con = pool.getConnection();
            sql = "INSERT INTO reviews (ReviewName, Content, Rating, RPhoto) VALUES (?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, review.getReviewName());
            pstmt.setString(2, review.getContent());
            pstmt.setInt(3, review.getRating());
            pstmt.setString(4, review.getRPhoto());
            
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt);
        }
    }
    
    public List<ReviewBean> getAllReviews() {
        List<ReviewBean> reviewList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = pool.getConnection();
            String query = "SELECT * FROM reviews ORDER BY CreatedAt DESC";
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewBean review = new ReviewBean();
                review.setReviewID(rs.getInt("ReviewID"));
                review.setProductID(rs.getInt("ProductID"));
                review.setAuthorID(rs.getInt("AuthorID"));
                review.setRating(rs.getInt("Rating"));
                review.setContent(rs.getString("Content"));
                review.setCreatedAt(rs.getString("CreatedAt"));
                review.setRPhoto(rs.getString("RPhoto"));
                review.setReviewName(rs.getString("ReviewName"));
                reviewList.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return reviewList;
    }
    
    public List<ReviewBean> getReviews(int start, int total) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ReviewBean> list = new ArrayList<>();
        
        try {
            con = pool.getConnection();
            String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM reviews ORDER BY CreatedAt DESC LIMIT ?, ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, start);
            pstmt.setInt(2, total);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ReviewBean review = new ReviewBean();
                review.setReviewID(rs.getInt("ReviewID"));
                review.setReviewName(rs.getString("ReviewName"));
                review.setContent(rs.getString("Content"));
                review.setRating(rs.getInt("Rating"));
                review.setRPhoto(rs.getString("RPhoto"));
                review.setCreatedAt(rs.getString("CreatedAt"));
                list.add(review);
            }
            rs.close();
            
            pstmt = con.prepareStatement("SELECT FOUND_ROWS()");
            rs = pstmt.executeQuery();
            if (rs.next())
                this.noOfRecords = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) pool.freeConnection(con);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public int getNoOfRecords() {
        return this.noOfRecords;
    }
    
    public ReviewBean getReviewById(int reviewId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReviewBean review = null;

        try {
            con = pool.getConnection();
            String sql = "SELECT * FROM reviews WHERE ReviewID = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, reviewId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                review = new ReviewBean();
                review.setReviewID(rs.getInt("ReviewID"));
                review.setProductID(rs.getInt("ProductID"));
                review.setAuthorID(rs.getInt("AuthorID"));
                review.setRating(rs.getInt("Rating"));
                review.setContent(rs.getString("Content"));
                review.setCreatedAt(rs.getString("CreatedAt"));
                review.setRPhoto(rs.getString("RPhoto"));
                review.setReviewName(rs.getString("ReviewName"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }

        return review;
    }


}

    

