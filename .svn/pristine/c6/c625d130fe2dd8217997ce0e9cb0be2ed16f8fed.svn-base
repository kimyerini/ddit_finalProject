<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.employee" var="empVO" />
   <c:set var="empVO2" value="${empVO}" scope="session" />
</sec:authorize>
<script src="http://code.jquery.com/jquery-3.6.0.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
#searchDiv1 {
	position: fixed;
	width: 670px;
	height: auto;
	background-color: white;
	display: none;
	z-index: 9990;
	top: 8%;
	left: 8%;
	box-shadow: 2px 2px 2px 2px gray;
	
}

#patDetail {
	position: fixed;
	width: 670px;
	height: auto;
	background-color: white;
	display: none;
	left: 35%;
	top: 25%;
	z-index: 9999;
	box-shadow: 2px 2px 2px 2px gray;
}

.form-control {
	width: 35%;
	display: inline-block;
	margin-right: 15px;
}

.mb-3 {
	margin-bottom: 0;
}

#insertModal {
	position: fixed;
	width: 800px;
	height: 700px;
	background-color: white;
	display: none;
	z-index: 9999;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	box-shadow: 5px 5px 5px 5px gray;
}

#modal-box {
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
	background-color: rgba(0, 0, 0, 0.6);
	display: none;
	justify-content: center;
	align-items: center;
	z-index: 9998;
}

#modal-box.active {
	display: flex;
}

.form-control.form-control-sm {
	width: 120%;
}

.swal2-container {
	z-index: 9999;
}
#receiptDiv{
	position: fixed;
	background-color: white;
	display: none;
	z-index: 9990;
	top: 13%;
	left: 16%;
	box-shadow: 2px 2px 2px 2px gray;
}

#rcptTbody > tr > td, #rcptTbody2 > tr > td {
	padding : 0px;
}
</style>
<!-- //////////////////////////////////////접수모달시작//////////////////////////////////// -->
<div id="receiptDiv">
	<div style="display : flex; width: 1300px; height : 750px; z-index : 9999;">
		<div style="width : 18%; height :100%; background-color : #e7e9ed; overflow : auto;">
			<div>
				<h5 style="margin-top : 15px; margin-right : 10px; text-align : center; font-weight : bold;" >최근 방문 기록</h5>
				<div id="dateTable" style="overflow : auto;">
					
				</div>
			</div>
		</div>
		<div style="width : 82%; height : 98%; margin-top : 15px; padding:20px;">
			<div style="float : left; width : 45%; margin-left : 15px;">
				<h5 style="margin : 0; font-weight:bold; margin-left : -10px;">정보</h5>
			</div>
			<div style="display : inline-block; text-align : right;  width : 50%;">
				<h5 style="margin : 0;" id="rDate">2023-09-25</h5>
			</div>
			<hr>
			<div>
				<h5 style="font-weight : bold;">환자정보</h5>
				<h6 id="pNo">230901001</h6>
				<div style="display : flex; margin-top : 5px;">		
					<h4 style="margin : 0;"  id="pInfo">윤묵밥(남,30세)</h4>
				</div>
				
				<div style="width : 100%;">
					<table style="width : 100%; margin-top : 25px;">
						<tr>
							<th style="width:200px;">주민등록번호</th>
							<th style="width:200px;">연락처</th>
							<th>주소</th>
						</tr>
						<tr>
							<td id="pIdhNum">941226-1234567</td>
							<td id="pTel">010-4307-5115</td>
							<td id="pAddr">대전 서구 탄방동55-6 403호</td>
						</tr>
					</table>
				</div>
			</div>
			<hr>


