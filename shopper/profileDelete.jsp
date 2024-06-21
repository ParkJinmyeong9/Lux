<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="shopper.User"%>
<%@page import="shopper.ProductBean"%>
<%@page import="java.util.List"%>
<%@page import="shopper.ProductMgr"%>
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
<title>Withdrawal Request</title>
<!-- 부트스트랩 링크 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Font Awesome 아이콘 링크 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<!-- CSS 스타일 -->
<style>
/* 모든 것 왼쪽 정렬 */
body {
	text-align: left;
}
/* 추가적인 CSS 스타일링 */
.withdraw-section {
	text-align: center;
	margin-top: 40px;
}

.withdraw-info {
	text-align: left;
	margin-top: 20px;
}

.withdraw-info p {
	margin: 5px 0;
}

.withdraw-info .icon-text {
	margin-right: 5px;
}

.section-icon {
	float: right;
	margin-left: 10px;
}
/* 폼 스타일 */
.form-container {
	max-width: 500px;
	margin: 0 auto;
}
/* 탈퇴 사유 입력란 스타일 */
.reason-input {
	display: none;
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
					<li class="nav-item"><a class="nav-link" href="index.jsp">메인화면</a>
					</li>
					<!-- 로그인한 사용자 정보 표시 -->
					<%
					if (loggedInUser != null) {
					%>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="userDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> <%=loggedInUser.getName()%>님 <!-- 사용자 이름 표시 -->
					</a>
						<div class="dropdown-menu" aria-labelledby="userDropdown">
							<a class="dropdown-item" href="./products.jsp">마이페이지</a> <a
								class="dropdown-item" href="./cart.html">장바구니</a> <a
								class="dropdown-item" href="./checkout.jsp">결제하기</a> <a
								class="dropdown-item" href="./Exchange.jsp">환전하기</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="logout.jsp">로그아웃</a>
						</div></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link" href="login.jsp">로그인</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="register.html">회원가입</a>
					</li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<!-- 탈퇴 신청 섹션 -->
	<div class="container withdraw-section">
		<!-- 탈퇴 신청 정보 -->
		<div class="row">
			<div class="col">
				<h4>회원 탈퇴 신청</h4>
				<!-- 안내 메시지 -->
				<p>탈퇴 신청을 하시려면 아래의 회원 약관을 반드시 읽고 동의해주세요.</p>
				<!-- 약관 동의 박스 -->
				<div class="alert alert-info">
					<h5>회원 약관</h5>
					<p>
						<!-- 약관 내용 생략 -->
					</p>
				</div>
				<!-- 약관 동의 체크박스 -->
				<form action="index.jsp" method="POST"
					class="form-container">
					<div class="form-group">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value=""
								id="withdrawAgreementCheck" required> <label
								class="form-check-label" for="withdrawAgreementCheck">
								회원 약관에 동의합니다. </label>
						</div>
					</div>
					<!-- 탈퇴 사유 선택 -->
					<div class="form-group">
						<label for="withdrawReason">탈퇴 사유</label> <select
							class="form-control" id="withdrawReason" name="withdrawReason"
							required>
							<option value="">탈퇴 사유 선택</option>
							<option value="personal_reason">개인적인 사유</option>
							<option value="service_unsatisfied">서비스 불만족</option>
							<option value="other">기타</option>
						</select>
					</div>
					<!-- 기타 사유 입력 -->
					<div class="form-group reason-input" id="otherReasonInput">
						<label for="otherReason">기타 사유 입력</label>
						<textarea class="form-control" id="otherReason" name="otherReason"
							rows="3"></textarea>
					</div>
					<!-- 비밀번호 입력 -->
					<div class="form-group">
						<label for="password">비밀번호 확인</label> <input type="password"
							class="form-control" id="password" name="password" required>
					</div>
					<!-- 탈퇴 버튼 -->
					<button type="button" class="btn btn-danger" id="withdrawBtn">회원
						탈퇴 신청</button>
				</form>
			</div>
		</div>
	</div>

	<!-- 팝업 모달 -->
	<div class="modal fade" id="withdrawalModal" tabindex="-1"
		role="dialog" aria-labelledby="withdrawalModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="withdrawalModalLabel">회원 탈퇴 안내</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">정말 탈퇴하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger"
						id="confirmWithdrawBtn">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 부트스트랩 및 자바스크립트 링크 -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>  <!-- Full version of jQuery -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
$(document).ready(function() {
    $('#withdrawReason').change(function() {
        if ($(this).val() === 'other') {
            $('#otherReasonInput').slideDown();
            $('#otherReason').prop('required', true);
        } else {
            $('#otherReasonInput').slideUp();
            $('#otherReason').prop('required', false);
        }
    });

    $('#withdrawBtn').click(function() {
        if ($('#withdrawAgreementCheck').prop('checked') && $('#withdrawReason').val() !== '') {
            $('#withdrawalModal').modal('show');
        } else {
            alert('회원 약관에 동의하고 탈퇴 사유를 선택해주세요.');
        }
    });

    // 이벤트 위임을 사용하여 문서의 모든 단계에서 이벤트를 처리
    $(document).on('click', '#confirmWithdrawBtn', function() {
        var inputPassword = $('#password').val();
        $.ajax({
            url: 'deleteUser',
            type: 'POST',
            data: {password: inputPassword},
            success: function(response) {
                if (response.trim() === 'success') {
                    alert('비밀번호가 일치하여 탈퇴되었습니다.');
                    window.location.href = 'logout.jsp';
                } else {
                    alert('비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
                    $('#password').val('');
                    $('#withdrawalModal').modal('hide');
                }
            },
            error: function(xhr) {
                alert('서버와의 통신 중 오류가 발생했습니다: ' + xhr.status);
            }
        });

    });
});
</script>

</body>
</html>
