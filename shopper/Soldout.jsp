<%@page import="shopper.ProductBean"%>
<%@page import="shopper.ProductMgr"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<html lang="en">
<head>
<meta charset="utf-8">
<title>Bootstrap E-commerce Templates</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
<!-- bootstrap -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	rel="stylesheet">

<link href="themes/css/bootstrappage.css" rel="stylesheet" />

<!-- global styles -->
<link href="themes/css/flexslider.css" rel="stylesheet" />
<link href="themes/css/main.css" rel="stylesheet" />

<!-- scripts -->
<script src="https://kit.fontawesome.com/df13639f85.js"
	crossorigin="anonymous"></script>
<script src="themes/js/jquery-1.7.2.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="themes/js/superfish.js"></script>
<script src="themes/js/jquery.scrolltotop.js"></script>
<!--[if lt IE 9]>			
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
			<script src="js/respond.min.js"></script>
		<![endif]-->
<style>
.header_text h4 span {
	font-size: 30px; /* 원하는 텍스트 크기로 조정 */
	font-weight: bold; /* 텍스트를 굵게 만듭니다 */
}
</style>

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
			<c:choose>
				<c:when test="${param.brand == 'LouisVuitton'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/LouisVuitton.png" alt="Louis Vuitton">
				</c:when>
				<c:when test="${param.brand == 'Chanel'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/Chanel.png" alt="Chanel">
				</c:when>
				<c:when test="${param.brand == 'Gucci'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/gucci.png" alt="Gucci">
				</c:when>
				<c:when test="${param.brand == 'Hermes'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/Hermes.png" alt="Hermes">
				</c:when>
				<c:when test="${param.brand == 'Cartier'}">
					<img class="pageBanner" style="width: 300px; height: 130px;"
						src="themes/images/brandlogo/Cartier.png" alt="Cartier">
				</c:when>
				<c:when test="${param.brand == 'Rolex'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/Rolex.png" alt="Rolex">
				</c:when>
				<c:when test="${param.brand == 'Dior'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/Dior.png" alt="Dior">
				</c:when>
				<c:when test="${param.brand == 'Tiffany'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/Tiffany.png" alt="Tiffany">
				</c:when>
				<c:when test="${param.brand == 'Burberry'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/Burberry.png" alt="Burberry">
				</c:when>
				<c:when test="${param.brand == 'Prada'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/Prada.png" alt="Prada">
				</c:when>
				<c:when test="${param.brand == 'Others'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/other.png" alt="Other Brands">
				</c:when>
				<c:when test="${param.brand == 'Gucci'}">
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/gucci.png" alt="Gucci">
				</c:when>
				<c:otherwise>
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/gucci.png" alt="Gucci">
				</c:otherwise>
			</c:choose>
		</section>


		<section class="main-content">
			<%
			// 변수 설정 및 초기화
			int currentPage = 1;
			int recordsPerPage = 6;
			if (request.getParameter("page") != null) {
				currentPage = Integer.parseInt(request.getParameter("page"));
			}
			if (currentPage < 1)
				currentPage = 1;

			ProductMgr productMgr = new ProductMgr();
			String selectedBrand = request.getParameter("brand");

			List<ProductBean> products = productMgr.getProductsByBrand(selectedBrand, currentPage, recordsPerPage);
			pageContext.setAttribute("products", products); // Java 리스트를 JSP EL에 사용 가능하도록 설정합니다.
			int noOfRecords = productMgr.getNoOfRecords(selectedBrand);
			int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
			%>

			<div class="row">
				<div class="span9">
					<ul class="thumbnails listing-products">
						<c:forEach items="${products}" var="product">
							<li class="span3">
								<div class="product-box">
									<span class="sale_tag"></span>
									<p>
										<a href="product_detail.html"><img src="${product.photo}"
											alt="${product.name}" /></a>
									</p>
									<a href="product_detail.html" class="title product-name">${product.name}</a><br />
									<a href="products.html" class="category">현재 입찰가: </a>
									<p class="price">${product.currentBid}&nbsp;<i
											class="fa-solid fa-won-sign"></i>
									</p>
									입찰자: ${product.bidCount}
									<p class="BidCount">
										<i class="fa-solid fa-heart heart-icon"
											onclick="toggleHeart(this)"
											data-product-id="${product.productID}"></i>
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
					<hr>

					<div class="pagination pagination-small pagination-centered">
						<ul>
							<%
							if (currentPage > 1) {
							%>
							<li><a
								href="<%="product.jsp?brand=" + selectedBrand + "&page=" + (currentPage - 1)%>">Prev</a></li>
							<%
							} else {
							%>
							<li class="disabled"><span>Prev</span></li>
							<%
							}
							%>

							<%
							for (int i = 1; i <= noOfPages; i++) {
								if (i == currentPage) {
							%>
							<li class="active"><span><%=i%></span></li>
							<%
							} else {
							%>
							<li><a
								href="<%="product.jsp?brand=" + selectedBrand + "&page=" + i%>"><%=i%></a></li>
							<%
							}
							}
							%>

							<%
							if (currentPage < noOfPages) {
							%>
							<li><a
								href="<%="product.jsp?brand=" + selectedBrand + "&page=" + (currentPage + 1)%>">Next</a></li>
							<%
							} else {
							%>
							<li class="disabled"><span>Next</span></li>
							<%
							}
							%>
						</ul>
					</div>
				</div>

				
					</div>


					




				</div>
			</div>
		</section>



		<section id="footer-bar">
			<div class="row">
				<div class="span3">
					<h4>Navigation</h4>
					<ul class="nav">
						<li><a href="./index.html">Homepage</a></li>
						<li><a href="./about.html">About Us</a></li>
						<li><a href="./contact.html">Contac Us</a></li>
						<li><a href="./cart.html">Your Cart</a></li>
						<li><a href="./register.html">Login</a></li>
					</ul>
				</div>
				<div class="span4">
					<h4>My Account</h4>
					<ul class="nav">
						<li><a href="#">My Account</a></li>
						<li><a href="#">Order History</a></li>
						<li><a href="#">Wish List</a></li>
						<li><a href="#">Newsletter</a></li>
					</ul>
				</div>
				<div class="span5">
					<p class="logo">
						<img src="themes/images/logo.png" class="site_logo" alt="">
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
		</section>
		<section id="copyright">
			<span>Copyright 2013 bootstrappage template All right
				reserved.</span>
		</section>
	</div>
	<script src="themes/js/common.js"></script>
	<script type="text/javascript">
		$(function() {
			$(document).ready(function() {
				$('.flexslider').flexslider({
					animation : "fade",
					slideshowSpeed : 4000,
					animationSpeed : 600,
					controlNav : false,
					directionNav : true,
					controlsContainer : ".flex-container" // the container that holds the flexslider
				});
				$('#myCarousel').carousel({
				// 옵션 설정 (필요하다면)
				});

				// myCarousel-2에 대해서도 동일하게 적용
				$('#myCarousel-2').carousel({
				// 옵션 설정 (필요하다면)
				});

			});
			// 하트 아이콘을 클릭하면 실행되는 함수입니다
			function toggleHeart(element) {
				// 여기서 userId는 로그인한 사용자의 ID를 설정합니다.
				// 이 예시에서는 userID를 1로 고정하고 있습니다.
				var userId = 1;
				var productId = $(element).data('product-id');
				var isLiked = $(element).hasClass('liked');
				var action = isLiked ? 'remove' : 'add';

				$.ajax({
					type : 'POST',
					url : '/myapp/favoriteProduct',
					data : {
						userId : userId,
						productId : productId,
						action : action
					},
					dataType : 'json',
					success : function(response) {
						// 서버의 응답을 확인하여 상태를 업데이트합니다.
						if (response.success) {
							$(element).toggleClass('liked', !isLiked);
						} else {
							// 오류 메시지를 사용자에게 표시합니다.
							alert(response.message);
						}
					},
					error : function() {
						// AJAX 호출에 실패했을 때의 처리
						alert('An error occurred while updating favorites.');
					}
				});
			}

			// 클릭 이벤트를 바인딩합니다.
			$('.heart-icon').click(function() {
				var userId = 1; // 현재 로그인된 사용자 ID를 여기에 설정합니다.
				toggleHeart(this, userId);
			});
		});
	</script>
</body>
</html>