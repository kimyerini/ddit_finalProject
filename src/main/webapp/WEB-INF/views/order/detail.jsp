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
<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.3.0/exceljs.min.js"
	integrity="sha512-UnrKxsCMN9hFk7M56t4I4ckB4N/2HHi0w/7+B/1JsXIX3DmyBcsGpT3/BsuZMZf+6mAr0vP81syWtfynHJ69JA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link href="/resources/css/orderdoc.css" rel="stylesheet" />
<title>발주내역</title>
<style>
.container-p-y {
	display: flex;
}
#div1 {
	margin: 11px 28px 0px 10px;
}
#div2 {
	margin: 48px 0px 0px 0px;
    width: 45vw;
    height: 77vh;
    overflow: auto;
}
.tab-content {
	width: 50vw;
	height: 77vh;
}
.card-header {
	padding: 0px 0px 0px 0px;
    font-weight: bolder;
    margin: 5px 0px 25px 0px;
}
.doc-header {
	padding: 0px 0px 0px 0px;
    font-weight: bolder;
	margin: 30px 0px 30px 25px;
}
#mediTable, #equipTable {
	overflow: auto;
	height: 65vh;
}
#mediOrderTable, #equipOrderTable td {
	font-size: 14px;
}
#savePdfBtn {
    width: 4vw;
    height: 4vh;
    margin-top: 25px;
    margin-left: 662px;
}
#orderDocDiv {
	margin-left: 26px;
}
#orderStamp {
    margin: 12px 0px 61px 44px;
    height: 63%;
}
</style>
</head>
<body>
	<div class="nav-align-top mb-4" id="div1">
		<!-------------------- 탭 -------------------->
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item">
				<button type="button" class="nav-link active" role="tab" data-bs-toggle="tab"
					data-bs-target="#mediTab" aria-controls="navs-top-home" aria-selected="true">약품</button>
			</li>
			<li class="nav-item">
				<button type="button" class="nav-link" role="tab" data-bs-toggle="tab"
					data-bs-target="#equipTab" aria-controls="navs-top-profile" aria-selected="false">비품</button>
			</li>
		</ul>
		
		<div class="tab-content">
			<!---------------------- 약품 상세 조회 ---------------------->
			<div class="tab-pane fade active show" id="mediTab" role="tabpanel">
				<div class="orderHeader">
					<h4 class="card-header">약품 발주 내역</h4>
				</div><!-- order header 끝 -->
				<!-- 테이블 처리 -->
				<div class="table-responsive text-nowrap" id="mediTable">
				</div><!-- table div 끝 -->
			</div>
			<!---------------------- /약품 상세 조회 ---------------------->
			
			<!---------------------- 비품 상세 조회 ---------------------->
			<div class="tab-pane" id="equipTab" role="tabpanel">
				<div class="orderHeader">
					<h4 class="card-header">비품 발주 내역</h4>
				</div><!-- order header 끝 -->
				<!-- 테이블 처리 -->
				<div class="table-responsive text-nowrap" id="equipTable">
				</div><!-- table div 끝 -->
			</div>
			<!---------------------- /비품 상세 조회 ---------------------->
		</div>
	</div>

	<div class="card" id="div2">
		<div class="orderHeader" style="display:flex;">
			<h4 class="doc-header">발주서</h4>
			<button type="button" class="btn btn-info" id="savePdfBtn">PDF</button>
		</div>
		<!----------- 발주서 html ----------->
		<div id="orderDocDiv">
			<div id="pdfContainer" class="hpa" style="width: 210mm; height: 296.99mm;">
				<div class="hcD" style="left: 10mm; top: 15mm;">
					<div class="hcI">
						<div class="hls ps20" style="line-height: 10.48mm; white-space: nowrap; left: 0mm; top: -0.53mm; height: 10.58mm; width: 189.99mm;">
							<span class="hrt cs7">발 주 서</span>
						</div>
						<div class="hls ps21" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 16.76mm; height: 3.53mm; width: 189.99mm;">
							<span class="hrt cs8" id="docOrderNo"></span>
						</div>
						<div class="hls ps21" style="line-height: 44.40mm; white-space: nowrap; left: 0mm; top: 22.58mm; height: 44.40mm; width: 189.99mm;">
							<div class="htb" style="width: 190mm; height: 44.40mm; display: inline-block; position: relative; vertical-align: -15%; line-height: 44.40mm;">
								<svg class="hs" viewBox="-2.50 -2.50 195 49.40" style="left: -2.50mm; top: -2.50mm; width: 195mm; height: 49.40mm;">
									<path d="M0,0 L0,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M9.06,0 L9.06,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M28.82,0 L28.82,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M75.53,10.94 L75.53,21.22"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M75.53,32.16 L75.53,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M95.29,10.94 L95.29,21.22"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M95.29,32.16 L95.29,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M146,0 L146,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M188.01,0 L188.01,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,0 L188.07,0"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M9.01,10.94 L188.07,10.94"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M9.01,21.21 L146.06,21.21"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M9.01,32.16 L146.06,32.16"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,42.40 L188.07,42.40"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M188.01,0 L188.01,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M0,0 L0,42.41"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,42.40 L188.07,42.40"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,0 L188.07,0"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path></svg>
								<div class="hce" style="left: 0mm; top: 0mm; width: 9.06mm; height: 42.40mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 13.30mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 5.46mm;">
												<span class="hrt cs8">발</span>
											</div>
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 5.47mm; height: 3.53mm; width: 5.46mm;">
												<span class="hrt cs8">주</span>
											</div>
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 11.11mm; height: 3.53mm; width: 5.46mm;">
												<span class="hrt cs8">처</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 9.06mm; top: 0mm; width: 19.76mm; height: 10.94mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 0.39mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">사업자</span>
											</div>
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 5.47mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">등록번호</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 28.82mm; top: 0mm; width: 117.18mm; height: 10.94mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 3.21mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 113.58mm;">
												<span class="hrt cs8">&nbsp;306-82-05291</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 146mm; top: 0mm; width: 42.01mm; height: 10.94mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 3.21mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 38.41mm;">
												<span class="hrt cs8">원부대조필 인</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 9.06mm; top: 10.94mm; width: 19.76mm; height: 10.27mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.87mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">상 호</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 28.82mm; top: 10.94mm; width: 46.71mm; height: 10.27mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.87mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 43.11mm;">
												<span class="hrt cs8">&nbsp;대덕 아작(나)스 병원</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 75.53mm; top: 10.94mm; width: 19.76mm; height: 10.27mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.87mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">발주자</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 95.29mm; top: 10.94mm; width: 50.71mm; height: 10.27mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.87mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 47.10mm;">
												<span class="hrt cs8" id="empName"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 146mm; top: 10.94mm; width: 42.01mm; height: 31.46mm;">
									<img id="orderStamp" src="/resources/images/stamp.jpg">
								</div>
								<div class="hce" style="left: 9.06mm; top: 21.21mm; width: 19.76mm; height: 10.94mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 0.39mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">사업장</span>
											</div>
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 5.47mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">소재지</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 28.82mm; top: 21.21mm; width: 117.18mm; height: 10.94mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 3.21mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 113.58mm;">
												<span class="hrt cs8">&nbsp;대전광역시 중구 계룡로 846, 3-4층</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 9.06mm; top: 32.16mm; width: 19.76mm; height: 10.25mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.86mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">Tel</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 28.82mm; top: 32.16mm; width: 46.71mm; height: 10.25mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.86mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 43.11mm;">
												<span class="hrt cs8">&nbsp;042-222-8202</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 75.53mm; top: 32.16mm; width: 19.76mm; height: 10.25mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.86mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 16.16mm;">
												<span class="hrt cs8">Fax</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 95.29mm; top: 32.16mm; width: 50.71mm; height: 10.25mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.86mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 47.10mm;">
												<span class="hrt cs8">&nbsp;070-8768-2972</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="hls ps21" style="line-height: 197.58mm; white-space: nowrap; left: 0mm; top: 69.09mm; height: 197.58mm; width: 189.99mm;">
							<div class="htb" style="width: 190mm; height: 197.58mm; display: inline-block; position: relative; vertical-align: -15%; line-height: 197.58mm;">
								<svg class="hs" viewBox="-2.50 -2.50 195 202.58" style="left: -2.50mm; top: -2.50mm; width: 195mm; height: 202.58mm;">
									<path d="M0,0 L0,195.59"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M10.88,0 L10.88,146.34"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M75.20,146.34 L75.20,156.80"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M111.62,0 L111.62,146.34"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M123.17,0 L123.17,146.34"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M134.72,0 L134.72,146.34"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M146.27,0 L146.27,146.34"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M167.14,0 L167.14,146.34"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M188,0 L188,195.59"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,0 L188.07,0"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,10.45 L188.07,10.45"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,20.91 L188.07,20.91"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,31.36 L188.07,31.36"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,41.81 L188.07,41.81"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,52.26 L188.07,52.26"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,62.72 L188.07,62.72"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,73.17 L188.07,73.17"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,83.62 L188.07,83.62"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,94.08 L188.07,94.08"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,104.53 L188.07,104.53"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,114.98 L188.07,114.98"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,125.43 L188.07,125.43"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,135.89 L188.07,135.89"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,146.34 L188.07,146.34"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,156.79 L188.07,156.79"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,195.58 L188.07,195.58"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M188,0 L188,195.59"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M0,0 L0,195.59"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,195.58 L188.07,195.58"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
									<path d="M-0.06,0 L188.07,0"
										style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path></svg>
								<div class="hce" style="left: 0mm; top: 0mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8">No</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 10.88mm; top: 0mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8">품 명</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 111.62mm; top: 0mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8">단위</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 123.17mm; top: 0mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8">단가</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 134.72mm; top: 0mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8">수량</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 146.27mm; top: 0mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8">금액</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 167.14mm; top: 0mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8">비고</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 10.45mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo1"></span>	
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 10.45mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName1"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 10.45mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit1"></span>	
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 10.45mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice1"></span>	
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 10.45mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty1"></span>	
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 10.45mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal1"></span>		
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 10.45mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc1"></span>		
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 20.91mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo2"></span>		
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 20.91mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName2"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 20.91mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit2"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 20.91mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice2"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 20.91mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty2"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 20.91mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal2"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 20.91mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc2"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 31.36mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo3"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 31.36mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName3"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 31.36mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit3"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 31.36mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice3"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 31.36mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty3"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 31.36mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal3"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 31.36mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc3"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 41.81mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo4"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 41.81mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName4"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 41.81mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit4"></span>
												</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 41.81mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice4"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 41.81mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty4"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 41.81mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal4"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 41.81mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc4"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 52.26mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo5"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 52.26mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName5"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 52.26mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit5"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 52.26mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice5"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 52.26mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty5"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 52.26mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal5"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 52.26mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc5"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 62.72mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo6"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 62.72mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName6"></span>
												</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 62.72mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit6"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 62.72mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice6"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 62.72mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty6"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 62.72mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal6"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 62.72mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc6"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 73.17mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo7"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 73.17mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName7"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 73.17mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit7"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 73.17mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice7"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 73.17mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty7"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 73.17mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal7"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 73.17mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc7"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 83.62mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 83.62mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 83.62mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 83.62mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 83.62mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 83.62mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 83.62mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 94.08mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo9"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 94.08mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName9"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 94.08mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit9"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 94.08mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice9"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 94.08mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty9"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 94.08mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal9"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 94.08mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc9"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 104.53mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo10"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 104.53mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName10"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 104.53mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit10"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 104.53mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice10"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 104.53mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty10"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 104.53mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal10"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 104.53mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc10"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 114.98mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo11"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 114.98mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName11"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 114.98mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnite11"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 114.98mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice11"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 114.98mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty11"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 114.98mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal11"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 114.98mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc11"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 125.43mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo12"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 125.43mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName12"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 125.43mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit12"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 125.43mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice12"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 125.43mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty12"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 125.43mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal12"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 125.43mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc12"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 0mm; top: 135.89mm; width: 10.88mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.28mm;">
												<span class="hrt cs8" id="docNo13"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 10.88mm; top: 135.89mm; width: 100.74mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.13mm;">
												<span class="hrt cs8" id="docName13"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 111.62mm; top: 135.89mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docUnit13"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 123.17mm; top: 135.89mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docPrice13"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 134.72mm; top: 135.89mm; width: 11.55mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 7.94mm;">
												<span class="hrt cs8" id="docQty13"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 146.27mm; top: 135.89mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docTotal13"></span>
											<span class="hrt cs8"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce"
									style="left: 167.14mm; top: 135.89mm; width: 20.87mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.26mm;">
												<span class="hrt cs8" id="docEtc13"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 0mm; top: 146.34mm; width: 75.20mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 71.60mm;">
												<span class="hrt cs8">합 &nbsp;계</span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 75.20mm; top: 146.34mm; width: 112.80mm; height: 10.45mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 2.96mm;">
											<div class="hls ps0" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 109.21mm;">
												<span class="hrt cs8" id="totalPrice"></span>
											</div>
										</div>
									</div>
								</div>
								<div class="hce" style="left: 0mm; top: 156.79mm; width: 188mm; height: 38.79mm;">
									<div class="hcD" style="left: 1.80mm; top: 0.50mm;">
										<div class="hcI" style="top: 0.20mm;">
											<div class="hls ps20"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 184.40mm;"></div>
											<div class="hls ps20"
												style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 5.47mm; height: 3.53mm; width: 184.40mm;">
												<span class="hrt cs8" id="orderDate"></span>
											</div>
											<div class="hls ps22" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 11.11mm; height: 3.53mm; width: 184.40mm;"></div>
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 16.76mm; height: 3.53mm; width: 184.40mm;">
												<span class="hrt cs9" id="orderCompany"></span>
											</div>
											<div class="hls ps22" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 22.40mm; height: 3.53mm; width: 184.40mm;"></div>
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 28.05mm; height: 3.53mm; width: 184.40mm;">
												<span class="hrt cs8">아래와 같이 발주합니다.</span>
											</div>
											<div class="hls ps20" style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 33.69mm; height: 3.53mm; width: 184.40mm;"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!----------- /발주서 html ----------->
	</div>
