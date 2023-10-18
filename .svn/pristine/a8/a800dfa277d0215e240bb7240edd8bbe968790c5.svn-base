<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Insert title here</title>
<style>
#wrapper {
    width:1000px;
    height:500px;
}
#myGrid {
    width: 68vw;
    height: 65.5vh;
    margin: 0px 0px 0px 26px;
}
a, a:active {
	color: inherit;
	text-decoration: none;
}
.table th {
	font-size: 13px;
}
.insertModal-bg, .detailModal-bg {
	position: fixed;
	top:0;
	right:0;
	bottom:0;
	left:0px;
	width:100%;
	height:100%;
	overflow:hidden;
	background:rgba(35,52,70,0.5);
	z-index:1100;
	display:none;
}
.insertModal-wrap, .detailModal-wrap {
	position:absolute; 
	top:6vw; 
	left:34.5vw; 
	width:32vw; 
	height:67vh; 
	border-radius:10px; 
	background-color:white; 
	display:none; 
	z-index:1101;
}
.insertModal-header, .detailModal-header {
	display:flex;
	justify-content:space-between;
}
.insertModal-title, .detailModal-title {
	margin: 25px 0px 0px 20px;
	font-weight:500;
}
#insertCloseBtn, #detailCloseBtn {
	margin: 20px 20px 0px 0px;
}
.insertModal-body, .detailModal-body {
	overflow: hidden;
	margin: 30px -0px 5px 36px;
}
.detailModal-body-keyInfo {
	text-align:center;
	display:flex;
}
.mb-3 {
	display:flex;
	margin-bottom:1.5rem!important;
}
.col-form-label {
	font-size:.75rem;
	width:65px;
}
.short-odd {
	width: 9.8vw!important;
	margin-right: 27px;
}
.short-even {
	width: 9.8vw!important;
}
.odd {
	width: 7vw!important;
	margin-right:27px;
}
.even {
	width:7vw!important;
}
.long {
	width:24.8vw!important;
}
#insertZipSch, #detailZipSch, #iEmailChkBtn, #dEmailChkBtn {
	width: 4.9vw;
	font-size: 12px;
	padding-top: 5px;
}
#insertBtns, #detailBtns, #updateBtns {
	 display:flex;
	 justify-content:space-around;
	 padding:0px 15px 0px 15px;
}
#insertBtn, #icancelBtn, #modifyBtn, #closeBtn, #saveBtn, #dcancelBtn {
	width:13vw!important;
	height:5vh;
	font-size:15px;
	padding-top:13px;
	margin-bottom:8px;
	text-align:center;
}
#empPicture {
/* 	width:107px; */
/* 	height:136px; */
/* 	border:2px solid blue; */
	margin-top:7px;
}
#empPicture img {
	width: 107px;
	height: 136px;
	object-fit: cover;
}
#autoCompleteBtn {
	width: 66px;
    height: 25px;
    margin: 21px 0px 0px -383px;
}
</style>
</head>
<body>

