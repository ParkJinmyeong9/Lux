<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="javax.servlet.http.HttpSession"%>
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
<title>Lux</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="themes/css/bootstrappage.css" rel="stylesheet" />
<link href="themes/css/flexslider.css" rel="stylesheet" />
<link href="themes/css/main.css" rel="stylesheet" />
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
			<img class="pageBanner" src="themes/images/Lux_logo.png" alt="새 제품">
			<h4>
				<span>로그인 또는 회원가입</span>
			</h4>
		</section>
		<section class="main-content">
			<div class="row">
				<div class="center">
					<h4 class="title">
						<span class="text"><strong>로그인</strong></span>
					</h4>
					<%
                    String error = request.getParameter("error");
                    if ("invalid".equals(error)) {
                    %>
                        <div class="alert alert-danger" style="margin-bottom: 20px;">
                            아이디 또는 비밀번호가 일치하지 않습니다.
                        </div>
                    <%
                    }
                    %>
					<form action="login" method="post" class="form-stacked">
						<!-- 'register'를 로그인 처리 서블릿 경로로 변경 -->
						
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="username">사용자 이름</label>
								<div class="controls">
									<input type="text" name="username" placeholder="사용자 이름을 입력하세요"
										id="username" class="input-xlarge" required>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="password">비밀번호</label>
								<div class="controls">
									<input type="password" name="password"
										placeholder="비밀번호를 입력하세요" id="password" class="input-xlarge"
										required>
								</div>
							</div>
							<div class="control-group">
								<input tabindex="3" class="btn btn-inverse large" type="submit"
									value="로그인">
								<hr>
								<p class="reset">
									아이디 및 비밀번호 <a tabindex="4" href="./reset-password.jsp"
										title="아이디나 비밀번호 찾기">찾기</a>
								</p>
							</div>
							<div class="control-group">
								<hr>
								<p class="reset">
									회원가입 <a tabindex="4" href="./register.jsp" title="회원가입">여기</a>
								</p>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</section>
		<section id="footer-bar">
			<div class="row">
				<div class="span3">
					<h4>내비게이션</h4>
					<ul class="nav">
						<li><a href="./myPage.jsp">마이페이지</a></li>
                        <li><a href="./favoriteProduct.jsp">장바구니</a></li>
                        <li><a href="./checkout.jsp">결제하기</a></li>
                        <li><a href="./Exchange.jsp">환전하기</a></li>
					</ul>
				</div>
				<div class="span4">
					<h4>내 계정</h4>
					<ul class="nav">
						<li><a href="#">내 계정</a></li>
						<li><a href="#">주문 내역</a></li>
						<li><a href="#">위시리스트</a></li>
						<li><a href="#">뉴스레터</a></li>
					</ul>
				</div>
				<div class="span5">
					<p class="logo">
						<img src="themes/images/logo.png" class="site_logo" alt="">
					</p>
					<p>로렘 입숨은 단순히 인쇄 및 조판 산업의 더미 텍스트입니다. 로렘 입숨은 업계의 표준 더미 텍스트였습니다.</p>
					<br /> <span class="social_icons"> <a class="facebook"
						href="#">페이스북</a> <a class="twitter" href="#">트위터</a> <a
						class="skype" href="#">스카이프</a> <a class="vimeo" href="#">비메오</a>
					</span>
				</div>
			</div>
		</section>
		<section id="copyright">
			<span></span>
		</section>
	</div>
	<script src="themes/js/common.js"></script>
</body>
</html>