<div class="nav-align-top mb-4">
      <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item" role="presentation">
          <button type="button" class="nav-link active" role="tab"  data-bs-toggle="tab" data-bs-target="#rInfoTab" aria-controls="rInfoTab" aria-selected="true">접수정보</button>
        </li>
        <li class="nav-item" role="presentation">
          <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#cInfoTab" aria-controls="cInfoTab" aria-selected="false" tabindex="-1">차트정보</button>
        </li>
        <li class="nav-item" role="presentation">
          <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#rtInfoTab" aria-controls="rtInfoTab" aria-selected="false" tabindex="-1">수납정보</button>
        </li>
      </ul>
      <div class="tab-content" style="height : 420px;">
        <div class="tab-pane fade show active" id="rInfoTab" role="tabpanel">
          <div style="margin : 15px;" id="rInfoDiv">
				<h5 style="font-weight : bold;">접수정보</h5>
				<h6 id="rNo">230902001</h6>
				<div>
					<form>
						<div style="display : flex; margin-bottom : 10px">
							<div id="selectDiv" style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="rceptFirstExamCode">초재진</label>
								<input type="radio" name="rceptFirstExamCode" value="Y" checked>초진
								<input type="radio" name="rceptFirstExamCode" value="N">재진
							</div>
							<div style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="rceptDayCode">주야간</label>
								<input type="radio" name="rceptDayCode" value="0" checked>주간
								<input type="radio" name="rceptDayCode" value="1">야간
							</div>
						</div>
						<div style="display : flex; margin-bottom : 10px;">
							<div style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="rceptPathCode">내원경로</label>
								<select name="rceptPathCode">
								</select>
							</div>
							<div style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="schdNo">담당의</label>
								<select name="schdNo" id="selSchd">
								</select>
							</div>
						</div>
						<div>
							<label style="width : 80px;" for="rceptMemo">접수 메모</label>
						</div>
						<div>
							<textarea cols="79" rows="7" id="rceptMemo"></textarea>
						</div>
						<div id="insDiv" style="text-align : right;">
							<button type="button" id="submitRpt" class="btn btn-success">접수</button>
							<button type="button" onclick="cancel()" class="btn btn-secondary">취소</button>
						</div>
						<div id="dtlDiv" style="text-align : right;">
							<button type="button"  onclick="cancel()" class="btn btn-secondary">닫기</button>
						</div>
					</form>
				</div>
			</div>
        </div>
        <div class="tab-pane fade" id="cInfoTab" role="tabpanel">
         			
			<div style="margin : 5px;" id="cInfoDiv"> 
				<h5 style="font-weight : bold;">차트정보</h5>
				<h6 id="detailNo"></h6>
				<div>
					<form>
						<div style="display : flex; margin-bottom : 10px">
							<div id="selectDiv" style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="rceptFirstExam">초재진</label>
								<input readonly style="border : 0px;" type="text" id="rceptFirstExam" name="rceptFirstExam" value="">
								
							</div>
							<div style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="rceptDay">주야간</label>
								<input readonly style="border : 0px;" type="text" id="rceptDay" name="rceptDay" value="">
							</div>
						</div>
						<div style="display : flex; margin-bottom : 10px;">
							<div style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="dissName">진단명</label>
								<input readonly style="border : 0px;" type="text" id="dissName" value="">
							</div>
							<div style="text-align : left; width : 48%; margin : 0;">
								<label style="width : 80px;" for="doctor">담당의</label>
								<input readonly style="border : 0px;" type="text" id="doctor" value="">
							</div>
						</div>
						<hr>
						<div>
							<h5 style="font-weight : bold;">오더리스트</h5>
						</div>
						<div style="display : flex; width : 100%; margin-bottom : 10px">
							<div style="text-align : left; width : 50%; margin : 0;">
								<label style="width : 80px;" for="treCont">처치 내역</label>
								<input readonly style="border : 0px;" type="text" id="treCont" value="">
							</div>
							<div style="text-align : left; width : 40%; margin : 0;">
								<label style="width : 80px;" for="physioCont">치료 내역</label>
								<input readonly style="border : 0px;" type="text" id="physioCont" value="">
							</div>
						</div>
						
						<div style="display : flex; width : 100%; margin-bottom : 10px">
							<div style="text-align : left; width : 50%; margin : 0;">
								<label style="width : 80px;" for="inspcCont">검사 내역</label>
								<input readonly style="border : 0px;" type="text" id="inspcCont" value="">
							</div>
							<div style="text-align : left; width : 40%; margin : 0;">
								<label style="width : 80px;" for="patHsptlzStatus">입원 상태</label>
								<input readonly style="border : 0px;" type="text" id="patHsptlzStatus" value="">

							</div>
						</div>
						<div style="display : flex; width : 100%; margin-bottom : 10px">
							<div style="text-align : left; width : 100%; margin : 0;">
								<label style="width : 80px;" for="mediCont">처방 내역</label>
								<input readonly style="border : 0px; width:85%;" type="text" id="mediCont" value="">
							</div>
						</div>
						<div id="insDiv" style="text-align : right; margin-top : 40px;">
							<button type="button" onclick="fReqDoc(this)" class="btn btn-primary">진단서 요청</button>
							<button type="button" onclick="fReqDoc(this)" class="btn btn-primary">소견서 요청</button>
							<button type="button" onclick="cancel()" class="btn btn-secondary">닫기</button>
						</div>
					</form>
				</div>			
			</div>
        </div>
        <div class="tab-pane fade" id="rtInfoTab" role="tabpanel">
	        <div style="margin : 5px; height: 350px;" id="rcptInfoDiv" >
	        	<h5 style="font-weight : bold;">수납정보</h5>
	        	<h6 id="tNo"></h6>
	        	<div style="overflow-y:auto; height: 266px;">
		        	<div id="rcptTable" style="max-height : 250px;">
		        		<table style ="width : 100%;" class="table table-bordered">
		        			<thead class="rThead">
			        			<tr style="height : 25px; text-align : center;">
			        				<th>항목</th>
			        				<th>오더코드</th>
			        				<th>오더명</th>
			        				<th>금액</th>
			        				<th>횟수</th>
			        				<th>일수</th>
			        				<th>총액</th>
			        				<th>본인부담금</th>
			        				<th>공단부담금</th>
			        			</tr>
		        			</thead>
		        			<tbody id="rcptTbody">
		        				<tr style="text-align : center; height : 25px;">
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        				</tr>
		        			</tbody>
		        		</table>
		        	</div>
		        	<div style="margin : 5px;">
		        		<table style="width : 100%;" class="table table-bordered">
		        			<thead>
		        				<tr style="height : 10px; text-align : center;">
		        					<th>총계</th>
		        					<th>본인부담금</th>
		        					<th>공단부담금</th>
		        					<th>납부금액</th>
		        				</tr>
		        			</thead>
		        			<tbody id="rcptTbody2">
		        				<tr style="text-align : right; height : 25px;">
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        					<td>-</td>
		        				</tr>
		        			</tbody>
		        		</table>
		        	</div>
	        		<p style="text-align:right;">단위 : 원</p>
		        </div>
	        	<div style="text-align : right;">
	        		<button type="button" onclick="fReceiption()" class="btn btn-primary">수납</button>
	        		<button type="button" onclick="cancel()" class="btn btn-secondary">닫기</button>
	        	</div>
	        </div>
        </div>
      </div>
    </div>
		</div>
	</div>
</div>
<!-- //////////////////////////////////////접수모달끝//////////////////////////////////// -->

<!-- ///////////////////////////////////정보 수정 모달 시작/////////////////////////////////// -->
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.employee" var="empVO" />
<%-- <div>세션체킁: ${empVO }</div>  --%>
</sec:authorize>


