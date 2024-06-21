<%@page import="shopper.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="shopper.ProductMgr"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="shopper.DBConnectionMgr"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="shopper.User"%>
<%@ page import="shopper.ReviewBean"%>
<%@ page import="shopper.ReviewMgr"%>
<%@ page import="java.util.Arrays"%>
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
<%
int currentPage = 1; // 변수 이름 변경: 'page' -> 'currentPage'
int recordsPerPage = 6;
if (request.getParameter("page") != null)
	currentPage = Integer.parseInt(request.getParameter("page"));
ReviewMgr reviewMgr = new ReviewMgr();
List<ReviewBean> reviewList = reviewMgr.getReviews((currentPage - 1) * recordsPerPage, recordsPerPage);
int noOfRecords = reviewMgr.getNoOfRecords();
int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
%>
<%
ReviewBean bestReview1 = reviewMgr.getReviewById(14);
ReviewBean bestReview2 = reviewMgr.getReviewById(12);
ReviewBean bestReview3 = reviewMgr.getReviewById(13);
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LUX Auction - 리뷰 목록</title>
<!-- 부트스트랩 CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<link href="themes/css/main.css" rel="stylesheet">
<!-- Font Awesome -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	rel="stylesheet">
<!-- 사용자 정의 CSS -->
<style>
/* 컨테이너 및 리뷰 스타일 */
.review-container, #wrapper, .carousel-inner .item {
	margin: 20px auto;
	max-width: 90%; /* 컨테이너 최대 너비 조정 */
}

.review, .footer-bar .container {
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	transition: all 0.3s ease-in-out;
	border: 1px solid #eeeeee;
	overflow: hidden;
}

.review-card:hover {
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.4);
	transform: scale(1.05);
}

.review-rating {
	font-size: 16px;
	color: #ffc107;
}

.site_logo {
	max-width: 100%;
	height: auto;
	display: block;
	margin: 0 auto;
}
/* 하단 바 스타일 조정 */
.footer-bar .container {
	max-width: 90%; /* 하단 바의 최대 너비를 제한 */
	margin: auto; /* 중앙 정렬 */
}

.social_icons a {
	margin-right: 10px; /* 소셜 아이콘 간격 조정 */
}

.carousel-control.left, .carousel-control.right {
	background-image: none; /* 기본 컨트롤 이미지 제거 */
}

.navbar.main-menu {
	padding: 20px 0; /* 상하 패딩을 20px, 좌우 패딩을 0으로 설정 */
}

.navbar-inner.main-menu {
	padding: 0 15px; /* 필요한 경우 내부 패딩 추가 */
}

.carousel-inner, .carousel-inner .item, .carousel-inner .item img {
	height: 500px; /* 슬라이더 높이 고정 */
	width: 100%; /* 너비를 자동으로 조절 */
}

.carousel-caption {
	background: rgba(0, 0, 0, 0.7);
	color: #fff;
	position: absolute;
	bottom: 20px;
	left: 50%;
	transform: translateX(-50%);
	padding: 15px;
	border-radius: 10px;
}

.carousel-content-wrapper {
	position: relative;
	text-align: center;
}

.fa-star {
	color: #ffc107; /* 별 색상 */
	margin-right: 4px; /* 별 사이 간격 */
}

.carousel-control.left, .carousel-control.right {
	background-image: none; /* 기본 컨트롤 이미지 제거 */
}

.carousel-indicators {
	bottom: -5px; /* 기본값에서 변경하여 인디케이터 위치 조정 */
}

.review-card {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	width: 40%;
	border-radius: 5px;
	margin: 10px;
}

.review-image {
	width: 100%;
	height: 500px;
	object-fit: cover; /* 이미지 비율 유지하면서 커버 */
}

.review-content {
	padding: 2px 16px;
}

.review-rating {
	color: gold;
}

@media ( max-width : 768px) {
	.carousel-caption {
		bottom: 10px;
		font-size: 14px; /* 모바일에서는 캡션의 글자 크기 조정 */
	}
	.review-image {
		height: 300px; /* 모바일에서는 이미지 높이 축소 */
	}
}
</style>


