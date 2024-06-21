<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="shopper.UserManager"%>
<%@ page import="shopper.User"%>
<%
User loggedInUser = (User) session.getAttribute("user");
UserManager userManager = new UserManager();
int userBalance = 0;

if (loggedInUser != null) {
    userBalance = userManager.getUserBalance(loggedInUser.getUserID()); // UserID를 넘겨 잔액 조회
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>계정 찾기 결과 - Lux</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
    <link href="themes/css/bootstrappage.css" rel="stylesheet">
    <link href="themes/css/flexslider.css" rel="stylesheet">
    <link href="themes/css/main.css" rel="stylesheet">
    <script src="themes/js/jquery-1.7.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="themes/js/superfish.js"></script>
    <script src="themes/js/jquery.scrolltotop.js"></script>
</head>
<body>
    <div id="top-bar" class="container">
    		<div class="row">
        <div class="span4">
            <form method="GET" class="search_form" action="searchProduct.jsp">
        <input type="text" class="input-block-level search-query" name="query" placeholder="eg. T-shirt">
    </form>
        </div>
        <div class="span8">
            <div class="account pull-right">
                <nav id="menu" class="pull-right">
                 <ul class="user-menu"> 
            <% if (loggedInUser != null) { %>
                <li><a href="#"> <%= loggedInUser.getName() %> | Balance: <%= userBalance %></a>
                    <ul>
                        <li><a href="./products.jsp">마이페이지</a></li>
                        <li><a href="./cart.html">장바구니</a></li>
                        <li><a href="./checkout.jsp">결제하기</a></li>
                        <li><a href="./Exchange.jsp">환전하기</a></li>
                    </ul>
                </li>
                <li><a href="logout.jsp">Logout</a></li>
            <% } else { %>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
            <% } %>
        </ul>
                </nav>
            </div>
        </div>
    </div>
	</div>
    <div id="wrapper" class="container">
    	<section class="navbar main-menu">
			<div class="navbar-inner main-menu">
				<a href="index.jsp" class="logo pull-left"><img
					src="themes/images/Lux_logo.png" class="site_logo" alt=""
					width="100"></a>
				<nav id="menu" class="pull-right">
					<ul>
						<li><a href="./man_index.jsp">남성</a>
						<li><a href="./woman_index.jsp">여성</a>
						<li><a href="./Event.jsp">Event</a></li>
						<li><a href="./product_register.jsp">판매</a></li>
						<li><a href="./showreviews.jsp">Review</a></li>
						<li><a href="./OfflineShop.jsp">오프라인샵</a></li>
						
						<li><a href="./product.jsp">BRAND</a></li>
					</ul>
				</nav>
			</div>
		</section>
        <section class="header_text sub">
            <img class="pageBanner" src="themes/images/Lux_logo.png" alt="계정 찾기">
            <h4><span>계정 찾기 결과</span></h4>
        </section>
        <section class="main-content">
            <div class="row">
                <div class="span12 center">
                    <div class="content-panel">
                        <h4>계정 찾기 요청 결과</h4>
                        <% 
                        // 서블릿에서 설정한 메시지를 가져옵니다.
                        String message = (String) request.getAttribute("message");
                        String error = (String) request.getAttribute("error");
                        if (message != null) {
                            %>
                            <p><%= message %></p>
                            <% 
                        } else if (error != null) {
                            %>
                            <p><%= error %></p>
                            <%
                        } else {
                            %>
                            <p>요청 처리 중 문제가 발생했습니다. 다시 시도해 주세요.</p>
                            <%
                        }
                        %>
                        <a href="index.jsp" class="btn btn-inverse large">홈으로 돌아가기</a>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script src="themes/js/common.js"></script>
</body>
</html>