</body>
<script>
//-------------------- 웹소켓 ----------------------
function fMessage() { // 받는 쪽에 작성
	let serverMsg = JSON.parse(event.data);

	if (serverMsg.cmd == "alarm") {
		getNotiList();
	}
}
//-------------------- /웹소켓 ----------------------

$(function() {
	getMediList(function() {
		$('#mediOrderTable tbody tr').on('click', function() {
			
			// tr 개수 구하기
			let trCount = $('#mediOrderTable >tbody tr').length;

			// 기존 값 초기화
			$('#docOrderNo').text("");
			$('#empName').text("");
			$('#totalPrice').text("");
			$('#orderDate').text("");
			$('#orderCompany').text("");
			for (let i=1; i<=trCount; i++) {
				$('#docNo' + i).text("");
				$('#docName' + i).text("");
				$('#docUnit' + i).text("");
				$('#docPrice' + i).text("");
				$('#docQty' + i).text("");
				$('#docTotal' + i).text("");
			}
		    
			let orderNo = $.trim($(this).children().eq(0).text());
			console.log("발주번호: ", orderNo);
			
			let xhr = new XMLHttpRequest();
			xhr.open("get", "/order/mediOrderDetail/" + orderNo, true);
			xhr.onreadystatechange = function() {
				if(xhr.readyState == 4 && xhr.status == 200) {
					let result = JSON.parse(xhr.responseText)[0];
					console.log("result", result);
					
					$('#docOrderNo').text(" No.  " + result.mediItemOrderNo);
					$('#empName').text(result.empNm);
					
					let totalPrice = 0;
					let items = result.mediItemList;
					
					for(let i=0; i<items.length; i++) {
						let item = items[i];
						let idPrefix = i + 1;
// 						console.log(idPrefix + "번째 item: " + JSON.stringify(item));
						
						$('#docNo' + idPrefix).text(i + 1);
						$('#docName' + idPrefix).text(item.mediItemName);
						$('#docUnit' + idPrefix).text(item.mediItemUnit);
						$('#docPrice' + idPrefix).text(item.mediItemPrice.toLocaleString());
						$('#docQty' + idPrefix).text(item.mediItemReqQy);
						$('#docTotal' + idPrefix).text(item.mediItemReqTotal.toLocaleString());
						totalPrice += item.mediItemReqTotal;
					}
					
					$('#totalPrice').text(totalPrice.toLocaleString() + "\t\t\t원");
					
					let date = result.mediItemOrderDate;
					let dateArr = date.split('-');
// 					console.log("dateArr", dateArr);
					$('#orderDate').text(dateArr[0] + "년\t\t\t" + dateArr[1] + "월\t\t\t" + dateArr[2] + "일");
					
					$('#orderCompany').text(result.mediItemList[0].mediItemMakr + "\t\t\t귀하");
				}
			}
			xhr.send();
		});
	});
	getEquipList(function(){
		$('#equipOrderTable tr').on('click', function() {
			
			// tr 개수 구하기
			let trCount = $('#mediOrderTable >tbody tr').length;

			// 기존 값 초기화
			$('#docOrderNo').text("");
			$('#empName').text("");
			$('#totalPrice').text("");
			$('#orderDate').text("");
			$('#orderCompany').text("");
			for (let i=1; i<=trCount; i++) {
				$('#docNo' + i).text("");
				$('#docName' + i).text("");
				$('#docUnit' + i).text("");
				$('#docPrice' + i).text("");
				$('#docQty' + i).text("");
				$('#docTotal' + i).text("");
			}
			
			let orderNo = $.trim($(this).children().eq(0).text());
// 			console.log("발주번호: ", orderNo);
			
			let xhr = new XMLHttpRequest();
			xhr.open("get", "/order/equipOrderDetail/" + orderNo, true);
			xhr.onreadystatechange = function() {
				if(xhr.readyState == 4 && xhr.status == 200) {
					let result = JSON.parse(xhr.responseText)[0];
					console.log("클릭한 tr 상세보기", result);
					
					$('#docOrderNo').text(" No.  " + result.itemOrderNo);
					$('#empName').text(result.empNm);
					let totalPrice = 0;
					
					for(let i=0; i<result.itemList.length; i++) {
						let item = result.itemList[i];
						let idPrefix = i + 1;
						console.log(idPrefix + "번째 itemList: " + JSON.stringify(item));
						
						$('#docNo' + idPrefix).text(i + 1);
						
						$('#docName' + idPrefix).text(item.itemName);
						$('#docUnit' + idPrefix).text("개");
						$('#docPrice' + idPrefix).text(item.itemPrice.toLocaleString());
						$('#docQty' + idPrefix).text(item.itemReqQy);
						$('#docTotal' + idPrefix).text(item.itemReqTotal.toLocaleString());
						totalPrice += item.itemReqTotal;
					}
					
					$('#totalPrice').text(totalPrice.toLocaleString() + "\t\t\t원");
					
					let date = result.itemOrderDate;
					let dateArr = date.split('-');
// 					console.log("dateArr", dateArr);
					$('#orderDate').text(dateArr[0] + "년\t\t\t" + dateArr[1] + "월\t\t\t" + dateArr[2] + "일");
					
					$('#orderCompany').text(result.itemList[0].itemMakr + "\t\t\t귀하");
				}
			}
			xhr.send();
		});
	});
	
});

