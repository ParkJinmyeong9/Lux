<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="shopper.DBConnectionMgr"%>
<%@ page import="shopper.User"%>

<%
// 사용자 ID 세션에서 가져오기
User loggedInUser = (User) session.getAttribute("user");
int userID = loggedInUser.getUserID();
JSONArray jsonArray = new JSONArray();

// DB 연결 및 쿼리 실행
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    conn = DBConnectionMgr.getInstance().getConnection();
    String sql = "SELECT fp.FavoriteID, p.Name, p.StartPrice, p.BuyNowPrice, p.CurrentBid " +
                 "FROM favoriteproducts fp JOIN products p ON fp.ProductID = p.ProductID " +
                 "WHERE fp.UserID = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, userID);
    rs = pstmt.executeQuery();

    while (rs.next()) {
        JSONObject obj = new JSONObject();
        obj.put("number", rs.getInt("FavoriteID"));
        obj.put("product", rs.getString("Name"));
        obj.put("startPrice", rs.getInt("StartPrice") + "원");
        obj.put("buyNowPrice", rs.getInt("BuyNowPrice") + "원");
        obj.put("currentBid", rs.getInt("CurrentBid") + "원");
        jsonArray.put(obj);
    }
    
    // JSON 배열을 문자열로 출력
    out.print(jsonArray.toString());

} catch (Exception e) {
    // 오류 처리
    JSONObject errorObj = new JSONObject();
    errorObj.put("error", e.getMessage());
    out.print(errorObj.toString());
} finally {
    // 자원 해제
    if (rs != null) try { rs.close(); } catch(SQLException ex) {}
    if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
    if (conn != null) try { conn.close(); } catch(SQLException ex) {}
}
%>
