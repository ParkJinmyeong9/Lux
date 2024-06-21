<%@page import="java.io.Console"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="shopper.ProductMgr"%>
<%@page import="shopper.ProductBean"%>
<%@page import="shopper.AuctionMgr"%>
<%@page import="shopper.AuctionBean"%>
<%@page import="shopper.UserMgr"%>
<%@page import="shopper.UserManager"%>
<%@page import="shopper.UserBean"%>
<%@page import="shopper.User"%>
<%@page import="shopper.CurrentBean"%>
<%@page import="shopper.CurrentMgr"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="pbean" class="shopper.ProductBean"/>
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
int userID = loggedInUser.getUserID();

String productIDString = request.getParameter("id");
int productID = Integer.parseInt(productIDString);
System.out.println(productID);
ProductMgr pmgr = new ProductMgr();
ProductBean product = pmgr.getProductById(productID);
AuctionMgr amgr = new AuctionMgr();
AuctionBean auction = amgr.getAuction(productID);
System.out.println(auction);
String time = auction.getEndTime();
System.out.println(time);
UserMgr umgr = new UserMgr();
UserBean user = umgr.getUserBalance(userID);


int StartPrice = product.getStartPrice();
System.out.println("tlwkr"+StartPrice);
String status = product.getStatus();
boolean isAuctionInProgress = status.equals("경매중");
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
    <link href="themes/css/bootstrappage.css" rel="stylesheet">
    
    <!-- global styles -->
    <link href="themes/css/main.css" rel="stylesheet">
    <link href="themes/css/jquery.fancybox.css" rel="stylesheet">
            
    <style>
        .row {
            display: flex;
            justify-content: space-between; /* 자식 요소를 가능한한 넓게 표시합니다. */
        }
        span5 {
            width: calc(50% - 20px + 200px); /* 이미지의 너비만큼을 제외한 나머지 너비 */
        }
        .image-and-info {
            display: flex;
            align-items: flex-start; /* 요소들을 위쪽으로 정렬 */
        }
        /* 텍스트가 main content 내에서 줄바꿈되도록 설정 */
        .bid-info {
            float: right;
            margin-top: 50px;
            top: 0;
            width: calc(50% - 20px + 200px); /* 텍스트 영역의 너비를 main content의 반으로 설정한 후 200px만큼 늘립니다. */
            white-space: normal; /* 줄바꿈이 되도록 설정 */
            overflow-wrap: break-word; /* 텍스트가 컨테이너를 벗어나면 단어 단위로 줄바꿈되도록 설정 */
        }
        /* 텍스트 줄바꿈이 되도록 설정 */
        .bid-info span {
            display: block;
            line-height: 1.2;
        }
        /* main content 세로선 스타일 */
        .vertical-line {
            width: 1px;
            height: 100%; /* main content의 높이에 맞추기 */
            background-color: #ccc;
            position: absolute;
            left: 50%;
            top: 0;
            transform: translateX(-50%);
        }
        /* main content의 스타일 */
        .main-content {
            position: relative; /* wrapper에 영향 받지 않도록 설정 */
            padding-left: 20px; /* 세로선을 고려하여 패딩 설정 */
            min-height: calc(100vh - 100px); /* 브라우저 높이에서 footer-bar의 높이를 뺀 값으로 최소 높이 설정 */
            display: flex; /* Flexbox 사용 */
            flex-direction: column; /* 컨텐츠를 세로 방향으로 배치 */
        }
        /* wrapper의 스타일 */
        #wrapper {
            height: auto; /* 원래 상태로 복구 */
        }
        /* 메인 이미지 틀 스타일 */
        .main-image-container {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
            margin-top: 10px; /* 메인 이미지 틀을 아래로 조금 내리는 상단 여백 */
            position: absolute; /* 위치 설정 */
            left: 50px; /* 왼쪽으로 이동하는 값을 0으로 설정합니다. */
            top: 50px;
        }
        #product-details {
            margin-bottom: 20px; /* footer-bar와 겹치지 않도록 하단 여백 추가 */
        }

        #footer-bar {
            clear: both; /* main-content의 하단에 배치하기 위해 floating을 해제합니다. */
            margin-top: 200px; /* main-content와 겹치지 않도록 footer-bar의 상단 여백 추가 */
        }
        /* 입찰하기 버튼 스타일 */
		#bid-button {
		    background-color: #4CAF50; /* 초록계열 바탕색 */
		    color: white; /* 흰색 텍스트 */
		    border: 2px solid #4CAF50; /* 테두리 */
		    border-radius: 10px; /* 모서리 둥글게 */
		    padding: 10px 20px; /* 내부 여백 */
		    font-size: 18px; /* 폰트 크기 */
		    cursor: pointer; /* 포인터 형태 */
		    width: 200px; /* 가로 길이 고정 */
		}
		
		/* 마우스 호버시 색상 변경 */
		#bid-button:hover {
		    background-color: #45a049; /* 더 진한 초록 계열 */
		    border-color: #45a049;
		}
		/* 즉시 구매하기 버튼 스타일 */
		#buy-now-button {
		    background-color: #FF6347; /* 빨간계열 바탕색 */
		    color: white; /* 흰색 텍스트 */
		    border: 2px solid #FF6347; /* 테두리 */
		    border-radius: 10px; /* 모서리 둥글게 */
		    padding: 10px 20px; /* 내부 여백 */
		    font-size: 18px; /* 폰트 크기 */
		    cursor: pointer; /* 포인터 형태 */
		    margin-left: 10px; /* 버튼 간격을 위한 마진 추가 */
		    width: 200px; /* 가로 길이 고정 */
		}
		
		/* 마우스 호버시 색상 변경 */
		#buy-now-button:hover {
		    background-color: #FF5733; /* 더 진한 빨간 계열 */
		    border-color: #FF5733;
		}
		
		#mainImage {
		    width: 450px; /* 이미지의 너비를 450px로 고정합니다. */
		    height: auto; /* 이미지의 높이를 자동으로 조정하여 비율을 유지합니다. */
		}
			
			/* 댓글 입력란과 버튼을 가로로 나란히 배치 */
	    .comment-form {
	        display: flex;
	        align-items: center;
	    }
	    
	    .comment-input {
	        flex: 1;
	    }
	    
		.submit-comment-button {
		    margin-top: -10px; /* 원하는 만큼 버튼을 위로 올립니다. */
		}
		    /* 댓글 목록의 폰트 크기 설정 */
	    .comment-list {
	    	font-family: 'Noto Sans KR', sans-serif;
	        font-size: 16px;
	    }
		
		.comment-list li {
		    padding: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    background-color: #f9f9f9;
		    margin-bottom: 10px;
		}
		
		/* 타이머가 3시간 미만일 때 텍스트 색상 변경 */
		#remaining-time.red {
    		color: red;
		}
		
    </style>
    
   
