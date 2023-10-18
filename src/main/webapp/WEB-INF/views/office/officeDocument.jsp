<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet"/> 
<link href="../resources/css/demo.css" rel="stylesheet"/> 
<style>
.mygrid{
	border : 1px solid black;
}
.mygrid-title{
	text-align : right;
	font-size : 0.8 rem;
}

#docReceiptionModal {
	position: fixed;
	width: 40%;
	height : 30%;
	background-color: white;
	display: none;
	left: 35%;
	top: 25%;
	z-index: 9999;
	box-shadow: 2px 2px 2px 2px gray;
	
}
</style>
<div class="grid-stack"></div>

<div id="docReceiptionModal" style="padding : 30px;">
	<h5>제증명 수납</h5>
	
	<hr>
	<input type="hidden" id="vReqDocNo"/>
	<div style="width : 100%; height : 50%;">
		<div style="width : 100%; height : 100%;">
			<table style="width : 100%; height : 70%;" class="table table-bordered">
				<thead>
					<tr>
						<th>신청번호</th>
						<th>환자명</th>
						<th>생년월일</th>
						<th>발급일자</th>
						<th>발급서류</th>
						<th>가격(원)</th>
					</tr>	
				</thead>
				<tbody id="docRTbody">	
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div style="width : 100%; height : auto; text-align : right;">
		<button class="btn btn-primary" onclick="fDocReceiption()">수납</button>
		<button class="btn btn-secondary" onclick="docModalClose()">닫기</button>
	</div>
</div>
<script>
$(function(){
	getProofReqList();
});

const gr1 = 
	`
	<div id="docList" style="padding : 30px;">
		<div style="text-align : left; margin-bottom : 50px;">
			<h5 class="pb-2 border-bottom mb-4" style="text-align:left;margin-right:120px;font-weight:bold;width:136px;">제증명 신청 목록</h5>
		</div>
		<table class="table table-hover">
		      <thead>
		         <tr>
		            <th>번호</th>
		            <th>환자명</th>
		            <th>생년월일</th>
		            <th>담당의</th>
		            <th>발급일자</th>
		            <th>신청상태</th>
		            <th>비고</th>
		            <th>수납</th>
		         </tr>
		      </thead>
		      <tbody id="docListTbody" class="table-border-bottom-0">
		         <tr>
		            <td></td>
		            <td></td>
		            <td></td>
		            <td></td>
		            <td></td>
		            <td></td>
		            <td></td>
		            <td></td>
		         </tr>
		      </tbody>
		</table>
	</div>
	`;
const gr2 =
	`
	<div id="docPreview" style="height : 100%;">
		<div style="display : flex; padding : 30px 30px 0px; height: 9%;">
			<div style="width : 50%; text-align : left;">
				<h5>서류 보기</h5>
			</div>
			<div style="text-align : right; width : 50%;">
				<button id="downloadBtn" onclick="fDownloadDoc()" class="btn btn-sm btn-primary">다운로드</button>
				<button id="printBtn" onclick="fPrintDoc()" class="btn btn-sm btn-info">출력</button>
			</div>
		</div>
			<hr style="margin-top : 0px; width : 95%; margin-left : 3%;">
		<div style="height : 87%;">
			<iframe id="docFrame" width="95%" height="100%" src="/pdffiles/아작나스_진단서.pdf#toolbar=0"> </iframe>
			<input type="hidden" id="fileCode" value="">
		</div>
	</div>
	`
var items = [ 
	   {w: 7, h:5, x:0, y:0, content: gr1},
	   {w: 5, h:5, x:8, y:0, content: gr2}
];

    var grid = GridStack.init(); grid.load(items);


const docListTbody = $('#docListTbody');
const docFrame = $('#docFrame');
const fileCode = $('#fileCode');
const downloadBtn = $('#downloadBtn');
const printBtn = $('#printBtn');
const docReceiptionModal = $('#docReceiptionModal');
const docRTbody = $('#docRTbody');
const vReqDocNo = $('#vReqDocNo');

