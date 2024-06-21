<%@page import="shopper.admin.UserBean"%>
<%@page import="java.util.Vector"%>
<%@page import="shopper.admin.UserMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">User Infomation</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">회원관리</a></li>
                        <li class="breadcrumb-item active">회원정보</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <% 
	
   		String searchKeyword = request.getParameter("table_search");
    
		// 페이지 번호를 가져옵니다.
		int pageNo = request.getParameter("pageNo") != null ? Integer.parseInt(request.getParameter("pageNo")) : 1;
		// 한 페이지에 보여줄 사용자 수
		int pageSize = 10;
    
		UserMgr userMgr = new UserMgr();
    
		Vector<UserBean> userList = userMgr.getUser();
		
		// 검색어가 있는 경우에는 검색 결과를 필터링하여 가져옵니다.
		if (searchKeyword != null && !searchKeyword.isEmpty()) {
		    // 검색 결과를 포함하는 상품들만을 필터링하여 새로운 목록에 저장합니다.
		    Vector<UserBean> filteredList = new Vector<>();
		    for (UserBean user : userList) {
		        // 상품명이나 다른 필드에서 검색어를 포함하는 상품만을 필터링하여 추가합니다.
		        if (user.getUsername().toLowerCase().contains(searchKeyword.toLowerCase())) {
		            filteredList.add(user);
		        }
		    }
		    userList = filteredList;
		}             
		
		// 전체 사용자 수
		int totalUsers = userList.size();
		// 전체 페이지 수
		int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
		
		// 현재 페이지에 해당하는 사용자들을 계산합니다.
		int startIdx = (pageNo - 1) * pageSize;
		int endIdx = Math.min(startIdx + pageSize, totalUsers);
		
		// 현재 페이지에 해당하는 상품들만 출력합니다.
		for (int i = startIdx; i < endIdx; i++) {
			UserBean user = userList.get(i);
		    // 상품 정보를 표시합니다.
		}
	%>		    
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">회원정보</h3>
                            <div class="card-tools">
                                <form action="userInfo.jsp" method="GET"> <!-- form 추가 -->
                                    <div class="input-group input-group-sm" style="width: 350px;">
                                        <input type="text" name="table_search" class="form-control float-right" placeholder="Search">

                                        <div class="input-group-append">
                                            <button type="submit" class="btn btn-default">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form> <!-- form 추가 -->
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th style="width: 10px"><input type="checkbox" id="checkbox_test" name="checkbox_test" /></th>
                                        <th>유저번호</th>
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
                                    // 현재 페이지에 해당하는 사용자들만 출력합니다.
                                    for (int i = startIdx; i < endIdx; i++) {
                                        UserBean user = userList.get(i);
                                    %>
                                    <!-- 각 사용자 행 시작 -->
                                    <tr>
                                        <td style="width: 10px"><input type="checkbox" class="row_checkbox" /></td>
                                        <td><%= user.getUserID() %></td>
                                        <td><%= user.getName() %></td>
                                        <td style="text-align: left"><%= user.getUsername() %></td>
                                        <td><%= user.getGender() %></td>
                                        <td style="text-align: left"><%= user.getEmail() %></td>
                                        <td><%= user.getPhone() %></td>
                                        <td><%= user.getCreated_at() %></td>
                                        <td><%= user.getBirthdate() %></td>
                                        <td><%= user.getBalance() %></td>
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
                            <!-- 페이징 링크 출력 -->
                            <ul class="pagination pagination-sm m-0 float-right">
    							<!-- 이전 페이지 링크 -->
							    <li class="page-item <%= pageNo == 1 ? "disabled" : "" %>">
							        <a class="page-link" href="userInfo.jsp?pageNo=<%= pageNo - 1 %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>">&laquo;</a>
							    </li>
							    <!-- 페이지 번호 링크 -->
							    <% for (int i = 1; i <= totalPages; i++) { %>
							        <li class="page-item <%= i == pageNo ? "active" : "" %>">
							            <a class="page-link" href="userInfo.jsp?pageNo=<%= i %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>"><%= i %></a>
							        </li>
							    <% } %>
							    <!-- 다음 페이지 링크 -->
							    <li class="page-item <%= pageNo == totalPages ? "disabled" : "" %>">
							        <a class="page-link" href="userInfo.jsp?pageNo=<%= pageNo + 1 %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>">&raquo;</a>
							    </li>
							</ul>
                            <button id = "deleteButton" class="user_update float-left btn-primary" type="button">선택삭제</button>
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
	                var userId = row.cells[1].innerText.trim(); 
	                selectedRows.push(userId);
	            });

	            // AJAX 호출로 Java 서버에 데이터 전송
	            var xhr = new XMLHttpRequest();
	            xhr.open("POST", "DeleteUserServlet", true);
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
