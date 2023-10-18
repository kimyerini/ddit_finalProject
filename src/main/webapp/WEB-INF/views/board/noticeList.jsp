<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal.employee" var="empVO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/js/jquery-3.6.0.js"></script>
<title>Insert title here</title>
<style>
.card {
	width: 70vw;
	height:79vh;
	margin: 27px 0px 0px 265px;
}
#noticeHeader {
	display:flex;
	width:81.6vw;
	margin: 9px 913px 0px 5px;
}
#noticeHeader p {
	font-size: 13px;
}
.card-header {
	margin: 17px 914px 0px 5px;
	font-weight:bolder;
}
#searchCtgr {
    width: 4vw;
    height: 4vh;
    margin-top: 35px;
}
#noticeSearch {
	width: 10vw;
    height: 5.5vh;
    margin-top: 35px;
    margin-left: 5px;
}
.table-hover {
    margin-left: 18px;
    width: 68vw;
}
.text-nowrap {
	height: 53vh;
}
.text-nowrap table td, th{
	font-size: 13px;
}
#writeBtn {
	width: 4vw;
    height: 3.5vh;
    padding: 3px 0px 0px 0px!important;
    margin: 18px 0px -2px 1240px;
}
a, a:active {
	color: inherit;
	text-decoration: none;
}
.noticeSearchSpan {
	width: 2vw;
	height: 4vh;
}
#searchInput {
	height: 4vh;
}
#noticeFooter {
	display: flex;
	justify-content: center;
}

</style>
</head>
<body>
	<div class="card">
		<div id="wrapper">
			<!-- notice header 시작 -->
			<form name="searchForm" id="searchForm">
				<input type="hidden" name="category" value="제목" />
				<div id="noticeHeader">
					<div>
						<h4 class="card-header">공지사항</h4>
						<p style="margin:13px 0px 13px 25px;">🔔 총 ${noticeCount}개의 게시글이 있습니다.</p>
					</div>
					<div class="btn-group">
						<button type="button" id="searchCtgr" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"></button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item searchCtgr" id="seachCtgr1" href="javascript:void(0);">제목</a></li>
							<li><a class="dropdown-item searchCtgr" id="seachCtgr2" href="javascript:void(0);">작성자</a></li>
							<li><a class="dropdown-item searchCtgr" id="seachCtgr3" href="javascript:void(0);">내용</a></li>
						</ul>
					</div>
					<div class="input-group input-group-merge" id="noticeSearch">
						<span class="input-group-text noticeSearchSpan" id="basic-addon-search31">
							<i class="bx bx-search"></i></span>
						<input type="text" class="form-control" name="keyword" value="${param.keyword}" 
							placeholder="검색" id="searchInput" aria-label="Search..." aria-describedby="basic-addon-search31">
					</div>
				</div><!-- notice header 끝 -->
			</form>
			
			<!-- 테이블 처리 -->
			<div class="table-responsive text-nowrap">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>No</th>
							<th>제목</th>
							<th>첨부</th>
							<th>등록일자</th>
							<th>작성자</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<!-- list : List<NoticeBoardVO> -->
	            		<c:forEach var="noticeVO" items="${data.content}" varStatus="stat">
	            			<tr>
			            		<td>${noticeVO.rnum2}</td>
			            		<td><a href='/board/detail/${noticeVO.ntbdCode}'>
			            			<span class="badge bg-label-secondary">${noticeVO.deptName}</span>&nbsp;${noticeVO.ntbdSubject}</a>
			            		</td>
				            	<td>
			            			<c:set var="imageCnt" value="0" />
				            		<c:if test="${fn:length(noticeVO.fileList)>0}">
				            			<c:forEach var="attachFileVO" items="${noticeVO.fileList}">						            		
					            			<c:if test="${not fn:contains(attachFileVO.fileContType,'image')}">
					            				<c:set var="imageCnt" value="1" />
					            			</c:if>					            			
					            		</c:forEach>
				            		</c:if>
				            		<c:if test="${imageCnt>0}">	
				            			<img src="/resources/images/file_clip.png" style="width:15px; margin-left:4px;">
				            		</c:if>
				            	</td>
			            		<td>${noticeVO.ntbdRegDate}</td>
			            		<td>${noticeVO.empName}</td>
			            		<td>${noticeVO.ntbdHit}</td>
	            			</tr>
	            		</c:forEach>
	            		<c:if test="${data.hasNoArticles()}">
	            			<tr>
								<td colspan="6" style="text-align:center; font-size:15px; font-weight:500;">
									<br><br><br><br><br><br>
									조회할 게시글이 없습니다.
									<br><br><br><br><br><br>
									<br><br><br><br><br><br>
								</td>
							</tr>
	            		</c:if>
					</tbody>
				</table>
			</div><!-- table div 끝 -->
			
			<c:if test="${empVO.deptCode == 'D006' || empVO.deptCode == 'D003' || empVO.deptCode == 'D000'}">
				<button type="button" class="btn btn-info" id="writeBtn" onclick="location.href='/board/write'">등록</button>
			</c:if>

			<c:if test="${param.currentPage==null}">
				<c:set var="currentPage" value="1" />
			</c:if>
			<c:if test="${param.currentPage!=null}">
				<c:set var="currentPage" value="${param.currentPage}" />
			</c:if>

			<!-- 페이징 처리 -->
			<div id="noticeFooter">
				<c:if test="${data.hasArticles()}">
					<nav aria-label="Page navigation">
						<ul class="pagination" style="justify-content:center;">
							<li class="page-item prev <c:if test='${data.startPage lt 6}'>disabled</c:if>">
							<a class="page-link" href="/board/notice?currentPage=${currentPage-5}&size=${data.size}">
								<i class="tf-icon bx bx-chevrons-left"></i></a>
							</li>
							
							<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
								<li class='page-item <c:if test="${currentPage eq pNo}">active</c:if>'>
									<a class="page-link" href="/board/notice?currentPage=${pNo}&size=${data.size}&keyword=${param.keyword}">${pNo}</a>
								</li>
							</c:forEach>
							
							<li class='page-item next <c:if test="${data.endPage ge data.totalPages}">disabled</c:if>'>
							<a class="page-link" href="/board/notice?currentPage=${data.startPage+5}&size=${data.size}">
								<i class="tf-icon bx bx-chevrons-right"></i></a>
							</li>
						</ul>
					</nav>
				</c:if>
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
}
//-------------------- /웹소켓 ----------------------

