<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	width: 68vw;
	margin: -9px 0px 0px 8px;	
}
.flex {
	display: flex;
    justify-content: space-between;
    margin: 1.5rem 0px 1.5rem 22px;
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
#fileDeleteBtn {
	margin-left: -23px;
}
#noticeBody textarea {
	width: 75.2vw;
}
.noticeFooter {
	display: flex;
	margin: -4px 0px 0px 1141px;
}
#updateBtn {
	width: 4vw;
	height: 4vh;
}
#cancelBtn {
	width: 4vw;
	height: 4vh;
	margin-left: 15px;
}
.fileAlign {
	display: block;
	margin: -3px 0px 0px 0px;
}
.eachFile {
	margin-right:30px;
	width: 100%;
}
</style>
</head>
<body>
	<div class="card">
		<div id="wrapper">
			<div class="noticeHeader">
				<h4 class="card-header">공지사항 수정</h4>
			</div><!-- notice header 끝 -->

			<form id="writeForm" action="/board/update" method="post" enctype="multipart/form-data">
				<input type="hidden" name="_method" value="put"/>
				<div style="width:70vw;height:65vh;overflow:auto;">
					<div class="noticeBody">
						<div class="flex">
							<input type="hidden" name="ntbdCode" value="${noticeBoardVO.ntbdCode}">
							<label for="smallInput" class="form-label writeLabel" style="width:61px;">제목</label>
							<input id="smallInput" class="form-control form-control-sm writeInput-long" type="text" value="${noticeBoardVO.ntbdSubject}" name="ntbdSubject">
						</div>
						<div class="flex">
							<input type="hidden" name="writerEmpNo" value="${empVO.empNo}">
							<label for="smallInput" class="form-label writeLabel" style="width:37px;">작성자</label>
							<input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="empName" value="${empVO.empNm}" readonly>
							<label for="smallInput" class="form-label writeLabel">부서</label>
							<input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="deptName" value="${empVO.comCodeName}" readonly>
							<label for="smallInput" class="form-label writeLabel">작성일자</label>
							<input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="ntbdRegDate" value="${noticeBoardVO.ntbdRegDate}" readonly>
						</div>
						<div style="display:flex; margin-left:24px;">
							<label for="smallInput" class="form-label writeLabel" style="width:29px;">첨부</label>
							<div style="margin-left:18px;width:63.8vw;">
								<input type="hidden" name="chkFilesParam" id="chkFilesParam">
								<c:forEach var="fileList" items="${noticeBoardVO.fileList}">
									<div class="eachFile">
										<input class="form-check-input" type="checkbox" name="chkFileNo" value="${fileList.fileNo}" id="defaultCheck3" checked>
										&nbsp;${fileList.fileName}
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="flex" style="margin-right:40px; overflow:auto;">
							<label for="smallInput" class="form-label writeLabel" style="margin-right:10px;width:52px;">내용</label>
							<textarea class="form-control" name="ntbdContent">${noticeBoardVO.ntbdContent}</textarea>
						</div>
					</div>
				</div>
				<div class="noticeFooter" id="updateBtns">
					<button type="submit" class="btn btn-primary" id="updateBtn">등록</button>
					<button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
				</div><!-- notice Footer 끝 -->
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
	CKEDITOR.instances.ntbdContent.getData();
});

$('#updateBtn').on('click', function() {
	// 체크박스 선택된 파일만 배열에 넣기
	console.log("파일 배열에 넣을거다");
	let chkFiles = [];
	$('input:checkbox[name=chkFileNo]:not(:checked)').each(function() {
		chkFiles.push(this.value);
		console.log("push!" + chkFiles);
	});
	console.log("체크 해제된 파일들: ", chkFiles);
	$('#chkFilesParam').val(chkFiles); // input type hidden에 value set
	$('#writeForm').submit();
});

// 오늘 날짜 가져오기 (작성일자)
function getToday() {
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

//글수정 취소
$('#cancelBtn').on('click', function() {
	Swal.fire({
		  title: '공지사항 작성을 취소하시겠습니까?',
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
	height: 250, width: 1562
});
	
</script>
</html>