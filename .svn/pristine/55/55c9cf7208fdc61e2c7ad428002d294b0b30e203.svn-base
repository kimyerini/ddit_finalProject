<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	height: 80vh;
}

.card-body {
	position: relative; /* .card-body를 상대적으로 위치시킵니다. */
	padding: 40px;
}

#img {
	width: 250px;
	height: 250px;
	margin-top: 30px;
}

#loginBtn {
	background-color: #46B8FF;
	color: white;
	border: none;
	width: 400px;
	height: 40px;
	border-radius: 10px;
	padding: 4px;
	margin-top: 30px;
}
</style>
</head>
<body>

	<div class="container-xxl" style="display: flex; justify-content: center; align-items: center;">
		<div class="authentication-wrapper authentication-basic container-p-y">
			<div class="authentication-inner">
				<!-- Register -->
				<div class="card">
					<div class="card-body">
						<!-- Logo -->
						<div class="app-brand justify-content-center">
							<a> <img id="img" src="/resources/images/진료이즈백_로고.png"
								alt="진료이즈백 로고">
							</a>
						</div>

						<p class="mb-3"></p>

						<form id="formAuthentication" class="mb-3" action="/login"
							method="POST">
							<div class="mb-4">
								<c:if test="${relogin eq ''}">
									<small>${relogin} 비밀번호가 정상적으로 변경되었습니다. 재로그인해주세요.</small><br><br>
								</c:if>
								 <span class="input-group-addon">
								 	<i class="fa fa-user" style="font-size: 20px;"></i>
								 </span> 
								 <label for="username"class="form-label">사번</label> 
								 <input type="text" class="form-control" id="username" name="username"
									placeholder="사번을 입력하세요." autofocus  />
							</div>
							<div class="mb-3">
								<span class="input-group-addon">
									<i class="fa fa-key" style="font-size: 20x;"></i>
								</span> 
								<label for="password" class="form-label">비밀번호</label> 
								<input type="password" class="form-control" id="password" name="password"
									placeholder="비밀번호를 입력하세요."  /> 
								<a id="pwSch" style="font-size: 5px; color: gray;" href="/emp/findPw">비밀번호를잊으셨나요?</a>
							</div>

							<div>
								<button id="loginBtn" type="submit" style="margin-bottom: 10px">로그인</button>
								<sec:csrfInput />
							
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

<script type="text/javascript">
Swal.fire({
	  title: '로그인에 실패하셨습니다.',
	  text: "아이디 또는 비밀번호가 올바른지 확인해주세요.",
	  icon: 'warning',
	  confirmButtonColor: '#3085d6',
	  confirmButtonText: '확인'
	})
</script>


</html>