function getProofReqList(){
	$.ajax({
		url : "/document/list",
		type : "get",
		dataType : "json",
		success : function(result){
			console.log(result);
			let txt = "";
			for(let i =0; i<result.length; i++){
				let r = result[i];
				let price = new Intl.NumberFormat('ko-KR').format(r.reqDocumentPayment);
				let status = "";
				if(r.reqDocumentStatus == 'DOWT') status = "발급대기"
				if(r.reqDocumentStatus == 'DOGO') status = "발급완료"
				let rDate = r.reqDocumentRegDate.substring(0,10);
				txt += 
					`
					<tr onclick="fShowDoc('\${r.reqDocumentNo}')">
		            	<td>\${i+1}</td>
		            	<td>\${r.patName}</td>
		            	<td>\${r.patBrthdy}</td>
		            	<td>\${r.empNm}</td>
		            	<td>\${rDate}</td>
		            	<td>\${status}</td>
		            	<td>\${r.documentType}</td>`;
		       if(status == "발급대기"){
		            txt += 
		            	`
		            		<td>-</td>
		            	</tr>
		            	`;
		       } else if(status == "발급완료")
					txt += 
			            	`
			            	<td><button class="btn btn-sm btn-primary" onclick="fOpenReceiptModal('\${r.reqDocumentNo}')">수납</button></td>
			            </tr>
			            `;
			}
			docListTbody.html(txt);
		}
	});
}

function fShowDoc(reqDocumentNo){
	$.ajax({
		url : "/document/getDoc/" + reqDocumentNo,
		type : "get",
		dataType : "json",
		success :function(result){
			console.log(result);
			console.log(result.fileWebPath);
			docFrame.attr("src",result.fileWebPath+"#toolbar=0");
			fileCode.val(result.fileName);
		}
	})
}

function fDownloadDoc(){
	let vFileCode = fileCode.val();
	location.href="/download?fileName=/pdf/"+vFileCode;
}


function fPrintDoc(){
	let vFileCode = fileCode.val();
	window.open("/pdffiles/" + vFileCode);
}

function fOpenReceiptModal(reqDocumentNo){
	docReceiptionModal.css("display","block");
	$.ajax({
		url : "/document/receiptModal/"+reqDocumentNo,
		type : "get",
		dataType : "json",
		success : function(result){
			console.log(result);
			let reqRegDate = result.reqDocumentRegDate.substring(0,10);
			let price =  new Intl.NumberFormat('ko-KR').format(result.reqDocumentPayment);
			let txt = 
				`
				<tr>
					<td>\${result.reqDocumentNo}</td>
					<td>\${result.patName}</td>
					<td>\${result.patBrthdy}</td>
					<td>\${reqRegDate}</td>
					<td>\${result.documentType}</td>
					<td>\${price}</td>					
				</tr>
				`;
			docRTbody.html(txt);
			vReqDocNo.val(result.reqDocumentNo);
		}
	});
}

function docModalClose(){
	docReceiptionModal.css("display","none");
}

function fDocReceiption(){
	let vNo = vReqDocNo.val();
	$.ajax({
		url : "/receiption/reqDocument/"+vNo,
		type : "get",
		success : function(result){
			if(result == "1"){
				Swal.fire({
	  				icon: 'success',
	  				title:'완료!',
	  				text:'수납이 완료되었습니다!',	
	  			});
			}else{
				Swal.fire({
	  				icon: 'error',
	  				title:'실패!',
	  				text:'수납 실패하였습니다!',	
	  			});
			}
			docModalClose();
			getProofReqList();
			docFrame.attr("src","/pdffiles/아작나스_진단서.pdf#toolbar=0");
		}
	});
	
}
//--------------------------- 웹소켓-------------------------------------

function fMessage(){ // 받는쪽에 작성
	let serverMsg = JSON.parse(event.data);

	if(serverMsg.cmd =="alarm"){
		getNotiList();
	}
	if(serverMsg.cmd =="endDocu"){
		getProofReqList();
	}
	if(serverMsg.cmd =="plzDocu"){
		getProofReqList();
	}
}
// --------------------------- /웹소켓 ------------------------------------- 
</script>