<form id="empInfoModal" method="post" action="/emp/updateMyInfo">
			<div id="modal-box">
				<div class="modal-content" style="background-color:white; width:500px; padding:5px; position:relative;">
		   <div class="modal-header" style="padding-top: 15px;">
			  <h5 class="modal-title" id="modalCenterTitle">정보 수정</h5>
			  <button type="button" id="close" class="btn-close" 
				 data-bs-dismiss="modal" aria-label="Close"></button>
		   </div>
		  <div class="modal-body" style="margin-bottom: 3px;  padding-top: 5px; padding-bottom: 5px;">
			 <div class="row mb-1" style="width: 100%;">
				<label class="col-sm-10 col-form-label" for="empNo">사번</label>
				<div class="col-sm-10">
				   <input id="empNo" class="form-control form-control-sm" type="text"
					  value="${empVO.empNo}" readonly>
				</div>
			 </div>
			 <div class="row mb-2">
				<label class="col-sm-10 col-form-label" for="empNm">사원명</label>
				<div class="col-sm-10">
				   <input type="text" class="form-control form-control-sm" id="empNm"
					  value="${empVO.empNm}" readonly>
				</div>
			 </div>
			 <div class="row mb-1">
				<label class="col-sm-10 col-form-label" for="empPassword">비밀번호</label>
				<div class="col-sm-10">
				   <input type="password" class="form-control form-control-sm"
					  id="empPassword" name="empPassword"
					  placeholder="영문 숫자 조합 8자리 이상으로 입력해주세요.">
				</div>
			 </div>
 
			 <div class="row mb-1">
				<label class="col-sm-10 col-form-label" for="empPassword">비밀번호확인</label>
				<div class="col-sm-10">
				   <input type="password" class="form-control form-control-sm"
					  id="empPassword1" name="empPassword1"
					  placeholder="영문 숫자 조합 8자리 이상으로 입력해주세요.">
				</div>
			 </div>
			 <div class="row mb-1">
				<label class="col-sm-10 col-form-label" for="empBrthdy">생년월일</label>
				<div class="col-sm-10">
				   <input type="text" class="form-control form-control-sm" 
					  id="empBrthdy" value="${empVO.empBrthdy}" readonly>
				</div>
			 </div>
			 <div class="row mb-1">
				<label class="col-sm-10 col-form-label" for="empEncpn">입사일</label>
				<div class="col-sm-10">
				   <input type="text" class="form-control form-control-sm"
					  id="empEncpn" value="${empVO.empEncpn }" readonly>
				</div>
			 </div>
 
			 <div class="row mb-1">
				<label class="col-sm-10 col-form-label" for="empTelno">연락처
				   ( - 를 포함하여 입력하시오. )</label>
				<div class="col-sm-10">
				   <input type="text" id="empTelno" value="${empVO.empTelno }" oninput="hypenTel(this)"
					  class="form-control form-control-sm" style="margin-bottom: 5px;">
				</div>
			 </div>
 
			 <div class="row mb-1">
				<label class="col-sm-10 col-form-label" for="empEmail"
				   style="width: 50px; margin-bottom: 10px;">이메일</label>
				<button type="button" id="emailbtn" class="btn btn-info"
				   style="width: 80px; height: 30px; font-size: 11px;">중복확인</button>
				<div class="col-sm-10">
				   <input type="text" class="form-control form-control-sm"
					  id="empEmail" name="empEmail" value="${empVO.empEmail}">
				   <input type="hidden" class="form-control form-control-sm"
					  id="empOriginEmail" name="empOriginEmail"
					  value="${empVO.empEmail}" />
				</div>
			 </div>
 
 
			 <div class="row mb-1">
				<label class="col-sm-10 col-form-label" for=""
				   style="width: 30px; margin-bottom: 5px;">주소</label>
				<button type="button" id="zipSrh" class="btn btn-info"
				   style="width: 50px; height: 30px; font-size: 11px; margin-left: 5px;">검색</button>
				<div class="col-sm-10">
				   <input type="text" id="empZip" name="empZip"
					  value="${empVO.empZip }" class="form-control form-control-sm"
					  style="margin-bottom: 10px;"> <input type="text"
					  id="empAddr" name="empAddr" value="${empVO.empAddr }"
					  class="form-control form-control-sm" style="margin-bottom: 10px;">
				   <input type="text" id="empDtlAddr" name="empDtlAddr"
					  value="${empVO.empDtlAddr }" class="form-control form-control-sm">
				</div>
 
			 </div>
 
		  </div>
 
 
		  <div class="modal-footer" style="padding-bottom: 10px;">
			 <button type="submit" class="btn btn-primary" id="save">저장</button>
		  </div>
		</div>
	 </div>
</form>


<!-- ///////////////////////////////////정보 수정 모달 끝/////////////////////////////////// -->


<!-- ///////////////////////////////////신규 환자 등록 모달 시작/////////////////////////////////// -->
<div class="col-xxl" id="insertModal">
	<div class="card mb-4">
		<div
			class="card-header d-flex align-items-center justify-content-between">
			<h5 class="mb-0">신규환자 등록</h5>
			<button type="button" id="autoCompleteBtnP" class="btn btn-xs btn-dark" onclick="autoComplBtn()">자동완성</button>
		</div>
		<div class="card-body">
			<form id="iForm">
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="patName">환자명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="patName"
							name="patName" placeholder="환자명">
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="patTel">연락처</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="patTel" name="patTel"
							placeholder="연락처">
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="patIhidnum">주민등록번호</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="patIhidnum"
							name="patIhidnum" placeholder="주민등록번호">
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="patZip">우편번호</label>
					<div class="col-sm-10">
						<input type="text" id="patZip" name="patZip"
							style="width: 50%; float: left; margin-right: 60px;"
							class="form-control" placeholder="우편번호" readonly>
						<button type="button" class="btn btn btn-primary" id="btnPostNum">검색</button>
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="patAddr">주소</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="patAddr"
							name="patAddr"> <input type="text" class="form-control"
							id="patDtlAddr" name="patDtlAddr" />
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="patFirstDate">최초내원일자</label>
					<input type="date" class="form-control" style="width: 83%;"
						id="patFirstDate" name="patFirstDate" />
				</div>
				<div class="row justify-content-end">
					<div class="col-sm-10">
						<button type="button" class="btn btn-primary" onclick="insertPat()" id="btnSave">등록</button>
						<button type="button" onclick="insertAndReceipt()" class="btn btn-primary">등록 후 접수</button>
						<button type="button" id="closeBtn" class="btn btn-danger">닫기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- ///////////////////////////////////신규 환자 등록 모달 끝/////////////////////////////////// -->

