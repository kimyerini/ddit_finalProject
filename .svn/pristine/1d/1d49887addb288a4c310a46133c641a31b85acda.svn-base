<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" href="/resources/sneat/assets/vendor/css/core.css" class="template-customizer-core-css" />

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
	width: 30vw;
	height: 90vh;
}

.mb-1 {
	width: 400px;
	margin-top: 10px;
}

.card-body {
	position: relative;
	/* .card-body를 상대적으로 위치시킵니다. */
	padding-top: 20px;
	padding-bottom: 30px;
	padding-left: 55px;
	padding-right: 20px;
	
}

#confirm {
	position: absolute;
	/* #confirm을 절대적으로 위치시킵니다. */
	bottom: 20px;
	/* 아래에서 15px 떨어진 위치에 배치합니다. 원하는 값으로 조정 가능합니다. */
	right: 20px;
	/* 오른쪽에서 20px 떨어진 위치에 배치합니다. 원하는 값으로 조정 가능합니다. */
	background-color: green;
	color: white;
	border: none;
	border-radius: 5px;
	width: 50px;
	height: 30px;
}

.flex-container {
	display: flex;
	align-items: center;
}

#zipSrh {
	margin-left: 10px;
	margin-top: 30px;
	background-color: blue;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 5px;
	width: 70px;
	height: 40;
}

#emailbtn {
	margin-left: 10px;
	margin-top: 30px;
	background-color: blue;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 5px;
	width: 70px;
	height: 40;
}

#employee {
	padding-top: 5px;
}

#img {
	witdh: 150px;
	height: 70px;
}

.form-control {
	margin-top: 6px;
}
</style>

</head>

<body>

	<!-- Content -->

	<div class="container-xxl">
		<div class="authentication-wrapper authentication-basic container-p-y">
			<div class="authentication-inner">

				<!-- Register Card -->
				<div class="card">
					<div class="card-body">
						<!-- Logo -->
						<div class="app-brand justify-content-center">
							<a href="" class="app-brand-link gap-2"> <span
								class="app-brand-logo demo"></span> <img id="img"
								src="/resources/images/진료이즈백 납작.png" alt="진료이즈백 로고">
							</a>
						</div>
						<div class="app-brand justify-content-center">
							<h6>회원가입</h6>
						</div>

						<form id="formAuthentication" class="mb-3" method="POST">
							<div class="mb-1">
								이름<input type="text" class="form-control" id="empNm"
									name="empNm" value="" required placeholder="" autocomplete="true" autofocus>
							</div>
							<div class="flex-container">
								<div class="mb-1" id="email">
									이메일<input type="text" class="form-control" id="empEmail" name="empEmail" value="" required placeholder="">
								</div>
								<div>
									<button type="button" id="emailbtn">중복확인</button>
								</div>
							</div>

							<div class="mb-1">
								생년월일<input type="text" class="form-control" id="empBrthdy" name="empBrthdy" required value="" placeholder="">
							</div>
							<div class="mb-1">
								연락처<input type="text" class="form-control" id="empTelno" name="empTelno" required 
									pattern="010-[0-9]{4}-[0-9]{4}" value="" placeholder="">
							</div>
							<!-- 우편번호 찾기 넣어야함 -->
							<div class="flex-container">
								<div class="mb-1" id="zip">
									우편번호<input type="text" class="form-control" id="empZip" name="empZip" required value="" readonly >
								</div>
								<div>
									<button id="zipSrh">검색</button>
								</div>
							</div>
							<div class="mb-1">
								기본주소<input type="text" class="form-control" id="empAddr" name="empAddr" required value="" placeholder="">
							</div>
							<div class="mb-1">
								상세주소<input type="text" class="form-control" id="empDtlAddr" name="empDtlAddr" required value="" placeholder="">
							</div>
							<div id="employee">
								직무<br> <select id="deptCode" style="width: 400px; height: 40px;">
									<option value="0">직무선택</option>
									<option value="D001">의사</option>
									<option value="D002">간호사</option>
									<option value="D003">원무</option>
									<option value="D004">물리치료</option>
									<option value="D005">영상의학</option>
									<option value="D006">인사총무</option>
								</select>
							</div>


							<div class="mb-3"></div>
							<button type="submit" id="confirm">확인</button>
							<sec:csrfInput/>
						</form>
					</div>
				</div>
				<!-- Register Card -->
			</div>
		</div>
	</div>
