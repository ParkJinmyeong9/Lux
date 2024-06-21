<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@page import="shopper.UserManager"%>
<%@ page import="shopper.User"%>
<%

UserManager userManager = new UserManager();
int userBalance = 0;





User loggedInUser = (User) session.getAttribute("user");
if (loggedInUser != null) {
    String userEmail = loggedInUser.getEmail();
    String userPhone = loggedInUser.getPhone();
    userBalance = userManager.getUserBalance(loggedInUser.getUserID()); // UserID를 넘겨 잔액 조회
    // 이메일과 전화번호가 null이 아닌지 로그를 남기세요.
    System.out.println("Email from session: " + userEmail);
    System.out.println("Phone from session: " + userPhone);
} else {
    // 세션에 사용자 정보가 없으면 로그를 남기세요.
    System.out.println("User object is not found in session.");
}
%>

<%
if (session.getAttribute("user") == null) {
    // 로그인하지 않은 사용자를 로그인 페이지로 리디렉션
    response.sendRedirect("login.jsp");
    return; // 현재 페이지의 처리를 중단
}
%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>LUX 충전</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<!-- 부트스트랩 -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="themes/css/bootstrappage.css" rel="stylesheet" />

<!-- 전역 스타일 -->
<link href="themes/css/flexslider.css" rel="stylesheet" />
<link href="themes/css/main.css" rel="stylesheet" />

<!-- 스크립트 -->
<script src="themes/js/jquery-1.7.2.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="themes/js/superfish.js"></script>
<script src="themes/js/jquery.scrolltotop.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

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
		<section class="main-content">
    <div class="row">
      <div class="span12">
        <h4>캐시 충전</h4>
        <form id="chargeForm" action="charge.html" method="post">
          <fieldset>
            <div class="control-group">
              <label class="control-label" for="chargeAmount">충전 금액</label>
              <div class="controls">
                <input type="number" min="0" step="10000" id="chargeAmount" name="chargeAmount" placeholder="충전할 금액을 입력하세요" class="input-xlarge">
              </div>
            </div>
            <button type="button" id="btnPay" class="btn btn-inverse">충전하기</button>
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
						<li><a href="./index.jsp">홈페이지</a></li>
						<li><a href="./about.html">회사 소개</a></li>
						<li><a href="./contact.html">문의하기</a></li>
						<li><a href="./cart.html">장바구니</a></li>
						<li><a href="./login.jsp">로그인</a></li>
					</ul>
				</div>
				<div class="span4">
					<h4>내 계정</h4>
					<ul class="nav">
						<li><a href="#">계정 정보</a></li>
						<li><a href="#">주문 내역</a></li>
						<li><a href="#">위시리스트</a></li>
						<li><a href="#">뉴스레터 구독</a></li>
					</ul>
				</div>
				<div class="span5">
					<p class="logo">
						<img src="themes/images/logo.png" class="site_logo" alt="">
					</p>
					<p>Lorem Ipsum은 인쇄 및 조판 산업에서 사용되는 더미 텍스트입니다. Lorem Ipsum은
						1500년대부터 산업 표준 더미 텍스트로 사용되어 왔습니다.</p>
					<br /> <span class="social_icons"> <a class="facebook"
						href="#">페이스북</a> <a class="twitter" href="#">트위터</a> <a
						class="skype" href="#">스카이프</a> <a class="vimeo" href="#">비메오</a>
					</span>
				</div>
			</div>
		</section>
		<section id="copyright">
			<span>Copyright 2013 부트스트랩 페이지 템플릿 모든 권리 보유.</span>
		</section>
	</div>
	<script src="themes/js/common.js"></script>

    <script>
$(document).ready(function(){
    $("#btnPay").click(function(){
        var chargeAmount = $("#chargeAmount").val();
        if(chargeAmount == "" || chargeAmount <= 0) {
            alert("충전 금액을 정해주세요.");
            return;
        }

        var loggedInUser = '<%= session.getAttribute("user") != null ? ((User)session.getAttribute("user")) : null %>';
        if(loggedInUser === null) {
            alert("로그인이 필요한 서비스입니다.");
            window.location.href = "/login.jsp";
            return;
        }

        // 로그인한 사용자의 ID를 가져오는 코드를 여기에 추가하세요.
        var IMP = window.IMP; // I'mport 객체 초기화
        IMP.init('imp48773364'); // 가맹점 식별 코드를 입력하세요.
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '테스트 상품',
            amount : chargeAmount,
            buyer_email : '<%= loggedInUser.getEmail() %>',
            buyer_name : '<%= loggedInUser.getName() %>',
            buyer_tel : '<%= loggedInUser.getPhone() %>',
        }, function(rsp) {
        	if (rsp.success) {
        	    // 결제 성공 시 서버로 요청할 데이터 준비
        	    var userId = '<%= loggedInUser.getUserID() %>'; // JSP 태그를 사용하여 사용자 ID를 가져옵니다.
        	    var paidAmount = rsp.paid_amount; // I'mport로부터 받은 실제 결제된 금액
		
        	    // AJAX POST 요청
        	    $.ajax({
        	        url: 'charge', // 올바른 서블릿 URL
        	        type: 'POST', // type 속성을 사용 (method도 동일하게 작동합니다)
        	        data: {
        	            amount: paidAmount, // 실제 결제된 금액 사용
        	            userId: userId // 이미 선언된 사용자 ID 변수 사용
        	        },
        	        success: function(response) {
        	            // 응답 처리
        	            alert('충전이 완료되었습니다.');
        	            // 추가적인 성공 처리 로직을 여기에 구현할 수 있습니다.
        	        },
        	        error: function(xhr, status, error) {
        	            // 오류 처리
        	            alert('충전 실패: ' + error);
        	            // 추가적인 오류 처리 로직을 여기에 구현할 수 있습니다.
        	        }
        	    });
        	} else {
        	    // 결제 실패 처리
        	    alert('결제에 실패하였습니다. 에러 내용: ' + rsp.error_msg);
        	}
        	
        });
    });

    // 숫자만 입력하도록 설정
    $("#chargeAmount").on("keydown", function(event) {
        // 숫자, 백스페이스, 탭, 좌/우 방향키만 허용
        if(event.key == "Backspace" || event.key == "Tab" || event.key == "ArrowLeft" || event.key == "ArrowRight") {
            return;
        }
        if(isNaN(event.key) || event.key == " ") {
            event.preventDefault();
        }
    });
});
</script>

</body>
</html>
