<%@page import="java.net.URLDecoder"%>
<%@page import="shopper.ProductBean"%>
<%@page import="shopper.ProductMgr"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
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
                        <li><a href="./myPage.jsp">마이페이지</a></li>
                        <li><a href="./favoriteProduct.jsp">장바구니</a></li>
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
             src="themes/images/brandlogo/LouisVuitton.png" alt="Louis Vuitton" />
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
				
				<c:otherwise>
					<img class="pageBanner" style="width: 300px; height: 220px;"
						src="themes/images/brandlogo/LouisVuitton.png" alt="Lux">
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
			String auctionStatus = "경매중";
			String selectedBrand = request.getParameter("brand");
			String selectedStatus = request.getParameter("status");
			List<ProductBean> productsToShow;
			if (selectedBrand != null) {
			    selectedBrand = selectedBrand.replace("+", " "); // URL 인코딩은 공백을 '+'로 변환하기도 합니다.
			}
			int noOfRecords;

			if ("낙찰".equals(selectedStatus)) {
				productsToShow = productMgr.getAuctionedProducts();
				noOfRecords = productsToShow.size();
			} else {
				productsToShow = selectedBrand != null
				? productMgr.getProductsByBrand(selectedBrand, currentPage, recordsPerPage)
				: productMgr.getAllProducts(currentPage, recordsPerPage);
				noOfRecords = productMgr.getNoOfRecords(selectedBrand);
			}

			// 페이지네이션 계산
			int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
			int noOfPagesSold = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
			// 상품 정보와 페이지 정보를 request 범위에 저장
			pageContext.setAttribute("products", productsToShow);
			pageContext.setAttribute("noOfPages", noOfPages);
			pageContext.setAttribute("currentPage", currentPage);
			pageContext.setAttribute("noOfPagesSold", noOfPagesSold); 
			%>
			



			<div class="row">
				<div class="span9">
					<ul class="thumbnails listing-products">
						<c:forEach items="${products}" var="product">
							<li class="span3">
								<div class="product-box" style="position: relative;">
									<!-- 기존 상품 이미지 -->
									<p>
										<a
                                 href="<c:if test="${product.status != '낙찰'}">product_detail.jsp?id=${product.productID}</c:if>"><img
                                 src="${product.photo}" alt="${product.name}" /></a>
									</p>
									<!-- 여기에 'Sold' 이미지를 추가 -->
									<c:if test="${product.status == '낙찰'}">
										<img src="themes/images/brandlogo/Sold.png" alt="Sold"
											class="sold-overlay" />
										<!-- 상품 정보를 비활성화하려면 여기에 추가 스타일 또는 클래스를 적용 -->
									</c:if>
									<!-- 나머지 상품 정보 -->
									<a
                              href="<c:if test="${product.status != '낙찰'}"> product_detail.jsp?id=${product.productID}</c:if>"
                              class="${product.status == '낙찰' ? 'title product-name disabled-link' : 'title product-name'}">${product.name}</a><br />
                           <a href="${product.status == '낙찰' ? '#' : 'products.html'}"
                              class="category">현재 입찰가: </a>
                           <p class="price">${product.currentBid}&nbsp;<i
                                 class="fa-solid fa-won-sign"></i>
									</p>
									입찰자: ${product.bidCount}
									<p class="BidCount">
										<i
											class="fa-solid fa-heart heart-icon ${product.status == '낙찰' ? 'disabled-heart' : ''}"
											onclick="${product.status == '낙찰' ? '' : 'toggleHeart(this)'}"
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
    <li><a href="<%="product.jsp?brand=" + selectedBrand + "&status=sold&page=" + (currentPage - 1)%>">Prev</a></li>
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
    <li><a href="<%="product.jsp?brand=" + selectedBrand + "&status=sold&page=" + i%>"><%=i%></a></li>
    <%
        }
    }
    %>

    <%
    if (currentPage < noOfPages) {
    %>
    <li><a href="<%="product.jsp?brand=" + selectedBrand + "&status=sold&page=" + (currentPage + 1)%>">Next</a></li>
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

				<div class="span3 col">
					<div class="block">
						<br />

						<ul class="nav nav-list below">
							<li class="nav-header"><a href="product.jsp?status=낙찰">Sold
									Products</a></li>
							<li class="nav-header">BRAND</li>
							<li	<c:if test="${param.brand == 'LouisVuitton'}">class="active"</c:if>><a
								href="product.jsp?brand=Louis Vuitton">Louis Vuitton</a></li>
							<li <c:if test="${param.brand == 'Chanel'}">class="active"</c:if>><a
								href="product.jsp?brand=Chanel">Chanel</a></li>
							<li <c:if test="${param.brand == 'Gucci'}">class="active"</c:if>><a
								href="product.jsp?brand=Gucci">Gucci</a></li>
							<li <c:if test="${param.brand == 'Hermes'}">class="active"</c:if>><a
								href="product.jsp?brand=Hermes">Hermes</a></li>
							<li
								<c:if test="${param.brand == 'Cartier'}">class="active"</c:if>><a
								href="product.jsp?brand=Cartier">Cartier</a></li>
							<li <c:if test="${param.brand == 'Rolex'}">class="active"</c:if>><a
								href="product.jsp?brand=Rolex">Rolex</a></li>
							<li <c:if test="${param.brand == 'Dior'}">class="active"</c:if>><a
								href="product.jsp?brand=Dior">Dior</a></li>
							<li
								<c:if test="${param.brand == 'Tiffany'}">class="active"</c:if>><a
								href="product.jsp?brand=Tiffany">Tiffany</a></li>
							<li
								<c:if test="${param.brand == 'Burberry'}">class="active"</c:if>><a
								href="product.jsp?brand=Burberry">Burberry</a></li>
							<li <c:if test="${param.brand == 'Prada'}">class="active"</c:if>><a
								href="product.jsp?brand=Prada">Prada</a></li>
							<li <c:if test="${param.brand == 'Others'}">class="active"</c:if>><a
								href="product.jsp?brand=Others">Others</a></li>
						</ul>
					</div>

					<%
					// ProductMgr 인스턴스 생성 및 랜덤 상품 목록 가져오기
					List<ProductBean> randomProducts = productMgr.getRandomProducts(10);
					pageContext.setAttribute("randomProducts", randomProducts);
					%>

					<div class="block">
						<h4 class="title">
							<span class="pull-left"><span class="text">Randomize</span></span>
							<span class="pull-right"> <a class="left button"
								href="#myCarousel" data-slide="prev"></a><a class="right button"
								href="#myCarousel" data-slide="next"></a>
							</span>
						</h4>


						<div id="myCarousel" class="carousel slide">
							<div class="carousel-inner">
								<c:forEach items="${randomProducts}" var="product"
									varStatus="status">
									<div class="${status.first ? 'active' : ''} item">
										<ul class="thumbnails listing-products">
											<li class="span3">
												<div class="product-box">
													<span class="sale_tag"></span>
													<p>
														<a href="product_detail.jsp?id=${product.productID}"><img
															src="${product.photo}" alt="${product.name}" /></a>
													</p>
													<a href="product_detail.jsp?id=${product.productID}" class="title product-name">${product.name}</a><br />
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
										</ul>
									</div>
								</c:forEach>
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
			    var loggedInUser = '<%= (User)session.getAttribute("user") != null ? ((User)session.getAttribute("user")).getUserID() : -1 %>'; // 로그인한 사용자의 아이디를 가져옵니다. 로그인하지 않은 경우 -1로 설정됩니다.

			    var productId = $(element).data('product-id'); // 상품 ID를 가져옵니다.
			    var isLiked = $(element).hasClass('liked'); // 현재 하트 아이콘에 'liked' 클래스가 있는지 확인합니다.
			    var action = isLiked ? 'remove' : 'add'; // 좋아요를 추가할지 제거할지 결정합니다.

			    // 로그인한 사용자의 아이디가 유효한 경우에만 AJAX 요청을 보냅니다.
			    if (loggedInUser != -1) {
			        // 서버로 AJAX 요청을 보냅니다.
			        $.ajax({
			            type: 'POST',
			            url: '/myapp/favoriteProduct', // 좋아요 상태를 업데이트할 서버의 엔드포인트를 설정합니다.
			            data: {
			                userId: loggedInUser, // 로그인한 사용자의 ID를 전달합니다.
			                productId: productId, // 상품 ID를 전달합니다.
			                action: action // 추가할지 제거할지에 대한 동작을 전달합니다.
			            },
			            dataType: 'json',
			            success: function(response) {
			                // 서버의 응답을 확인하여 상태를 업데이트합니다.
			                if (response.success) {
			                    $(element).toggleClass('liked', !isLiked); // 하트 아이콘에 'liked' 클래스를 토글합니다.
			                } else {
			                    // 오류 메시지를 사용자에게 표시합니다.
			                    alert(response.message);
			                }
			            },
			            error: function() {
			                // AJAX 호출에 실패했을 때의 처리
			                alert('An error occurred while updating favorites.');
			            }
			        });
			    } else {
			        // 로그인되지 않은 사용자에게 알림을 표시합니다.
			        alert('로그인이 필요합니다.');
			    }
			}


						// 클릭 이벤트를 바인딩합니다.
						$('.heart-icon').click(function() {
						    toggleHeart(this); // 하트 아이콘을 클릭했을 때 toggleHeart 함수를 호출합니다.
						});

		});
	</script>
</body>
</html>