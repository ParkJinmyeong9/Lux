<%@page import="java.sql.*"%>
<%@page import="shopper.DBConnectionMgr"%>
<%@page contentType="text/plain; charset=UTF-8"%>

<%
// favoriteID 파라미터 가져오기
String favoriteIDStr = request.getParameter("favoriteID");
System.out.println(favoriteIDStr);
if (favoriteIDStr != null && !favoriteIDStr.isEmpty()) {
    int favoriteID = Integer.parseInt(favoriteIDStr);
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = DBConnectionMgr.getInstance().getConnection();
        String sql = "DELETE FROM favoriteproducts WHERE FavoriteID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, favoriteID);
        
        int rowsAffected = pstmt.executeUpdate();
        
        if(rowsAffected > 0) {
            out.println("success");
        } else {
            out.println("fail");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("error: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
} else {
    out.println("error: No ID provided");
}
%>
