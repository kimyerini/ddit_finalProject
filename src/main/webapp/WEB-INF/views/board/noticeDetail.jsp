<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<sec:authentication property="principal.employee" var="empVO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Insert title here</title>
<style>
.card {
	width: 70vw;
	height:79vh;
	margin:27px 0px 0px 265px
}
.noticeHeader {
	display: flex;
	width: 81.6vw;
	margin: 10px 0px 0px 0px;
}
.card-header {
	font-weight:bolder;
	margin: 3px 0px 10px 5px;
}
a, a:active {
	color: inherit;
	text-decoration: none;
}
.noticeBody {
	width: 81vw;
	margin: -5px 0px 22px 20px;	
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
	width: 21.8vw!important;
}
#noticeBody textarea {
	width: 75.2vw;
}
.noticeFooter {
	display: flex;
	justify-content: end;
	margin: 0px 18px 0px 0px;
}
#insertBtn {
	width: 4vw;
	height: 4vh;
}
#deleteBtn, #closeBtn {
	width: 4vw;
	height: 4vh;
	margin-left: 15px;
}
.table {
    margin-left: -2px;
    width: 68vw;
}
.text-nowrap {
	width: 69vw;
	height: 61vh;
	overflow:auto;
}

</style>
</head>
<body>
	<div class="card">
		<div id="wrapper">
			<div class="noticeHeader">
				<h4 class="card-header">공지사항 조회</h4>
			</div><!-- notice header 끝 -->
	
			<div class="noticeBody">
				<div class="table-responsive text-nowrap">
					<input type="hidden" name="ntbdCode" value="${noticeBoardVO.ntbdCode}">
					<table class="table table">
						<thead>
						</thead>
						<tbody class="table-border-bottom-0">
							<tr class="table-default">
								<td colspan="3">
									<span class="badge bg-label-secondary">${noticeBoardVO.deptName}</span>
									&nbsp;${noticeBoardVO.ntbdSubject}
								</td>
							</tr>
							<tr style="text-align:left;">
								<td style="width:10%;">작성자  |  ${noticeBoardVO.empName}</td>
								<td style="width:10%;">조회수  |  ${noticeBoardVO.ntbdHit}</td>
								<td>작성일  |  ${noticeBoardVO.ntbdRegDate}</td>
							</tr>
							<c:if test="${fn:length(noticeBoardVO.fileList) > 0}">
								<c:set var="imageCnt" value="0" />
								<c:forEach var="attachFileVO" items="${noticeBoardVO.fileList}">
									<c:if test="${not fn:contains(attachFileVO.fileContType, 'image')}">
										<c:set var="imageCnt" value="1" />
									</c:if>
								</c:forEach>
								
								<c:if test="${imageCnt > 0}">
		            				<tr>
										<td colspan="1" style="text-align:left;">첨부파일</td>
										<td colspan="2" style="text-align:left;">
					            			<c:forEach var="attachFileVO" items="${noticeBoardVO.fileList}">
						            			<c:if test="${not fn:contains(attachFileVO.fileContType,'image')}">
						            				<c:set var="imageCnt" value="1" />
<%-- 														<a href="/download?fileName=${attachFileVO.fileWebPath}">${attachFileVO.fileName}<br></a> --%>
														<a href="/resources/upload${attachFileVO.fileWebPath}" download="${attachFileVO.fileName}">
															<img src="/resources/images/file_clip.png" style="width:15px; margin-left:4px;">
															&nbsp;${attachFileVO.fileName}<br>
														</a>
						            			</c:if>				            			
						            		</c:forEach>
										</td>
									</tr>
								</c:if>
							</c:if>
							<tr>
								<td colspan="3" style="text-align:left;">
									<!-- 이미지가 있으면 출력 -->
									<c:set var="imageCnt" value="0" />
			            			<c:forEach var="attachFileVO" items="${noticeBoardVO.fileList}">						            		
				            			<c:if test="${fn:contains(attachFileVO.fileContType,'image')}">
					            			<div><img style="width:40vw;margin:10px 0;" src="/resources/upload${attachFileVO.fileWebPath}" /></div>
				            			</c:if>					            			
				            		</c:forEach>
									<!-- 글내용 -->
									${noticeBoardVO.ntbdContent}
								</td>
							</tr>							
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="noticeFooter">
				<c:if test="${empVO.empNo == noticeBoardVO.writerEmpNo}">
					<button type="button" class="btn btn-primary" id="insertBtn" onclick="location.href='/board/update/${noticeBoardVO.ntbdCode}'">수정</button>
					<button type="button" class="btn btn-info" id="deleteBtn">삭제</button>
				</c:if>
				<button type="button" class="btn btn-secondary" id="closeBtn" onclick="location.href='/board/notice'">목록</button>
			</div><!-- noticeFooter 끝 -->
			
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
	
	let ntbdCode = $('input[name=ntbdCode]').val();
	if("${param.result}" == "1") {
    	Swal.fire({
    		icon: 'success',
    		title: '정상적으로 수정되었습니다.',
   		});
	}
}
//-------------------- /웹소켓 ----------------------

// CKEDITOR 설정
CKEDITOR.replace("ntbdContent", {
	height: 280, width: 1431
});

$(function() {
	
	CKEDITOR.instances.ntbdContent.getData();
	
})
	
	$('#deleteBtn').on('click', function() {
		let ntbdCode = ${noticeBoardVO.ntbdCode};
		
		let xhr = new XMLHttpRequest();
		delUrl = `/board/delete/\${ntbdCode}`;
		xhr.open("delete", delUrl, true);
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				console.log("체크", xhr.responseText); // delete 된 행의 개수
				
				Swal.fire({
					title: '게시글을 삭제하시겠습니까?',
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인',
					cancelButtonText: '취소'
				}).then((result) => {
					Swal.fire({
						icon: 'success',
						title: '삭제 완료',
						closeOnClickOutside : false
					}).then(function() {
						window.location.href = '/board/notice';
					});
				});
			}
		}
		xhr.send();
	});
	
</script>
</html>