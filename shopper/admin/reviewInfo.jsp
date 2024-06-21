<!--  reviewInfo.jsp -->
<%@page import="shopper.admin.UserBean"%>
<%@page import="shopper.admin.ProductBean"%>
<%@page import="shopper.admin.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page import="shopper.admin.ReviewMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6">
					<h1 class="m-0">Review Infomation</h1>
				</div>
				<!-- /.col -->
				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right">
						<li class="breadcrumb-item"><a href="reviewInfo.jsp">리뷰관리</a></li>
						<li class="breadcrumb-item active">리뷰정보</li>
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
		// 검색어를 가져옵니다.
		String searchKeyword = request.getParameter("table_search");
		
		// 페이지 번호를 파라미터로 받아옵니다.
		int pageNo = request.getParameter("pageNo") != null ? Integer.parseInt(request.getParameter("pageNo")) : 1;
		
		// 한 페이지에 보여줄 상품의 수
		int pageSize = 10;
		
		// 상품 관리자 객체 생성
		ReviewMgr reviewMgr = new ReviewMgr();
		
		// 전체 상품 목록을 가져옵니다.
		Vector<ReviewBean> getReview = reviewMgr.getReview();
		
		// 전체 상품 개수를 가져옵니다.
		int totalReviews = getReview.size();
		
		// 전체 페이지 수를 계산합니다.
		int totalPages = (int) Math.ceil((double) totalReviews / pageSize);
		
		// 현재 페이지에 해당하는 상품들을 계산합니다.
		int startIdx = (pageNo - 1) * pageSize;
		int endIdx = Math.min(startIdx + pageSize, totalReviews);
		
		// 현재 페이지에 해당하는 상품들만 출력합니다.
		for (int i = startIdx; i < endIdx; i++) {
			ReviewBean review = getReview.get(i);
		    // 상품 정보를 표시합니다.
		}
	%>
	<!-- Main content -->	
	<section class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col">
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">리뷰 목록</h3>
							<div class="card-tools">
								<div class="input-group input-group-sm" style="width: 350px;">
									<input type="text" name="table_search"
										class="form-control float-right" placeholder="Search">

									<div class="input-group-append">
										<button type="submit" class="btn btn-default">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
							</div>
						</div>
						<!-- /.card-header -->
						<div class="card-body">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th style="width: 10px"><input type="checkbox" id="checkbox_test" name="checkbox_test" /></th>
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
									for (int i = startIdx; i < endIdx; i++) {
							            ReviewBean review = getReview.get(i);
									%>
									<tr>
										<td style="width: 10px"><input type="checkbox"
											id="checkbox_test" name="checkbox_test" class="row_checkbox"/></td>
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
							<ul class="pagination pagination-sm m-0 float-right">
								<!-- 이전 페이지 링크 -->
							    <li class="page-item <%= pageNo == 1 ? "disabled" : "" %>">
							        <a class="page-link" href="reviewInfo.jsp?pageNo=<%= pageNo - 1 %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>">&laquo;</a>
							    </li>
							    <!-- 페이지 번호 링크 -->
							    <% for (int i = 1; i <= totalPages; i++) { %>
							        <li class="page-item <%= i == pageNo ? "active" : "" %>">
							            <a class="page-link" href="reviewInfo.jsp?pageNo=<%= i %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>"><%= i %></a>
							        </li>
							    <% } %>
							    <!-- 다음 페이지 링크 -->
							    <li class="page-item <%= pageNo == totalPages ? "disabled" : "" %>">
							        <a class="page-link" href="reviewInfo.jsp?pageNo=<%= pageNo + 1 %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>">&raquo;</a>
							    </li>
							</ul>
							<button id="deleteButton" class="user_delete float-left btn-primary" type="button">선택삭제</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<script>

document.getElementById("deleteButton").addEventListener(
	    "click",
	    function() {
	        // 경고창 표시
	        var confirmDelete = confirm("정말 삭제하시겠습니까?");
	        if (confirmDelete) {
	            // 선택된 행의 삭제를 실행하는 코드
	            var selectedRows = [];
	            var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
	            checkboxes.forEach(function(checkbox) {
	                var row = checkbox.closest("tr");
	                var reviewId = row.cells[1].innerText.trim(); 
	                selectedRows.push(reviewId);
	            });

	            // AJAX 호출로 Java 서버에 데이터 전송
	            var xhr = new XMLHttpRequest();
	            xhr.open("POST", "DeleteReviewServlet", true);
	            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	            xhr.onreadystatechange = function() {
	                if (xhr.readyState === XMLHttpRequest.DONE) {
	                    if (xhr.status === 200) {
	                    	alert(xhr.responseText);
	                        // 삭제가 성공적으로 처리되었을 때 추가로 실행할 코드 작성 가능
	                    	location.href = location.href;
	                    } else {
	                        alert('서버 오류');
	                    }
	                }
	            };
	            xhr.send(JSON.stringify(selectedRows));
	        } else {
	            alert("취소하였습니다");
	        }
	    }
	);
</script>
<%@ include file="footer.jsp"%>