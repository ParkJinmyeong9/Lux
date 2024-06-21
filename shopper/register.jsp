<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Lux 회원가입 선택</title>
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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function setUserForm() {
		document.getElementById("userForm").style.display = "block";
		document.getElementById("adminForm").style.display = "none";
	}

	function setAdminForm() {
		document.getElementById("userForm").style.display = "none";
		document.getElementById("adminForm").style.display = "block";
	}
</script>
</head>
<body>
	<div id="wrapper" class="container">
		<section class="navbar main-menu">
			<div class="navbar-inner main-menu">
				<nav id="menu" class="pull-right">
					<!-- Navigation -->
				</nav>
			</div>
		</section>
		<section class="header_text sub">
			<h4>
				<span>회원가입 선택</span>
			</h4>
		</section>
		<section class="main-content">
			<div class="row">
				<div class="span12">
					<h4 class="title">
						<span class="text"><strong>회원가입 유형 선택</strong></span>
					</h4>
					<button onclick="setUserForm()" class="btn btn-info">일반
						회원가입</button>
					<button onclick="setAdminForm()" class="btn btn-info">관리자
						회원가입</button>

					<div id="userForm" style="display: none;">
						<!-- 일반 회원가입 폼 -->
						<section class="main-content">
							<div class="row">
								<div class="span12">
									<div class="center">
										<h4 class="title">
											<span class="text"><strong>일반 회원가입</strong></span>
										</h4>
										<form action="register" method="post" class="form-stacked"
											onsubmit="return validateForm()">
											<fieldset>
												<div class="control-group">
													<label class="control-label" for="username">아이디</label>
													<div class="controls">
														<input type="text" placeholder="아이디를 입력하세요" id="username"
															name="username" class="input-xlarge" maxlength="12"
															pattern="[A-Za-z0-9]+" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="password">비밀번호</label>
													<div class="controls">
														<input type="password" placeholder="비밀번호를 입력하세요"
															name="password" id="password" class="input-xlarge"
															maxlength="14" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label">비밀번호 확인</label>
													<div class="controls">
														<input type="password" placeholder="비밀번호를 다시 입력하세요"
															name="confirmPassword" id="confirmPassword"
															class="input-xlarge" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="fullname">이름</label>
													<div class="controls">
														<input type="text" placeholder="이름을 입력하세요" name="fullname"
															class="input-xlarge" pattern="[가-힣]{1,6}" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="gender">성별</label>
													<div class="controls">
														<select name="gender" class="input-xlarge">
															<option value="M">남성</option>
															<option value="F">여성</option>
														</select>
													</div>
												</div>
												<div class="control-group">
													<div class="control-group">
														<label class="control-label">이메일</label>
														<div class="controls">
															<!-- 여기에 name="email" 속성을 추가합니다. -->
															<input type="email" placeholder="이메일을 입력하세요" name="email"
																class="input-xlarge">
														</div>
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="postcode">우편번호</label>
													<div class="controls">
														<div class="input-append">
															<input type="text" id="userPostcode" name="postcode"
																placeholder="우편번호" class="span2" readonly>
															<button type="button" onclick="searchPostcodeForUser()"
																class="btn">우편번호 찾기</button>
														</div>
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="address">주소</label>
													<div class="controls">
														<input type="text" id="userAddress" name="address"
															placeholder="주소" class="span4" readonly>
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="detailAddress">상세주소</label>
													<div class="controls">
														<input type="text" id="userDetailAddress"
															name="detailAddress" placeholder="상세주소" class="span4">
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="extraAddress">참고항목</label>
													<div class="controls">
														<input type="text" id="userExtraAddress"
															name="extraAddress" placeholder="참고항목" class="span4"
															readonly>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="birthdate">생년월일</label>
													<div class="controls">
														<input type="date" name="birthdate" class="input-xlarge">
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="phoneNumber">전화번호</label>
													<div class="controls">
														<input type="text" id="phoneNumber" name="phoneNumber"
															placeholder="010-1234-5678" class="input-xlarge"
															maxlength="13" required oninput="formatPhone(this);">
													</div>
												</div>
												<div class="action">
													<input tabindex="3" class="btn btn-inverse large"
														type="submit" value="가입하기">
												</div>
											</fieldset>
										</form>
									</div>
								</div>
							</div>
						</section>
					</div>

					<div id="adminForm" style="display: none;">
						<section class="main-content">
							<div class="row">
								<div class="span12">
									<div class="center">
										<h4 class="title">
											<span class="text"><strong>관리자 회원가입</strong></span>
										</h4>
										<form action="adminRegister" method="post">
											<fieldset>
												<div class="control-group">
													<label class="control-label" for="username">아이디</label>
													<div class="controls">
														<input type="text" placeholder="아이디를 입력하세요" id="username"
															name="username" class="input-xlarge" maxlength="12"
															pattern="[A-Za-z0-9]+" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="password">비밀번호</label>
													<div class="controls">
														<input type="password" placeholder="비밀번호를 입력하세요"
															name="password" id="password" class="input-xlarge"
															maxlength="14" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label">비밀번호 확인</label>
													<div class="controls">
														<input type="password" placeholder="비밀번호를 다시 입력하세요"
															name="confirmPassword" id="confirmPassword"
															class="input-xlarge" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="fullname">이름</label>
													<div class="controls">
														<input type="text" placeholder="이름을 입력하세요" name="fullname"
															class="input-xlarge" pattern="[가-힣]{1,6}" required>
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="gender">성별</label>
													<div class="controls">
														<select name="gender" class="input-xlarge">
															<option value="M">남성</option>
															<option value="F">여성</option>
														</select>
													</div>
												</div>
												<div class="control-group">
													<div class="control-group">
														<label class="control-label">이메일</label>
														<div class="controls">
															<!-- 여기에 name="email" 속성을 추가합니다. -->
															<input type="email" placeholder="이메일을 입력하세요" name="email"
																class="input-xlarge">
														</div>
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="postcode">우편번호</label>
													<div class="controls">
														<div class="input-append">
															<input type="text" id="adminPostcode" name="postcode"
																placeholder="우편번호" class="span2" readonly>
															<button type="button" onclick="searchPostcodeForAdmin()"
																class="btn">우편번호 찾기</button>
														</div>
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="address">주소</label>
													<div class="controls">
														<input type="text" id="adminAddress" name="address"
															placeholder="주소" class="span4" readonly>
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="detailAddress">상세주소</label>
													<div class="controls">
														<input type="text" id="adminDetailAddress"
															name="detailAddress" placeholder="상세주소" class="span4">
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="extraAddress">참고항목</label>
													<div class="controls">
														<input type="text" id="adminExtraAddress"
															name="extraAddress" placeholder="참고항목" class="span4"
															readonly>
													</div>
												</div>

												<div class="control-group">
													<label class="control-label" for="birthdate">생년월일</label>
													<div class="controls">
														<input type="date" name="birthdate" class="input-xlarge">
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="phoneNumber">전화번호</label>
													<div class="controls">
														<input type="text" id="phoneNumber" name="phoneNumber"
															placeholder="010-1234-5678" class="input-xlarge"
															maxlength="13" required oninput="formatPhone(this);">
													</div>
												</div>
												<div class="control-group">
													<label class="control-label" for="approvalCode">승인
														코드</label>
													<div class="controls">
														<input type="text" id="approvalCode" name="approvalCode"
															placeholder="승인 코드를 입력하세요" required>
													</div>
												</div>
												<div class="action">
													<button type="submit" class="btn btn-inverse large">관리자로
														등록하기</button>
												</div>
											</fieldset>
										</form>
									</div>
								</div>
							</div>
						</section>
					</div>
				</div>
			</div>
		</section>
		<section id="footer-bar">
			<div class="row">
				<div class="span3">
					<h4>내비게이션</h4>
					<ul class="nav">
						<li><a href="./index.html">홈페이지</a></li>
						<li><a href="./about.html">고객센터</a></li>
						<li><a href="./contact.html">연락처</a></li>
						<li><a href="./cart.html">장바구니</a></li>
						<li><a href="./login.jsp">로그인</a></li>
					</ul>
				</div>
				<div class="span4">
					<h4>내 계정</h4>
					<ul class="nav">
						<li><a href="#">내 계정</a></li>
						<li><a href="#">주문 내역</a></li>
						<li><a href="#">위시리스트</a></li>
						<li><a href="#">뉴스레터</a></li>
					</ul>
				</div>
				<div class="span5">
					<p class="logo">
						<img src="themes/images/logo.png" class="site_logo" alt="">
					</p>
					<p>로렘 입숨은 단순히 인쇄 및 조판 산업의 더미 텍스트입니다. 로렘 입숨은 업계의 표준 더미 텍스트였습니다.</p>
					<br /> <span class="social_icons"> <a class="facebook"
						href="#">페이스북</a> <a class="twitter" href="#">트위터</a> <a
						class="skype" href="#">스카이프</a> <a class="vimeo" href="#">비메오</a>
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
	<script>
		function validateForm() {
			var username = document.getElementById('username').value;
			if (!/^[A-Za-z0-9]{5,}$/.test(username)) {
				alert("아이디는 영문자와 숫자를 포함하여 5자리 이상이어야 합니다.");
				return false;
			}

			var password = document.getElementById('password').value;
			if (password.length < 8) {
				alert("비밀번호는 최소 8자리 이상이어야 합니다.");
				document.getElementById('password').style.borderColor = "red";
				document.getElementById('confirmPassword').style.borderColor = "red";
				return false;
			}

			var confirmPassword = document.getElementById('confirmPassword').value;
			if (password !== confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				document.getElementById('password').style.borderColor = "red";
				document.getElementById('confirmPassword').style.borderColor = "red";
				return false;
			} else {
				document.getElementById('password').style.borderColor = "initial";
				document.getElementById('confirmPassword').style.borderColor = "initial";
			}

			var fullname = document.querySelector('input[name="fullname"]').value;
			if (!/^[가-힣]{2,6}$/.test(fullname)) {
				alert("이름은 한글 2자리 이상, 최대 6글자까지 입력 가능합니다.");
				return false;
			}

			var postcode = document.getElementById('postcode').value;
			var address = document.getElementById('address').value;
			var detailAddress = document.getElementById('detailAddress').value;

			if (!postcode || !address || !detailAddress) {
				alert("주소를 입력해주세요.");
				return false;
			}

			var approvalCodeField = document.getElementById('approvalCode');
			if (approvalCodeField) { // 승인 코드 필드가 존재하는 경우에만 검증 수행
				var APPROVAL_CODE = "ADMIN123"; // 예시 승인 코드, 실제 코드로 변경 필요
				var inputApprovalCode = approvalCodeField.value;
				if (inputApprovalCode !== APPROVAL_CODE) {
					alert("승인 코드가 일치하지 않습니다.");
					approvalCodeField.style.borderColor = "red";
					return false;
				} else {
					approvalCodeField.style.borderColor = "initial";
				}
			}

			return true; // 모든 검증을 통과한 경우
		}

		function searchPostcodeForAdmin() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 우편번호와 주소 정보를 관리자 폼의 필드에 채웁니다.
							document.getElementById('adminPostcode').value = data.zonecode;
							document.getElementById('adminAddress').value = data.roadAddress;

							// 참고항목 정보를 채웁니다.
							var extraAddress = '';
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddress += data.bname;
							}
							// 건물명이 있고, 공동주택인 경우 추가합니다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddress += (extraAddress !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// extraAddress가 비어있지 않으면, 결과값에 추가합니다.
							document.getElementById('adminExtraAddress').value = extraAddress;

							// 상세주소 입력 필드에 포커스를 맞춥니다.
							document.getElementById('adminDetailAddress')
									.focus();
						}
					}).open();
		}
		function searchPostcodeForUser() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 우편번호와 주소 정보를 일반 사용자 폼의 필드에 채웁니다.
							document.getElementById('userPostcode').value = data.zonecode; // 우편번호
							document.getElementById('userAddress').value = data.roadAddress; // 도로명 주소

							// 참고항목 정보를 채웁니다.
							var extraAddress = '';
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddress += data.bname;
							}
							// 건물명이 있고, 공동주택인 경우 추가합니다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddress += (extraAddress !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// extraAddress가 비어있지 않으면, 결과값에 추가합니다.
							document.getElementById('userExtraAddress').value = extraAddress;

							// 상세주소 입력 필드에 포커스를 맞춥니다.
							document.getElementById('userDetailAddress')
									.focus();
						}
					}).open();
		}
	</script>
	<script>
function formatPhone(obj) {
    var numbers = obj.value.replace(/\D/g, ''),
        char = {3: '-', 7: '-'};
    obj.value = '';
    for (var i = 0; i < numbers.length; i++) {
        obj.value += (char[i] || '') + numbers[i];
    }
}
</script>
</body>
</html>
