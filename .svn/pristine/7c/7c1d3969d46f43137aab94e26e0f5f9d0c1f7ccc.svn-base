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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>Insert title here</title>
<style>
.card {
	width: 70vw;
	height:79vh;
	margin: 27px 0px 0px 265px;
}
#orderHeader {
	display:flex;
	width:81.6vw;
	margin:0px 0px 25px 0px;
}
#orderHeader p {
	font-size: 12px;
}
.card-header {
	margin: 17px 0px 0px 5px;
	font-weight:bolder;
}
#showOrderBtn {
    width: 4vw;
    height: 4vh;
    margin-top: 35px;
}
.table-hover {
    margin-left: 18px;
    width: 68vw;
}
#chkRejectBtn {
	width: 4vw;
    height: 4vh;
    padding: 3px 0px 0px 0px!important;
    margin: 30px 0px -2px 1237px;
}
a, a:active {
	color: inherit;
	text-decoration: none;
}
.text-nowrap {
	overflow:auto;
}
#orderListTable table th, td {
	font-size: 13px;
}
.orderModal-bg, .rejectModal-bg {
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
.orderModal-wrap, .rejectModal-wrap {
	position:absolute; 
	top:6vw; 
	left:26vw; 
	width:48vw; 
	height:67vh; 
	border-radius:10px; 
	background-color:white; 
	display:none; 
	z-index:1101;
}
.orderModal-header, .rejectModal-header {
	display:flex;
	justify-content:space-between;
}
.orderModal-title, .rejectModal-title {
	margin: 25px 0px 0px 20px;
	font-weight:500;
}
#orderCloseBtn, #rejectCloseBtn {
	margin: 10px 10px 0px 0px;
}
#orderBtn, #orderCancelBtn, #rejectBtn, #rejectCancelBtn {
	width:17vw!important;
	height:5vh;
	font-size:15px;
	padding-top:13px;
	margin-bottom:8px;
	text-align:center;
}
.orderModal-body, .rejectModal-body {
	overflow: hidden;
	margin: 25px 0px 0px 28px;
}
.mb-3 {
	display:flex;
	margin-bottom:1.2rem!important;
}
.orderModal-footer, .rejectModal-footer {
	 display:flex;
	 justify-content:space-around;
	 padding:0px 15px 0px 15px;
}
#tableByCompany, #rejectTable {
	width: 45vw;
}
#tableByCompany th, #rejectTable th {
	font-size: 11px;
}
#tableByCompany td, #rejectTable td {
	font-size: 10px;
	height: 37px;
}
</style>
</head>
<body>
	
	<!--------------------------- 발주 모달 시작 --------------------------->
	<div class="orderModal-bg">
		<div class="orderModal-wrap">
			<div class="orderModal-header">
				<h5 class="orderModal-title">발주 신청 승인</h5>
				<button type="button" class="btn-close" id="orderCloseBtn" onclick="closeOrderModal()"></button>
			</div>
			<div class="orderModal-body">
				<div class="mb-3 row">
					<label for="html5-text-input" class="col-md-2 col-form-label" style="width:3vw">거래처</label>
					<select id="selectCompany" class="form-select form-select-sm short-even" name="mediItemMakr" style="width:18vw; margin-right:19px;" required>
						<option value="" selected disabled>선택</option>
					</select>
					<label for="html5-text-input" class="com-md-2 col-form-label" style="width:3vw;">발주인</label>
					<input id="smallInput" class="form-control form-control-sm" type="text" value="${empVO.empNm}" style="width:18vw;" readonly>
				</div>
				<div class="table-responsive text-nowrap" style="height:46.5vh;">
					<table class="table table-bordered" id="tableByCompany">
						<thead>
							<tr>
								<th>신청번호</th>
								<th>약품코드</th>
								<th>약품명</th>
								<th>단가</th>
								<th>수량</th>
								<th>총액</th>
								<th>신청인</th>
								<th>신청일자</th>
							</tr>
						</thead>
						<tbody>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="orderModal-footer" id="orderBtns">
				<button type="button" class="btn btn-primary d-grid" id="orderBtn">발주</button>
				<button type="button" class="btn btn-outline-secondary d-grid" id="orderCancelBtn" onclick="closeOrderModal()">취소</button>
			</div>
		</div>
	</div>
	<!----------------------------- 발주 모달 끝 ----------------------------->
	
	<!--------------------------- 반려 모달 시작 --------------------------->
	<div class="rejectModal-bg">
		<div class="rejectModal-wrap">
			<div class="rejectModal-header">
				<h5 class="rejectModal-title">발주 신청 반려</h5>
				<button type="button" class="btn-close" id="rejectCloseBtn" onclick="closeRejectModal()"></button>
			</div>
			<div class="rejectModal-body">
				<div class="table-responsive text-nowrap" style="height:53vh;">
					<table class="table table-bordered" id="rejectTable">
						<thead>
							<tr>
								<th><input class="form-check-input" type="checkbox" id="rejectSelectAll" checked></th>
								<th>신청번호</th>
								<th>약품코드</th>
								<th>약품명</th>
								<th>거래처</th>
								<th>단가</th>
								<th>수량</th>
								<th>총액</th>
								<th>신청인</th>
								<th>신청일자</th>
							</tr>
						</thead>
						<tbody>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
							<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="rejectModal-footer" id="rejectBtns">
				<button type="button" class="btn btn-primary d-grid" id="rejectBtn">반려</button>
				<button type="button" class="btn btn-outline-secondary d-grid" id="orderCancelBtn" onclick="closeRejectModal()">취소</button>
			</div>
		</div>
	</div>
	<!----------------------------- 반려 모달 끝 ----------------------------->

	<!---------------------------- 기본 화면 시작 ---------------------------->
	<div class="card">
		<div id="wrapper">
			<div id="orderHeader">
				<div>
					<div style="display:flex;">
						<h4 class="card-header">약품 신청 조회</h4>
						<button class="btn btn-primary" type="button" id="showOrderBtn" onclick="orderModal()">발주</button>
					</div>
					<p style="margin:8px 0px -10px 25px;"></p>
				</div>
			</div><!-- order header 끝 -->
			

			<!-- 테이블 처리 -->
			<div class="table-responsive text-nowrap" id="orderListTable" style="height:55vh;">
			</div><!-- table div 끝 -->
			
			<button type="button" class="btn btn-secondary" id="chkRejectBtn" onclick="showRejectModal()">반려</button>
			
		</div><!-- wrapper 끝 -->
	</div><!-- card 끝 -->
	<!---------------------------- 기본 화면 끝 ---------------------------->
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
	getMediItemList(function() {
		// mediItemTable 전체선택, 전체해제 이벤트
		$("#selectAll").on('click',function() {
			if($("#selectAll").is(":checked")) $("input[name='chkArr[]']").prop("checked", true);
			else $("input[name='chkArr[]']").prop("checked", false);
		});
		// mediItemTable에서 하나라도 체크 해제 시 전체해제 되게
		$("input[name='chkArr[]']").on('click', function() {
			var total = $("input[name='chkArr[]']").length;
			var checked = $("input[name='chkArr[]']:checked").length;
		
			if(total != checked) $("#selectAll").prop("checked", false);
			else $("#selectAll").prop("checked", true); 
		});
	});
	
});

