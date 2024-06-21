<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shopper.OfflineShopBean"%>
<%@page import="java.util.Vector"%>
<%@page import="shopper.OfflineShopMgr"%>
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
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>매장안내</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
    <!-- bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">      
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">  
    <!-- global styles -->
    <link href="themes/css/flexslider.css" rel="stylesheet"/>
    <link href="themes/css/main.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <!-- scripts -->
    <script src="themes/js/jquery-1.7.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>               
    <script src="themes/js/superfish.js"></script>   
    <script src="themes/js/jquery.scrolltotop.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=be8c3718a600554246946d9c63d7e385&libraries=services"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <!--[if lt IE 9]>            
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <script src="js/respond.min.js"></script>
    <![endif]-->
    <style>
        .kakao_map_container {
        	display:flex;
            flex-direction: row;
            width:100%;
        }
        #map {
            height: 500px;
            margin-right: 20px;
        }
        .search-container {
        	flex:1;
            flex-direction: column;
            align-items: center;
            width: 30%;
            padding: 20px;
        }
        .search-input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 20px;
            width: 50%;
            height: 10%;
            margin-bottom: 10%;
        }
        .search-button {
            padding: 10px 15px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        .search-button:hover {
            background-color: #0056b3;
        }
        .map-container {
        	margin-top: 10px;
            width: 50%;
            height: 400px;
            /* overflow-y: hidden; */
        }
        .map-container table {
            width: 100%;
        }
        .btn{
        	font-size: 16px;
        	font-weight: bold;
        	flex-grow: 1;
        	color: black;
        	background-color: gold ;
        	width: 250px;
        	heigth: 200px;
        	margin: 10px;
        	padding:30px ;
        	display: inline-block;

        }
          
		/* Swiper 슬라이더 스타일 */
		.swiper-container {
		    width: 100%;
		    
		    height: 100%; /* 슬라이더의 높이를 자식 요소에 맞게 자동으로 조정합니다. */
		}
		
		.swiper-slide img {
		    width: 100%;
		    height: 100%;
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
        <section>
            <!-- Slider main container -->
            <div class="swiper">
              <!-- Additional required wrapper -->
              <div class="swiper-wrapper" style="height: 500px">
                <!-- Slides -->
                <div class="swiper-slide" ><img src="themes/images/banner_1.png"></div>
                <div class="swiper-slide"><img src="themes/images/banner_2.jpg"></div>
                <div class="swiper-slide"><img src="themes/images/banner_3.jpg"></div>
                
              </div>
              <!-- If we need pagination -->
              <div class="swiper-pagination"></div>
            
              <!-- If we need navigation buttons -->
              <div class="swiper-button-prev"></div>
              <div class="swiper-button-next"></div>
            
              <!-- If we need scrollbar -->
             
            </div>
    
        </section>
        <div class="kakao_map_container">
            <div class="map-container">
                <div id="map"></div>
            </div>
            <div class="search-container">
                
                <table>
                <% 
                    // OfflineShopMgr 인스턴스 생성
                    OfflineShopMgr shopMgr = new OfflineShopMgr();
                    // getOfflineShop 메소드 호출하여 데이터 가져오기
                    Vector<OfflineShopBean> shopList = shopMgr.getOfflineShop();
                    // 가져온 데이터를 테이블에 추가
                    for (OfflineShopBean shop : shopList) {
                %>
	                <tr>
	                <button class="btn " onclick="moveMapToLocation('<%=shop.getLatitude()%>', '<%=shop.getLongitude() %>')">
	                	<%= shop.getLocation() %></button>
	                </tr>
                <% } %>
                </table>
            </div>
        </div>
        <section class="header_text sub">
            
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
            <span>Copyright 2013 bootstrappage template  All right reserved.</span>
        </section>
    </div>
    <script>
        var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
        var mapOption = {
            center: new kakao.maps.LatLng(37.5115, 127.0596), // 초기 지도의 중심좌표
            level: 3 // 초기 지도의 확대 레벨
        };
        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

        // 마커를 표시할 위치와 title 객체 배열입니다 
      var positions = [
            // 데이터베이스에서 가져온 위치 정보를 JavaScript 배열에 추가
            <%
                OfflineShopMgr shopMgr1 = new OfflineShopMgr();
                Vector<OfflineShopBean> shopList1 = shopMgr1.getOfflineShop();
                for (OfflineShopBean shop : shopList) {
            %>
            {
                title: '<%= shop.getLocation() %>',
                latlng: new kakao.maps.LatLng(<%= shop.getLatitude() %>, <%= shop.getLongitude() %>),
            	text: '<%= shop.getLocation() %>'
            },
            <%
                }
            %>
        ];

        // 마커 이미지의 이미지 주소입니다
        var imageSrc = "themes/images/Lux_pin_2.png"; 

        for (var i = 0; i < positions.length; i ++) {
            // 마커 이미지의 이미지 크기 입니다
            var imageSize = new kakao.maps.Size(150, 150); 
            // 마커 이미지를 생성합니다    
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                map: map, // 마커를 표시할 지도
                position: positions[i].latlng, // 마커를 표시할 위치
                title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                image : markerImage // 마커 이미지 
            });
        }

        function searchMap() {	
            var searchText = document.getElementById('searchInput').value.trim();
            var geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch(searchText, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    map.setCenter(coords);
                    marker.setPosition(coords);
                } else {
                    alert('검색 결과가 없습니다.');
                }
            });
        }

        function moveMapToLocation(latitude, longitude) {
            var coords = new kakao.maps.LatLng(latitude, longitude);
            map.setCenter(coords);
            marker.setPosition(coords);
        }



        const swiper = new Swiper('.swiper', {
              // Optional parameters
              direction: 'horizontal',
              loop: true,
              
              // 자동 슬라이드 설정
              autoplay: {
                delay: 3000, // 슬라이드 간의 딜레이 (밀리초)
                disableOnInteraction: false, // 유저 상호작용 후 자동 슬라이드 중지 여부
              },
            
              // If we need pagination
              pagination: {
                el: '.swiper-pagination',
              },
            
              // Navigation arrows
              navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
              },
            
              
            });
    
    </script>
</body>
</html>