<!-- ///////////////////////////////////////환자 상세보기 시 모달 시작//////////////////////////////////// -->
<div class="card-body" id="patDetail">
	<div style="display: flex;">
		<div>
			<h5 class="pb-2 border-bottom mb-4"
				style="text-align: left; margin-right: 120px; font-weight: bold;">환자정보</h5>
		</div>
	</div>
	<div class="info-container">
		<div class="row">
			<div class="col-md-6" style="width: auto;">
				<ul class="list-unstyled">
					<li class="mb-3"><span class="fw-medium me-2">환자코드:</span> <input
						type="text" name="patCode" class="form-control " id="HpatCode"
						style="width: 40%;"> <span class="fw-medium me-2">환자유형:</span>
						<input type="text" name="patHsptlzStatus" class="form-control "
						id="HpatHsptlzStatus" style="width: 15%;"></li>
					<li class="mb-3"><span class="fw-medium me-2">이름:</span> <input
						type="text" name="patName" class="form-control " id="HpatName"
						style="width: 25%;"> <span class="fw-medium me-2">연락처:</span>
						<input type="text" name="patTel" class="form-control "
						id="HpatTel" style="width: 40%;"></li>
					<li class="mb-3"><span class="fw-medium me-2">성별:</span> <input
						type="text" name="patGenCode" class="form-control "
						id="HpatGenCode" style="width: 19%;"> <span
						class="fw-medium me-2">나이:</span> <input type="text" name="patAge"
						class="form-control " id="HpatAge" style="width: 12%;"> <span
						class="fw-medium me-2">외국인여부:</span> <input type="text"
						name="patFrgnrYn" class="form-control " id="HpatFrgnrYn"
						style="width: 12%;"></li>
					<li class="mb-3"><span class="fw-medium me-2">주소:</span> <input
						type="text" name="patAddr" class="form-control " id="HpatAddr"
						style="width: 80%;"></li>
					<li class="mb-3"><span class="fw-medium me-2">최초내원일자:</span> <input
						type="text" name="patFirstDate" class="form-control "
						id="HpatFirstDate" style="width: 70%;"></li>
					<li class="mb-3"><span class="fw-medium me-2">최근내원일자:</span> <input
						type="text" name="patLastDate" class="form-control "
						id="HpatLastDate" style="width: 70%;"></li>
				</ul>
			</div>
		</div>
		<div class="d-flex justify-content-center pt-3"></div>
	</div>
	<button class="btn btn-primary" style="float:right;" onclick="fClose()">닫기</button>
</div>
<!-- ///////////////////////////////////////환자 상세보기 시 모달  끝///////////////////////////////////// -->


<!-- ///////////////////////////////////환자 검색 시 뜨는 모달창 시작/////////////////////////////////// -->
<div class="table-responsive text-nowrap" id="searchDiv1"
	style="width: 700px;">
	<table class="table" style="width: 30%">
		<thead>
			<tr>
				<th style="text-align:center;">환자코드</th>
				<th style="text-align:center;">환자이름</th>
				<th style="text-align:center;">생년월일</th>
				<th style="text-align:center;">성별</th>
				<sec:authorize access="hasAnyRole('ROLE_OFFICE','ROLE_ADMIN')">
					<th style="text-align:center;">접수</th>
				</sec:authorize>
				<th style="text-align:center;">상세</th>
			</tr>
		</thead>
		<tbody class="table-border-bottom-0" id="sTbody">

		</tbody>
	</table>
</div>
<!-- ///////////////////////////////////환자 검색 시 뜨는 모달창 끝/////////////////////////////////// -->
<div id="contextPath"
	data-context-path="<%=request.getAttribute("javax.servlet.forward.request_uri").toString()%>"></div>

<script>
	var vModal = $("#insertModal");
	
	function pInsert(){
		vModal.css("display","block");
		$('#patName').val("");
		$('#patTel').val("");
		$('#patIhidnum').val("");
		$('#patZip').val("");
		$('#patAddr').val("");
		$('#patDtlAddr').val("");
		$('#patFirstDate').val("");
		
		
	}
	
   // 휴대폰번호 자동 하이픈 추가
   const hypenTel = (target) => {
      target.value = target.value
         .replace(/[^0-9]/g, '')
         .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
   }
   
   // 전체삭제버튼
   function deleteAll(){
	   $.ajax({
		   type: "get", 
		   url: "/calendar/deleteNotiList?empNo=${empVO.empNo}", 
		   dataType:"text",
		   success: function (res) {
// 			   console.log("res체킁 : " + res);
			   
			   $("#circle").html("0");
			   getNotiList();
		   },
		   error: function(xhr, status, error) {
// 			   console.log("code: " + xhr.status);
// 			   console.log("message: " + xhr.responseText);
// 			   console.log("error: " + error);
		   }
	   });
   };

