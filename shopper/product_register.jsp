<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileOutputStream" %>
<%@page import="shopper.ProductMgr"%>
<%@page import="shopper.ProductBean"%>
<%@page import="shopper.UserMgr"%>
<%@page import="shopper.UserManager"%>
<%@page import="shopper.UserBean"%>
<%@page import="shopper.User"%>
<!-- 파일업로드 위한 라이브러리 임포트 -->
<%@ page import="java.io.File" %>
<!-- 파일 이름이 동일한게 나오면 자동으로 다른걸로 바꿔주고 그런 행동 해주는것 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 실제로 파일 업로드 하기 위한 클래스 -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="shopper.User"%>
<%
	User loggedInUser = (User) session.getAttribute("user");
	int userID = loggedInUser.getUserID();
	
	UserManager userManager = new UserManager();
	int userBalance = 0;

	if (loggedInUser != null) {
	    userBalance = userManager.getUserBalance(loggedInUser.getUserID()); // UserID를 넘겨 잔액 조회
	}
	
	ProductMgr pmgr = new ProductMgr();
    ProductBean product = pmgr.getProductById(1);
    UserMgr umgr = new UserMgr();
    UserBean user = umgr.getUserBalance(1);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Bootstrap E-commerce Templates</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <!--[if ie]><meta content='IE=8' http-equiv='X-UA-Compatible'/><![endif]-->
    
    <!-- bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">      
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">        
    <link href="themes/css/bootstrappage.css" rel="stylesheet"/>
    
    <!-- global styles -->
    <link href="themes/css/main.css" rel="stylesheet"/>
    <link href="themes/css/jquery.fancybox.css" rel="stylesheet"/>
            
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
    
    <style>
        /* 추가한 CSS */
        .form-group {
            overflow: hidden;
            clear: both;
        }
        .form-group label {
            width: 150px; /* 레이블 너비 조정 */
            float: left;
            text-align: right;
            margin-right: 20px; /* 레이블 간격 조정 */
        }
        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 150px; /* 입력 필드 너비 조정 */
            float: left;
            margin-left: 10px; /* 입력 필드와 레이블 간격 조정 */
        }
        .form-group textarea {
            width: 350px; /* 텍스트 영역 너비 조정 */
            float: left;
            margin-left: 10px; /* 텍스트 영역과 레이블 간격 조정 */
        }
        .clear {
            clear: both;
        }
        .form-group select {
            margin-left: 10px; /* 레이블과 <select> 요소 사이의 간격을 조정하여 오른쪽으로 이동 */
        }
       .form-group #Photo {
		    margin-left: 10px;
		}
		.preview-container {
		    float: right; /* 오른쪽으로 이동 */
		    margin-top: 10px; /* 위쪽 여백 추가 */
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
                   
        <section class="main-content">                
            <div class="row">                        
                <div class="span9">
                    <div class="row">
                        <!-- Product Registration Form -->
                  <div class="span6">
                      <h3>상품 등록하기</h3>
                        <form id="productForm" enctype="multipart/form-data">
                          <div class="form-group">
                              <label for="Name">상품이름 : </label>
                              <input type="text" class="form-control" id="Name" name="Name" required>
                          </div>
                          <div class="form-group">
                              <label for="Brand">브랜드:</label>
                              <select class="form-control" id="Brand" name="Brand" required>
                                <option value="Louis Vuitton">Louis Vuitton</option>
                                <option value="Gucci">Gucci</option>
                                <option value="Chanel">Chanel</option>
                                <option value="Hermes">Hermes</option>
                                <option value="Cartier">Cartier</option>
                                <option value="Rolex">Rolex</option>
                                <option value="Dior">Dior</option>
                                <option value="Tiffany">Tiffany</option>
                                <option value="Burberry">Burberry</option>
                                <option value="Prada">Prada</option>
                                <option value="Others">Others</option>
                              </select>
                          </div>
                          
                          <div class="form-group">
                              <label for="StartPrice">시작가격 :</label>
                              <input type="number" class="form-control" id="StartPrice" name="StartPrice" required>
                          </div>
                          <div class="form-group">
                              <label for="BuyNowPrice">즉시구매가격:</label>
                              <input type="number" class="form-control" id="BuyNowPrice" name="BuyNowPrice" required>
                          </div>
                          <div class="form-group">
                              <label for="AuctionDuration">경매시간:</label>
                              <select class="form-control" id="AuctionDuration" name="AuctionDuration" required>
                                  <option value="6">6 Hours</option>
                                  <option value="12">12 Hours</option>
                                  <option value="24">24 Hours</option>
                              </select>
                          </div>
                          <div class="form-group">
                              <label for="Description">상품 설명:</label>
                              <textarea class="form-control" id="Description" name="Description" rows="5" required></textarea>
                          </div>
                      </form>
                     
                          <div class="form-group">
						    <label for="Photo">상품 이미지:</label>
						    <input type="file" class="form-control" id="Photo" name="Photo" required>
						    <div id="imagePreview" class="preview-container"></div> <!-- 미리보기를 포함할 div 요소 -->
                          <button type="submit" id="submitButton" class="btn btn-primary">상품등록</button>
						  </div>
                     
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
    </div>
    
    <!-- scripts -->
    <script src="themes/js/jquery-1.7.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>                
    <script src="themes/js/superfish.js"></script>   
    <script src="themes/js/jquery.scrolltotop.js"></script>
    <script src="themes/js/jquery.fancybox.js"></script>
    <script>
    $('#Photo').change(function() {
        // 파일 선택기에서 선택한 파일 가져오기
        var file = this.files[0];
        
        // 파일이 선택되었는지 확인
        if (file) {
            // 이미지 미리보기를 포함할 div 요소 선택
            var previewContainer = $('#imagePreview');
            
            // 이전에 생성된 미리보기 삭제
            previewContainer.empty();
            
            // 파일 이름을 표시하는 엘리먼트 생성
            var fileNameElement = $('<p>').text('Product Image: ' + file.name);
            
            // 이미지 엘리먼트 생성 및 스타일 지정
            var imgElement = $('<img>').css({'width': '300px', 'height': '300px'});
            
            // 파일을 읽기 위한 FileReader 객체 생성
            var reader = new FileReader();
            
            // 파일을 읽고 미리보기 생성
            reader.onload = function(e) {
                // 이미지 데이터를 이미지 엘리먼트에 설정
                imgElement.attr('src', e.target.result);
            };
            
            // 파일을 읽기 시작
            reader.readAsDataURL(file);
            
            // 파일 이름과 이미지를 미리보기를 포함하는 div에 추가
            previewContainer.append(fileNameElement, imgElement);
        }
    });
</script>
<script>
    $(document).ready(function() {
        $('#submitButton').click(function(e) {
            e.preventDefault(); // 기본 제출 동작 방지

            // 파일 입력 요소에서 파일 가져오기
            var file = $('#Photo')[0].files[0];
            console.log('Selected file name:', file.name);
            console.log('Selected file size:', file.size); // 파일의 크기 출력
			var filename = file.name;
            // 파일 입력 요소에서 파일이 선택되지 않은 경우 처리
            if (!file) {
                alert('Please select a file.');
                return;
            }

            // FormData 객체 생성 (파일 및 기타 데이터를 담음)
            var formData = new FormData($('#productForm')[0]);
            var userID = <%= userID %>;
            var b = parseInt(userID);
        	// 파일 추가
            formData.append('Photo', file);

            // 기타 데이터 추가 (예: 텍스트 필드)
            formData.append('Name', $('#Name').val());
            formData.append('Brand', $('#Brand').val());
            formData.append('StartPrice', $('#StartPrice').val());
            formData.append('BuyNowPrice', $('#BuyNowPrice').val());
            formData.append('AuctionDuration', $('#AuctionDuration').val());
            formData.append('Description', $('#Description').val());
            formData.append('PhotoName', filename); // 파일 이름 추가
            formData.append('userId', b);
            // Ajax 요청
            $.ajax({
                url: 'productInsertServlet', // 서버로 보낼 URL
                type: 'POST', // 전송 방식
                data: formData,
                processData: false, // 데이터 처리 방법 (false로 설정하여 FormData가 처리되도록 함)
                contentType: false, // 컨텐츠 타입 (false로 설정하여 FormData가 설정한 컨텐츠 타입이 유지되도록 함)
                success: function(response) {
                    // 서버로부터의 성공 응답 처리
                    console.log('Servlet연결 성공!');
                    // 여기에 성공 시 동작할 코드 추가
                    alert('제품 등록에 성공하였습니다.');
                    // index.jsp로 이동
                    window.location.href = 'index.jsp';
                },
                error: function(xhr, status, error) {
                    // 서버로의 요청 실패 처리
                    //console.error('Error:', error);
                    // 여기에 실패 시 동작할 코드 추가
                    alert('같은 파일이 존재합니다.');
                }
            });
        });
    });
</script>


</body>
</html>