const getMediList = (callback) => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/order/mediOrderList", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
// 			console.log("받아온 약품 발주리스트", result);
			
			let tblStr = `<table class="table table-hover" id="mediOrderTable">
				<thead>
					<tr>
						<th>발주번호</th>
						<th>약품정보</th>
						<th>발주일자</th>
						<th>발주인</th>
					</tr>
				</thead>
				<tbody>`;
			if (result.length == 0 || result == null) {
				tblStr += `<tr>
								<td colspan="4" style="text-align:center;">
									<br><br><br><br><br><br><br><br><br><br><br>
									조회할 약품 발주내역이 없습니다
									<br><br><br><br><br><br><br><br><br><br><br><br>
								</td>
							</tr>`;
			} else {
				for(let i=0; i<result.length; i++) {
					tblStr += `<tr>
									<td>\${result[i].mediItemOrderNo}</td>`;

					if(result[i].mediItemList.length > 1) {
						tblStr += `<td>\${result[i].mediItemList[0].mediItemName} 외 \${result[i].mediItemList.length - 1}건</td>`;
					} else {
						tblStr += `<td>\${result[i].mediItemList[0].mediItemName}</td>`;
					}
					
					tblStr += `<td>\${result[i].mediItemOrderDate}</td>
								<td>\${result[i].empNm}</td>
						   </tr>`;
				}
			}
			tblStr += `</tbody></table>`;
			
		//		console.log("tblStr" + tblStr);
			$('#mediTable').html(tblStr);
			
			callback();
		}
	}
	xhr.send();
}