<!--------------------------- 직원등록 모달 시작 --------------------------->
<form id="insertForm" action="/emp/register" method="post" enctype="multipart/form-data">
	<div class="insertModal-bg">
		<div class="insertModal-wrap">
			<div class="insertModal-header">
				<h5 class="insertModal-title">직원 등록</h5>
				<button type="button" id="autoCompleteBtn" class="btn btn-xs btn-dark">자동완성</button>
				<button type="button" class="btn-close" id="insertCloseBtn" onclick="insertClose()"></button>
			</div>
			<div class="insertModal-body">
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">이름</label>
					<input class="form-control form-control-sm short-odd" type="text" name="empNm" id="html5-text-input" style="margin-right:31px;">
					<label for="html5-text-input" class="col-md-2 col-form-label">부서</label>
					<select id="insertSelect" class="form-select form-select-sm short-even" name="deptCode" required>
						<option value="D001">진료과</option>
						<option value="D002">간호과</option>
						<option value="D003">원무과</option>
						<option value="D004">물리치료과</option>
						<option value="D005">영상의학과</option>
						<option value="D006">인사총무과</option>
					</select>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">입사일자</label>
					<input class="form-control form-control-sm short-odd" type="text" name="empEncpn" oninput="hyphenDate(this)"
						maxlength="10" placeholder="20230301" id="html5-text-input" required>
					<label for="html5-date-input" class="col-md-2 col-form-label">생년월일</label>
					<input class="form-control form-control-sm short-even" type="text" name="empBrthdy" oninput="hyphenDate(this)"
						maxlength="10" placeholder="20000101" id="html5-date-input">
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">연락처</label>
					<input class="form-control form-control-sm long" type="text" name="empTelno" oninput="hypenTel(this)"
						maxlength="13" placeholder="01012345678" id="html5-text-input" required>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">이메일</label>
					<input class="form-control form-control-sm long" type="email" name="empEmail" placeholder="jinryoemr@ddit.or.kr" id="html5-text-input" required>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">우편번호</label>
					<input class="form-control form-control-sm" type="text" name="empZip" id="html5-text-input"
						style="margin-right:1px; width:19.8vw;" readonly required>
					<button type="button" class="btn btn-info" id="insertZipSch" onclick="zipSearch()">검색</button>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">기본주소</label>
					<input class="form-control form-control-sm long" type="text" name="empAddr" id="html5-text-input" readonly required>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">상세주소</label>
					<input class="form-control form-control-sm long" type="text" name="empDtlAddr" id="html5-text-input">
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">직원사진</label>
					<input class="form-control form-control-sm long" type="file" id="formFile" name="files" onchange="fileCheck(this)" accept="image/png, image/jpg, image/jpeg" required/>
				</div>
			</div>
			<div class="insertModal-footer" id="insertBtns">
				<button type="submit" class="btn btn-primary d-grid" id="insertBtn">등록</button>
				<button type="button" class="btn btn-outline-secondary d-grid" id="icancelBtn" onclick="insertClose()">취소</button>
			</div>
		</div>
	</div>
</form>
<!----------------------------- 직원등록 모달 끝 ----------------------------->


<!--------------------------- 상세조회 모달 시작 --------------------------->
<form id="detailForm" action="/emp/modify" method="post" enctype="multipart/form-data">
<div class="detailModal-bg">
	<div class="detailModal-wrap">
		<div class="detailModal-header">
			<h5 class="detailModal-title">직원 상세 조회</h5>
			<button type="button" class="btn-close" id="detailCloseBtn" onclick="detailClose()"></button>
		</div>
		<div class="detailModal-body">
			<div class="detailModal-body-keyInfo">
				<div id="empPicture"></div>
				<div style="margin-left:11px;">
					<div class="mb-3 row" style="display:flex;">
						<label for="html5-text-input" class="col-md-2 col-form-label">사번</label>
						<input class="form-control form-control-sm odd" type="text" name="empNo" id="html5-text-input" readonly>
						<label for="html5-text-input" class="col-md-2 col-form-label">부서</label>
						<select id="detailSelect" class="form-select form-select-sm even" name="deptCode" disabled>
							<option value="D001">진료과</option>
							<option value="D002">간호과</option>
							<option value="D003">원무과</option>
							<option value="D004">물리치료과</option>
							<option value="D005">영상의학과</option>
							<option value="D006">인사총무과</option>
						</select>
					</div>
					<div class="mb-3 row" style="display:flex;">
						<label for="html5-text-input" class="col-md-2 col-form-label">이름</label>
						<input class="form-control form-control-sm odd" type="text" name="empNm" id="html5-text-input" required>
						<label for="html5-date-input" class="col-md-2 col-form-label">생년월일</label>
						<input class="form-control form-control-sm even" type="text" name="empBrthdy"
							oninput="hyphenDate(this)" maxlength="10" id="html5-date-input" required>
					</div>
					<div class="mb-3 row" style="display:flex;">
						<label for="html5-text-input" class="col-md-2 col-form-label">입사일자</label>
						<input class="form-control form-control-sm odd" type="text" name="empEncpn" oninput="hyphenDate(this)"
							maxlength="10" id="html5-text-input" required>
						<label for="html5-text-input" class="col-md-2 col-form-label">퇴사일자</label>
						<input class="form-control form-control-sm even" type="text" name="empRtcpn" oninput="hyphenDate(this)"
							maxlength="10" placeholder="20230901" id="html5-text-input">
					</div>
				</div>
			</div>
			<div class="detailModal-body-info">
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">연락처</label>
					<input class="form-control form-control-sm long" type="text" name="empTelno" maxlength="13" oninput="hypenTel(this)" id="html5-text-input" required>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">이메일</label>
					<input class="form-control form-control-sm long" type="email" name="empEmail" id="html5-text-input" equired>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">우편번호</label>
					<input class="form-control form-control-sm" type="text" name="empZip" id="html5-text-input"
						style="margin-right:1px; width:19.8vw;" readonly required>
					<button type="button" class="btn btn-info" id="detailZipSch" onclick="zipSearch()">검색</button>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label">기본주소</label>
					<input class="form-control form-control-sm long" type="text" name="empAddr" id="html5-text-input" readonly required>
				</div>
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label" style="font-size:.75rem;">상세주소</label>
					<input class="form-control form-control-sm long" type="text" name="empDtlAddr" id="html5-text-input">
				</div>
			</div>
		</div>
		<div class="detailModal-footer" id="detailBtns">
			<button type="button" class="btn btn-primary d-grid" id="modifyBtn">수정</button>
			<button type="button" class="btn btn-secondary d-grid" id="closeBtn" onclick="detailClose()">닫기</button>
		</div>
		<div class="detailModal-footer" id="updateBtns">
			<button type="submit" class="btn btn-primary d-grid" id="saveBtn">저장</button>
			<button type="button" class="btn btn-secondary d-grid" id="dcancelBtn">취소</button>
		</div>
	</div>
