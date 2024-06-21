<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

        /* 버튼 위치 조정 */
        .edit-buttons {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }

        .edit-buttons button {
            margin-left: 5px;
            background-color: #fff;
            color: #000;
        }

        .edit-buttons button:hover {
            background-color: #ddd;
        }

        /* 중앙 정렬 체크박스 */
        .form-check {
            text-align: center;
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
            <a class="navbar-brand" href="#"><img src="Lux.jpg" alt="LUX Logo" style="width: 100px;"></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">홈</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">리뷰</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">상점</a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" placeholder="검색" aria-label="검색">
                    <button class="btn btn-outline-secondary my-2 my-sm-0" type="submit"><i class="fas fa-search"></i></button>
                </form>
                <!-- 고객센터, 마이페이지, 로그인 -->
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">고객센터</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" id="myPageLink">마이페이지</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">로그인</a>
                    </li>
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
                        <h4>마이페이지</h4>
                    </div>
                </div>
                <!-- 아이디 -->
                <div class="row">
                    <div class="col">
                        <p><span class="icon-text"><i class="fas fa-user"></i></span>아이디: <span class="user-id">로그인한 사람 아이디</span></p>
                    </div>
                </div>
                <!-- 배송지 정보 -->
                <div class="row">
                    <div class="col">
                       <!-- 배송지 정보 수정 클릭 시 모달 팝업 -->
                        <p><span class="icon-text"><i class="fas fa-map-marker-alt"></i></span>배송지 정보: <span id="currentAddress">부산광역시 00</span> <a href="#" id="editAddressLink" data-toggle="modal" data-target="#editAddressModal">수정&gt;</a></p>
                    </div>
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
                    <li><a href="#" id="bidListLink">입찰목록(<span>0</span>)</a></li>
                    <li><a href="#" id="failedBidListLink">유찰목록(<span>0</span>)</a></li>
                    <li><a href="#" id="bidOrderListLink">경매주문목록(<span>0</span>)</a></li>
                    <li><a href="#" id="outstandingListLink">미결제목록(<span>0</span>)</a></li>
                    <li><a href="#" id="bidRegistLink">경매등록(<span>0</span>)</a></li>
                </ul>
            </div>
            <!-- 구매 내역 -->
            <div class="col-sm-4">
                <h5>구매내역 <span class="section-icon"><img src="image 5.png" alt="Purchase Icon"></span></h5>
                <ul>
                    <li><a href="#" id="favoriteProductLink">관심상품(<span>0</span>)</a></li>
                    <li><a href="#" id="orderListLink">주문목록(<span>0</span>)</a></li>
                    <li><a href="#" id="outstanding2Link">미결제목록(<span>0</span>)</a></li>
                </ul>
            </div>
            <!-- 회원 정보 -->
            <div class="col-sm-4">
                <h5>회원정보 <span class="section-icon"><img src="image 6.png" alt="Member Icon"></span></h5>
                <ul>
                    <li><a href="#" id="profileUpdateLink">개인정보수정</a></li>
                    <li><a href="#" id="profileDeleteLink">회원탈퇴신청</a></li>
                </ul>
            </div>
        </div>
    </div>

        <!-- 경매 등록 테이블 -->
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <div class="edit-buttons">
                        <button type="button" class="btn btn-info" onclick="editSelected()">선택한 행 수정</button>
                        <button type="button" class="btn btn-success" onclick="saveSelected()">선택한 행 저장</button>
                    </div>
                    <h5>경매 등록</h5>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>선택</th>
                                <th>번호</th>
                                <th>경매상품ID(출품자)</th>
                                <th>상품정보</th>
                                <th>검수 상태</th>
                                <th>운송장 번호</th>
                            </tr>
                        </thead>
                        <tbody id="auctionTableBody">
                            <!-- 임의의 데이터 -->
                            <tr>
                                <td class="form-check"><input type="checkbox" class="form-check-input" id="check1"></td>
                                <td>1</td>
                                <td>12345 (출품자)</td>
                                <td>상품 정보 설명 Lorem Ipsum</td>
                                <td>검수 완료</td>
                                <td>1234567890</td>
                            </tr>
                            <tr>
                                <td class="form-check"><input type="checkbox" class="form-check-input" id="check2"></td>
                                <td>2</td>
                                <td>67890 (출품자)</td>
                                <td>상품 정보 설명 Lorem Ipsum</td>
                                <td>검수 완료</td>
                                <td>0987654321</td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- 이전 다음 키 -->
                    <div class="text-center">
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전</a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <!-- 다른 페이지 수에 따라 추가 -->
                            <li class="page-item">
                                <a class="page-link" href="#">다음</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 부트스트랩 및 Font Awesome 스크립트 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- JavaScript 코드 -->
    <script>
        // 선택한 행을 수정하는 함수
        function editSelected() {
            var rows = document.querySelectorAll("#auctionTableBody tr");
            var checked = false;
            rows.forEach(function(row) {
                var checkbox = row.querySelector(".form-check-input");
                if (checkbox.checked) {
                    checked = true;
                    var shippingTd = row.querySelector("td:nth-child(6)");
                    var shippingValue = shippingTd.textContent;
                    var shippingInput = document.createElement("input");
                    shippingInput.type = "text";
                    shippingInput.className = "form-control";
                    shippingInput.value = shippingValue;
                    shippingTd.textContent = "";
                    shippingTd.appendChild(shippingInput);
                }
            });
            if (!checked) {
                alert("수정할 항목을 선택해주세요.");
            }
        }

        // 선택한 행을 저장하는 함수
        function saveSelected() {
            var rows = document.querySelectorAll("#auctionTableBody tr");
            var checked = false;
            rows.forEach(function(row) {
                var checkbox = row.querySelector(".form-check-input");
                if (checkbox.checked) {
                    checked = true;
                    var shippingTd = row.querySelector("td:nth-child(6)");
                    var shippingInput = shippingTd.querySelector("input");
                    if (shippingInput) {
                        var shippingValue = shippingInput.value;
                        shippingTd.textContent = shippingValue;
                    }
                }
            });
            if (!checked) {
                alert("저장할 항목을 선택해주세요.");
            } else {
                alert("수정 완료되었습니다.");
            }
        }
    </script>
</body>
</html>