const getEquipList = (callback) => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/order/equipOrderList", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
// 			console.log("받아온 비품 발주리스트", result);
			
			let tblStr = `<table class="table table-hover" id="equipOrderTable">
				<thead>
					<tr>
						<th>발주번호</th>
						<th>비품정보</th>
						<th>발주일자</th>
						<th>발주인</th>
					</tr>
				</thead>
				<tbody>`;
			if (result.length == 0 || result == null) {
				tblStr += `<tr>
								<td colspan="4" style="text-align:center;">
									<br><br><br><br><br><br><br><br><br><br><br>
									조회할 비품 발주내역이 없습니다
									<br><br><br><br><br><br><br><br><br><br><br><br>
								</td>
							</tr>`;
			} else {
				for(let i=0; i<result.length; i++) {
					tblStr += `<tr>
									<td>\${result[i].itemOrderNo}</td>`;
									
					if(result[i].itemList.length > 1) {
						tblStr += `<td>\${result[i].itemList[0].itemName} 외 \${result[i].itemList.length}건</td>`;
					} else {
						tblStr += `<td>\${result[i].itemList[0].itemName}</td>`;
					}
									
					tblStr += `<td>\${result[i].itemOrderDate}</td>
								<td>\${result[i].empNm}</td>
						   </tr>`;
				}
			}
			tblStr += `</tbody></table>`;
			
		//		console.log("tblStr" + tblStr);
			$('#equipTable').html(tblStr);
			
			callback();
		}
	}
	xhr.send();
}