</head>
<body>
	<div id="top-bar" class="container">
		<div class="row">
			<div class="col-md-3">
				<!-- 검색창 영역: 너비 축소 -->
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
                       <li><a href="./myPage.jsp">마이페이지</a></li>
                        <li><a href="./favoriteProduct.jsp">장바구니</a></li>
                        <li><a href="./checkout.jsp">결제하기</a></li>
                        <li><a href="./Exchange.jsp">환전하기</a></li>
                    </ul>
                </li>
                <li><a href="logout.jsp">Logout</a></li>
            <% } else { %>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.html">Register</a></li>
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
		<h2 class="section-title">베스트 리뷰</h2>
		<div id="best-review-carousel" class="carousel slide"
			data-ride="carousel">
			<!-- Indicators (optional) -->
			<ol class="carousel-indicators">
				<li data-target="#best-review-carousel" data-slide-to="0"
					class="active"></li>
				<li data-target="#best-review-carousel" data-slide-to="1"></li>
				<li data-target="#best-review-carousel" data-slide-to="2"></li>
			</ol>

			<!-- Wrapper for slides -->
			<!-- Wrapper for slides -->
			
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="<%=bestReview1.getRPhoto()%>" alt="Best Review 1"
						style="width: 100%; height: 500px; object-fit: cover;">
					<div class="carousel-caption">
						<h3><%=bestReview1.getReviewName()%></h3>
						<p><%=bestReview1.getContent()%></p>
					</div>
				</div>

				<div class="item">
					<img src="<%=bestReview2.getRPhoto()%>" alt="Best Review 2"
						style="width: 100%;">
					<div class="carousel-caption">
						<h3><%=bestReview2.getReviewName()%></h3>
						<p><%=bestReview2.getContent()%></p>
					</div>
				</div>

				<div class="item">
					<img src="<%=bestReview3.getRPhoto()%>" alt="Best Review 3"
						style="width: 100%;">
					<div class="carousel-caption">
						<h3><%=bestReview3.getReviewName()%></h3>
						<p><%=bestReview3.getContent()%></p>
					</div>
				</div>
			</div>

			<!-- Controls -->
			<a class="left carousel-control" href="#best-review-carousel"
				role="button" data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#best-review-carousel"
				role="button" data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
		<h1>리뷰 목록</h1>
		<%
		for (ReviewBean review : reviewList) {
		%>
		<div class="review">
			<h2><%=review.getReviewName()%></h2>
			<div class="review-rating">
				<%
				for (int i = 0; i < review.getRating(); i++) {
				%>
				<i class="fas fa-star"></i>
				<%-- 채워진 별 --%>
				<%
				}
				%>
				<%
				for (int i = review.getRating(); i < 5; i++) {
				%>
				<i class="far fa-star"></i>
				<%-- 빈 별 --%>
				<%
				}
				%>
			</div>
			<p><%=review.getContent()%></p>
			<%
			if (review.getRPhoto() != null && !review.getRPhoto().isEmpty()) {
			%>
			<img src="<%=review.getRPhoto()%>" alt="Review image"
				style="max-width: 300px;">
			<%
			}
			%>
			<p>
				작성일:
				<%=review.getCreatedAt()%></p>
		</div>
		<%
		}
		%>
		<div class="pagination">
			<%
			for (int i = 1; i <= noOfPages; i++) {
				if (i == currentPage) {
			%>
			<span><%=i%></span>
			<%
			} else {
			%>
			<a href="showreviews.jsp?page=<%=i%>"><%=i%></a>
			<%
			}
			}
			%>
		</div>
	</div>
	<section id="footer-bar">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<h4>빠른이동</h4>
					<ul class="nav">
						<li><a href="./index.jsp">메인화면</a></li>
						<li><a href="./about.html">About Us</a></li>
						<li><a href="./contact.html">Contact Us</a></li>
						<li><a href="./cart.html">Review</a></li>
						<li><a href="./register.html">Login</a></li>
					</ul>
				</div>
				<div class="col-md-4">
					<h4>Home</h4>
					<ul class="nav">
						<li><a href="#">Home</a></li>
						<li><a href="#">Order History</a></li>
						<li><a href="#">Wish List</a></li>
						<li><a href="#">Newsletter</a></li>
					</ul>
				</div>
				<div class="col-md-4">
					<p class="logo">
						<img src="themes/images/Lux_logo.png" class="site_logo" alt="">
					</p>
					<p>Lorem Ipsum is simply dummy text of the printing and
						typesetting industry. the Lorem Ipsum has been the industry's
						standard dummy text ever since the you.</p>
					<br /> <span class="social_icons"> <a class="facebook"
						href="#">Facebook</a> <a class="twitter" href="#">Twitter</a> <a
						class="skype" href="#">Skype</a> <a class="vimeo" href="#">Vimeo</a>
					</span>
				</div>
			</div>
		</div>
	</section>
	<!-- 스크립트 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
		
	</script>
</body>
</html>