$(function(){
	
	// 기본값을 제목으로
	$('#searchCtgr').text("제목");
	$('#searchCtgr').on('click', function() {
		// 현재 선택된 버튼값
	    let nowText = $('#searchCtgr').text();
		    
		// 드롭다운 메뉴의 모든 값 표시
	    $('.dropdown-menu li').show(); 
	    
		// 현재 선택된 버튼값과 같은 li 숨김
	    $('.dropdown-menu li:contains(' + nowText + ')').hide(); 
	});
	
	// 드롭다운 메뉴 선택 시 변경
	var oldBtnVal = "";
	$('.dropdown-menu').on('click', '.searchCtgr', function () {
		// 선택한 드롭다운 메뉴
	    let newBtnVal = $(this).text();

	 	// 버튼값 업데이트
	    $('#searchCtgr').text(newBtnVal); 

	 	$("input[name='category']").val(newBtnVal);
	 	
		// 이전 버튼값을 다시 드롭다운 메뉴에 추가
	    if (oldBtnVal !== "") {
	        $('.dropdown-menu').append(oldBtnVal);
	    }

	    // 클릭된 항목의 부모인 <li> 태그를 삭제
	    oldBtnVal = $(this).parent();
	    oldBtnVal.remove();
	});
	
	// 검색 시 엔터 클릭 이벤트 
	$('#searchInput').keyup(function(event) {
		if (event.keyCode === 13) {
			event.preventDefault();
			$("#searchForm").submit();
		}
	});
    
	// 검색 후 드롭다운 유지 처리
	let category = "${param.category}";
	console.log("category : " + category);
	if(category!=null) {
		if(category=="작성자") {
			$("#searchCtgr").text("작성자");
			$("input[name='category']").val("작성자");
		} else if(category=="내용") {
			$("#searchCtgr").text("내용");
			$("input[name='category']").val("내용");
		} else{
			$("#searchCtgr").text("제목");
			$("input[name='category']").val("제목");
		}
	}
	
	if ("${param.result}" == "1") {
// 		alert("소켓에 메세지 보냈음");

		Swal.fire({
			icon: 'success',
			title: '공지사항이 등록되었습니다.'
		});
		
		let msg = {
			to : "all",
			from : "경민",
			cmd : "alarm",
			data : "새로운 공지사항이 등록되었습다."
		}
		webSocket.send(JSON.stringify(msg));
	}
});
</script>
</html>