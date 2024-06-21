<!-- productsList.jsp -->
<%@page import="shopper.admin.UserBean"%>
<%@page import="shopper.admin.ProductBean"%>
<%@page import="shopper.admin.ProductMgr"%>
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
                        <li class="breadcrumb-item"><a href="saleInfo.jsp">쇼핑몰관리</a></li>
                        <li class="breadcrumb-item active">상품관리</li>
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
    <h2>
        상품관리 페이지 <br> <br>
    </h2>
	<%
		// 검색어를 가져옵니다.
		String searchKeyword = request.getParameter("table_search");
		
		// 페이지 번호를 파라미터로 받아옵니다.
		int pageNo = request.getParameter("pageNo") != null ? Integer.parseInt(request.getParameter("pageNo")) : 1;
		
		// 한 페이지에 보여줄 상품의 수
		int pageSize = 10;
		
		// 상품 관리자 객체 생성
		ProductMgr productMgr = new ProductMgr();
		
		// 전체 상품 목록을 가져옵니다.
		Vector<ProductBean> productList = productMgr.productList();
		
		// 검색어가 있는 경우에는 검색 결과를 필터링하여 가져옵니다.
		if (searchKeyword != null && !searchKeyword.isEmpty()) {
		    // 검색 결과를 포함하는 상품들만을 필터링하여 새로운 목록에 저장합니다.
		    Vector<ProductBean> filteredList = new Vector<>();
		    for (ProductBean product : productList) {
		        // 상품명이나 다른 필드에서 검색어를 포함하는 상품만을 필터링하여 추가합니다.
		        if (product.getName().toLowerCase().contains(searchKeyword.toLowerCase())) {
		            filteredList.add(product);
		        }
		    }
		    productList = filteredList;
		}
		
		// 전체 상품 개수를 가져옵니다.
		int totalProducts = productList.size();
		
		// 전체 페이지 수를 계산합니다.
		int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
		
		// 현재 페이지에 해당하는 상품들을 계산합니다.
		int startIdx = (pageNo - 1) * pageSize;
		int endIdx = Math.min(startIdx + pageSize, totalProducts);
		
		// 현재 페이지에 해당하는 상품들만 출력합니다.
		for (int i = startIdx; i < endIdx; i++) {
		    ProductBean product = productList.get(i);
		    // 상품 정보를 표시합니다.
		}
	%>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">상품 목록</h3>
                            <div class="card-tools">
                               <form action="productsList.jsp" method="GET"> <!-- form 추가 -->
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
							            <th rowspan="3" style="width: 10px" class="align-middle"><input type="checkbox" id="checkbox_test" name="checkbox_test" /></th>
							            <th rowspan="3" class="align-middle" >상품번호</th>
							            <th rowspan="3" class="align-middle" >상품이미지</th>
							            <th rowspan="2" class="align-middle" >상품명</th>
							            <th rowspan="3" class="align-middle" >모델번호</th>
							            <th rowspan="3" class="align-middle" >브랜드</th>
							            <th class="align-middle" >시작가격</th>
							            <th rowspan="3" class="align-middle" >상태</th>
							            <th rowspan="3" class="align-middle" >경매시작</th>
							            <th rowspan="3" class="align-middle" >경매종료</th>
							            <th rowspan="3" class="align-middle">관리</th>
							        </tr>
							        <tr>
							            <th class="align-middle" >즉시구매가</th>
							        </tr>
							        <tr>
							            <th class="align-middle" >판매자</th>
							            <th class="align-middle" >현재경매가</th>
							        </tr>
							    </thead>
                                 <tbody>
							        <%
							        // 현재 페이지에 해당하는 상품들만 출력합니다.
							        for (int i = startIdx; i < endIdx; i++) {
							            ProductBean product = productList.get(i);
							        %>
							        <!-- 각 상품 행 시작 -->
							        <tr>
							            <!-- 체크박스 열 추가 -->
							            <td rowspan="3" class="align-middle"><input type="checkbox" class="row_checkbox" /></td>
							            <!-- 상품번호 열 추가 -->
							            <td rowspan="3" class="align-middle" style="width:40px;"><%= product.getProductID() %></td>
							            <!-- 상품이미지 열 추가 -->
							            <td rowspan="3" class="align-middle"><img src="../<%= product.getPhoto() %>" alt="상품 이미지" width="150px" height="150px"></td>
							            <!-- 상품명 열 추가 -->
										<td rowspan="2" class="align-middle" style="text-align: left; white-space: pre-wrap; word-break: break-all; width: 500px;"><%= product.getName() %></td>
										<td rowspan="3" class="align-middle"><%= product.getModelNumber() %></td>
										<td rowspan="3" class="align-middle"><%= product.getBrand() %></td>
							            <!-- 시작가격 열 추가 -->
							            <td class="align-middle"><%= product.getStartPrice() %></td>
							            <!-- 상태 열 추가 -->
							            <td rowspan="3" class="align-middle">
							                <select name="status">
							                    <option value="경매중" <%= product.getStatus().equals("경매중") ? "selected" : "" %>>경매중</option>
							                    <option value="검수중" <%= product.getStatus().equals("검수중") ? "selected" : "" %>>검수중</option>
							                    <option value="낙찰" <%= product.getStatus().equals("낙찰") ? "selected" : "" %>>낙찰</option>
							                    <option value="배송준비중" <%= product.getStatus().equals("배송준비중") ? "selected" : "" %>>배송준비중</option>
							                </select>
							            </td>
							            <!-- 경매시작 열 추가 -->
							            <td rowspan="3" class="align-middle"><%= product.getStartTime() %></td>
							            <!-- 경매종료 열 추가 -->
							            <td rowspan="3" class="align-middle"><%= product.getEndTime() %></td>
							            <!-- 관리 열 추가 -->
							            <td rowspan="3" class="align-middle"style="width:120px"><button id="table_update" class="table_update btn-primary" type="button">정보수정</button></td>
							        </tr>
							        <!-- 추가 정보 행 추가 -->
							        <tr>
							            <!-- 즉시구매가 열 추가 -->
							            <td class="align-middle"><%= product.getBuyNowPrice() %></td>
							        </tr>
							        <!-- 상태, 경매시작, 경매종료 열 추가 -->
							        <tr>
							            <!-- 판매자 열 추가 -->
							            <td style="text-align: left" class="align-middle"><%= product.getUsername() %></td>
							            <!-- 현재경매가 열 추가 -->
							            <td class="align-middle"><%= product.getCurrentBid() %></td>
							        </tr>
							        <!-- 각 상품 행 끝 -->
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
							        <a class="page-link" href="productsList.jsp?pageNo=<%= pageNo - 1 %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>">&laquo;</a>
							    </li>
							    <!-- 페이지 번호 링크 -->
							    <% for (int i = 1; i <= totalPages; i++) { %>
							        <li class="page-item <%= i == pageNo ? "active" : "" %>">
							            <a class="page-link" href="productsList.jsp?pageNo=<%= i %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>"><%= i %></a>
							        </li>
							    <% } %>
							    <!-- 다음 페이지 링크 -->
							    <li class="page-item <%= pageNo == totalPages ? "disabled" : "" %>">
							        <a class="page-link" href="productsList.jsp?pageNo=<%= pageNo + 1 %><%= searchKeyword != null ? "&table_search=" + searchKeyword : "" %>">&raquo;</a>
							    </li>
							</ul>
                            <button id="deleteButton" class="user_delete float-left btn-primary" type="button">선택삭제</button>
                            <button id="updateButton" class="user_update float-left btn-primary" type="button">선택수정</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    $(document).on('click', '.table_update', function () {
        // 해당 행을 가져옵니다.
        var row = $(this).closest("tr");

        // 각 셀의 데이터를 가져옵니다.
        var Name = row.find('td:eq(3)').text().trim();
        var modelNumber = row.find('td:eq(4)').text().trim();
        var brand = row.find('td:eq(5)').text().trim();
        var startPrice = row.find('td:eq(6)').text().trim();
        var status = row.find('td:eq(7) select').val();
        var startTime = row.find('td:eq(8)').text().trim();
        var endTime = row.find('td:eq(9)').text().trim();

        // 다음 두 행의 데이터도 가져옵니다.
        var buyNowPrice = row.next().find('td:eq(0)').text().trim();
        var currentBid = row.next().next().find('td:eq(1)').text().trim();

        // 선택된 행들의 데이터를 수정 가능한 input 폼으로 변경합니다.
        row.find('td:eq(3)').html('<input type="text" class="form-control" value="' + Name + '">');
        row.find('td:eq(4)').html('<input type="text" class="form-control" value="' + modelNumber + '">');
        row.find('td:eq(5)').html('<select class="form-control">' +
            '<option value="Louis Vuitton"' + (brand === "Louis Vuitton" ? "selected" : "") + '>Louis Vuitton</option>' +
            '<option value="Chanel"' + (brand === "Chanel" ? "selected" : "") + '>Chanel</option>' +
            '<option value="Gucci"' + (brand === "Gucci" ? "selected" : "") + '>Gucci</option>' +
            '<option value="Hermes"' + (brand === "Hermes" ? "selected" : "") + '>Hermes</option>' +
            '<option value="Cartier"' + (brand === "Cartier" ? "selected" : "") + '>Cartier</option>' +
            '<option value="Rolex"' + (brand === "Rolex" ? "selected" : "") + '>Rolex</option>' +
            '<option value="Dior"' + (brand === "Dior" ? "selected" : "") + '>Dior</option>' +
            '<option value="Tiffany"' + (brand === "Tiffany" ? "selected" : "") + '>Tiffany</option>' +
            '<option value="Burberry"' + (brand === "Burberry" ? "selected" : "") + '>Burberry</option>' +
            '<option value="Prada"' + (brand === "Prada" ? "selected" : "") + '>Prada</option>' +
            '<option value="Others"' + (brand === "Others" ? "selected" : "") + '>Others</option>' +
            '</select>');

        row.find('td:eq(6)').html('<input type="text" class="form-control" value="' + startPrice + '">');
        row.find('td:eq(7)').html('<select class="form-control"><option value="경매중" '
            + (status === "경매중" ? "selected" : "") + '>경매중</option><option value="검수중" '
            + (status === "검수중" ? "selected" : "") + '>검수중</option><option value="낙찰" '
            + (status === "낙찰" ? "selected" : "") + '>낙찰</option><option value="배송준비중" '
        	+ (status === "배송준비중" ? "selected" : "") + '>배송준비중</option></select>');
        row.find('td:eq(8)').html('<input type="text" class="form-control" value="' + startTime + '">');
        row.find('td:eq(9)').html('<input type="text" class="form-control" value="' + endTime + '">');

        // 다음 두 행의 데이터도 수정 가능한 input 폼으로 변경합니다.
        row.next().find('td:eq(0)').html('<input type="text" class="form-control" value="' + buyNowPrice + '">');
        row.next().next().find('td:eq(1)').html('<input type="text" class="form-control" value="' + currentBid + '">');

        // "table_update" 버튼을 "수정 완료" 버튼으로 변경합니다.
        $(this).text('수정 완료').removeClass('table_update').addClass('table_update_complete');
    });

    $(document).on('click', '.table_update_complete', function () {

    	// 해당 버튼이 속한 행을 가져옵니다.
        var row = $(this).closest("tr");
		
        var productID = row.find('td:eq(1)').text().trim();
        // 수정된 데이터를 가져옵니다.
        var editedName = row.find('td:eq(3) input').val();
        var editedModelNumber = row.find('td:eq(4) input').val();
        var editedBrand = row.find('td:eq(5) select').val();
        var editedStartPrice = row.find('td:eq(6) input').val();
        var editedStatus = row.find('td:eq(7) select').val();
        var editedStartTime = row.find('td:eq(8) input').val();
        var editedEndTime = row.find('td:eq(9) input').val();
        var editedBuyNowPrice = row.next().find('td:eq(0) input').val();
        var editedCurrentBid = row.next().next().find('td:eq(1) input').val();
	
        var confirmation = confirm("수정한 내용을 저장하시겠습니까?");
        if (confirmation) {
            $.ajax({
                url: 'UpdateProductsServlet2', // 서버 측 URL
                type: 'POST', // HTTP 메소드
                data: {
                    Name: editedName,
                    modelNumber: editedModelNumber,
                    brand: editedBrand,
                    startPrice: editedStartPrice,
                    status: editedStatus,
                    startTime: editedStartTime,
                    endTime: editedEndTime,
                    buyNowPrice: editedBuyNowPrice,
                    currentBid: editedCurrentBid,
                    productID: productID // 해당 제품의 고유 ID
                },
                success: function (response) {
                    // 성공적으로 서버로부터 응답을 받았을 때 처리
                    alert(response);
                    // 페이지 새로 고침
                    location.href = location.href;
                },
                error: function (xhr, status, error) {
                    // 서버로의 요청이 실패했을 때 처리
                    console.error('데이터 업데이트 실패:', error);
                }
            });
        } else {
        	location.href = location.href;
        }
    });
});

