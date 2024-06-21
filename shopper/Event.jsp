<%@page import="shopper.UserManager"%>
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
*{
  margin: 0;
  padding: 0;
}

body{
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100vw;
  height: 100vh;
  background-color: #202020;
  overflow: hidden;
}

.contenedor-ruleta{
  transform: rotate(180deg);
}

.contenedor-ruleta::before{
  content: "";
  width: 60px;
  height: 60px;
  background-color: white;
  position: absolute;
  z-index: 99999;
  top: 50%;
  left: 55%;
  transform: translate(-50%, -50%) rotate(-135deg); /* 왼쪽으로 135도 회전 */
  pointer-events: none;
}


.ruleta{
  /*background-color: #303030;*/
  border-radius: 360px;
  position: relative;
  overflow: hidden;
  
  -webkit-animation-timing-function: cubic-bezier(0, 0.4, 0.4, 1.04);
          animation-timing-function: cubic-bezier(0, 0.4, 0.4, 1.04);
  -webkit-animation-duration: 5.8s;
          animation-duration: 5.8s;
  -webkit-animation-fill-mode: forwards;
          animation-fill-mode: forwards;
  -webkit-animation-iteration-count: 1;
          animation-iteration-count: 1;
}

.ruleta::before{
  content: "";
  width: 100px;
  height: 100px;
  background-color: #fff;
  position: absolute;
  z-index: 9999;
  border-radius: 360px;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  cursor: pointer;
}

.opcion{
  border: 0 solid transparent;
  position: absolute;
  transform-origin: top center;
  top: 50%;
}

.opcion::before{
  z-index: 99999;
  position: absolute;
  display: block;
  text-align: center;
  font-size: 20px;
  color: #fff;
  font-weight: bold;
  font-family: sans-serif;
  width: 40px;
  line-height: 40px;
  left: -20px;
  margin-top: 125px;
  transform: rotate(180deg);
}
#footer-bar {
    max-width: var(--max-container-width);
    margin: 20px auto;
    padding-top: 10px;
    background-color: #242424;
    border-top: 1px solid #ddd;
    color: #777;
 }
.header_text h4 span {
    font-size: 30px; /* 원하는 텍스트 크기로 조정 */
    font-weight: bold; /* 텍스트를 굵게 만듭니다 */
}
.main-content {
  padding: 20px 0;
}

.main-content .row {
  margin-left: auto;
  margin-right: auto;
}

.listing-products {
  margin-left: 0; /* 기본 마진을 제거 */
  padding-left: 0; /* 기본 패딩을 제거 */
  list-style-type: none; /* 기본 리스트 스타일을 제거 */
}

.listing-products .product-box {
  padding: 10px; /* 상품 상자 주변에 패딩을 추가 */
  border: 1px solid #ddd; /* 상품 상자 주변에 경계선을 추가 */
  margin-bottom: 20px; /* 하단 마진을 추가하여 상품 간의 간격을 설정 */
}
:root {
  --max-container-width: 1170px; /* 이 값을 조정하여 최대 너비를 변경할 수 있습니다. */
}

#top-bar {
  background-color: #fff;
  padding: 10px 0;
  margin: 0 auto; /* 중앙 정렬 */
  max-width: var(--max-container-width); /* 변수 사용 */
  border-bottom: 4px solid #d0d0d0;
}

#wrapper {
  max-width: var(--max-container-width); /* 변수 사용 */
  margin: 20px auto; /* 상단 여백 조정 및 중앙 정렬 */
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}
.main-content {
  padding: 20px;
  display: flex; /* 플렉스박스 적용 */
  justify-content: center; /* 가로축 중앙 정렬 */
  align-items: center; /* 세로축 중앙 정렬 */
}

/* 룰렛 컨테이너 스타일 */
.roulette-container {
  width: 100%; /* 룰렛 컨테이너의 너비를 100%로 설정 */
  max-width: 600px; /* 룰렛의 최대 너비를 설정 */
  height: auto; /* 높이를 자동으로 설정 */
}
/* 공통 컨테이너 스타일 */
.container {
  max-width: 1200px; /* 최대 너비 설정 */
  margin: 0 auto; /* 좌우 자동 마진으로 중앙 정렬 */
  padding: 0 15px; /* 양쪽에 패딩 추가 */
  box-sizing: border-box; /* 패딩 포함하여 너비 계산 */
}

/* 상단 바와 메뉴 스타일 조정 */
#top-bar, .navbar.main-menu {
  width: 100; /* 너비를 부모 요소의 100%로 설정 */
}