</head>
<body>
    <div id="top-bar" class="container">
		<div class="row">
			<div class="span4">
				<form method="POST" class="search_form">
					<input type="text" class="input-block-level search-query"
						Placeholder="eg. T-sirt">
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

        <section class="main-content" id="main-content">
            <div class="row">
                <div class="span9">
                    <div class="row">
                        <div class="span4">
                            <div class="vertical-line"></div>
                            <div class="main-image-container">
                                <img id="mainImage" src="<%= product.getPhoto() %>" alt="Main Image">
                            </div>
                        </div>
                        <div class="span5">
                            <address class="bid-info" id="product-details">
                                <strong style="font-size: 28px;">BID PRICE</strong><br>
                                <span style="font-size: 30px; font-weight: bold;"><%= product.getCurrentBid() %>원</span><br><br>
                                <span style="font-size: 20px; "><%= product.getBrand() %></span><br>
                                <span style="font-size: 26px;"><%= product.getName() %></span><br>
                                <span style="font-size: 16px;">모델ID: <%= product.getModelNumber() %></span><br><br>
                                <span id="remaining-time" style="font-size: 24px;"></span><br><br>								                               
								<input type="button" id="bid-button" class="bid-button" value="입찰하기" <%= isAuctionInProgress ? "" : "disabled" %>>
								<input type="button" id="buy-now-button" value="즉시 구매하기" <%= isAuctionInProgress ? "" : "disabled" %>><br><br>								                            
                                <span style="font-size: 14px;">즉시 구매가 : <%= product.getBuyNowPrice() %>원</span><br>
                                <span style="font-size: 14px;">경매 시작가 : <%= product.getStartPrice() %>원</span><br>
                                <span style="font-size: 16px">입찰가 : <input type="text" id="userbid" value="입찰가를 입력하세요." onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)"></span>
		                        <div id="chart-container">
								    <canvas id="bid-chart"></canvas>
								</div>						                       
                            </address>
                        </div>
                    </div>
                </div>
            </div>
            <div style="clear: both;"></div> <!-- main-content의 하단에 clear 추가 -->
        </section>
        
        <section id="tab-bar">
			<div class="row">
				<div class="span9">
					<ul class="nav nav-tabs" id="myTab">
						<li class="active"><a href="#home">상품 설명</a></li>
						<li class=""><a href="#comment">댓글</a></li>
					</ul>							 
					<div class="tab-content">
						<div class="tab-pane active" id="home"><%= product.getDescription() %></div>
						<div class="tab-pane" id="comment">
						    <form id="commentForm" class="comment-form">
						        <div class="form-group comment-input">
						            <input type="text" class="form-control" id="commentInput" placeholder="댓글을 입력하세요">
							       <button type="button" class="btn btn-primary submit-comment submit-comment-button" id="submitComment">댓글 제출</button>
						        </div>
						    </form>
						    <ul id="commentList" class="comment-list"></ul> <!-- 댓글이 추가될 목록 -->
						</div>
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
    
    
     <!-- scripts -->
    <script src="themes/js/jquery-1.7.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>                
    <script src="themes/js/superfish.js"></script>   
    <script src="themes/js/jquery.scrolltotop.js"></script>
    <script src="themes/js/jquery.fancybox.js"></script>
    <!--[if lt IE 9]>           
        <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <script src="js/respond.min.js"></script>
    <![endif]-->
    
    <!-- 막대그래프 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
	<script>
	    // 데이터 가져오기
	    var startPrice = <%= product.getStartPrice() %>;
	    var currentBid = <%= product.getCurrentBid() %>;
	    var buyNowPrice = <%= product.getBuyNowPrice() %>;
	
	    // 차트 생성
	    var ctx = document.getElementById('bid-chart').getContext('2d');
	    var myChart = new Chart(ctx, {
	        type: 'bar',
	        data: {
	            labels: ['경매시작가', '현재입찰가', '즉시구매가'],
	            datasets: [{
	               
	                data: [startPrice, currentBid, buyNowPrice],
	                backgroundColor: [
	                    'rgba(255, 99, 132, 0.2)',
	                    'rgba(54, 162, 235, 0.2)',
	                    'rgba(255, 206, 86, 0.2)'
	                ],
	                borderColor: [
	                    'rgba(255, 99, 132, 1)',
	                    'rgba(54, 162, 235, 1)',
	                    'rgba(255, 206, 86, 1)'
	                ],
	                borderWidth: 1
	            }]
	        },
	        options: {
	            scales: {
	                y: {
	                    beginAtZero: true
	                    
	                }
	            },
	            plugins: {
	                
	            	legend: {display: false}
	            }
	        }
	    });
	</script>

	<!-- 상품설명이랑 댓글 탭 -->
	<script src="themes/js/common.js"></script>
	<script>
	    $(document).ready(function(){
	        $('#myTab a').click(function (e) {
	            e.preventDefault();
	            $(this).tab('show'); // 클릭한 탭을 수동으로 보여줍니다.
	        });
	    });
	</script>
	
	<!-- 타이머 -->
    <script>
	 // 남은 시간을 표시하는 함수
	    function updateRemainingTime() {
	        var remainingTimeElement = document.getElementById('remaining-time');
	        var endTimeStr = "<%= auction.getEndTime() %>";
	        var productStatus = "<%= product.getStatus() %>"; // 제품 상태 가져오기
	
	        // 제품 상태에 따라 다른 메시지 표시
	        if (productStatus === "낙찰") {
	            remainingTimeElement.textContent = "경매가 종료되었습니다.";
	        } else if (productStatus === "검수중") {
	            remainingTimeElement.textContent = "검수중 입니다.";
	        } else {
	            // 이전과 동일하게 남은 시간 표시 로직을 진행합니다.
	            var currentTime = new Date();
	            var endTime = new Date(endTimeStr);
	            var remainingTimeMillis = endTime - currentTime;
	            
	            if (remainingTimeMillis > 0) {
	                var hours = Math.floor(remainingTimeMillis / (1000 * 60 * 60));
	                var minutes = Math.floor((remainingTimeMillis % (1000 * 60 * 60)) / (1000 * 60));
	                var seconds = Math.floor((remainingTimeMillis % (1000 * 60)) / 1000);
	                remainingTimeElement.textContent = hours + "시간 " + minutes + "분 " + seconds + "초 남음";
	                // 남은 시간이 3시간 미만이면 텍스트 색상을 빨간색으로 변경
	                if (hours < 3) {
	                    remainingTimeElement.classList.add('red');
	                } else {
	                    // 3시간 이상 남은 경우에는 빨간색 클래스를 제거
	                    remainingTimeElement.classList.remove('red');
	                }

	            } else {
	                remainingTimeElement.textContent = "경매가 종료되었습니다.";
	                // 필요 시 추가 작업 수행 (예: 데이터베이스 업데이트)
	                var productID = <%= productID %>;
	                $.ajax({
	                    url: "updateStateSuccessServlet",
	                    type: "POST",
	                    data: { productId: productID },
	                    success: function(data) {
	                        data = JSON.parse(data);
	                    },
	                    error: function(xhr) {
	                        console.log(xhr);
	                    }
	                });
	            }
	        }
	    }
	
	    // 페이지 로드 시 처음 한 번 실행
	    updateRemainingTime();
	
	    // 1초마다 남은 시간 업데이트
	    setInterval(updateRemainingTime, 1000);
    </script>
    
    <!-- 입찰가 입력란 -->
    <script>
	    function clearPlaceholder(input) {
	        if (input.value === input.defaultValue) {
	            input.value = '';
	        }
	    }
	
	    function restorePlaceholder(input) {
	        if (input.value === '') {
	            input.value = input.defaultValue;
	        }
	    }
	</script>
	
	<!-- 입찰하기 버튼과 입찰가 입력란 연동 -->
	<script>
	// bid-button 클릭 이벤트 처리
	document.getElementById('bid-button').addEventListener('click', function() {
	    // userbid 입력란의 값을 가져옴
	     console.log("버튼을 눌러버림!");
	     var isAuctionInProgress = <%= isAuctionInProgress %>;
	     if(isAuctionInProgress){
	     console.log("경매가 진행!!!");
	    var userBidInput = document.getElementById('userbid');
	    var userBid = parseInt(userBidInput.value);
	    var productID = <%= productID %>;
        var a = parseInt(productID);
	    var userID = <%= userID %>;
        var b = parseInt(userID);
	    // 입력값이 숫자인지 확인
	    if (!isNaN(userBid)) {
	        // CurrentBid와 비교
	        if (userBid <= <%= product.getCurrentBid() %>) { 
	        	alert("현재 입찰가보다 낮습니다.")
	            userBidInput.value = "";	            
	            userBidInput.focus();
	        }
	        // StartPrice와 비교
	        else if (userBid < <%= product.getStartPrice()%> ){
	        	alert("시작금액을 확인해주세요.");	            
	            userBidInput.value = "";	            
	            userBidInput.focus();
	        }
	        // BuyNowPrice와 비교
	        else if (userBid >= <%= product.getBuyNowPrice() %>) {
	            alert("즉시 구매가보다 높습니다!");	            
	            userBidInput.value = "";	            
	            userBidInput.focus();
	        }
	        // 백 단위가 0인지 확인
	        else if (userBid % 1000 !== 0) {
	            alert("입찰가는 천 단위여야 합니다.");	            
	            userBidInput.value = "";	            
	            userBidInput.focus();
	        }
	        // 유저가 보유한 금액보다 높은지 확인
	        else if (userBid > <%= user.getBalance()%>){
	        	alert("보유 금액보다 높습니다.")
	        	userBidInput.value = "";
	        	userBidInput.focus();
	        }
	        // 유효한 입력일 경우
	        else {
            	// 추가된 부분: 현재 테이블에 데이터 삽입을 위한 AJAX 요청
                $.ajax({
                    url: "currentInsertServlet",
                    type: "POST",
                    data: {
                        userId: b,
                        productId: a,
                        userBid: userBid
                    },
                    success: function(response) {
                        // 현재 테이블에 데이터 삽입 후 처리할 내용
                    },
                    error: function(xhr) {
                        console.log(xhr); // 에러가 발생했을 때의 처리
                    }
                });    	
	        
	        	alert("입찰 되었습니다.");
	        	$.ajax({
                    url: "userBalanceCurrentServlet",
                    type: "POST",
                    data: { userId: b,
                    		productId: a, 
                    		userBid: userBid}, // 제품 ID를 전송합니다. 여기서 1은 예시일 뿐이므로 실제로 전송할 제품 ID로 변경하세요.
                    success: function(response) {
                    	//data = JSON.parse(data);
				       	location.reload();
                    },
                    error: function(xhr) {
                        console.log(xhr); // 에러가 발생했을 때의 처리
                    }
                });
                    	userBidInput.value = "";
	        }
	    } else {
	        alert("숫자를 입력하세요.");
	        userBidInput.value = "";	        
	        userBidInput.focus();
	    }
	    
	    } else { 
	    // 경매 중이 아닌 경우 알림 표시
	    console.log("경매가 진행 중이 아님");
	    alert("경매중이 아닙니다!");
	   
		}
	});

	</script>
	
	<script>
	// 즉시 구매하기 버튼 클릭 이벤트 처리
	document.getElementById('buy-now-button').addEventListener('click', function() {
		 <% if(isAuctionInProgress) { %>
	    // "정말로 즉시구매 하시겠습니까?"라는 알림 표시
	    var confirmFirst = confirm("즉시구매 하시겠습니까?");
	    var userID = <%= userID %>;
        var b = parseInt(userID);
        var productID = <%= productID %>;
        var a = parseInt(productID);
        var userBalance = <%= user.getBalance() %>;
        var buyNowPrice = <%= product.getBuyNowPrice() %>;
	    // 사용자가 확인을 선택한 경우
	    if (confirmFirst) {
	        // 다시 한번 확인 메시지 표시
	        var confirmSecond = confirm("정말 즉시구매 하시겠습니까?");
		    var buyNowPrice = <%= product.getBuyNowPrice() %>;
	        // 사용자가 확인을 선택한 경우에만 즉시구매 처리 실행
	        	if (confirmSecond) {	        	
		        	  if (userBalance < buyNowPrice) {
		        	        alert("보유금액이 부족합니다!");
		        	  } else {
		        	// 상태 업뎃 하는거
		            $.ajax({
		                url: "buyNowServlet", // 즉시구매를 처리하는 서블릿 URL
		                type: "POST",
		                data: { userId: b,
		                		productId: a,
		                		buyNowPrice: buyNowPrice}, // 즉시구매할 제품의 ID 등 필요한 데이터를 전송합니다.
		                success: function(response) {
		                	//data = JSON.parse(data);// 즉시구매 성공 시 수행할 동작
		                	alert("즉시구매가 완료되었습니다!");
		                	$.ajax({
		                        url: "updateStateSuccessServlet",
		                        type: "POST",
		                        data: { productId: a }, // 제품 ID를 전송합니다. 여기서 1은 예시일 뿐이므로 실제로 전송할 제품 ID로 변경하세요.
		                        success: function(data) {
		                        	data = JSON.parse(data);
		                        },
		                        error: function(xhr) {
		                            console.log(xhr); // 에러가 발생했을 때의 처리
		                        }
		                    });
		                	var currentBid = <%= product.getBuyNowPrice()%>;
		                	// 추가된 부분: 현재 테이블에 데이터 삽입을 위한 AJAX 요청
			                $.ajax({
			                    url: "currentInsertServlet",
			                    type: "POST",
			                    data: {
			                        userId: b,
			                        productId: a,
			                        userBid: currentBid
			                    },
			                    success: function(response) {
			                        // 현재 테이블에 데이터 삽입 후 처리할 내용
			                    },
			                    error: function(xhr) {
			                        console.log(xhr); // 에러가 발생했을 때의 처리
			                    }
			                }); 
		                	
		                	window.location.href = "index.jsp";
		                },
		                error: function(xhr) {
		                    console.log(xhr); // 오류 발생 시 로그에 출력
		                }
		            });
		        }
	        }
	    } else {
	        // 사용자가 취소를 선택한 경우 아무 동작 없음
	    }
	    
	    <% } else { %>
	    // 경매 중이 아닌 경우 알림 표시
	    alert("경매중이 아닙니다!");
	    <% } %>
		 
	});
	</script>
	
	<script>
	// 댓글 제출 함수
	function submitComment() {
	    // 입력된 댓글 내용 가져오기
	    var commentInput = document.getElementById('commentInput');
	    var commentText = commentInput.value.trim();
	    
	    // 입력된 댓글이 비어있지 않은 경우에만 처리
	    if (commentText !== '') {
	        // 새로운 댓글 아이템 생성
	        var commentList = document.getElementById('commentList');
	        var newCommentItem = document.createElement('li');
			
	        // 댓글 달기
	        newCommentItem.textContent = commentText;
	        
	        // 목록에 새로운 댓글 추가
	        commentList.appendChild(newCommentItem);
	        
	        // 댓글 입력란 비우기
	        commentInput.value = '';
	    }
	}
	
	// 댓글 제출 버튼과 댓글 입력란에 이벤트 리스너 추가
	document.getElementById('submitComment').addEventListener('click', submitComment);
	document.getElementById('commentInput').addEventListener('keypress', function(event) {
	    // 엔터 키(키 코드: 13)를 눌렀을 때만 처리
	    if (event.keyCode === 13) {
	        // 기본 엔터 기능 제거
	        event.preventDefault();
	        // 댓글 제출 함수 호출
	        submitComment();
	    }
	});
</script>
</body>
</html>
