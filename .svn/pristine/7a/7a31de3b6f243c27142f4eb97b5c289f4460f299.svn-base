<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal.employee" var="empVO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<title>Insert title here</title>
<style>
.card {
	width: 70vw;
	height:79vh;
	margin:27px 0px 0px 265px;
}
.noticeHeader {
	display: flex;
	width: 81.6vw;
	margin: 10px 0px 0px 0px;
}
.card-header {
	font-weight:bolder;
	margin: 3px 0px -5px 5px;
}
a, a:active {
	color: inherit;
	text-decoration: none;
}
.noticeBody {
	width: 70vw;
	margin: -9px 0px 0px 8px;	
}
.flex {
	display: flex;
    justify-content: space-between;
    margin: 1.5rem;
}
.writeInput-long {
	width: 79vw!important;
}
.writeInput-short {
	width: 18.7vw!important;
}
#formFileMultiple {
	width: 94vw!important;
}
#noticeBody textarea {
	width: 75.2vw;
}
.noticeFooter {
	display: flex;
	justify-content: end;
	margin: -2px 33px 0px 0px;
}
#insertBtn {
	width: 4vw;
	height: 4vh;
}
#cancelBtn {
	width: 4vw;
	height: 4vh;
	margin-left: 15px;
}
#autoCompleteBtn {
	width: 66px;
	height: 25px;
	margin: 26px 0px 0px -10px;
}
</style>
</head>
<body>
	<div class="card">
		<div id="wrapper">
			<div class="noticeHeader">
				<h4 class="card-header">공지사항 작성</h4>
				<button type="button" id="autoCompleteBtn" class="btn btn-xs btn-dark">자동완성</button>
			</div><!-- notice header 끝 -->

			<form id="writeForm" action="/board/write" method="post" enctype="multipart/form-data">
				<div class="noticeBody">
					<div class="flex">
						<label for="smallInput" class="form-label writeLabel" style="width:61px;">제목</label>
						<input id="smallInput" class="form-control form-control-sm writeInput-long" type="text" name="ntbdSubject">
					</div>
					<div class="flex">
						<input type="hidden" name="writerEmpNo" value="${empVO.empNo}">
						<label for="smallInput" class="form-label writeLabel" style="width:37px;">작성자</label>
						<input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="empName" value="${empVO.empNm}" readonly>
						<label for="smallInput" class="form-label writeLabel">부서</label>
						<input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="deptName" value="${empVO.comCodeName}" readonly>
						<label for="smallInput" class="form-label writeLabel">작성일자</label>
						<input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="ntbdRegDate" readonly>
					</div>
					<div class="flex">
						<label for="smallInput" class="form-label writeLabel" style="width:74px;">첨부</label>
						<input id="formFileMultiple" class="form-control form-control-sm" type="file" name="files" multiple>
					</div>
					<div class="flex" style="margin-right:40px;">
						<label for="smallInput" class="form-label writeLabel" style="margin-right:10px;width:52px;">내용</label>
						<textarea class="form-control" name="ntbdContent"></textarea>
					</div>
				</div>
			
			<div class="noticeFooter" id="insertBtns">
				<button type="submit" class="btn btn-primary" id="insertBtn">등록</button>
				<button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
			</div><!-- noticeFooter 끝 -->
			</form>	
		</div><!-- wrapper 끝 -->
	</div><!-- card 끝 -->
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

$(function(){
	$('input[name=ntbdRegDate]').val(getToday());
	
});

// 자동완성 기능
$('#autoCompleteBtn').on('click', function() {
	$('input[name=ntbdSubject]').val("[학회] 허위진단서 근절 캠페인 포스터 안내");
	// CKEditor에 텍스트 설정
	CKEDITOR.instances.ntbdContent.setData("<p>[포스터 신청 안내]</p><p>* 회원 정보 :</p><p>- 성함</p>	<p>- 의사면허번호</p><p>- 소속</p><p>- 연락처</p><p>* 배송 주소 : (우편번호)</p><p>* 포스터 수량 : ( )장</p><p>위 내용을 작성하여 이메일(ortho@koa.or.kr)로 신청하시기 바랍니다.</p>");
});

function getToday() {
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

// 글쓰기 취소
$('#cancelBtn').on('click', function() {
	Swal.fire({
		  title: '공지사항 등록을 취소하시겠습니까?',
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소'
	}).then((result) => {
		 location.href='/board/notice';
	});
});

// CKEDITOR 설정
CKEDITOR.replace("ntbdContent", {
	height: 290, width: 1562
});
	
</script>
</html>