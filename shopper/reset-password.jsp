<%@ page contentType="text/html; charset=EUC-KR"%>
<%@page import="shopper.UserManager"%>
<%@ page import="shopper.User"%>
<%
User loggedInUser = (User) session.getAttribute("user");
UserManager userManager = new UserManager();
int userBalance = 0;

/* if (loggedInUser != null) {
    userBalance = userManager.getUserBalance(loggedInUser.getUserID()); // UserID�� �Ѱ� �ܾ� ��ȸ
} */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Lux - ���̵�/��й�ȣ ã��</title>
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
                        <li><a href="./products.jsp">����������</a></li>
                        <li><a href="./cart.html">��ٱ���</a></li>
                        <li><a href="./checkout.jsp">�����ϱ�</a></li>
                        <li><a href="./Exchange.jsp">ȯ���ϱ�</a></li>
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
						<li><a href="./man_index.jsp">����</a>
						<li><a href="./woman_index.jsp">����</a>
						<li><a href="./Event.jsp">Event</a></li>
						<li><a href="./product_register.jsp">�Ǹ�</a></li>
						<li><a href="./showreviews.jsp">Review</a></li>
						<li><a href="./OfflineShop.jsp">�������μ�</a></li>
						
						<li><a href="./product.jsp">BRAND</a></li>
					</ul>
				</nav>
			</div>
		</section>
		<section class="header_text sub">
			<img class="pageBanner" src="themes/images/Lux_logo.png" alt="�� ��ǰ">
			<h4>
				<span>���̵�/��й�ȣ ã��</span>
			</h4>
		</section>
		<section class="main-content">
			<div class="row">
				<div class="span12 center">
					<h4 class="title">
						<span class="text"><strong>���̵�/��й�ȣ ã��</strong></span>
					</h4>
					<form action="/myapp/shopper/find-account" method="post">
						<fieldset>
							<div class="control-group">
								<label class="control-label">�̸��� �ּ�</label>
								<div class="controls">
									<input type="email" placeholder="���� �� ����� �̸��� �ּҸ� �Է��ϼ���"
										class="input-xlarge" name="email" required>
								</div>
							</div>
							<div class="action">
								<button type="submit" name="action" value="findId"
									class="btn btn-inverse large">���̵� ã��</button>
								<button type="submit" name="action" value="resetPassword"
									class="btn btn-inverse large">��й�ȣ ã��</button>
							</div>
						</fieldset>
					</form>

				</div>
			</div>
		</section>
		<section id="footer-bar">
			<div class="row">
				<div class="span3">
					<h4>������̼�</h4>
					<ul class="nav">
						<li><a href="./index.html">Ȩ������</a></li>
						<li><a href="./about.html">������</a></li>
						<li><a href="./contact.html">����ó</a></li>
						<li><a href="./cart.html">��ٱ���</a></li>
						<li><a href="./register.html">�α���</a></li>
					</ul>
				</div>
				<div class="span4">
					<h4>�� ����</h4>
					<ul class="nav">
						<li><a href="#">�� ����</a></li>
						<li><a href="#">�ֹ� ����</a></li>
						<li><a href="#">���ø���Ʈ</a></li>
						<li><a href="#">��������</a></li>
					</ul>
				</div>
				<div class="span5">
					<p class="logo">
						<img src="themes/images/logo.png" class="site_logo" alt="">
					</p>
					<p>�η� �Լ��� �ܼ��� �μ� �� ���� ����� ���� �ؽ�Ʈ�Դϴ�. �η� �Լ��� ������ ǥ�� ���� �ؽ�Ʈ�����ϴ�.</p>
					<br /> <span class="social_icons"> <a class="facebook"
						href="#">���̽���</a> <a class="twitter" href="#">Ʈ����</a> <a
						class="skype" href="#">��ī����</a> <a class="vimeo" href="#">��޿�</a>
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