.main-menu nav ul {
  padding-left: 0; /* 기본 리스트 패딩 제거 */
  text-align: center; /* 메뉴 아이템 가운데 정렬을 위함 */
}

.main-menu nav ul li {
  display: inline-block; /* 리스트 아이템을 가로로 나열 */
  margin-right: 20px; /* 아이템 사이 간격 조정 */
}

.main-menu nav ul li:last-child {
  margin-right: 0; /* 마지막 아이템은 간격 제거 */
}
.top-bar{
	width:100;
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

    <div id="wrapper-inner" class="container">
    
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

        <%
// 검색어 가져오기
String searchQuery = request.getParameter("query");

// ProductMgr 인스턴스 생성 및 검색 메서드 호출
ProductMgr productMgr = new ProductMgr();
List<ProductBean> searchResults = productMgr.searchProducts(searchQuery, "경매중");

// 검색 결과를 request 속성으로 설정
request.setAttribute("searchResults", searchResults);
%>


           <section class="main-content">
            <div class="roulette-container" style="display: flex; justify-content: center; align-items: center;">
                <div class="contenedor-ruleta">
                    <div class="ruleta"></div>
                </div>
            </div>
        </section>


        
    </div>
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

            var tamanyoRuleta = 360;
            var numeroCasillas = 4;
            var anguloCasillas = 360 / numeroCasillas;
            var alturaCasilla = Math.tan((180 - anguloCasillas) / 2 * Math.PI / 180) * (tamanyoRuleta / 2);
            
            $(".ruleta").css({
              'width': tamanyoRuleta + 'px',
              'height': tamanyoRuleta + 'px'
            });
            
            $('head').append('<style id="afterNumero"></style>');

            var prizes = ["600P", "꽝", "1200P", "꽝"];
            for(var i = 0; i < numeroCasillas; i++) {
              $(".ruleta").append('<div class="opcion opcion-' + (i+1) + '"></div>');
              var clasS = '.opcion-' + (i+1);
              
              $(clasS).css({
                'transform': 'rotate(' + anguloCasillas * (i+1) + 'deg)',
                'border-bottom-color': getRandomColor()
              });
              $('#afterNumero').append('.opcion-' + (i+1) + '::before {content: "'+ prizes[i] +'"}');
            }

            $(".opcion").css({
              'border-bottom-width': alturaCasilla + 'px',
              'border-right-width': (tamanyoRuleta / 2) + 'px',
              'border-left-width': (tamanyoRuleta / 2) + 'px'
            });

            function getRandomColor() {
              var letters = '0123456789ABCDEF';
              var color = '#';
              for (var i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
              }
              return color;
            }
            

            $('.ruleta').on('click', function() {
                var fixedSpins = 10; // 회전 횟수
                var offset = -360; // 당첨 위치 보정을 위한 각도
                var fixedDegrees = fixedSpins * 360 + offset; // 총 회전 각도

                $(this).css({
                    'transition': 'transform 5s ease-out',
                    'transform': 'rotate(' + fixedDegrees + 'deg)'
                });

                $(this).one('transitionend webkitTransitionEnd oTransitionEnd', function() {
                    var degrees = fixedDegrees % 360;
                    var winningOptionIndex = (Math.floor(degrees / anguloCasillas) + numeroCasillas/2) % numeroCasillas;
                    var winningOption = prizes[winningOptionIndex];

                    // 당첨 알림을 표시하는 부분
                    alert("축하합니다! " + winningOption + "을(를) 획득하셨습니다.");

                    // 문자열에서 숫자 부분만 추출하여 서블릿으로 전송
                    var prizeNumber = parseInt(winningOption);
                    $.ajax({
                        type: "POST",
                        url: "rouletteResultServlet",
                        data: { prize: prizeNumber }, // 수정된 부분: prize 값을 숫자로 전달
                        success: function(response) {
                            var data = JSON.parse(response);
                            if(data.success) {
                                alert("축하합니다! 1200P 을(를) 획득하셨습니다.");
                                // 잔액 업데이트 또는 추가 액션
                                location.href = location.href;
                            } else {
                                alert("잔액 업데이트 중 오류가 발생했습니다.");
                            }
                        },
                        error: function() {
                            alert("오류가 발생했습니다. 다시 시도해주세요.");
                        }
                    });

                    $(this).css({
                        'transition': 'none',
                        'transform': 'rotate(' + degrees + 'deg)'
                    });
                });
            });
              
              
        });
    </script>
</body>
</html>