</body>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<script>
	$(function () {
		$('#zipSrh').on('click', function () {
			new daum.Postcode({
				//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
				oncomplete: function (data) {
					$('input[name="empZip"]').val(data.zonecode);
					$('input[name="empAddr"]').val(data.address);
					$('input[name="empDtlAddr"]').val(data.buildingName);
				}
			}).open();
		}); 
	})

	// 이메일 정규 표현식
    let regex = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

    // 이메일 유효성 검사 함수
    function validateEmail(email) {
        return regex.test(email);
    }

	
	 // ajax로 보내는 token, 복사/붙여넣기
	 //const header = '${_csrf.headerName}';
	 //const token = '${_csrf.token}';
	
	 // 이메일 사용가능 여부 체크가 아직 안 되어 있음
	 let isEmailChecked = false; 
	
	 // 이메일 중복 체크 구현
	 $('#emailbtn').on("click", () => {
	   var empEmail = $("#empEmail").val();
	   
	   // 이메일 형식 검증
	   if (!validateEmail(empEmail)) {
	      Swal.fire({
	         icon: 'error',
	         title: '유효하지 않은 이메일 주소입니다.',
	         text: '올바른 이메일 주소를 입력하세요.'
	      });
	      return;
	   }
	
	   $.ajax({
	     type: "get",
	     url: "/emp/emailCheck",
	     data: "email=" + empEmail,
	     dataType: "text",
	     success: function (res) {
	       console.log("체크", res);
	       if (res == "fail") {
	         Swal.fire({
	           icon: 'error',
	           title: '이미 등록된 메일주소입니다.!',
	           text: '메일 주소를 다시 확인해주세요.',
	         })
	       } else {
	         Swal.fire(empEmail +'은 사용가능한 메일주소입니다.')
	         isEmailChecked = true;
	       }
	     },
	     error: function (xhr, status, error) {  // 요건 항상 복사/붙여넣기로
	       console.log("code: " + xhr.status)
	       console.log("message: " + xhr.responseText)
	       console.log("error: " + error);
	     }
	
	   })
	 })
	
	 $("#formAuthentication").on("submit", function (){ 
	   event.preventDefault();   // built-in 이벤트 막기, submit 
	
	   if(!isEmailChecked){
	     Swal.fire({
	           icon: 'error',
	           title: '이메일 중복 여부를 확인해주세요.',
	           text: ''
	     });
	     $("#empEmail")[0].focus(); // 커서를 이메일 텍스트박스로 옮김!
	     return; // 함수종료하여 밑으로 내려가지 않게 함
	   }
	
	   var today = new Date();
	   var year = today.getFullYear() + "";
	   year = year.substr(2, 2);
	   var month = today.getMonth() + 1;
	   if (month < 10) {
	     month = "0" + month;   // 2자리 맹글깅
	   }
	   var empNo = year + month + "03";
	   
	
	   //var formData = FormData(폼elem);  // FormData 아작스로 파일 전송시 꼬옥 필요하니깡 알아 두는 걸롱! 
	
	   var empNm = $("#empNm").val();
	   var empEmail = $("#empEmail").val();
	   var empBrthdy = $("#empBrthdy").val();
	   var empTelno = $("#empTelno").val();
	   var empZip = $("#empZip").val();
	   var empAddr = $("#empAddr").val();
	   var empDtlAddr = $("#empDtlAddr").val();
	   var deptCode = $("#deptCode").val();
	
	   let employeeVO = {
	     empNm,
	     empEmail,
	     empBrthdy,
	     empTelno,
	     empZip,
	     empAddr,
	     empDtlAddr,
	     deptCode
	   };
	   // 디버깅  필수
	   console.log("체킁:", employeeVO);
	
	
	   $.ajax({
	     type: "POST", // 전송방식
	     url: "/emp/register",    // 컨트롤러 URL
	     data: JSON.stringify(employeeVO), // 보내는 데이터
	     contentType: "application/json; charset=UTF-8",   // 보내는 내용물은 json  문자열임당!
	     dataType: "text",      // 서버에서 받은 데이타에  JSON.parse()를 적용할거냥, 안 할거냥
	     //beforeSend: function (xhr) {
	     //  xhr.setRequestHeader(header, token);
	     //},
	     success: function (rslt) {
	       console.log("서버에서 리턴한 값체크 :", rslt)
	       if(rslt == "success"){  // DB에 등록 성공 했다면
	         location.href = "/emp/login";  // 주소표시줄에 직접 쓰는 건 get방식
	         //location.replace("/login"); // 기능은 위와 똑같지만 cache를 사용하지 않음, 항상 서버에 새로 요청
	       }else {
	         Swal.fire({
	           icon: 'error',
	           title: 'error',
	           text: 'error'
	         })
	       }
	     },
	     error: function (xhr, status, error) {  // 요건 항상 복사/붙여넣기로
	       console.log("code: " + xhr.status)
	       console.log("message: " + xhr.responseText)
	       console.log("error: " + error);
	     }
	   });
	   
	   
	   
	 })
</script>




</html>