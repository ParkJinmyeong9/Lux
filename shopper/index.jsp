<%@page import="shopper.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="shopper.ProductMgr"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="shopper.DBConnectionMgr"%>
<%@ page import="java.sql.SQLException"%>
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
		
    <!-- 기타 meta 태그 및 스타일 시트 링크 등 -->

    

		
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
		<section class="homepage-slider" id="home-slider">
			<%
			ProductMgr productMgr = new ProductMgr();
			String auctionStatus = "경매중";
			List<ProductBean> productsForHomeSlider = productMgr.getProductsByStatus(auctionStatus, 3); // "경매중" 상태인 상품 3개만 가져옴
			List<ProductBean> productsForCarousel = productMgr.getProductsByStatus(auctionStatus, 5); // "경매중" 상태인 상품 3개만 가져옴
			List<ProductBean> productsForCarousel2 = productMgr.getProductsByGender("Male", 5); // 남성 상품 5개 가져오기
			pageContext.setAttribute("productsForMaleAuction", productsForCarousel2);
			List<ProductBean> productsForCarousel3 = productMgr.getProductsByGender("Female", 5); // 여성 상품 5개 가져오기
			pageContext.setAttribute("productsForFemaleAuction", productsForCarousel3);
			ProductBean randomMaleProduct = productMgr.getRandomMaleProduct("Male"); // 남성 상품 1개 랜덤하게 가져오기
			pageContext.setAttribute("randomMaleProduct", randomMaleProduct);
			%>
			<div class="flexslider">
				<ul class="slides">
					<%
					for (ProductBean product : productsForHomeSlider) {
					%>
					<li><img src="<%=product.getPhoto()%>"
						alt="<%=product.getName()%>" />
						<div class="intro">
							<div class="product-info">
								<h1>Time</h1>
								<p>
									
								</p>
								<p>
									<span>현재입찰가 : </span><span><%=product.getCurrentBid()%>원</span>
								</p>
							</div>
							<div class="product-name-right">
								<span class="enhanced-span"><%=product.getName()%></span>
							</div>
						</div></li>
					<%
					}
					%>
				</ul>
			</div>
		</section>



		<section class="main-content">
			<div class="row">
				<div class="span12">
					<div class="row">
						<div class="span12">
							<h4 class="title">
								<span class="pull-left"><span class="text"><span
										class="line">Popular <strong>Auction <i
												class="fa-solid fa-fire"></i></strong></span></span></span> <span class="pull-right">
									<a class="left button" href="#myCarousel" data-slide="prev"></a>
									<a class="right button" href="#myCarousel" data-slide="next"></a>
								</span>
							</h4>
							<div id="myCarousel" class="myCarousel carousel slide">
								<div class="carousel-inner">


									<%
									boolean isFirst = true;
									int itemCounter = 0; // 상품의 개수를 카운트하는 변수입니다.
									for (int i = 0; i < productsForCarousel.size(); i++) {
										// 4개의 상품마다 새로운 슬라이드 아이템 시작
										if (itemCounter % 4 == 0) {
											if (isFirst) {
										isFirst = false;
											} else {
									%></ul>
								</div>
								<%
								// 이전 아이템 종료 태그
								}
								%><div class="item <%=(itemCounter == 0) ? "active" : ""%>">
									<ul class="thumbnails">
										<%
										}
										ProductBean product = productsForCarousel.get(i);
										%>
										<li class="span3">
											<div class="product-box">
												<span class="sale_tag"></span>
												<p>
													<a href="product_detail.jsp?id=<%=product.getProductID()%>"><img
														src="<%=product.getPhoto()%>" alt="<%=product.getName()%>" /></a>
												</p>
												<a href="product_detail.jsp?id=<%=product.getProductID()%>" class="title product-name"><%=product.getName()%></a><br />
												<a href="products.html" class="category">현재 입찰가: </a>
												<p class="price"><%=product.getCurrentBid()%>&nbsp;<i
														class="fa-solid fa-won-sign"></i>
												</p>
												입찰자:
												<%=product.getBidCount()%>
												<p class="BidCount">
													<i class="fa-solid fa-heart heart-icon"
														onclick="toggleHeart(this)"
														data-product-id="<%=product.getProductID()%>"></i>
												</p>
											</div>
										</li>
										<%
										itemCounter++;
										// 마지막 상품이면 마무리 태그 추가
										if (i == productsForCarousel.size() - 1) {
										%>
									</ul>
								</div>
								<%
								}
								}
								%>
							</div>
						</div>

					</div>
				</div>
		</section>
		<br />
		<section class="homepage-slider" id="home-slider">
			<div class="flexslider">
				<ul class="slides">
					<%
					if (randomMaleProduct != null) {
					%>
					<li><img src="<%=randomMaleProduct.getPhoto()%>"
						alt="<%=randomMaleProduct.getName()%>" />
						<div class="intro">
							<div class="product-info">
								<h1>Time</h1>
								<p>
									
								</p>
								<p>
									<span>현재입찰가 : </span><span><%=randomMaleProduct.getCurrentBid()%>원</span>
								</p>
							</div>
							<div class="product-name-right">
								<span class="enhanced-span"><%=randomMaleProduct.getName()%></span>
							</div>
						</div></li>
					<%
					}
					%>
				</ul>
			</div>
		</section>
		<section>
			<div class="row">
				<div class="span12">
					<h4 class="title">
						<span class="pull-left"><span class="text"><span
								class="line">man<strong> popularity <i
										class="fa-solid fa-mars"></i></strong></span></span></span> <span class="pull-right">
							<a class="left button" href="#myCarousel-2" data-slide="prev"></a><a
							class="right button" href="#myCarousel-2" data-slide="next"></a>
						</span>
					</h4>
					<div id="myCarousel-2" class="myCarousel carousel slide">
						<div class="carousel-inner">


							<%
							boolean isFirst2 = true;
							int itemCounter2 = 0; // 상품의 개수를 카운트하는 변수입니다.
							for (int i = 0; i < productsForCarousel2.size(); i++) {
								// 4개의 상품마다 새로운 슬라이드 아이템 시작
								if (itemCounter2 % 4 == 0) {
									if (isFirst2) {
								isFirst2 = false;
									} else {
							%></ul>
						</div>
						<%
						// 이전 아이템 종료 태그
						}
						%><div class="item <%=(itemCounter2 == 0) ? "active" : ""%>">
							<ul class="thumbnails">
								<%
								}
								ProductBean product = productsForCarousel2.get(i);
								%>
								<li class="span3">
                    <div class="product-box">
                      <span class="sale_tag"></span>
                      <p><a href="product_detail.jsp?id=<%=product.getProductID()%>"><img src="<%=product.getPhoto()%>" alt="<%=product.getName()%>" /></a></p>
                      <a href="product_detail.jsp?id=<%=product.getProductID()%>" class="title product-name"><%=product.getName()%></a><br />
                      <a href="products.html" class="category">현재 입찰가: </a>
                      <p class="price"><%=product.getCurrentBid()%>&nbsp;<i class="fa-solid fa-won-sign"></i></p>
                      입찰자: <%=product.getBidCount()%>
                      <p class="BidCount">
                        <i class="fa-solid fa-heart heart-icon" onclick="toggleHeart(this)" data-product-id="<%=product.getProductID()%>"></i>
                      </p>
                    </div>
                  </li>
								<%
								itemCounter2++;
								// 마지막 상품이면 마무리 태그 추가
								if (i == productsForCarousel.size() - 1) {
								%>
							</ul>
						</div>
						<%
						}
						}
						%>
					</div>
				</div>

			</div>
	</div>
	</section>
	<section>
		<div class="row">
			<div class="span12">
				<h4 class="title">
					<span class="pull-left"><span class="text"><span
							class="line">Woman<strong> popularity <i
									class="fa-solid fa-venus"></i></strong></span></span></span> <span class="pull-right">
						<a class="left button" href="#myCarousel-3" data-slide="prev"></a><a
						class="right button" href="#myCarousel-3" data-slide="next"></a>
					</span>
				</h4>
				<div id="myCarousel-3" class="myCarousel carousel slide">
					<div class="carousel-inner">


						<%
						boolean isFirst3 = true;
						int itemCounter3 = 0; // 상품의 개수를 카운트하는 변수입니다.
						for (int i = 0; i < productsForCarousel3.size(); i++) {
							// 4개의 상품마다 새로운 슬라이드 아이템 시작
							if (itemCounter3 % 4 == 0) {
								if (isFirst3) {
							isFirst3 = false;
								} else {
						%></ul>
					</div>
					<%
					// 이전 아이템 종료 태그
					}
					%><div class="item <%=(itemCounter3 == 0) ? "active" : ""%>">
						<ul class="thumbnails">
							<%
							}
							ProductBean product = productsForCarousel3.get(i);
							%>
							<li class="span3">
                    <div class="product-box">
                      <span class="sale_tag"></span>
                      <p><a href="product_detail.jsp?id=<%=product.getProductID()%>"><img src="<%=product.getPhoto()%>" alt="<%=product.getName()%>" /></a></p>
                      <a href="product_detail.jsp?id=<%=product.getProductID()%>" class="title product-name"><%=product.getName()%></a><br />
                      <a href="products.html" class="category">현재 입찰가: </a>
                      <p class="price"><%=product.getCurrentBid()%>&nbsp;<i class="fa-solid fa-won-sign"></i></p>
                      입찰자: <%=product.getBidCount()%>
                      <p class="BidCount">
                        <i class="fa-solid fa-heart heart-icon" onclick="toggleHeart(this)" data-product-id="<%=product.getProductID()%>"></i>
                      </p>
                    </div>
                  </li>
							<%
							itemCounter3++;
							// 마지막 상품이면 마무리 태그 추가
							if (i == productsForCarousel.size() - 1) {
							%>
						</ul>
					</div>
					<%
					}
					}
					%>
				</div>
			</div>

		</div>
	</section>
	<section id="footer-bar">
		<div class="row">
			<div class="span3">
				<h4>빠른이동</h4>
				<ul class="nav">
					<li><a href="./index.html">메인화면</a></li>
					<li><a href="./about.html">About Us</a></li>
					<li><a href="./contact.html">Contac Us</a></li>
					<li><a href="./cart.html">Review</a></li>
					<li><a href="./register.html">Login</a></li>
				</ul>
			</div>
			<div class="span4">
				<h4>Home</h4>
				<ul class="nav">
					<li><a href="#">Home</a></li>
					<li><a href="#">Order History</a></li>
					<li><a href="#">Wish List</a></li>
					<li><a href="#">Newsletter</a></li>
				</ul>
			</div>
			<div class="span5">
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
	</section>
	<section id="copyright">
		<span>Copyright 2013 bootstrappage template All right reserved.</span>
	</section>
	</div>
	<script src="themes/js/common.js"></script>
	<script src="themes/js/jquery.flexslider-min.js"></script>
	
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
		document.getElementById('sellLink').addEventListener('click', function() {
		    // 로그인 상태를 확인합니다. 실제 구현에서는 서버에서 이 값을 설정해야 합니다.
		    // 예시 코드에서는 JSP 스크립틀릿을 사용하여 로그인 상태를 체크합니다.
		    <% if (loggedInUser == null) { %>
		        // 로그인하지 않은 상태면 로그인 페이지로 리다이렉트합니다.
		        window.location.href = 'login.jsp';
		    <% } else { %>
		        // 로그인 상태면 판매 페이지로 이동합니다.
		        window.location.href = './product_register.jsp';
		    <% } %>
		});
	</script>
	
</body>
</html>