// 약품 발주 모달 show
const orderModal = () => {
	$('.orderModal-wrap').show();
	$('.orderModal-bg').show();
	getSelectCompany();
}

// 약품 신청 조회 리스트 뿌리기
const getMediItemList = (callback) => {
// 	console.log("여기는 getMediItemList");
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/order/mediList", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
// 			console.log("받아온 약품 신청 조회 리스트", result);
			
			$('#orderHeader p').text("🔔 총 " + result.length + "개의 약품신청내역이 있습니다.");
			
			let tblStr = `<table class="table table-hover" id="mediItemTable">
						<thead>
							<tr>
								<th><input class="form-check-input" type="checkbox" id="selectAll"></th>
								<th>약품코드</th>
								<th>약품명</th>
								<th>거래처</th>
								<th>단가</th>
								<th>신청수량</th>
								<th>총액</th>
								<th>신청일자</th>
								<th>신청인</th> 
							</tr>
						</thead>
						<tbody>`;
			if (result.length == 0 || result == null) {
				tblStr += `<tr>
								<td colspan="9" style="text-align:center;">
									<br><br><br><br><br><br><br><br><br><br>
									조회할 약품 신청 내역이 없습니다
									<br><br><br><br><br><br><br><br><br><br><br>
								</td>
							</tr>`;
			} else {
				for(let i=0; i<result.length; i++) {
					tblStr += `<tr>`;
					tblStr += `<td><input class="form-check-input" type="checkbox" name="chkArr[]" id="defaultCheck3">
									<input type="hidden" id="reqNo" value="\${result[i].mediItemReqNo}">
								</td>`;
					tblStr += `<td>\${result[i].mediItemCode}</td>`;
					tblStr += `<td>\${result[i].mediItemName}</td>`;
					tblStr += `<td>\${result[i].mediItemMakr}</td>`;
					tblStr += `<td>\${result[i].mediItemPrice}</td>`;
					tblStr += `<td>\${result[i].mediItemReqQy}</td>`;
					tblStr += `<td>\${result[i].mediItemReqTotal}</td>`;
					tblStr += `<td>\${result[i].mediItemReqDe}</td>`;
					tblStr += `<td>\${result[i].empNm}</td>`;
					tblStr += `</tr>`;
				}
			}
			tblStr += `</tbody></table>`;
			
// 			console.log("tblStr" + tblStr);
			$('#orderListTable').html(tblStr);
			
			callback();
		} 
	}
	xhr.send();
}