$(function(){
	connect();
	getMenuList();
	getNotiList();
	$('#deleteAll').on("click",deleteAll); // 함수이름뒤에 ()를 붙이면 함수가 호출됨! 


	$(document).click(function() {
		search.val("");
		sDiv.css("display","none");
	});
	
	var url = $("#contextPath").data("context-path");
		
	$('#btnPostNum').on('click',function(){
		  new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete:function(data){
				$('input[name="patZip"]').val(data.zonecode);
				$('input[name="patAddr"]').val(data.address);
				$('input[name="patDtlAddr"]').val(data.buildingName);
			}
		  }).open();
	  });
	
	  //모달창 닫기 눌렀을떄
	  $('#closeBtn').on('click',function(){
		  vModal.css("display","none");
	  });
	  
	const search           =   $('#pSearch');
	const sTbody           =   $('#sTbody');
	const sDiv             =   $('#searchDiv1');
	
	//search 함수
	 $('#pSearch').on('keyup',function(){
		 sDiv.css("display","block");
		 let patName = search.val();
		 	if(patName!=''){
			 $.ajax({
			        url: `/office/searchPat/\${patName}`,
			        type: 'GET',
			        dataType: 'JSON',
			        success: function (result) {
			            if (result.length !=0){
							let txt = "";
							$.each(result,function(i,res){
								let gen = "";
								if(res.patGenCode == "F"){
									gen = "여";
								}else{
									gen = "남";
								}
// 								console.log(res);
// 								console.log(res.patCode);
								txt += "<tr>"
								txt += "<td><span class='fw-medium'>"+res.patCode+"</span></td>";
								txt += "<td>"+res.patName+"</td>";
								txt += "<td>"+res.patBrthdy+"</td>";
								txt += "<td>"+gen+"</td>";
								<sec:authorize access="hasAnyRole('ROLE_OFFICE','ROLE_ADMIN')">
								    txt += `<td><button name = "receiptBtn" class='btn btn-primary' onclick='receipt(\${res.patCode})'>접수</button></td>`;
								</sec:authorize>
								txt += `<td><button class='btn btn-primary' onclick='patDetailModal(\${res.patCode})'>환자상세</button></td>`;
							})
// 							console.log("txt",txt);
							sTbody.html(txt);
			            }else{
// 			            	console.log("없엉");
			            	sDiv.css("display","none");
			            }
			        }
			        
			    });
		 	}else{
		 		sDiv.css("display","none");
		 	}

	  });
	


});

function patDetailModal(patCode){
	let pDetail    =   $('#patDetail');
// 	console.log("환자정보조회버튼 체킁");

// 	console.log("patCode",patCode);
    

    let xhr = new XMLHttpRequest();
    let schURL = "/doctor/clinic/"+patCode;
//     console.log(schURL);
    xhr.open("get",schURL,true);
    xhr.onreadystatechange = function(){
        if(xhr.readyState == 4 && xhr.status == 200){
//         	console.log("성공!");
            let patientVO = xhr.responseText;
            if(patientVO){
              	patientVO = JSON.parse(patientVO); //json문자열을 json객체로
           	 console.log(patientVO);
            	
             	$("#HpatCode").val(patientVO.patCode);
             	$("#HpatName").val(patientVO.patName);
            	$("#HpatTel").val(patientVO.patTel);
            	$("#HpatGenCode").val(patientVO.patGenCode);
            	$("#HpatAddr").val(patientVO.patAddr);

             	const birthdate = patientVO.patBrthdy; // patBrthdy.value는 "19980813" 형식으로 가정
//              	console.log(birthdate);
             	
             	const currentDate = new Date(); // 현재 날짜
             	const age = currentDate.getFullYear() - birthdate.substring(0, 4); // 현재 년도 - 1998
             	// 계산된 나이를 patAge에 설정
             	$("#HpatAge").val(age);
             	
                $("#HpatFirstDate").val(formatDate(patientVO.patFirstDate));
                $("#HpatLastDate").val(formatDate(patientVO.patLastDate));            	
            	$("#HpatFrgnrYn").val(patientVO.patFrgnrYn);
            	$("#HpatHsptlzStatus").val(patientVO.patHsptlzStatus);
            	pDetail.css("display","block");
   				
            }else{
                alert("해당 환자정보는 없습니다.");
            }
        }
    }
    xhr.send(); 
}
function fClose(){
	let pDetail    =   $('#patDetail');
	pDetail.css("display","none");
	
}
// 날짜 변환하기
function formatDate(inputDate) {
    let options = { year: 'numeric', month: '2-digit', day: '2-digit' };
    let date = new Date(inputDate);
    return date.toLocaleString(undefined, options);
}

// 등록일자 시간 나타내기
function convertTimeToRelative(timeInMilliseconds) {
 const currentTime = new Date().getTime();
 const timeDifference = currentTime - timeInMilliseconds;

 const seconds = Math.floor(timeDifference / 1000);
 const minutes = Math.floor(seconds / 60);
 const hours = Math.floor(minutes / 60);
 const days = Math.floor(hours / 24);

    if (days > 0) {
        return days + "일 전";
    } else if (hours > 0) {
        return hours + "시간 전";
    } else if (minutes > 0) {
        return minutes + "분 전";
    } else {
        return "방금 전";
    }
}

</script>


