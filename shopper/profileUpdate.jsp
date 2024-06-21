<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shopper.User"%>
<%@page import="java.util.List"%>
<%@ page import="shopper.ProductMgr"%>
<%@ page import="java.sql.*"%>
<%@ page import="shopper.DBConnectionMgr"%>
<%@ page import="java.sql.SQLException"%>
<%
User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LUX Auction - 개인정보수정</title>
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
        /* 추가된 스타일 */
        .content-box {
            border: 1px solid #ccc;
            padding: 20px;
            margin-top: 40px;
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
        /* 링크 색상 변경 */
        #bidListLink,
        #failedBidListLink,
        #bidOrderListLink,
        #outstandingListLink,
        #bidRegistLink,
        #favoriteProductLink,
        #orderListLink,
        #outstanding2Link {
            color: #000; /* 검정색으로 변경 */
        }
        /* 수정 완료 팝업 스타일 */
        .popup {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 20px;
            border-radius: 5px;
            display: none;
        }
        /* 수정 버튼 스타일 */
        #editButton {
            background-color: #fff; /* 배경색 흰색으로 변경 */
            color: #000; /* 글자색 검정색으로 변경 */
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

    <!-- 내용 박스 -->
    <div class="container content-box">
        <h2>개인정보 수정</h2>
        <form id="editProfileForm" method="post" action="updatePassword">
            <div class="form-group row">
                <label for="currentPassword" class="col-sm-3 col-form-label">현재 비밀번호</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="현재 비밀번호" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="newPassword" class="col-sm-3 col-form-label">새 비밀번호</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="confirmPassword" class="col-sm-3 col-form-label">새 비밀번호 재확인</label>
                <div class="col-sm-9">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="새 비밀번호 재확인" required>
                    <small id="passwordMatch"></small> <!-- 일치 여부 표시 -->
                </div>
            </div>
            <!-- 수정 버튼 -->
            <div class="form-group row">
                <div class="col-sm-9 offset-sm-3">
                    <button type="submit" class="btn btn-primary" id="editButton">수정</button>
                </div>
            </div>
        </form>
    </div>

    <!-- 수정 완료 팝업 -->
    <div class="popup" id="editSuccessPopup">
        수정이 완료되었습니다.
    </div>

    <!-- JavaScript 코드 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#newPassword, #confirmPassword').on('input', function() {
                var newPassword = $('#newPassword').val();
                var confirmPassword = $('#confirmPassword').val();
                if (newPassword === confirmPassword) {
                    $('#passwordMatch').text('비밀번호가 일치합니다.').css('color', 'green');
                } else {
                    $('#passwordMatch').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
                }
            });

            $('#editProfileForm').submit(function(event) {
                event.preventDefault();
                var currentPassword = $('#currentPassword').val();
                var newPassword = $('#newPassword').val();
                var confirmPassword = $('#confirmPassword').val();

                if (newPassword === confirmPassword) {
                    $.ajax({
                        url: 'updatePassword', // Your servlet URL
                        type: 'POST',
                        data: {
                            currentPassword: currentPassword,
                            newPassword: newPassword
                        },
                        success: function(response) {
                            if (response.trim() === 'success') {
                                $('#editSuccessPopup').show().fadeOut(3000);
                                $('#editProfileForm').trigger("reset");
                            } else {
                                alert('비밀번호 업데이트에 성공했습니다.');
                            }
                        },
                        error: function() {
                            alert('비밀번호 업데이트 중 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('새 비밀번호가 일치하지 않습니다.');
                }
            });
        });
    </script>
</body>
</html>
