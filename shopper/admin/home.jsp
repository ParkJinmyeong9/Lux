<%@page import="shopper.admin.ReviewBean"%>
<%@page import="shopper.admin.ReviewMgr"%>
<%@page import="shopper.admin.UserBean"%>
<%@page import="java.util.Vector"%>
<%@page import="shopper.admin.UserMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">LUX Administrator Menu</h1>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="#">Home</a></li>
						<li class="breadcrumb-item active">Main Page</li>
					</ol>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->
<%
	UserMgr userMgr = new UserMgr();
	Vector<UserBean> getUser = userMgr.getUser();
%>
	<!-- Main content -->
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col">
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">신규 가입 회원</h3>
							<div class="card-tools">
							<div style="text-align: right" class="local_desc02 local_desc">
   								총회원수 <%= userMgr.countUser() %>명 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp; 신규회원 <%= userMgr.countWeekUser() %>명 &emsp;&emsp;
    						</div>
								<div class="input-group input-group-sm" style="width: 350px;">
									<div class="input-group-append">
									</div>
								</div>
							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>이름</th>
                                        <th>아이디</th>
                                        <th>성별</th>
                                        <th>이메일</th>
                                        <th>전화번호</th>
                                        <th>가입일</th>
                                        <th>생일</th>
                                        <th>보유금액</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%  
                                	int user_repeat = 0;
                                	if (getUser.size() > 5)
                                		user_repeat = 5;
                                	else
                                		user_repeat = getUser.size();
	                                for (int i = 0; i < user_repeat; i++) {
	                        		UserBean user = getUser.get(i);
	                        	%>
                                    <!-- 각 사용자 행 시작 -->
                                    <tr>
                                        <td><%= user.getName() %></td>
                                        <td style="text-align: left"><%= user.getUsername() %></td>
                                        <td><%= user.getGender() %></td>
                                        <td style="text-align: left"><%= user.getEmail() %></td>
                                        <td><%= user.getPhone() %></td>
                                        <td><%= user.getCreated_at() %></td>
                                        <td><%= user.getBirthdate() %></td>
                                        <td><%= user.getBalance()  %></td>
                                    </tr>
                                    <!-- 각 사용자 행 끝 -->
                                    <%
                                    }
                                    %>
                                </tbody>
                        	</table>
						</div>
						<!-- /.card-body -->
						<div class="card-footer clearfix">
							<a href="userInfo.jsp">
								<button id="deleteButton" class="user_delete float-right btn-primary" type="button">회원 전체보기</button>
							</a>
						</div>
					</div>
					<!-- /신규 회원  -->
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">최근 작성된 리뷰</h3>
							<div class="card-tools">
								<div class="input-group input-group-sm" style="width: 350px;">
									<div class="input-group-append">
									</div>
								</div>
							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th>리뷰번호</th>
										<th>상품명</th>
										<th>작성자</th>
										<th>평점</th>
										<th>리뷰내용</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>
									<%
                                    	ReviewMgr reviewMgr = new ReviewMgr();
                                    	Vector<ReviewBean> getReview = reviewMgr.getReview();
                                    	
                                    	int review_repeat = 0;
                                    	if (getReview.size() > 5)
                                    		review_repeat = 5;
                                    	else
                                    		review_repeat = getReview.size();
                                    	for (int i = 0; i < review_repeat; i++) {
                                    		ReviewBean review = getReview.get(i);
                                    %>
									<tr>
											<td><%=review.getReviewID()%></td>
										<td style="text-align: left"><%=review.getName()%></td>
										<td style="text-align: left"><%=review.getUserName()%></td>
										<td><%=review.getRating()%></td>
										<td style="text-align: left"><a href="../showreviews.jsp"><%=review.getContent()%></a></td>
										<td><%=review.getCreatedAt()%></td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
						</div>
						<!-- /.card-body -->
						<div class="card-footer clearfix">
							<a href="reviewInfo.jsp">
								<button id="deleteButton" class="user_delete float-right btn-primary" type="button">리뷰 더보기</button>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<%@ include file="footer.jsp"%>