<nav class="navbar navbar-expand-lg navbar-light bg-light mb-5"
	style="background-color: #ffffff !important; height: 60px; margin-top: 5px; z-index : 10;">
	<a href="#" class="app-brand-link" style="margin: 30px;" id="myLink"> <span
		class="app-brand-logo demo"> <img width="160px;"
			src="/resources/images/진료이즈백 납작.png">
	</span>
	</a>
	<div class="container-fluid">

		<!-- Search -->

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
<%-- 		<div>세션체킁: ${empVO }</div>  --%>
		<div class="collapse navbar-collapse" id="navbarSupportedContent"
			style="width: 100%;">
			<form class="d-flex">
				<div class="input-group">
					<span class="input-group-text"><i
						class="tf-icons bx bx-search"></i></span> <input type="text" id="pSearch"
						class="form-control"
						style="border-left: none; margin-left: -13px;" placeholder="환자 검색">
					&nbsp;&nbsp;&nbsp;
					<sec:authorize access="hasAnyRole('ROLE_OFFICE','ROLE_ADMIN')">
						<button type="button" id="pInsertBtn" onclick="pInsert()"
							style="height: 35px; background-color: #696cff; border: 0px; radius: 0.5;">
							<span style="color: white;">신규환자등록</span>
						</button>
					</sec:authorize>
				</div>
			</form>
		</div>
		<!-- /Search -->

		<!-- 알림내역 -->
		<li class="nav-item navbar-dropdown dropdown-user dropdown"
			style="margin-top: -22px; list-style: none; height : 100%; top : 12px;"><a
			class="nav-link dropdown-toggle hide-arrow"
			href="javascript:void(0);" data-bs-toggle="dropdown"
			aria-expanded="false" style="margin-left: 45px;">
				<div class="d-flex">
					<div class="flex-shrink-0 me-3">
						<img src="/resources/images/bell_gold.png" alt="bell_gold.png"
							class="w-px-40 h-auto rounded-circle"
							style="width: 20px; height: 20px;">
					</div>
					<div id="circle"
						style="width: 20px; height: 20px; border-radius: 50%; background-color: red; 
						color: white; font-size: 12px; text-align: center; margin-left: -20px;">
						0</div>
				</div>
		</a>
			<ul class="dropdown-menu dropdown-menu-end" style="z-index: 9990;"
				id="ulNoti">
				
				<!-- 			        <li><a class="dropdown-item" href="/calendar/schedule"> -->
				<!-- 			            <i class="fa fa-bell me-2"></i> <span class="align-middle">새로운 병원 일정이 등록되었습니다.</span></a> -->
				<!-- 			        </li> -->
				<!-- 			        <li> -->
				<!-- 			            <div class="dropdown-divider"></div> -->
				<!-- 			        </li> -->
				<!-- 			        <li><a class="dropdown-item" href="#"> -->
				<!-- 			            <i class="fa fa-bell me-2"></i> <span class="align-middle">새로운 공지사항이 등록되었습니다.</span></a> -->
				<!-- 			        </li> ==> 이 부분은 아래에서 $.each처리해줌 -->
			</ul></li>
		<!-- /알림내역 -->

		<!-- User -->
		<li class="nav-item navbar-dropdown dropdown-user dropdown"
			style="margin-right: 15px; margin-top: -22px; list-style: none; top : 12px;"><a
			class="nav-link dropdown-toggle hide-arrow"
			href="javascript:void(0);" data-bs-toggle="dropdown"
			aria-expanded="false">
				<div class="d-flex">
					<div class="flex-shrink-0 me-3">
					<c:choose>
					<c:when test="${empty empVO.fileList}">
						<img src="/resources/images/defaultUser.png"
							alt="" class="w-px-40 h-auto rounded-circle"
							style="width: 20px; height: 20px; margin-top: 2px;">
					</c:when>
					<c:otherwise>
						<img src="/resources/upload${empVO.fileList[0].fileWebPath}"
							alt="" class="w-px-40 h-auto rounded-circle"
							style="width: 40px !important; height: 40px !important; margin-top: 2px;">
					</c:otherwise>
					</c:choose>
					</div>
					<div class="flex-grow-1">
						<span class="fw-semibold d-block"> ${empVO.empNm} </span> <small
							class="text-muted"> ${empVO.comCodeName} </small>
					</div>
				</div>
		</a>
			<ul class="dropdown-menu dropdown-menu-end " style="z-index: 9990;">
				<li><a class="dropdown-item" id="open"> <i
						class="bx bx-user me-2"></i> <span class="align-middle">정보수정</span></a>
				</li>
				<li>
					<div class="dropdown-divider"></div>
				</li>
				<li><a class="dropdown-item" href="/emp/logout"> <i
						class="bx bx-power-off me-2"></i> <span class="align-middle">로그아웃</span></a>
				</li>
			</ul></li>
		<!-- /User -->

	</div>
</nav>
<nav
	class="navbar navbar-example navbar-expand-lg navbar-light bg-light"
	style="z-index: 5;">
	<div class="container-fluid">
<!-- 		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" -->
<!-- 			data-bs-target="#navbar-ex-2" aria-controls="navbar-ex-2" -->
<!-- 			aria-expanded="false" aria-label="Toggle navigation"> -->
<!-- 			<span class="navbar-toggler-icon"></span> -->
<!-- 		</button> -->
		<div class="collapse navbar-collapse" id="navbar-ex-2">
			<div class="navbar-nav me-auto" id="menuNav">
			</div>
		</div>
	</div>
</nav>
<script>
// 로고 클릭 시 권한별 메인 페이지로 이동
document.addEventListener("DOMContentLoaded", function () {
    
    var myLink = document.getElementById("myLink");
    
    myLink.addEventListener("click", function (event) {
        event.preventDefault();
        
        var deptCode =  "${empVO.deptCode}";
        var redirectURL;

		switch (deptCode) {
		case "D001":
			 redirectURL = "/doctor/clinic";
			break;
		case "D002":
			redirectURL = "/item/itemRequest";
			break;
		case "D003":
			 redirectURL = "/office/main";
			break;
		case "D004":
			redirectURL = "/physio/main";
			break;
		case "D005":
			redirectURL = "/insp/insp";
			break;
		case "D006":
			redirectURL = "/employee/index";
			break;
		
		case "D000":
			redirectURL = "/office/main";
			break;
		
		case "D999":
			redirectURL = "/physio/main";
			break;
		}
        window.location.href = redirectURL;

    });
});