// 발주 승인 모달 - select box의 option에 약품 신청 리스트에 있는 거래처명 append
const getSelectCompany = () => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/order/mediCompanyList", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
// 			console.log("약품목록에 있는 거래처명: ", result);
			
			// 기존의 option 요소 모두 제거
			$("#selectCompany").empty();
			
			// 기본 선택 옵션 추가
			$("#selectCompany").append('<option value="" selected disabled>선택</option>');

			for(let i=0; i<result.length; i++) {
// 				console.log(i + "번째 mediItemMakr: " + result[i].mediItemMakr);
				$("#selectCompany").append(`<option value="\${result[i].mediItemMakr}">\${result[i].mediItemMakr}</option>`);
			}
		}
	}
	xhr.send();
}

// 발주 승인 모달 - 거래처 선택 시 해당하는 약품 리스트 출력
$('#selectCompany').on('change', function() {
	let companyName = this.value;
// 	console.log("선택한 회사명: " + companyName);
	let url = "/order/mediListByCompany/" + companyName;
	let xhr = new XMLHttpRequest();
	xhr.open("get", url, true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status) {
			let result = JSON.parse(xhr.responseText);
// 			console.log("거래처에 따른 리스트: ", result);
			
			// tbody를 선택하여 변수로 저장
			let tbody = $('#tableByCompany tbody');
			// 모든 행 선택
			let rows = tbody.find('tr');
			
			for(let i=0; i<result.length; i++) {
				let row;
				
				// 기존테이블의 tr보다 result 개수가 더 많으면 tr을 추가
                if (i >= rows.length) {
                    // 새로운 행 추가
                    tbody.append('<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
                    row = tbody.find('tr').eq(i);
                } else {
                    // 기존 행 업데이트
                    row = rows.eq(i);
                }
				
				row.find('td:eq(0)').text(result[i].mediItemReqNo);
				row.find('td:eq(1)').text(result[i].mediItemCode);
				row.find('td:eq(2)').text(result[i].mediItemName);
				row.find('td:eq(3)').text(result[i].mediItemPrice);
				row.find('td:eq(4)').text(result[i].mediItemReqQy);
				row.find('td:eq(5)').text(result[i].mediItemReqTotal);
				row.find('td:eq(6)').text(result[i].empNm);
				row.find('td:eq(7)').text(result[i].mediItemReqDe);
			}
			
			// 남은 기존 행 초기화 (이전의 결과 행보다 새로운 결과 행이 더 적은 경우)
            for (let i=result.length; i<rows.length; i++) {
                let row = rows.eq(i);
                row.find('td').text("");
            }
		}
	}
	xhr.send();
});