</div>
</form>
<!----------------------------- 상세조회 모달 끝 ----------------------------->



<!--------------------------- 전체 직원 조회 테이블--------------------------->
<div class="card" style="width:70vw; height:79vh; margin:27px 0px 0px 265px">
	<div id="wrapper">
		<div style="display:flex; width:81.6vw; margin:0px 0px 25px 0px;">
			<h4 class="card-header" id="cardTitle" style="margin: 17px 0px 0px 5px; font-weight:bolder">직원 조회</h4>
			
			<button type="button" class="btn btn-info" onclick="insertEmp()" style="width:3.3vw; height:4vh; margin-top:35px;">
				<img src="/resources/images/userplus.png"></button>
			<div class="input-group input-group-merge" id="empSearch" style="width:12vw;; height:4vh; margin:35px 800px 0px 10px;">
				<span class="input-group-text" id="basic-addon-search31" style="width: 2vw; height: 4vh;">
					<i class="bx bx-search"></i></span>
				<input type="text" class="form-control" placeholder=" 전체 검색" id="searchInput" style="height:4vh; width:5vw;"
					aria-label="Search..." aria-describedby="basic-addon-search31" oninput="onQuickFilterChanged()">
        	</div>
			<button type="button" class="btn btn-icon btn-secondary" onclick="fExp()"
				style="width:4.6vw; height:4vh; margin:35px 0px 0px -25px; font-size:12px; font-weight:bold; color:#eeeeee;">
				<img src="/resources/images/export.png" style="width:20px;">&nbsp;내보내기</button>
	    </div>
		<div id="myGrid" class="ag-theme-material"></div>
	</div>
</div>
<!--------------------------- 전체 직원 조회 테이블 끝 --------------------------->

</body>
<script>

//-------------------- 웹소켓 ----------------------
function fMessage() { // 받는 쪽에 작성
	let serverMsg = JSON.parse(event.data);

	if(serverMsg.cmd == "alarm") {
		getNotiList();
	}
}
//-------------------- /웹소켓 ----------------------