const open = $("#open");
const close = $("#close");
const save = $("#save");
const modalBox = $("#modal-box");
const empInfoModal = $('#empInfoModal');

open.on("click", function(){
    modalBox.addClass("active");
});

close.on("click", function() {
    modalBox.removeClass("active");
    $("#empInfoModal")[0].reset();
    
});



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


	// 이메일 정규 표현식
    let regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

    // 이메일 유효성 검사 함수
    function validateEmail(email) {
        return regex.test(email);
    }

	 // 이메일 사용가능 여부 체크가 아직 안 되어 있음
	 let isEmailChecked = false; 
	
 // 이메일 중복 체크 구현
 $('#emailbtn').on("click", function() {
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
//        console.log("체크", res);
       if (res == "fail") {
         Swal.fire({
           icon: 'error',
           title: '이미 등록된 메일주소입니다.!',
           text: '메일 주소를 다시 확인해주세요.',
         })
       } else {
         Swal.fire({
        	 icon: 'success',
        	 title: '가능한 메일주소입니다.!',
        	 text:empEmail +'은 사용가능한 메일주소입니다.'
        })
         isEmailChecked = true;
       }
     },
     error: function (xhr, status, error) { 
//        console.log("code: " + xhr.status)
//        console.log("message: " + xhr.responseText)
//        console.log("error: " + error);
     }

   });
 });//이메일 중복체크 끝
	 
	 
	 
	 //나의 정보 폼 전송
	 var eModal = $("#empInfoModal");
	  $("#empInfoModal").on("submit", function (){ 
	   event.preventDefault();   // built-in 이벤트 막기, submit 
	   
	   
	   let empNo = $("#empNo").val();
	   var empEmail = $("#empEmail").val();
	   var empOriginEmail = $("#empOriginEmail").val();
	   var empTelno = $("#empTelno").val();
	   var empZip = $("#empZip").val();
	   var empAddr = $("#empAddr").val();
	   var empDtlAddr = $("#empDtlAddr").val();
	   var empPassword = $("#empPassword").val();
	   var empPassword1 = $("#empPassword1").val();
	   
// 	   console.log("empOriginEmail : " + empOriginEmail + " vs empEmail : " + empEmail);
	   
	   //empOriginEmail과 empEmail이 다를 때 작동.
	   if(empOriginEmail!=empEmail){
		   if(!isEmailChecked){
		     Swal.fire({
		           icon: 'error',
		           title: '이메일 중복 여부를 확인해주세요.',
		           text: ''
		     });
		     $("#empEmail")[0].focus(); // 커서를 이메일 텍스트박스로 옮김!
		     return; // 함수종료하여 밑으로 내려가지 않게 함
		   }//end if
	   }
	   
		// 비밀번호 정규 표현식
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
		      return;
		}
	   
	   // empPassword1비밀번호확인과 empPassword가 같아야함
	   if(empPassword1 && empPassword != null){
		   if(empPassword1!=empPassword){
			     Swal.fire({
			           icon: 'error',
			           title: '비밀번호가 일치하지 않습니다.',
			           text: ''
			     });
			     $("#empPassword")[0].focus(); // 커서를 비밀번호 텍스트박스로 옮김!
			     return; 
		   }
	   } else {
		     Swal.fire({
		           icon: 'error',
		           title: '비밀번호는 필수 입력 사항입니다.',
		           text: ''
		     });
		     $("#empPassword")[0].focus(); // 커서를 비밀번호 텍스트박스로 옮김!
		     return; 
	   }
	
	   let employeeVO = {
		"empNo":empNo,
		"empEmail":empEmail,
		"empOriginEmail":empOriginEmail,
		"empTelno":empTelno,
		"empZip":empZip,
		"empAddr":empAddr,
		"empDtlAddr":empDtlAddr,
		"empPassword":empPassword,
	   };
	   
// 	   console.log("체킁:", employeeVO);
	   
		$.ajax({
			type:"post",
			url: "/emp/updateMyInfo",
			data : JSON.stringify(employeeVO),
			contentType:"application/json; charset=UTF-8",
			dataType:"text",
			success:function(rslt){
// 				console.log("성공체크 : " , rslt);
			},
			error: function (xhr, status, error) {  
// 				console.log("code: " + xhr.status)
// 				console.log("message: " + xhr.responseText)
// 				console.log("error: " + error);
	     	}
		});//end ajax
		 Swal.fire({
	           icon: 'success',
	           title: '정보수정완료',
	           text: '정보수정이 완료되었습니다.'
	     });
	    modalBox.removeClass("active");
	    $("#empInfoModal")[0].reset();
	 });//나의 정보 폼 전송 끝
	 
	 
	// --------------------------- 웹소켓-------------------------------------
	let webSocket; 
	function connect() {
	  //  webSocket = new WebSocket("ws://192.168.142.26/emrsoc"); // End Point
	   webSocket = new WebSocket("ws://localhost/emrsoc"); // End Point
	  	//이벤트에 이벤트핸들러 등록
	  	webSocket.onopen = fOpen; // 소켓 접속되면 자동 실행할 함수
	  	webSocket.onmessage = fMessage; // 서버에서 메세지 오면 자동으로 실행할 함수
	}
 
	 
	function fOpen(){
		let loginId = "min";
		//webSocket.send(loginId + ",header");
	}

	function fCloseWebSocket() {
    // WebSocket 객체를 닫음
    webSocket.close();
	}

	// --------------------------- /웹소켓 ------------------------------------- 
	function getNotiList(){
// 		console.trace();
			//일정 업데이트 시 알림내역 목록
	let empNo = "${empVO.empNo}";
// 	console.log("로그인 한 empNo : " + empNo);
	
	//가상 폼 
	let formData = new FormData();
	formData.append("empNo",empNo);
	
	$.ajax({
		url:"/calendar/selectNoti",
		processData:false,
		contentType:false,
		data:formData,
		type:"post",
		dataType:"json",
		success:function(result){
// 			console.log("result :",result);
			//result : List<NotificationVO>
			
		 	
			
			if(result.length==0){
		        let str = "<li style='text-align: center; font-size :13px;'><span class='centered-text'>알림내역이 없습니다.</span></li>";
		        $("#ulNoti").html(str);
		        $("#circle").html(0);
			}else{
				let str = "";
				let cnt = 0;
				
				
				$.each(result,function(index,notificationVO){
					const relativeTime = convertTimeToRelative(result[index].ntcnDt);
					
					if(notificationVO.ntcnGubun=="일정"){
						str += "<li><a class='dropdown-item' href='/calendar/schedule?ntcnId="+notificationVO.ntcnId+"'>";
					}else if(notificationVO.ntcnGubun=="공지사항"){
						str += `<li><a class='dropdown-item' href='/board/noti/\${notificationVO.ntcnUrl}/\${notificationVO.ntcnId}'>`;
					}else{
						str += "<li><a class='dropdown-item' href='/calendar/schedule?ntcnId="+notificationVO.ntcnId+"'>";
					}
					str += `<i class='fa fa-bell me-2'></i> <span class='align-middle'>\${notificationVO.ntcnContent}&nbsp;&nbsp;&nbsp;\${relativeTime}</span></a>`;
					str += "</li><li><div class='dropdown-divider'></div></li>";
					cnt++;
				});
				str += "<li style='float:right; margin-right : 10px; '><button type='button' id='deleteAll' onclick='deleteAll()' class='btn btn-secondary' style='font-size : 12px;' >전체삭제</button></li>"
				$("#ulNoti").html(str);
				$("#circle").html(cnt);
			}
		},
		error: function(xhr, status, error) {
//     	    console.log("code: " + xhr.status);
//     	    console.log("message: " + xhr.responseText);
//     	    console.log("error: " + error);
    	}
	});
	}
	const $menuNav = $('#menuNav');
	function getMenuList(){
		let authGrpCode = `${empVO.userAuthList[0].authGrpCode}`;
// 		console.log("권한은!"+authGrpCode);
		$.ajax({
			url : "/menu/list/"+authGrpCode,
			get : "get",
			success : function(result){
// 				console.log(result);
				let txt = "";
				for(let i = 0; i<result.length; i++){
					let r = result[i];
					if(r.upperMenuId == null && r.switchYn == 'Y'){
						txt += 
							`
							<div class="btn-group" style="margin-right : 30px;">
								<a id="\${r.menuId}" class="nav-item nav-link" href="\${r.menuUrl}"><strong>\${r.menuName}</strong></a>
							</div>
							`;
					}
					if(r.upperMenuId == null && r.switchYn == 'N'){
						txt +=
							`
				              <div class="btn-group"  style="margin-right : 30px;">
					              <a class=" nav-item nav-link" data-bs-toggle="dropdown" aria-expanded="true"><strong>\${r.menuName}</strong></a>
					              <ul class="dropdown-menu" id="\${r.menuId}" style="position: absolute; inset: 0px auto auto 0px; margin: 0px; transform: translate(0px, 40px);" data-popper-placement="bottom-start">
					              </ul>
             				 </div>
							`;
					}
					
				}
 				$menuNav.html(txt);
 				for(let i=0; i<result.length; i++){
 					let r = result[i];
 					if(r.switchYn == 'Y' && r.upperMenuId != null){
						 let $ul = $('#' + r.upperMenuId);
// 						    console.log("찾으려는 id", r.upperMenuId);
						 let txt2 = 
						        `
                 				 <li><a class="dropdown-item" href="\${r.menuUrl}">\${r.menuName}</a></li> 
						        `;
						 $ul.append(txt2);
// 						 console.log("목록들", txt2);
					}
 				}
			}
		});
	}
	
	const insertPat = () => {
		  // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
		let params = $("#iForm").serialize();
		params = decodeURIComponent(params);
		
// 		console.log("params : " + params);
		  
		Swal.fire({
			  title: '환자 등록을 완료하시겠습니까?',
			  text: "확인 시 환자 등록이 완료됩니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
			    vModal.css("display", "none");
			    $.ajax({
			      url: '/office/insertPat',
			      type: 'POST',
			      data: params,
			      contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			      dataType: 'text',
			      success: function (result) {
			        if (result) {
			          Swal.fire({
			            icon: 'success',
			            title: '완료!',
			            text: '환자 등록이 완료되었습니다.'
			          });
			        }
			      },
			      error:function(request,status,error){
//	 		            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			        }
			    });
			  }
			});
	}
	function insertAndReceipt(){
		var params = $("#iForm").serialize();
		params = decodeURIComponent(params);
		
	 	insertPat();
	 	setTimeout(function(){
// 	 		console.log("ㅡㅡㅡㅡ")
	 		$.ajax({
	 			url : `/office/selectPatNoByName`,
	 			type : "POST",
	 			data:params,
	 		    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	 		    dataType: 'json',
	 		    success : function(result){
// 	 		    	console.log("오잉",result.patCode);
	 		    	insModal.css("display","none");
	 		    	receipt(result.patCode);	 		    	
	 		    }
	 			
	 		});
	 		
	 	}, 3000);
		
	}
	
	
	//자동완성버튼
	function autoComplBtn(){
		$("#patName").val("김신규");
		$("#patTel").val("010-4307-5115");  
		$("#patIhidnum").val("941225-1400000");  
		$("#patZip").val("35201");  
		$("#patAddr").val("대전 서구 만년로 25");  
		$("#patDtlAddr").val("강변아파트");  
		$("#patFirstDate").val("2023-10-17");  
	}

</script>