$(document).ready(function () {
    // 일정 시간마다 AJAX 요청을 보내도록 설정
    setInterval(function () {
        $.ajax({
            url: "StatusUpdateServlet",
            type: "GET",
            success: function (data) {
                console.log("서블릿 실행 완료");
                // 여기서 서블릿이 반환한 데이터를 사용하여 페이지 업데이트를 수행할 수 있음
            },
            error: function () {
                console.log("서블릿 실행 실패");
            }
        });
    }, 5000); // 5초마다 서블릿 실행 요청을 보냄
});


$(document).ready(function () {
    // 검색 버튼 클릭 시 URL을 수정하여 페이지를 다시 로드합니다.
    $('.btn-default').click(function () {
        var searchText = $('input[name="table_search"]').val(); // 검색어를 가져옵니다.
        var url = window.location.href.split('?')[0]; // 현재 페이지 URL에서 쿼리 파라미터를 제외한 부분을 가져옵니다.
        window.location.href = url + '?pageNo=1&table_search=' + searchText; // 검색어와 함께 첫 페이지로 이동합니다.
    });

    // 페이지가 로드될 때 URL에서 검색어를 가져와서 필터링합니다.
    var searchTextFromUrl = getUrlParameter('table_search');
    if (searchTextFromUrl) {
        $('input[name="table_search"]').val(searchTextFromUrl); // 검색어 입력 필드에 검색어를 설정합니다.
        filterTable(searchTextFromUrl); // 검색어를 기반으로 테이블을 필터링합니다.
    }

    // URL에서 특정 쿼리 파라미터의 값을 가져오는 함수
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    // 테이블을 필터링하는 함수
    function filterTable(searchText) {
        // 모든 행을 숨깁니다.
        $('tbody tr').hide();

        // 각 상품명을 검색어와 비교하여 필터링합니다.
        $('tbody tr').each(function () {
            var productName = $(this).find('td:eq(3)').text().toLowerCase(); // 상품명 열의 텍스트를 소문자로 변환합니다.
            if (productName.includes(searchText)) { // 검색어가 상품명에 포함되어 있는지 확인합니다.
                // 상품명이 포함된 행을 표시합니다.
                $(this).show();

                // 해당 상품 번호를 가져옵니다.
                var productID = $(this).find('td:eq(1)').text().trim();

                // 해당 상품 번호와 같은 행들 중 추가 정보를 표시합니다.
                $('tbody tr').each(function () {
                    var currentProductID = $(this).find('td:eq(1)').text().trim();
                    if (currentProductID === productID) {
                        // rowspan이 3이므로 현재 행과 다음 2개의 행을 표시합니다.
                        $(this).next().show();
                        $(this).next().next().show();
                    }
                });
            }
        });
    }
});

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
                var productID = row.cells[1].innerText.trim(); // 상품번호를 가져올 때 공백을 제거하여야 함
                selectedRows.push(productID);
            });

            // AJAX 호출로 Java 서버에 데이터 전송
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "DeleteProductsServlet", true);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                    	alert(xhr.responseText);
                        // 삭제가 성공적으로 처리되었을 때 추가로 실행할 코드 작성 가능
                    	location.href = location.href;
                    } else {
                        alert('서버 오류');
                        console.log(productID);
                        alert(productID);
                    }
                }
            };
            xhr.send(JSON.stringify(selectedRows));
        } else {
            alert("취소하였습니다");
        }
    }
);

document.getElementById("updateButton").addEventListener(
    "click",
    function() {
        var selectedRows = [];
        var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        checkboxes.forEach(function(checkbox) {
            var row = checkbox.closest("tr");
            var statusSelect = row.querySelector("select[name='status']");
            var productID = row.cells[1].innerText.trim(); // 상품번호를 가져올 때 공백을 제거하여야 함
            if (statusSelect) {
                var rowData = {
                    productID: productID,
                    status: statusSelect.value
                };
                selectedRows.push(rowData);
            }
        });

        // 값이 제대로 수집되었는지 확인하는 alert 추가
        var message = "선택된 행의 데이터:\n";
        selectedRows.forEach(function(rowData) {
            message += "상품번호: " + rowData.productID + ", 상태: " + rowData.status + "\n";
        });
        alert(message);

        // AJAX 호출로 Java 서버에 데이터 전송
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "UpdateProductsServlet", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    alert(xhr.responseText);
                    // 성공적으로 처리되었을 때 추가로 실행할 코드 작성 가능
                    location.href = location.href;
                } else {
                    alert('서버 오류');
                }
            }
        };
        xhr.send(JSON.stringify(selectedRows));
    }
);
</script>
<script>
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

<%@ include file="footer.jsp"%>
