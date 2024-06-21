<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException"%>
<%@page import="shopper.UserManager"%>
<%@ page import="shopper.User"%>
<%
User loggedInUser = (User) session.getAttribute("user");
UserManager userManager = new UserManager();
int userBalance = 0;

if (loggedInUser != null) {
    userBalance = userManager.getUserBalance(loggedInUser.getUserID()); // UserID를 넘겨 잔액 조회
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LUX Auction - 리뷰 작성</title>
<!-- 부트스트랩 링크 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Font Awesome 아이콘 링크 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<!-- CSS 스타일 -->
<style>
/* 추가적인 CSS 스타일링 */
body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-color: #f8f9fa;
}

.container {
	max-width: 800px;
	margin: 40px;
	background-color: #ffffff;
	padding: 40px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

form {
	margin-top: 20px;
}

.form-group {
	margin-bottom: 20px;
}

.rating {
	display: flex;
	flex-direction: row; /* 별점을 가로로 나열하도록 수정 */
	justify-content: flex-start;
	align-items: center; /* 별점 텍스트와 아이콘을 세로 중앙 정렬 */
	margin: 10px 0;
}

.rating input {
	display: none;
}

.rating label {
	cursor: pointer;
	font-size: 30px;
	color: #ddd;
	margin-right: 10px;
}

.rating input:checked ~ label, .rating input:checked ~ label ~ label {
	color: #ffc107;
}

.btn-submit {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
}

.btn-submit:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<!-- 리뷰 작성 폼 -->
	<div class="container">
		<h2>상품 리뷰 작성</h2>
		<form id="reviewForm" method="POST" action="review.jsp"
			enctype="multipart/form-data" onsubmit="return validateForm()">
			<div class="form-group">
				<label for="rating">별점</label> <span id="ratingValue"
					style="margin-left: 10px; font-weight: bold;"></span>
				<div class="rating">
					<input type="radio" id="star5" name="rating" value="5"> <label
						for="star5"><i class="fas fa-star"></i></label> <input
						type="radio" id="star4" name="rating" value="4"> <label
						for="star4"><i class="fas fa-star"></i></label> <input
						type="radio" id="star3" name="rating" value="3"> <label
						for="star3"><i class="fas fa-star"></i></label> <input
						type="radio" id="star2" name="rating" value="2"> <label
						for="star2"><i class="fas fa-star"></i></label> <input
						type="radio" id="star1" name="rating" value="1"> <label
						for="star1"><i class="fas fa-star"></i></label>
				</div>
				<span id="ratingError" style="color: red; display: none;">별점을
					선택해주세요.</span>
			</div>
			<div class="form-group">
				<label for="reviewTitle">리뷰 제목</label> <input type="text"
					class="form-control" id="reviewTitle" name="reviewTitle" required>
			</div>
			<div class="form-group">
				<label for="reviewText">리뷰 내용</label>
				<textarea class="form-control" id="reviewText" name="reviewText"
					rows="5" required></textarea>
			</div>
			<div class="form-group">
				<label for="photo">사진 업로드</label> <input type="file"
					class="form-control-file" id="photo" name="photo">
			</div>
			<button type="submit" id="submitButton" class="btn btn-submit">리뷰
				작성 완료</button>
		</form>
	</div>

	<!-- scripts -->
	<script src="themes/js/jquery-1.7.2.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="themes/js/superfish.js"></script>
	<script src="themes/js/jquery.scrolltotop.js"></script>
	<script src="themes/js/jquery.fancybox.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		// 별점 선택 시 선택한 별점을 텍스트로 표시하는 기능

		// 폼 유효성 검사
		function validateForm() {
			var rating = $("input[name='rating']:checked").val();
			if (!rating) {
				$("#ratingError").show();
				return false;
			}
			return true;
		}

		$(document).ready(function() {
			$(".rating input:radio").attr("checked", false);

			$('.rating input').click(function() {
				$(".rating span").html('');
				$(".rating span").html($(this).next().html());
				var ratingValue = $(this).attr("value");
				$("#ratingValue").text("별점 (" + ratingValue + "점)");
				$("#ratingError").hide();
			});
			$('#submitButton').click(function(e) {
				e.preventDefault(); // 기본 제출 동작 방지

				// 파일 입력 요소에서 파일 가져오기
				var file = $('#photo')[0].files[0];
				console.log('Selected file name:', file.name);
				console.log('Selected file size:', file.size); // 파일의 크기 출력
				var filename = file.name;
				// 파일 입력 요소에서 파일이 선택되지 않은 경우 처리
				if (!file) {
					alert('Please select a file.');
					return;
				}

				// FormData 객체 생성 (파일 및 기타 데이터를 담음)
				var formData = new FormData($('#productForm')[0]);

				// 선택한 별점 숫자 받아오기
				var rating = $("input[name='rating']:checked").val();
				console.log('Selected rating:', rating);

				// 별점 숫자를 formData에 추가
				formData.append('Rating', rating);
				console.log('별점', rating);
				// 파일 추가
				formData.append('photo', file);

				// 기타 데이터 추가 (예: 텍스트 필드)
				formData.append('reviewTitle', $('#reviewTitle').val());
				formData.append('reviewText', $('#reviewText').val());
				formData.append('photoName', filename); // 파일 이름 추가
				// Ajax 요청
				$.ajax({
					url : 'reviewInsertServlet', // 서버로 보낼 URL
					type : 'POST', // 전송 방식
					data : formData,
					processData : false, // 데이터 처리 방법 (false로 설정하여 FormData가 처리되도록 함)
					contentType : false, // 컨텐츠 타입 (false로 설정하여 FormData가 설정한 컨텐츠 타입이 유지되도록 함)
					success : function(response) {
						// 서버로부터의 성공 응답 처리
						alert('리뷰 저장 완료'); // 성공 메시지
                    window.location.href = 'orderList.jsp'; // 페이지 리디렉션
						// 여기에 성공 시 동작할 코드 추가
					},
					error : function(xhr, status, error) {
						// 서버로의 요청 실패 처리
						//console.error('Error:', error);
						// 여기에 실패 시 동작할 코드 추가
						 alert('리뷰 저장 중 오류가 발생했습니다.'); // 에러 메시지

					}
				});
			});
			$('#reviewForm').submit(function(e) {
				e.preventDefault(); // 폼 기본 제출 동작을 방지합니다.

				// 폼 데이터를 FormData 객체로 생성합니다.
				var formData = new FormData(this);

				// AJAX 요청을 통해 서버에 리뷰 데이터를 전송합니다.
				$.ajax({
					url : 'reviewInsertServlet',
					type : 'POST',
					data : formData,
					processData : false,
					contentType : false,
					success : function(response) {
						// 성공적으로 리뷰가 저장되었을 때의 처리 로직입니다.
						alert('리뷰 저장 완료'); // 리뷰 저장 완료 메시지를 표시합니다.
						window.location.href = 'orderList.jsp'; // orderList.jsp 페이지로 이동합니다.
					},
					error : function(xhr, status, error) {
						// 에러가 발생했을 때의 처리 로직입니다.
						console.error('Error:', error);
						alert('리뷰 저장 중 오류가 발생했습니다.');
					}
				});
			});
		});
	</script>


</body>
</html>