// 발주 승인 처리
$('#orderBtn').on('click', function() {
// 	console.log("발주 승인버튼 클릭");
	let mediArray = [];
	let selectValue = $('#selectCompany').val();
	if(selectValue == null) {
		// 발주할 약품이 없는 경우
		Swal.fire({
			icon: 'error',
			title: '발주할 약품이 없습니다.',
			text: '발주할 약품을 선택 후 다시 시도해주세요.'
		});
	} else {
		Swal.fire({
			  title: '약품 발주를 승인하시겠습니까?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
		}).then((result) => {
			$('#tableByCompany tbody tr').each(function(index, element) {
				// 값이 있을 때만 vo에 저장
				if(element.children[0].innerHTML.trim() != "") {
				    let reqNo = $(element).find('td:eq(0)').text();
				    let mediCode = $(element).find('td:eq(1)').text();
					
				    let mediItemReqDetailVO = {
				    		"mediItemReqNo" : reqNo,
				    		"mediItemCode" : mediCode
				    }
// 				    console.log("승인할 mediItemReqDetailVO: " + JSON.stringify(mediItemReqDetailVO));
				    mediArray.push(mediItemReqDetailVO);
				}
			});
			
			let xhr = new XMLHttpRequest();
			xhr.open("put", "/order/approveMedi", true);
			xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
			xhr.onreadystatechange = function() {
				if(xhr.readyState == 4 && xhr.status == 200) {
					let result = xhr.responseText;
// 					console.log("승인 결과: " + result);
	
			    	Swal.fire({
			    		icon: 'success',
			    		title: '신청건이 정상적으로 승인되었습니다.'
			   		}).then((result) => { // 확인버튼 클릭 시 화면 이동
			   		    if (result.isConfirmed) {
			   		  		// 모달 숨기기
							$('.orderModal-wrap').hide();
							$('.orderModal-bg').hide();
							location.href = "/order/mediItem";
			   		    }
			   		});
				}
			}
			xhr.send(JSON.stringify(mediArray));
		});
	}
});

// 약품 반려 모달, 반려 테이블 체크박스 실행 함수
const showRejectModal = () => {
	putChkArr(function() {
		// rejectItemTable 전체선택, 전체해제 이벤트
		$("#rejectSelectAll").on('click',function() {
			if($("#rejectSelectAll").is(":checked")) $("input[name='rejectChkArr[]']").prop("checked", true);
			else $("input[name='rejectChkArr[]']").prop("checked", false);
		});
		// mediItemTable에서 하나라도 체크 해제 시 전체해제 되게
		$("input[name='rejectChkArr[]']").on('click', function() {
			let total = $("input[name='rejectChkArr[]']").length;
			let checked = $("input[name='rejectChkArr[]']:checked").length;
		
			if(total != checked) $("#rejectSelectAll").prop("checked", false);
			else $("#rejectSelectAll").prop("checked", true); 
		});
	});
};

// 약품 반려 모달 처리
const putChkArr = (callback) => {
    let selectChkBoxes= $("#mediItemTable input[name='chkArr[]']:checked");
    
    // 약품코드가 저장될 배열
    let mediArray = [];
    selectChkBoxes.each(function() {
        let reqNo = $(this).closest('tr').find('td:eq(0) input[type="hidden"]').val(); // 0번째 td인 신청번호 push
        let mediCode = $(this).closest('tr').find('td:eq(1)').text(); // 1번째 td인 약품코드 push
        let vo = {
        		"mediItemReqNo": reqNo,
        		"mediItemCode": mediCode
        }
        mediArray.push(vo);
//         console.log("push하고 난 mediArray", mediArray);
    });
    
    // 선택한 약품이 없는 경우
    if(mediArray.length == 0 || mediArray == null) {
    	Swal.fire({
    		icon: 'error',
    		title: '반려할 약품이 없습니다.',
    		text: '반려할 약품을 선택 후 다시 시도해주세요.'
   		});
    // 선택한 약품이 있는 경우
    } else {
//     	alert(JSON.stringify(mediArray)); // 체크

    	let xhr = new XMLHttpRequest();
		xhr.open("post", "/order/rejectMediList", true);
		xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				let result = JSON.parse(xhr.responseText);
// 				console.log("반려 약품리스트: ", result);
				
		    	$('.rejectModal-wrap').show();
		    	$('.rejectModal-bg').show();
		    	
				// tbody를 선택하여 변수로 저장
				let tbody = $('#rejectTable tbody');
				// 모든 행 선택
				let rows = tbody.find('tr');
				
				for(let i=0; i<result.length; i++) {
					let row;
					
					// 기존테이블의 tr보다 result 개수가 더 많으면 tr을 추가
	                if (i >= rows.length) {
	                    // 새로운 행 추가
	                    tbody.append('<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
	                    row = tbody.find('tr').eq(i);
	                } else {
	                    // 기존 행 업데이트
	                    row = rows.eq(i);
	                }
					
					row.find('td:eq(0)').html(`<input class="form-check-input" type="checkbox" name="rejectChkArr[]" id="defaultCheck3" checked>`);
					row.find('td:eq(1)').text(result[i].mediItemReqNo);
					row.find('td:eq(2)').text(result[i].mediItemCode);
					row.find('td:eq(3)').text(result[i].mediItemName);
					row.find('td:eq(4)').text(result[i].mediItemMakr);
					row.find('td:eq(5)').text(result[i].mediItemPrice);
					row.find('td:eq(6)').text(result[i].mediItemReqQy);
					row.find('td:eq(7)').text(result[i].mediItemReqTotal);
					row.find('td:eq(8)').text(result[i].empNm);
					row.find('td:eq(9)').text(result[i].mediItemReqDe);
				}
				
				// 남은 기존 행 초기화 (이전의 결과 행보다 새로운 결과 행이 더 적은 경우)
	            for (let i=result.length; i<rows.length; i++) {
	                let row = rows.eq(i);
	                row.find('td').text("");
	            }
				
				callback();
			}
			
		}
		xhr.send(JSON.stringify(mediArray));
    }
};