$(function() {
	
	// 이메일 정규 표현식
	let regex = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");
	
	// 이메일 유효성 검사
	function validateEmail(email) {
		return regex.test(email);
	}
	
	if("${param.result}" == "1") {
    	Swal.fire({
    		icon: 'error',
    		title: '세션 만료',
    		text: '재로그인 해주세요.'
   		}).then((result) => {
   			location.href = "/emp/login";
   		});
	}
	
	if("${param.result}" == "2") {
		Swal.fire({
			icon: 'success',
			title: '직원 등록 완료',
			text: '입력하신 이메일로 사번과 임시비밀번호가 전송되었습니다.'
		});
	}
	
	if("${param.result}" == "3") {
		Swal.fire({
			icon: 'success',
			title: '직원 수정 완료'
		});
	}
});
	
	// 자동완성 기능
	$('#autoCompleteBtn').on('click', function() {
		$('input[name=empNm]').val("이철희");
		$('input[name=deptCode]').val("D004");
		$('input[name=empEncpn]').val("2023-10-17");
		$('input[name=empBrthdy]').val("1992-05-06");
		$('input[name=empTelno]').val("010-4024-0240");
		$('input[name=empEmail]').val("dun05139@gmail.com");
		$('input[name=empZip]').val("40240");
		$('input[name=empAddr]').val("경북 울릉군 울릉읍 독도이사부길 55");
		$('input[name=empDtlAddr]').val("뱃길따라 200리");
	});
	
	// 직원 등록 모달
	function insertEmp() {
		$('.insertModal-wrap').show();
		$('.insertModal-bg').show();
		
		$('.insertModal-body input').val("");
	}

	// 직원 등록 
	// 직원 상세조회 모달
	function detailEmp(empId) {

		$('.detailModal-body input').val("");
		
		// 모달 출력
		$('.detailModal-wrap').show();
	    $('.detailModal-bg').show();

		// 모달 버튼 교체
		$(updateBtns).hide();
		$(detailBtns).show();

		// readonly 처리
		$(".detailModal-body input").attr("readonly", "true");
		
		// 우편번호 검색 버튼 안보이게
		$('.detailModal-body input[name=empZip]').css("width", "24.8vw");
		$('#detailZipSch').css("display", "none");
		
		// 이메일 중복검사 버튼 안보이게
		$('.detailModal-body input[name=empEmail]').css("width", "24.8vw");
		$('#dEmailChkBtn').css("display", "none");
		
		// 퇴사일자 placeholder 처리
		let empRtcpn = $('.detailModal-body input[name=empRtcpn]').val();
		console.log("empRtcpn: " + empRtcpn);
		if(empRtcpn == "" || empRtcpn == null) {
			$('.detailModal-body input[name=empRtcpn]').attr("placeholder", "-");
		}
		
		// 데이터 받아오기
		let xhr = new XMLHttpRequest();
		xhr.open("get", "/employee/" + empId, true);
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				let result = JSON.parse(xhr.responseText);
				console.log("직원상세 result : " + JSON.stringify(result));
		
				// input value 세팅
				$('.detailModal-body input[name=empNo]').val(result.empNo);
				$('.detailModal-body input[name=empNm]').val(result.empNm);	
				$('#detailSelect').val(result.deptCode).prop("selected", true);
				$('.detailModal-body input[name=empBrthdy]').val(result.empBrthdy);
				$('.detailModal-body input[name=empTelno]').val(result.empTelno);
				$('.detailModal-body input[name=empEmail]').val(result.empEmail);
				$('.detailModal-body input[name=empZip]').val(result.empZip);
				$('.detailModal-body input[name=empAddr]').val(result.empAddr);
				$('.detailModal-body input[name=empDtlAddr]').val(result.empDtlAddr);
				$('.detailModal-body input[name=empEncpn]').val(result.empEncpn);
				if(result.empRtcpn != null) {
					$('.detailModal-body input[name=empRtcpn]').val(result.empRtcpn);
				}
				if(!result.fileList[0]) {
					$('#empPicture').html("<img src=/resources/images/defaultUser.png />")
				} else {
					$('#empPicture').html("<img src='/resources/upload" + result.fileList[0].fileWebPath +"' />");
				}
			}
		}
		xhr.send();
	}

	
    // 직원 상세조회 모달 닫기
	function detailClose() {
		$('.detailModal-wrap').hide();
		$('.detailModal-bg').hide();
	}
    
    // 직원등록 모달 닫기
    function insertClose() {
		Swal.fire({
			  title: '직원 등록을 취소하시겠습니까?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
		}).then((result) => {
	    	$('.insertModal-wrap').hide();
	    	$('.insertModal-bg').hide();
		});
    }
    
    /*
    // 외부영역 클릭 시 모달 닫기
	$(document).mouseup(function (e){
		if($('.detailModal-wrap').has(e.target).length === 0){
			detailClose();
		}
	});
	
	// ESC 키 클릭시 모달 닫기
	$(document).keydown(function(e){
		// keyCode 구 브라우저, which 현재 브라우저
	    var code = e.keyCode || e.which;
	    if (code == 27) { // 27 = ESC 키번호
	    	detailClose();
	    }
	});
	*/
	
	// 수정 버튼 이벤트
	$("#modifyBtn").on("click", function() {
		console.log("수정버튼 클릭");
		
		// 조회 시 버튼 가리고 수정 시 버튼 출력
		$(updateBtns).show();
		$(detailBtns).hide();
		
		// 수정할 요소 readonly 제거
		$('.detailModal-body input[name=empTelno]').removeAttr("readonly");
		$('.detailModal-body input[name=empEmail]').removeAttr("readonly");
		$('.detailModal-body input[name=empDtlAddr]').removeAttr("readonly");
		$('.detailModal-body input[name=empRtcpn]').removeAttr("readonly");
		
		// 우편번호 검색 버튼 나타나게
		$('.detailModal-body input[name=empZip]').css({"width":"19.8vw", "margin-right":"1px"});
		$('#detailZipSch').show();
		
		// 이메일 중복검사 버튼 나타나게
		$('.detailModal-body input[name=empEmail]').css({"width":"19.8vw", "margin-right":"1px"});
		$('#dEmailChkBtn').show();
		
		// 퇴사일자 placeholder 처리
		let empRtcpn = $('.detailModal-body input[name=empRtcpn]').val();
		console.log("empRtcpn: " + empRtcpn);
		if(empRtcpn == "" || empRtcpn == null) {
			$('.detailModal-body input[name=empRtcpn]').attr("placeholder", "20230901");
		}
		
	});
	
	// 취소버튼 이벤트
	$('#dcancelBtn').on("click", function() {
		console.log("취소버튼 클릭");
		Swal.fire({
			  title: '직원 수정을 취소하시겠습니까?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
		}).then((result) => {
			let empNo = $('.detailModal-body input[name=empNo]').val();
			detailEmp(empNo);
		});
	});
	
	// 직원 등록 시 파일이 이미지타입인지 검사
	const fileCheck = (obj) => {
		pathPoint = obj.value.lastIndexOf(".");
		filePoint = obj.value.substring(pathPoint + 1, obj.length);
		fileType = filePoint.toLowerCase();
		if(fileType == 'jpg' || fileType == 'jpeg' || fileType == 'png') {
			// 정상적인 파일인 경우
		} else {
	    	Swal.fire({
	    		icon: 'error',
	    		title: '이미지 파일을 선택해주세요.',
	    		text: 'jpg/jpeg/png 파일만 등록할 수 있습니다.'
	   		});
	    	parentObj = obj.parentNode;
	    	node = parentObj.replaceChild(obj.cloneNode(true), obj);
	    	return false;
		}
	}
	
	// 우편번호 검색 API - insert 시
	function zipSearch() {
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete: function (data) {
				$('input[name="empZip"]').val(data.zonecode);
				$('input[name="empAddr"]').val(data.address);
				$('input[name="empDtlAddr"]').val(data.buildingName);
			}
		}).open();
	}
	
	/*
	// 휴대폰번호 자동 하이픈 추가 - header랑 겹침
	const hypenTel = (target) => {
		target.value = target.value
			.replace(/[^0-9]/g, '')
			.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	}
	*/
	
	// 날짜 자동 하이픈 추가
	const hyphenDate = (target) => {
	  target.value = target.value
	    .replace(/[^0-9]/g, '') // 숫자와 하이픈(-)만 허용
	    .replace(/^(\d{4})(\d{1,2})(\d{2})$/, `$1-$2-$3`); // 년-월-일 형식으로 변경
	};

	// agGrid 첫번째 행의 헤더 이름들 설정
	const columnDefs = [
	    { field: "empno", headerName: "사번", sortable: true},
	    { field: "dept", headerName: "부서", sortable: true},
	    { field: "name",  headerName: "이름", sortable: true},
	    { field: "phone", headerName: "연락처", sortable: true},
	    { field: "email", headerName: "이메일", sortable: true},
	    { field: "enterDate", headerName: "입사일자", sortable: true},
	    { field: "resignDate",  headerName: "퇴사일자", sortable: true},
	];
	
	// 테이블에 들어올 데이터. 초기값으로 빈 데이터 설정(설정 안하면 로딩중 메시지 출력됨)
	const rowData = [];
	
	// agGrid 설정 옵션: 중요! 위에 정의한 것들이 여기서 통합됨
	const gridOptions = {
	    columnDefs: columnDefs,
	    rowData: rowData,
	    defaultColDef: {
	        flex:1, // 자동으로 같은 사이즈로
	        filter:true,
	        resizable:true,
	        minWidth:100,
// 	        headerClass: "centered"
			headerClass: "left"
	    },
	    // 페이지 설정
	    pagination:true,
	    paginationAutoPageSize:true, // 페이지 사이즈를 자동으로 맞춰줌
	    //paginationPageSize:5,    // 같이 설정하니 위에 꺼 우선순위
// 	    onCellClicked: params => {
// 	    	console.log("클릭한 cell: ", params);
// 	    },
	    onRowClicked: params => {
	    	console.log("클릭한 row의 사원번호: ", params.data.empno);
	    	detailEmp(params.data.empno);
	    },
// 	    getRowStyle: params => {
// 	    	console.log("resignDate: " + params.data.resignDate);
// 	        if (params.data.resignDate == null || params.data.resignDate == "") {
// 	        	return { background: '#fff' };
// 	        } else {
// 	            return { background: 'red' };
// 	        }
// 	    },
    }
	
	// agGrid에 세팅할 데이터 가져오기
	function getData(){
		let xhr = new XMLHttpRequest();
		xhr.open("get","/employee/list", true);
		xhr.onreadystatechange = function() {
			
			 rowData.length = 0;
			 gridOptions.api.setRowData(rowData);
			 
		     if(xhr.readyState == 4 && xhr.status == 200) {
				let result = JSON.parse(xhr.responseText);
				console.log("result", result);
				
				for(let i=0; i< result.length; i++) {
					
					let item = {
						empno : result[i].empNo,
						dept : result[i].comCodeName,
						name : result[i].empNm,
						phone : result[i].empTelno,
						email : result[i].empEmail,
						enterDate : result[i].empEncpn,
						resignDate : result[i].empRtcpn
					}
					rowData.push(item);
// 					console.log("rowData", rowData);
				}
				
				// 아작스로 가져온 row데이터를 agGrid에 세팅하는 api
				gridOptions.api.setRowData(rowData);
			}
		}
		xhr.send();
	}
	
	// excel 내보내기, 별로 안 중요, 그냥 이대로 설정하고 값만 고치면 됨
	function fExp(){
		var v_params = {
			fileName: "㈜아작(나)스병원_직원목록"
		}
		gridOptions.api.exportDataAsCsv(v_params);
	}

	// 그리드 셋업
	document.addEventListener('DOMContentLoaded', () => {
		const gridDiv = document.querySelector('#myGrid');
		new agGrid.Grid(gridDiv, gridOptions);
		getData();  // 데이터 불러오깅
	}); 

	// 검색 기능
	function onQuickFilterChanged() {
		gridOptions.api.setQuickFilter(document.getElementById('searchInput').value);
	}
	
	// ------------------------------------- AGGRID 세팅 -------------------------------------
	function MyComp() {
		return this;
	}

	// AG-GRID 문서에 나오는 커스텀 Cell Renderer
	MyComp.prototype.init = function(params) {
		this.eGui = document.createElement('div');
		this.eGui.innerHTML = 
			`
			<input type="date" value="" class="myCal" style="border:0px;width:0px"> 
			<span class="mySpan">${params.value}</span>
			`;
	        
		this.myCal = this.eGui.querySelector('.myCal')
		this.mySpan = this.eGui.querySelector('.mySpan')
		this.mySpan.onclick = () => {
			this.myCal.showPicker();
		}
		this.myCal.onchange = ()=> {
			console.log("check",this.myCal.value);
			this.mySpan.innerHTML = this.myCal.value;
		}
	}
	
	MyComp.prototype.getGui=function(){
		console.log("check1");
		return this.eGui;
	}

	MyComp.prototype.refresh=function(){
		console.log("check2");
		return true;
	}
	
	MyComp.prototype.destroy=function(){
		console.log("check3");
	} 
	
</script>
</html>