// PDF 저장 함수
$('#savePdfBtn').on('click', function() {
	
	let orderNo = document.querySelector('#docOrderNo').innerHTML;
	if(orderNo == null || orderNo == "") {
		Swal.fire({
    		icon: 'error',
    		title: '저장할 발주내용이 없습니다.',
    		text: '발주내역을 선택해주세요.'
   		});
	} else {
		mkPdf("pdfContainer", "아작(나)스_발주서.pdf");
	}
});

let jsPDF = jspdf.jsPDF;

// PDF 생성 함수
function mkPdf(containerId, pdfName) {
	html2canvas($(`#\${containerId}`)[0]).then(function(canvas) { // 지정한 containerId의 div 요소를 캡처하여 PDF를 생성
		
		// 캔버스를 이미지로 변환
		const imgData = canvas.toDataURL("image/png"); // 캔버스 이미지 데이터를 PNG 형식의 데이터 URL로 추출
		const imgWidth = 210; // 가로 사이즈 지정, A4사이즈
		const pageHeight = imgWidth * 1.414; // 세로 사이즈 계산 (1.414로 곱하는 이유는 뭐지?)
		const imgHeight = (canvas.height * imgWidth) / canvas.width; // 이미지 높이 계산
		
		// jsPDF 인스턴스 생성
		const doc = new jsPDF({
			orientation: "p", // 페이지 방향 (p: 세로)
			unit: "mm", // 측정 단위 (mm: 밀리미터)
			format: "a4", // 페이지 형식 (a4: A4 사이즈)
		});
		
		let heightLeft = imgHeight; // 아직 출력되지 않은 세로 공간의 높이
		let position = 0; // 페이지 내에서 이미지의 상단 위치
		
		// 첫 페이지에 이미지 추가
		doc.addImage(imgData, "png", 0, position, imgWidth, imgHeight);
		heightLeft -= pageHeight; // 아직 남은 세로 공간 계산
		
		// 페이지 높이보다 많은 이미지가 있는 경우 여러 페이지에 걸쳐 이미지를 추가
		while(heightLeft >= 20) {
			position = heightLeft - imgHeight;
			doc.addPage();
			doc.addImage(imgData, "png", 0, position, imgWidth, imgHeight);
			heightLeft -= pageHeight;
		}
		
		// 생성한 PDF를 Blob 형태로 추출
		var blobPDF = doc.output('blob');
		console.log("blobPDF: ", blobPDF);
		
		// "No. "를 제외한 orderNo를 추출
		let orderNo = document.querySelector("#docOrderNo").innerHTML.trim();
// 		console.log("No 지우기 전 orderNo", orderNo);
		if(orderNo.startsWith("N")) {
			orderNo = orderNo.substr(5);
		}
// 		console.log("orderNo잘려", orderNo);
		
		// FormData 객체에 PDF파일과 관련정보 추가
		let formData = new FormData();
		formData.append("pdfFile", blobPDF); // PDF 파일 추가
		formData.append("fileName", orderNo + "_" + pdfName); // 파일 이름 추가
		formData.append("orderNo", orderNo); // 요청 문서 번호 추가
		
		console.log("orderNo", formData.get("orderNo"));
		
		let xhr = new XMLHttpRequest();
		xhr.open("post", "/order/pdf", true);
// 		xhr.setRequestHeader(header, token);
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				let fileName = xhr.responseText;
				console.log("파일이름 넘어왔나용", fileName);
				
				location.href = "/download?fileName=" + fileName;
			}
		}
		xhr.send(formData);
	});
}

// 엑셀 저장 함수
$('#saveExcelBtn').on('click', function() {
	
	let orderNo = document.querySelector('#docOrderNo').innerHTML;
	if(orderNo == null || orderNo == "") {
		Swal.fire({
    		icon: 'error',
    		title: '저장할 발주내용이 없습니다.',
    		text: '발주내역을 선택해주세요.'
   		});
	} else {
		
	}
});

</script>
</html>