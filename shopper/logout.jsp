<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session2 = request.getSession(false);
    if (session2 != null) {
        session2.invalidate();
    }
    response.sendRedirect("index.jsp"); // 로그아웃 후 리다이렉트할 페이지
%>