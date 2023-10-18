<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="/resources/sneat/assets/vendor/css/core.css"
	class="template-customizer-core-css" />
<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css"
	rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
* {
	margin: 0px;
	padding: 0px;
}

.card {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 25vw;
	height: 70vh;
}

.card-body {
	position: relative; /* .card-body를 상대적으로 위치시킵니다. */
	padding: 50px;
}

#img {
	width: 300px;
	height: 150px;
	margin-top: 10px;
	margin-bottom: 10px;
}

#confirmBtn {
	background-color: #46B8FF;
	color: white;
	bottom: 30px; /* 아래에서 20px만큼 띄우기 */
	right: 10px; /* 오른쪽에서 20px만큼 띄우기 */
	border: none;
	width: 90px;
	height: 40px;
	border-radius: 10px;
	margin-right: 20px;
	margin-bottom: 10px;
}

#passSchBtn {
	background-color: #46B8FF;
	color: white;
	border: none;
	bottom: 30px; /* 아래에서 20px만큼 띄우기 */
	right: 20px; /* 오른쪽에서 20px만큼 띄우기 */
	margin-bottom: 40px;
	width: 130px;
	height: 30px;
	border-radius: 20px;
	margin-left: 200px;
}

.form-label {
	font-size: 15px;
}
</style>
</head>
<body>



	<div class="container-xxl"
		style="display: flex; justify-content: center; align-items: center;">
		<div class="authentication-wrapper authentication-basic container-p-y">
			<div class="authentication-inner">
				<!-- Register -->
				<div class="card">
					<div class="card-body">
						<!-- Logo -->
						<div class="app-brand justify-content-center">
							<a> <img id="img" src="/resources/images/진료이즈백 납작.png" alt="진료이즈백메인로고"></a>
						</div>
						<p class="mb-5" style="text-align: center;">비밀번호 찾기</p>

						<form id="formAuthentication" class="mb-3" action="/emp/findPw" method=post onsubmit="showAlert()">
							<div class="mb-4">
								<span class="input-group-addon"><i class="fa fa-user" style="font-size: 15px;"></i></span> 
								<label for="username" class="form-label">사번</label> 
								<input type="text" class="form-control" id="username" name="empNo" placeholder="사번" autofocus="">
							</div>
							<div class="mb-5">
								<span class="input-group-addon"><i class="fa fa-envelope" style="font-size: 15x;"></i></span> 
								<label for="email" class="form-label">이메일</label><br>
								<input type="email" class="form-control" id="email" name="empEmail" placeholder="이메일">
								<small style="font: gray; font-size: 10px;">입력하신 이메일로 임시비밀번호가 발송됩니다.</small><br>
								<small style="font: gray; font-size: 10px;">가입시 입력한 이메일을 입력해주세요.</small>
							</div>

							<div class="text-end">
								<button id="confirmBtn" type="submit">확인</button>
							</div>
						</form>
					</div>
				</div>
				<!-- /Register -->
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>	
<script>
	function showAlert() {
		Swal.fire({
			icon: 'success',
			title: '비밀번호 전송 완료',
			text: '임시 비밀번호가 메일로 전송되었습니다.',
		});
	}
</script>

</body>

</html>