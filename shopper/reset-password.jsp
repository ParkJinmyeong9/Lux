<%@ page contentType="text/html; charset=EUC-KR"%>
<%@page import="shopper.UserManager"%>
<%@ page import="shopper.User"%>
<%
User loggedInUser = (User) session.getAttribute("user");
UserManager userManager = new UserManager();
int userBalance = 0;

/* if (loggedInUser != null) {
    userBalance = userManager.getUserBalance(loggedInUser.getUserID()); // UserID를 넘겨 잔액 조회
} */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Lux - 아이디/비밀번호 찾기</title>
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
				<span>아이디/비밀번호 찾기</span>
			</h4>
		</section>
		<section class="main-content">
			<div class="row">
				<div class="span12 center">
					<h4 class="title">
						<span class="text"><strong>아이디/비밀번호 찾기</strong></span>
					</h4>
					<form action="/myapp/shopper/find-account" method="post">
						<fieldset>
							<div class="control-group">
								<label class="control-label">이메일 주소</label>
								<div class="controls">
									<input type="email" placeholder="가입 시 사용한 이메일 주소를 입력하세요"
										class="input-xlarge" name="email" required>
								</div>
							</div>
							<div class="action">
								<button type="submit" name="action" value="findId"
									class="btn btn-inverse large">아이디 찾기</button>
								<button type="submit" name="action" value="resetPassword"
									class="btn btn-inverse large">비밀번호 찾기</button>
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
						<li><a href="./index.html">홈페이지</a></li>
						<li><a href="./about.html">고객센터</a></li>
						<li><a href="./contact.html">연락처</a></li>
						<li><a href="./cart.html">장바구니</a></li>
						<li><a href="./register.html">로그인</a></li>
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
	<script>
		$(document).ready(function() {
			$('#checkout').click(function(e) {
				document.location.href = "checkout.html";
			})
		});
	</script>
</html>