// 약품 반려 처리
$('#rejectBtn').on('click', function() {
// 	console.log("약품 반려 버튼 클릭");
	let selectChkBoxes= $("#rejectTable input[name='rejectChkArr[]']:checked");

	// 약품코드가 저장될 배열
	let mediArray = [];
	selectChkBoxes.each(function() {
		let reqNo = $(this).closest('tr').find('td:eq(1)').text(); // 1번째 td인 신청번호 push
		let mediCode = $(this).closest('tr').find('td:eq(2)').text(); // 2번째 td인 약품코드 push
		let vo = {
			"mediItemReqNo": reqNo,
			"mediItemCode": mediCode
	    }
		mediArray.push(vo);
// 			console.log("push하고 난 mediArray", JSON.stringify(mediArray));
		});
	
    // 선택한 약품이 없는 경우
    if(mediArray.length == 0 || mediArray == null) {
		Swal.fire({
			icon: 'error',
			title: '반려할 약품이 없습니다.',
			text: '반려할 약품을 선택 후 다시 시도해주세요.'
		});
	// 선택한 약품이 있는 경우
	} else {
		Swal.fire({
			  title: '약품 신청을 반려하시겠습니까?',
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
		}).then((result) => {
			let xhr = new XMLHttpRequest();
			xhr.open("put", "/order/rejectMedi", true);
			xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
			xhr.onreadystatechange = function() {
				let result = xhr.responseText;
	// 			console.log("반려 결과: " + result);
				
				Swal.fire({
		    		icon: 'success',
		    		title: '신청건이 정상적으로 반려되었습니다.'
		   		}).then((result) => { // 확인버튼 클릭 시 화면 이동
		   		    if (result.isConfirmed) {
						// 모달 숨기기
						$('.rejectModal-wrap').hide();
						$('.rejectModal-bg').hide();
						location.href = "/order/mediItem";
		   		    }
		   		});
			}
			xhr.send(JSON.stringify(mediArray));
		});
	}
});

// 발주 모달 hide
const closeOrderModal = () => {
	Swal.fire({
		  title: '승인 처리를 취소하시겠습니까?',
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소'
	}).then((result) => {
		$('.orderModal-wrap').hide();
		$('.orderModal-bg').hide();
	});
}

// 반려 모달 hide
const closeRejectModal = () => {
	Swal.fire({
		  title: '반려 처리를 취소하시겠습니까?',
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소'
	}).then((result) => {
		// 모달 숨기기
		$('.rejectModal-wrap').hide();
		$('.rejectModal-bg').hide();
		
		// 기존 체크값 체크 해제
		$('#selectAll').prop("checked", false);
		$("input[name='chkArr[]']").prop("checked", false);
	});
}

</script>
</html>