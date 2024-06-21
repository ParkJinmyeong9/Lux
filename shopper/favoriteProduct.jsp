<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shopper.User"%>
<%@page import="shopper.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="shopper.ProductMgr"%>
<%@ page import="java.sql.*"%>
<%@ page import="shopper.DBConnectionMgr"%>
<%@ page import="java.sql.SQLException"%>
<%
    // 사용자 ID 세션에서 가져오기
   User loggedInUser = (User) session.getAttribute("user");
    int userID = loggedInUser.getUserID();
    JSONArray jsonArray = new JSONArray();
    // DB 연결 및 쿼리 실행
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    ArrayList<String> bidData = new ArrayList<String>();

    String favIDStr = request.getParameter("favoriteID");
    if (favIDStr != null && !favIDStr.trim().isEmpty()) {
        int favoriteID = Integer.parseInt(favIDStr); // 여기에서만 favoriteID를 선언

        try {
            conn = DBConnectionMgr.getInstance().getConnection();
            String sql = "DELETE FROM favoriteproducts WHERE FavoriteID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, favoriteID);

            // 쿼리 실행
            int result = pstmt.executeUpdate();

            if(result > 0) {
                // 성공적으로 삭제됐을 때의 처리
                out.print("success");
            } else {
                // 삭제 실패
                out.print("fail");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("error");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    try {
        conn = DBConnectionMgr.getInstance().getConnection();
        String sql = "SELECT fp.FavoriteID, p.Name, p.StartPrice, p.BuyNowPrice, p.CurrentBid " +
                     "FROM favoriteproducts fp JOIN products p ON fp.ProductID = p.ProductID " +
                     "WHERE fp.UserID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userID);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("favoriteID", rs.getInt("FavoriteID")); // 'number' 대신 'favoriteID'로 키 변경
            obj.put("product", rs.getString("Name"));
            obj.put("startPrice", rs.getInt("StartPrice") + "원");
            obj.put("buyNowPrice", rs.getInt("BuyNowPrice") + "원");
            obj.put("currentBid", rs.getInt("CurrentBid") + "원");
            jsonArray.put(obj);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LUX Auction</title>
    <!-- 부트스트랩 링크 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome 아이콘 링크 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <!-- CSS 스타일 -->
    <style>
        /* 여기에 추가적인 CSS 스타일링이 가능합니다 */
        .navbar-brand {
            padding: 0;
        }
        .navbar-nav .nav-link {
            color: #555;
        }
        .profile-section {
            text-align: center;
            margin-top: 40px;
        }
        .profile-info {
            text-align: left;
            margin-top: 20px;
        }
        .profile-info p {
            margin: 5px 0;
        }
        .profile-info .icon-text {
            margin-right: 5px;
        }
        .content-box {
            border: 1px solid #ccc;
            padding: 20px;
            margin-top: 40px;
        }
        /* 추가된 스타일 */
        .section-icon {
            float: right;
            margin-left: 10px;
        }

        /* 중간 크기 화면에서 섹션들을 한 줄에 하나씩 표시 */
        @media (max-width: 992px) {
            .col-sm-4 {
                margin-bottom: 20px;
            }
        }

        /* 테이블 반응형 스타일 */
        @media (max-width: 768px) {
            table {
                width: 100%;
            }
            table thead {
                display: none;
            }
            table tbody tr {
                display: block;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                padding: 10px;
            }
            table tbody td {
                display: block;
                text-align: left;
                font-weight: bold;
            }
        }

        /* 테이블과 테이블 셀 내용 중앙 정렬 */
        .table {
            text-align: center;
        }

        .table th,
        .table td {
            vertical-align: middle;
        }

        /* 이전 다음 키 정렬 */
        .pagination {
            justify-content: center;
        }
        
         /* 링크 색상 변경 */
        #bidListLink,
        #failedBidListLink,
        #bidOrderListLink,
        #outstandingListLink,
        #bidRegistLink,
        #favoriteProductLink,
        #orderListLink,
        #outstanding2Link,
        #profileUpdateLink,
        #profileDeleteLink {
            color: #000; /* 검정색으로 변경 */
        }
        
        #editAddressLink,
        #pointUpdateLink {
         	color: #808080;
        }

        /* 추가된 스타일 */
        /* 새로운 배송지 입력칸 보이기/숨기기 */
        .new-address-input {
            display: block;
        }
    </style>
</head>
<body>
     <!-- 네비게이션 바 -->
   <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <!-- ... 기타 네비게이션 바 내용 ... -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <!-- 기타 메뉴 아이템들 -->
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">메인화면</a>
                </li>
                <!-- 로그인한 사용자 정보 표시 -->
                <%
                if (loggedInUser != null) {
                %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <%= loggedInUser.getName() %>님 <!-- 사용자 이름 표시 -->
                        </a>
                        <div class="dropdown-menu" aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="./products.jsp">마이페이지</a>
                            <a class="dropdown-item" href="./cart.html">장바구니</a>
                            <a class="dropdown-item" href="./checkout.jsp">결제하기</a>
                            <a class="dropdown-item" href="./Exchange.jsp">환전하기</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="logout.jsp">로그아웃</a>
                        </div>
                    </li>
                <%
                } else {
                %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">로그인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="register.html">회원가입</a>
                    </li>
                <%
                }
                %>
            </ul>
        </div>
    </div>
</nav>

    <!-- 프로필 및 정보 섹션 -->
    <div class="container profile-section">
        <!-- 마이페이지 프로필 아이콘 및 정보 -->
        <div class="row align-items-center">
            <!-- 프로필 사진 -->
            <div class="col-md-2">
                <img src="image 1.png" alt="Profile Image" style="width: 130px;">
            </div>
            <!-- 마이페이지 정보 -->
            <div class="col-md-10 profile-info">
                <!-- 마이페이지 글씨 -->
                <div class="row">
    <div class="col">
        <h4><%= loggedInUser.getName() %> 님의 마이페이지</h4>
    </div>
</div>

                <!-- 아이디 -->
                <div class="row">
                <div class="col">
                    <p><span class="icon-text"><i class="fas fa-user"></i></span>아이디: <span class="user-id"><%= loggedInUser.getUsername() %></span></p>
                </div>
            </div>
                <!-- 배송지 정보 -->
<div class="row">
    <div class="col">
        <p><span class="icon-text"><i class="fas fa-map-marker-alt"></i></span>배송지 정보: 
            <span id="currentAddress">
                <%= loggedInUser.getAddress() + " " + loggedInUser.getExtraAddress() + " " + loggedInUser.getDetailAddress() %>
            </span> 
            <a href="#" id="editAddressLink" data-toggle="modal" data-target="#editAddressModal">수정&gt;</a>
        </p>
    </div>
</div>

                <!-- 보유 포인트 -->
                 <div class="row">
                <div class="col">
                    <p><span class="icon-text"><i class="fas fa-coins"></i></span>보유 포인트: <span id="currentPoints"><%= loggedInUser.getBalance() %></span></p>
                </div>
            </div>
            </div>
        </div>
    </div>

   <!-- 배송지 정보 수정 팝업 -->
    <div class="modal fade" id="editAddressModal" tabindex="-1" role="dialog" aria-labelledby="editAddressModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAddressModalLabel">배송지 정보 수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- 배송지 정보 입력 폼 -->
                    <form id="editAddressForm">
                        <div class="form-group">
                            <label for="newAddress">새로운 배송지</label>
                            <!-- 새로운 배송지 입력란 -->
                            <input type="text" class="form-control" id="newAddress" placeholder="새로운 배송지 입력">
                            <!-- 상세 주소 입력란 -->
                            <input type="text" class="form-control mt-2 new-address-input" id="detailAddress" placeholder="상세 주소 입력" disabled>
                            <!-- 주소 검색 버튼 -->
                            <button type="button" class="btn btn-primary mt-3" id="searchAddressBtn">주소 검색</button>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <!-- 취소 버튼 -->
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <!-- 저장 버튼 -->
                    <button type="button" class="btn btn-primary" id="saveAddressBtn" disabled>저장</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 포인트 충전 팝업 -->
    <div class="modal fade" id="pointChargeModal" tabindex="-1" role="dialog" aria-labelledby="pointChargeModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="pointChargeModalLabel">포인트 충전</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- 포인트 충전 안내 -->
                    <p>포인트를 충전하시려면 아래 버튼을 클릭하세요.</p>
                    <p>포인트 충전 페이지로 이동합니다.</p>
                </div>
                <div class="modal-footer">
                    <!-- 취소 버튼 -->
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                    <!-- 포인트 충전 페이지로 이동하는 링크 -->
                    <a href="pointCharge.jsp" class="btn btn-primary">포인트 충전</a>
                </div>
            </div>
        </div>
    </div>
    
 <!-- 저장 팝업 -->
    <div class="modal fade" id="savedPopup" tabindex="-1" role="dialog" aria-labelledby="savedPopupLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="savedPopupLabel">저장 완료</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    배송지 정보가 성공적으로 저장되었습니다.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 공백 -->
    <div class="container" style="height: 40px;"></div>

    <!-- 내용 박스 -->
    <div class="container content-box">
        <div class="row">
            <!-- 경매 내역 -->
            <div class="col-sm-4">
                <h5>경매내역 <span class="section-icon"><img src="image 4.png" alt="Auction Icon"></span></h5>
                <!-- 입찰목록 클릭 시 bidList.jsp로 이동하는 코드 -->
                <ul>
                    <li><a href="#" id="bidListLink">입찰목록</a></li>
                    <li><a href="#" id="failedBidListLink">유찰목록</a></li>
                    <li><a href="#" id="bidRegistLink">경매등록</a></li>
                </ul>
            </div>
            <!-- 구매 내역 -->
            <div class="col-sm-4">
                <h5>구매내역 <span class="section-icon"><img src="image 5.png" alt="Purchase Icon"></span></h5>
                <ul>
                    <li><a href="#" id="favoriteProductLink">관심상품</a></li>
                    <li><a href="#" id="orderListLink">주문목록</a></li>
                    <li><a href="#" id="outstanding2Link">미결제목록</a></li>
                </ul>
            </div>
            <!-- 회원 정보 -->
            <div class="col-sm-4">
                <h5>회원정보 <span class="section-icon"><img src="image 6.png" alt="Member Icon"></span></h5>
                <ul>
                <li id="profileUpdateLi"><a href="./profileUpdate.jsp">개인정보수정</a></li>
<li id="profileDeleteLi"><a href="./profileDelete.jsp">회원탈퇴신청</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 유찰목록 테이블 -->
    <div class="container content-box">
        <h5>관심상품</h5>
        <table class="table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>상품 정보</th>
                    <th>시작 가격</th>
                    <th>즉시 구매 가격</th>
                    <th>현재 입찰가</th>
                    <th>삭제하기</th>
                </tr>
            </thead>
            <tbody id="bidListTableBody">
            <!-- Table rows will be dynamically added here -->
        </tbody>
    </table>
    <!-- Pagination links will be added here -->
    <div class="text-center">
        <ul class="pagination justify-content-center" id="pagination">
            <!-- Pagination links will be added here dynamically -->
        </ul>
    </div>
</div>

   <!-- JavaScript 코드 -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    var bidData = <%= new org.json.JSONArray(bidData).toString() %>;

        // 페이지가 로드될 때 실행
        $(document).ready(function() {
        	var bidData = <%= jsonArray.toString() %>;
            fillTableData();

         // JavaScript 수정 사항
            // JavaScript 수정 사항
function fillTableData() {
    var tableBody = $('#bidListTableBody');
    tableBody.empty(); // 테이블 초기화

    bidData.forEach(function(item) {
        // 로그를 사용하여 받은 데이터의 구조 확인 (디버깅 목적)
        console.log(item);

        var row = '<tr>' +
                  '<td>' + item.favoriteID + '</td>' +
                  '<td>' + item.product + '</td>' +
                  '<td>' + item.startPrice + '</td>' +
                  '<td>' + item.buyNowPrice + '</td>' +
                  '<td>' + item.currentBid + '</td>' +
                  '<td><button onclick="removeItem(' + item.favoriteID + ')">삭제</button></td>' +
                  '</tr>';
        tableBody.append(row);
    });
}



         // 수정된 removeItem 함수
            window.removeItem = function(favoriteID) {
                console.log("Attempting to remove item with ID:", favoriteID);
                
                // AJAX 호출로 서버에 삭제 요청
                $.ajax({
                    url: 'deleteFavoriteProduct.jsp',
                    type: 'POST',
                    data: { 'favoriteID': favoriteID },
                    success: function(response) {
                        response = response.trim();
                        if(response === 'success') {
                            alert('삭제되었습니다.');
                            // 삭제된 항목을 페이지에서 바로 제거
                            $('tr').filter(function() {
                                return $(this).find('td:first').text() == favoriteID;
                            }).remove();
                        } else {
                            alert('삭제에 실패했습니다: ' + response);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error:', xhr, status, error);
                        alert('삭제에 실패했습니다. 오류: ' + error);
                    }
                });
            };

        	
            // 배송지 정보 수정 링크 클릭 시 이벤트 처리
            $('#editAddressLink').on('click', function(event) {
                event.preventDefault();
                // 기존 배송지 정보를 가져와서 폼에 입력
                var currentAddress = $('#currentAddress').text().trim();
                $('#newAddress').val(currentAddress);
                // 새로운 배송지 입력칸 보이기
                $('#newAddress').show();
                // 상세 주소 입력란 비활성화
                $('#detailAddress').prop('disabled', true).val('');
                // 저장 버튼 비활성화
                $('#saveAddressBtn').prop('disabled', true);
            });

            // 배송지 정보 저장 버튼 클릭 시 이벤트 처리
            $('#saveAddressBtn').on('click', function() {
                // 수정된 배송지 정보 가져오기
                var newAddress = $('#newAddress').val();
                var detailAddress = $('#detailAddress').val();
                
                // 새로운 배송지 정보가 빈칸인지 확인
                if (newAddress.trim() === '' || detailAddress.trim() === '') {
                    alert('주소와 상세 주소를 모두 입력해주세요.'); // 빈칸이면 알림창 출력
                    return; // 함수 종료
                }

                // 여기서는 간단히 콘솔에 출력하여 확인
                console.log('새로운 배송지 정보:', newAddress);
                console.log('상세 주소:', detailAddress);

                // 새로운 배송지 정보를 화면에 업데이트
                $('#currentAddress').text(newAddress + ' ' + detailAddress);

                // 팝업 닫기
                $('#editAddressModal').modal('hide');
                
                // 저장되었다는 팝업 띄우기
                $('#savedPopup').modal('show');
            });

            // 주소 검색 버튼 클릭 시 다음 주소 검색 팝업 띄우기
            $('#searchAddressBtn').on('click', function() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        var fullAddress = data.address;
                        var extraAddress = '';

                        // 기본 주소와 나머지 주소 필드를 조합하여 하나의 주소로 구성
                        if (data.addressType === 'R') {
                            if (data.bname !== '') {
                                extraAddress += data.bname;
                            }
                            if (data.buildingName !== '') {
                                extraAddress += (extraAddress !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            fullAddress += (extraAddress !== '' ? ' (' + extraAddress + ')' : '');
                        }

                        // 검색된 주소 정보를 입력란에 넣기
                        $('#newAddress').val(fullAddress);
                        // 주소 검색 후 상세 주소 입력 가능하도록 활성화
                        $('#detailAddress').prop('disabled', false);
                        // 주소 검색 후 저장 버튼 활성화
                        $('#saveAddressBtn').prop('disabled', false);
                    }
                }).open();
            });

            // 새로운 배송지 주소 입력란의 값이 바뀔 때 상세 주소 입력란 활성/비활성화
            $('#newAddress').on('input', function() {
                var newAddressVal = $(this).val().trim();
                if (newAddressVal === '') {
                    $('#detailAddress').prop('disabled', true).val('');
                } else {
                    $('#detailAddress').prop('disabled', false);
                }
            });
        });
        
        $(document).ready(function() {
            loadFavoriteProducts(); // 페이지 로드 시 데이터 로딩
        });

        // JavaScript 코드
        $(document).ready(function() {
            // 임시 데이터
             var bidData = <%= jsonArray.toString() %>;

            // 페이지당 보여줄 항목 수
            var itemsPerPage = 5;
            var currentPage = 1;

            // 테이블 데이터 총 개수
            var totalItems = bidData.length;

            // 테이블 데이터 채우기 함수
            function fillTableData(page) {
                var start = (page - 1) * itemsPerPage;
                var end = start + itemsPerPage;
                var tableBody = $('#bidListTableBody');
                tableBody.empty(); // 이전 데이터 제거

                for (var i = start; i < end && i < bidData.length; i++) {
                    var row = bidData[i];
                    var newRow = '<tr>' +
                        '<td>' + row.favoriteID + '</td>' + // 'number' 대신 'favoriteID'를 사용합니다.
                        '<td>' + row.product + '</td>' +
                        '<td>' + row.startPrice + '</td>' +
                        '<td>' + row.buyNowPrice + '</td>' +
                        '<td>' + row.currentBid + '</td>' +
                        '<td><button onclick="removeItem(' + row.favoriteID + ')">삭제</button></td>' + // 'id' 대신 'favoriteID'를 사용합니다.
                        '</tr>';
                    tableBody.append(newRow);
                }

            }

            fillTableData(); // 이 함수를 호출하여 데이터로 테이블을 채웁니다.
            // 페이지 초기화
            fillTableData(currentPage);
            createPagination();

            // 페이지네이션 클릭 이벤트 핸들러
            $('#pagination').on('click', 'a', function(event) {
                event.preventDefault();
                var page = parseInt($(this).attr('data-page'));

                if (page && page !== currentPage) {
                    currentPage = page;
                    fillTableData(currentPage);
                    createPagination();
                }
            });

            // 페이지네이션 생성 함수
            function createPagination() {
                var totalPages = Math.ceil(totalItems / itemsPerPage);
                var paginationElement = $('#pagination');
                paginationElement.empty(); // 이전 페이지네이션 제거

                // 이전 버튼 추가
                var prevButton = '<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '"><a class="page-link" href="#" data-page="' + (currentPage - 1) + '">이전</a></li>';
                paginationElement.append(prevButton);

                // 페이지 번호 추가
                for (var i = 1; i <= totalPages; i++) {
                    var pageButton = '<li class="page-item ' + (i === currentPage ? 'active' : '') + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
                    paginationElement.append(pageButton);
                }

                // 다음 버튼 추가
                var nextButton = '<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '"><a class="page-link" href="#" data-page="' + (currentPage + 1) + '">다음</a></li>';
                paginationElement.append(nextButton);
            }
        });

        // 입찰목록 링크 클릭 시 이벤트 처리
        document.getElementById('bidListLink').addEventListener('click', function(event) {
            // 기본 이벤트 방지
            event.preventDefault();
            // bidList.jsp로 이동
            window.location.href = 'bidList.jsp';
        });

        // 유찰목록 링크 클릭 시 이벤트 처리
        document.getElementById('failedBidListLink').addEventListener('click', function(event) {
            event.preventDefault();
            window.location.href = 'failedBidList.jsp';
        });

        
        // 입찰등록 링크 클릭 시 이벤트 처리
        document.getElementById('bidRegistLink').addEventListener('click', function(event) {
            event.preventDefault();
            window.location.href = 'bidRegist.jsp';
        });

        // 관심상품 링크 클릭 시 이벤트 처리
        document.getElementById('favoriteProductLink').addEventListener('click', function(event) {
            event.preventDefault();
            window.location.href = 'favoriteProduct.jsp';
        });

        // 주문목록 링크 클릭 시 이벤트 처리
        document.getElementById('orderListLink').addEventListener('click', function(event) {
            event.preventDefault();
            window.location.href = 'orderList.jsp';
        });

        // 미결제 목록 링크 클릭 시 이벤트 처리
        document.getElementById('outstanding2Link').addEventListener('click', function(event) {
            event.preventDefault();
            window.location.href = 'outstanding2.jsp';
        });
        
        document.getElementById('myPageLink').addEventListener('click', function(event) {
        	event.preventDefault();
        	window.location.href = 'myPage.jsp';
        });
        
        document.getElementById('profileUpdateLink').addEventListener('click', function(event) {
            event.preventDefault();
            window.location.href = 'profileUpdate.jsp';
        });

        document.getElementById('profileDeleteLink').addEventListener('click', function(event) {
        	event.preventDefault();
        	window.location.href = 'profileDelete.jsp';
        });
    </script>
</body>
</html>
