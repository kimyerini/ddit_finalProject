<!-- 임시사번이랑 임시비번으로 첫번째 로그인해서 비번 바꾸는 view
 비번 바꾸기 확인 누르면 ==> 비번 update + 최초로그인 여부 y에서 n으로 update
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
	margin-bottom: 10px;
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
							<a> <img id="img" src="/resources/images/진료이즈백 납작.png"
								alt="진료이즈백메인로고">
							</a>
						</div>
						<p class="mb-5" style="text-align: center;">비밀번호 변경하기</p>

						<form id="formAuthentication" class="mb-3" action="/emp/updatePwForm"
							method="POST" onsubmit="return validation();" >
							<sec:csrfInput/>
							<div class="mb-5">
								<span class="input-group-addon"><i class="fa fa-key"
									style="font-size: 15px;"></i></span> 
								<label for="empPassword0"
									class="form-label">새로운 비밀번호</label> 
								<input type="password"
									class="form-control" id="empPassword0" name="empPassword0"
									 autofocus="" placeholder="영문 숫자 조합 8자리 이상으로 입력해주세요.">
							</div>
							<div class="mb-5">
								<span class="input-group-addon"><i class="fa fa-key"
									style="font-size: 15x;"></i></span> 
								<label for="empPassword" class="form-label">비밀번호 확인</label><br>
								<input type="password" class="form-control" id="empPassword" name="empPassword" placeholder="영문 숫자 조합 8자리 이상으로 입력해주세요." >
								<small style="font: gray; font-size: 10px;"></small><br>
								<small style="font: gray; font-size: 10px; " hidden="">가입시 입력한 이메일을 입력해주세요.</small>
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
</body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
	function validation() {

		var empPassword0 = $("#empPassword0").val();
		var empPassword = $("#empPassword").val();
		
		let reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
		
		function validationPw(password){
			return reg.test(password);
		}
		
		if(!validationPw(empPassword)){
	      Swal.fire({
		         icon: 'error',
		         title: '비밀번호를 확인해주세요.',
		         text: '비밀번호는 영문 숫자 조합 8자리 이상입니다.'
		      });
	      	  event.preventDefault();
		}

		if (empPassword0 != empPassword) {
			Swal.fire({
				icon : 'error',
				title : '비밀번호 확인 오류',
				text : '새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.'
			})
			event.preventDefault();
		}
		return;
	}
</script>

</html>