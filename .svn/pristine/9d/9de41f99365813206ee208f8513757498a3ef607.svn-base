<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
		<sec:authentication property="principal.employee" var="imsiVO" />
		<sec:authentication property="principal.employee" var="empVO" />
		<!DOCTYPE html>
		<html>
		<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
		<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet" />
		<link href="/resources/css/demo.css" rel="stylesheet" />
		<link href="/resources/css/diagno.css" rel="stylesheet" />
		<link href="/resources/css/opinion.css" rel="stylesheet" />

		<head>
			<meta charset="UTF-8">
			<title>제증명</title>
		</head>
		<style>
			.mygrid {
				border: 1px solid black;
			}

			.mygrid-title {
				text-align: right;
				font-size: 0.8 rem;
			}

			#diagnoModal,
			#opinionModal {
				position: fixed;
				width: 800px;
				/* 	height: 700px; */
				background-color: white;
				display: none;
				z-index: 9999;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				box-shadow: 5px 5px 5px 5px gray;
			}

			.form-control {
				width: 35%;
				display: inline-block;
				margin-right: 15px;
			}

			.mb-3 {
				margin-bottom: 0.3rem !important;
			}

			.mb-4 {
				margin-bottom: 0.4rem !important;
				display: block;
			}

			.col-md-6 {
				width: auto;
			}

			.dropdown-toggle {
				margin: 10px;
			}

			.grid-stack-item-content {
				overflow: hidden;
			}

			.medi {
				width: 80px;
			}

			.mb-3 {
				text-align: left;
			}

			.form-control-sm {
				border: none;
			}

			.gs-id-0>.grid-stack-item[gs-h="2.5"] {
				height: 380px;
			}

			.gs-id-0>.grid-stack-item[gs-h="2.7"] {
				height: 400px;
			}


			.gs-id-0>.grid-stack-item[gs-h="3.5"] {
				height: 410px;
			}

			.gs-id-0>.grid-stack-item[gs-h="4.5"] {
				height: 660px;
			}

			.gs-12>.grid-stack-item[gs-w="6"] {
				width: 50%;
			}

			.gs-id-0>.grid-stack-item[gs-y="2.5"] {
				top: 373.333px;
			}

			.hidden-cell {
				display: none;
			}

			#callPat {
				margin-left: 10px;
			}
			
			#autoCompleteBtn {
			    height: 25px;
			    display: flex; 
			    justify-content: center;
			     align-items: center;
			}
		</style>

		<body>

			<div class="grid-stack"></div>

			<!-- ///////////////////////////////////진단서작성 모달 시작/////////////////////////////////// -->
			<div class="col-xxl" id="diagnoModal">
				<div class="card mb-4" style="box-shadow: none;">
					<div class="modal-header">
						<h4 class="pb-2 border-bottom mb-4"
							style="text-align: left; margin-right: 120px; font-weight: bold;">진단서 작성</h4>
						<button type="button" id="autoCompleteBtn" class="btn btn-xs btn-dark" onclick="autoComplBtnD()">자동완성</button>
					</div>
					<div class="card-body">
						<form id="iForm">
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="patName">환자명</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="patName1" name="patName" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="patIhidnum">주민등록번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="patIhidnum1" name="patIhidnum" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="patAddr">주소</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="patAddr1" name="patAddr"
										style="width: 29vw;" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="documentDissCn">병명</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="documentDissCn1" name="documentDissCn"
										style="width: 29vw;" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="documentDissClNo">질병분류번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="documentDissClNo1"
										name="documentDissClNo" style="width: 29vw;" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="documentOpinion">향후치료의견</label>
								<div class="col-sm-10">
									<textarea class="form-control" id="documentOpinion1" name="documentOpinion"
										cols="30" rows="5" style="width: 29vw;"></textarea>
								</div>
							</div>
							<div style="display:flex;">
								<div class="row mb-3">
									<label class="col-sm-2 col-form-label" for="documentPrpos">용도</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="documentPrpos1" name="documentPrpos"
											style="width: 14vw;">
									</div>
								</div>
								<div class="row mb-3">
									<label class="col-sm-2 col-form-label" for="documentRm">비고</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="documentRm1" name="documentRm"
											style="width: 14vw;">
									</div>
								</div>
							</div>
							<div class="row justify-content-end" style="float: right;">
								<div class="col-sm-10" style="margin-left: 25px; margin-bottom: 15px;">
									<button type="button" class="btn btn-primary" onclick="diagnoSave()">등록</button>
									<button type="button" id="closeBtn" class="btn btn-danger"
										onclick="closeDetailModal()">닫기</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- ///////////////////////////////////진단서작성 모달 끝/////////////////////////////////// -->



			<!-- ///////////////////////////////////소견서작성 모달 시작/////////////////////////////////// -->
			<div class="col-xxl" id="opinionModal">
				<div class="card mb-4" style="box-shadow: none;">
					<div class="modal-header">
						<h4 class="pb-2 border-bottom mb-4"
							style="text-align: left; margin-right: 120px; font-weight: bold;">소견서 작성</h4>
						<button type="button" id="autoCompleteBtn" class="btn btn-xs btn-dark" onclick="autoComplBtnO()">자동완성</button>
					</div>
					<div class="card-body">
						<form id="iForm">
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="patName">환자명</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="patName2" name="patName" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="patIhidnum">주민등록번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="patIhidnum2" name="patIhidnum" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="patAddr">주소</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="patAddr2" name="patAddr"
										style="width: 29vw;" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="patTel">연락처</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="patTel2" name="patTel"
										style="width: 29vw;" readonly>
								</div>
							</div>
							<div class="row mb-3">
								<label class="col-sm-2 col-form-label" for="documentOpinion">진료소견</label>
								<div class="col-sm-10">
									<textarea class="form-control" id="documentNote2" name="documentNote" cols="30"
										rows="5" style="width: 29vw;"></textarea>
								</div>
							</div>
							<div style="display:flex;">
								<div class="row mb-3">
									<label class="col-sm-2 col-form-label" for="documentPrpos">용도</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="documentPrpos2" name="documentPrpos"
											style="width: 14vw;">
									</div>
								</div>
								<div class="row mb-3">
									<label class="col-sm-2 col-form-label" for="documentRm">비고</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="documentRm2" name="documentRm"
											style="width: 14vw;">
									</div>
								</div>
							</div>
							<div class="row justify-content-end" style="float: right;">
								<div class="col-sm-10" style="margin-left: 25px; margin-bottom: 15px;">
									<button type="button" class="btn btn-primary" onclick="opinionSave()">등록</button>
									<button type="button" id="closeBtn" class="btn btn-danger"
										onclick="closeDetailModal()">닫기</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- ///////////////////////////////////소견서작성 모달 끝/////////////////////////////////// -->


			<script>


				//--------------------------- 웹소켓-------------------------------------


				function fMessage() { // 받는쪽에 작성

					let serverMsg = JSON.parse(event.data);

					//공지,일정 등록 실시간 알람
					if (serverMsg.cmd == "alarm") {
						getNotiList();
					}

					//원무과에서 제증명 신청시
					if (serverMsg.cmd == "plzDocu") {
						getWaitPat();
					}
				}


				// --------------------------- 웹소켓 ------------------------------------- 



				var empNo = ${ empVO.empNo };
				var empNm = "${empVO.empNm}";
				//console.log(empNo);
				//console.log(empNm);

				var gr1 =
					`
					<div class="table-responsive text-nowrap" style="overflow:hidden;">
						<table class="table" style="text-align : left;">
							<thead>
								<tr>
									<th style="text-align : center;" id="waitTotal2"></th>
								</tr>
							</thead>
							<tbody class="table-border-bottom-0" id="waitTBody" style="border-bottom: 2px solid #d9dee3;">
							</tbody>
						</table>
					</div>`;

				///////////////////////////환자신청정보 시작/////////////////////////
				var gr2 = `
					<div class="card-body">
						<div style="display:flex;">
							<div>
								<h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:120px; font-weight: bold;">환자신청정보</h5>
							</div>
						</div>

						<div class="info-container">
							<div class="row">
								<div class="col-md-6">
									<ul class="list-unstyled">
										<li class="mb-3">
											<input type="hidden" name="rceptNo" class="form-control form-control-sm" id="rceptNo0" style="border:none;"/>

											<label class="form-label"><strong>환자코드</strong></label>
											<input type="text" name="patCode" class="form-control form-control-sm" id="patCode0" style="width:40%;"/>
											<input type="hidden" name="reqDocumentNo" class="form-control form-control-sm" id="reqDocumentNo0" style="width:40%;"/>
										</li>
										<li class="mb-3">
											<label class="form-label"><strong>이름</strong></label>
											<input type="text" name="patName" class="form-control form-control-sm " id="patName0" style="width:50%;"/>
											<input type="hidden" class="form-control" id="patIhidnum0" name="patIhidnum"/>
										</li>
										<li class="mb-3">
											<label class="form-label"><strong>연락처</strong></label>
											<input type="text" name="patTel" class="form-control form-control-sm" id="patTel0" style="width:40%;"/>

										</li>

										<li class="mb-3">
											<label class="form-label"><strong>요청서류</strong></label>
											<input type="text" name="documentType" class="form-control form-control-sm" id="documentType0" style="width:50%;"/>
										</li>

										<li class="mb-3">
											<label class="form-label"><strong>신청차트날짜</strong></label>
											<input type="text" name="detailRegDate" class="form-control form-control-sm" id="detailRegDate0" style="width:50%;"/>
										</li>

										<li class="mb-3">
											<label class="form-label"><strong>주소</strong></label>
											<input type="text" name="patAddr" class="form-control form-control-sm" id="patAddr0" style="width:75%;"/>
										</li>

										<input type="hidden" name="DreqDocumentNo" class="form-control form-control-sm" id="DreqDocumentNo" style="width:75%;"/>
										<input type="hidden" name="OreqDocumentNo" class="form-control form-control-sm" id="OreqDocumentNo" style="width:75%;"/>
									</ul>
								</div>
							</div> 
										<div class="d-flex justify-content-center pt-3">
										</div>
						</div>
					</div>`;
				///////////////////////////환자정보 끝/////////////////////////



				//////////////////////////////////날짜로 검색한 차트 시작////////////////////////////////////////////////////      

				var gr3 = `
				<div style="display:flex;"><div id="disp" style="float:left;"></div>
					<div class="card-body">
						<h5 class="pb-2 border-bottom mb-4" style="text-align: left; margin-right: 120px; font-weight: bold; width:72px;">진료내역</h5>
							<div class="mb-3">
								<input type="text" name="rceptFirstExamCode" class="form-control-sm " id="rceptFirstExamCode2" style="width:15%; margin:0px;"/>
								<input type="text" name="rceptDayCode" class="form-control-sm " id="rceptDayCode2" style="width:15%; margin:0px;"/>
								<input type="text" name="clnicSttusCode" class="form-control-sm " id="patHsptlzStatus2" style="width:35%; margin:0px;"/>
							</div>
							<div class="mb-3">
								<label class="form-label"><strong>증상메모</strong></label>
								<input type="text" class="form-control-sm chartlog" name="detailMemo" id="detailMemo2" style="width:90%;"/>
							</div>
							<div class="mb-3">
								<label class="form-label"><strong>질병</strong></label>
								<input type="text" name="dissKorName" class="form-control-sm chartlog" id="dissKorName2"/>
								<input type="hidden" name="dissCodeNo" class="form-control-sm chartlog" id="dissCodeNo2"/>
								<input type="hidden" name="dissEngName" class="form-control-sm chartlog" id="dissEngName2"/>
							</div>
							<div class="mb-3">
								<label class="form-label"><strong>오더내역</strong></label><br/>
								<label class="form-label">검사</label>
								<input type="text" name="inspcType" class="form-control-sm chartlog" id="inspcType2" style="width:90%;"/><br/>
								<label class="form-label">처치</label>
								<input type="text" name="treContent" class="form-control-sm chartlog" id="treContent2" style="width:90%;"/><br/>
								<label class="form-label">치료</label>
								<input type="text" name="physioContent" class="form-control-sm chartlog" id="physioContent2" style="width:90%;"/>
							</div>
							<div class="mb-3">
								<label class="form-label"><strong>처방내역</strong></label><br/>
								<input type="text" name="mediItemName" class="form-control-sm chartlog" id="mediItemName2" style="width:90%;"/>
							</div>
							<div class="mb-3">
								<label class="form-label"><strong>수납금</strong></label>
								<input type="text" name="rcivPayment" class="form-control-sm chartlog" id="rcivPayment2"/>
							</div>
								<button type="button" style="float:right;" id="diagno" class="btn btn-info me-3" onclick="diagno()" disabled>진단서</button>
								<button type="button" style="float:right;" id="opinion" class="btn btn-info me-3" onclick="opinion()" disabled>소견서</button>
					</div>
				</div>`;
				//////////////////////////////////날짜로 검색한 차트 끝////////////////////////////////////////////////////


				/////////////////////////////// 진단서 html 시작 ////////////////////////////////////////////
				var gr4 = `
					<div id="diagnoDiv">
						<div style="height:68px;">
							<button id="btn_pdf_D" class="btn btn-primary"
								style="float: right;margin: 15px 53px 15px 15px;width: 80px;">완료</button>
						</div>
						<div id="areaContainerD" class="hpa"
							style="width: 210mm;height: 297mm; margin: 0px 0px 10px 45px;">
							<div class="hcD" style="left: 10mm; top: 10mm;">
								<div class="hcI">
									<div class="hls ps1"
										style="line-height: 30.34mm; white-space: nowrap; left: 0mm; top: 0mm; height: 30.34mm; width: 189.99mm;">
										<div class="htb"
											style="left: 0.34mm; width: 159.51mm; top: 0.55mm; height: 30.34mm; display: inline-block; position: relative; vertical-align: middle;">
											<svg class="hs" viewBox="-2.50 -2.50 164.51 35.34"
												style="left: -2.50mm; top: -2.50mm; width: 164.51mm; height: 35.34mm;">
												<path d="M51.77,11.41 L79.59,11.41"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M51.77,11.78 L79.59,11.78"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M79.59,11.41 L99.48,11.41"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M79.59,11.78 L99.48,11.78"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M99.48,11.41 L112.41,11.41"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M99.48,11.78 L112.41,11.78"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M51.77,11.41 L79.59,11.41"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M51.77,11.78 L79.59,11.78"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M79.59,11.41 L99.48,11.41"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M79.59,11.78 L99.48,11.78"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M99.48,11.41 L112.41,11.41"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M99.48,11.78 L112.41,11.78"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M129.33,0 L129.33,29.79"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M159.17,0 L159.17,29.79"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M129.27,0 L159.24,0"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M129.27,7.59 L159.24,7.59"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M129.27,29.79 L159.24,29.79"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M159.17,0 L159.17,29.79"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M129.33,0 L129.33,29.79"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M129.27,29.79 L159.24,29.79"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M129.27,0 L159.24,0"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path></svg>
											<div class="hce"
												style="left: 0mm; top: 0mm; width: 19.90mm; height: 11.60mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 3.68mm;">
														<div class="hls ps0"
															style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 19.23mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 19.90mm; top: 0mm; width: 31.92mm; height: 11.60mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 3.68mm;">
														<div class="hls ps0"
															style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 31.26mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 51.82mm; top: 0mm; width: 60.55mm; height: 11.60mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 2.62mm;">
														<div class="hls ps1"
															style="line-height: 5.52mm; white-space: nowrap; left: 0mm; top: -0.32mm; height: 6.35mm; width: 59.89mm;">
															<span class="hrt cs15">진 단 서&nbsp;</span>
														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 112.37mm; top: 0mm; width: 16.96mm; height: 11.60mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 3.68mm;">
														<div class="hls ps0"
															style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 16.30mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 129.33mm; top: 0mm; width: 29.84mm; height: 7.59mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 2.03mm;">
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 29.18mm;">
															<span class="hrt cs10">원부대조필 인</span>

														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 129.33mm; top: 7.59mm; width: 29.84mm; height: 22.20mm;">
												<img alt="아작난 도장" src="/resources/images/stamp.jpg" style="height: 79px;width: 70px;vertical-align: baseline;"/>
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 1.61mm;">
															<div class="hls ps7"
																style="line-height: 18.98mm; white-space: nowrap; left: 0mm; top: 0mm; height: 18.98mm; width: 29.18mm;">
																<div class="hsR"
																	style="top: 0mm; left: 0mm; margin-bottom: 0mm; margin-right: 0mm; width: 16.63mm; height: 18.98mm; display: inline-block; position: relative; vertical-align: middle; background-repeat: no-repeat; background-image: url('아작나스 진단서_hd1.png');"></div>
															</div>
														</div>
													</div>
											</div>
											<div class="hce"
												style="left: 0mm; top: 11.60mm; width: 51.82mm; height: 8.59mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 2.53mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 51.15mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 51.82mm; top: 11.60mm; width: 27.77mm; height: 8.59mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 2.53mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.11mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 79.59mm; top: 11.60mm; width: 19.90mm; height: 8.59mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 2.53mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 19.23mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 99.48mm; top: 11.60mm; width: 12.88mm; height: 8.59mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 2.53mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 12.22mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 112.37mm; top: 11.60mm; width: 16.96mm; height: 8.59mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 2.53mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 16.30mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 0mm; top: 20.19mm; width: 51.82mm; height: 9.60mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 3.03mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 51.15mm;">
															<span class="hrt cs13">담 당 의: \${empNm}
															</span>
														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 51.82mm; top: 20.19mm; width: 77.51mm; height: 9.60mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 3.03mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 76.85mm;">
															<span class="hrt cs10">&nbsp;</span><span class="hrt cs13">진단서
																번호:</span><span class="hrt cs13" id="reqDocumentNoD"></span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="hls ps1"
										style="line-height: 227.40mm; white-space: nowrap; left: 0mm; top: 32.67mm; height: 227.40mm; width: 189.99mm;">
										<div class="htb"
											style="left: 0.34mm; width: 159.61mm; top: 0.55mm; height: 227.40mm; display: inline-block; position: relative; vertical-align: middle;">
											<svg class="hs" viewBox="-2.50 -2.50 164.61 232.40"
												style="left: -2.50mm; top: -2.50mm; width: 164.61mm; height: 232.40mm;">
												<path d="M0,0 L0,226.86"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
												<path d="M28.55,0 L28.55,154.16"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M65.13,0 L65.13,14.13"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M82.14,60.63 L82.14,87.32"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M97.17,139.98 L97.17,154.16"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M102.11,0 L102.11,14.13"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M102.11,60.63 L102.11,87.32"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M115.70,139.98 L115.70,154.16"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M126.97,28.42 L126.97,60.64"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M159.27,0 L159.27,226.86"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
												<path d="M0,0 L159.28,0"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
												<path d="M0,14.13 L159.28,14.13"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M0,28.42 L159.28,28.42"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M0,60.63 L159.28,60.63"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M0,87.32 L159.28,87.32"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M0,139.98 L159.28,139.98"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M0,154.16 L159.28,154.16"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
												<path d="M0,226.85 L159.28,226.85"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
												<path d="M159.27,0 L159.27,226.86"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
												<path d="M0,0 L0,226.86"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
												<path d="M0,226.85 L159.28,226.85"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
												<path d="M0,0 L159.28,0"
													style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path></svg>
											<div class="hce"
												style="left: 0mm; top: 0mm; width: 28.55mm; height: 14.13mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 5.30mm;">
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 2mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
															<span class="hrt cs10">환</span><span class="hrt cs10">자의
																성명</span>
														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 28.55mm; top: 0mm; width: 36.58mm; height: 14.13mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 5.30mm;">
														<div class="hls ps4"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 35.91mm;">
															<span class="hrt cs13" id="patNameD"></span>
														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 65.13mm; top: 0mm; width: 36.99mm; height: 14.13mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 5.30mm;">
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 5mm; top: -0.18mm; height: 3.53mm; width: 36.32mm;">
															<span class="hrt cs10">주민등록번호</span>
														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 102.11mm; top: 0mm; width: 57.16mm; height: 14.13mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 1.77mm;">
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 56.49mm;">
														</div>
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 3.35mm; height: 3.53mm; width: 56.49mm;">
															<span class="hrt cs13" id="patIhidnumD"></span>
														</div>
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 6.88mm; height: 3.53mm; width: 56.49mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 0mm; top: 14.13mm; width: 28.55mm; height: 14.29mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 5.38mm;">
														<div class="hls ps1"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
															<span class="hrt cs10">환자의 주소</span>
														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 28.55mm; top: 14.13mm; width: 130.73mm; height: 14.29mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 5.38mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 130.06mm;">
															<span class="hrt cs13" id="patAddrD"></span>
														</div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 0mm; top: 28.42mm; width: 28.55mm; height: 32.21mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI">
														<div class="hls ps4"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;"></div>
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 3.35mm; height: 3.53mm; width: 27.88mm;"></div>
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 6.88mm; height: 3.53mm; width: 27.88mm;"></div>
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 12.41mm; height: 3.53mm; width: 27.88mm;">
															<span class="hrt cs10">병
																&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</span>
														</div>
														<div class="hls ps6"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 13.93mm; height: 3.53mm; width: 27.88mm;">
															<span class="hrt cs10">&nbsp;</span>
														</div>
														<div class="hls ps6"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 17.46mm; height: 3.53mm; width: 27.88mm;"></div>
														<div class="hls ps6"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 20.99mm; height: 3.53mm; width: 27.88mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 28.55mm; top: 28.42mm; width: 98.42mm; height: 32.21mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI" style="top: 5.87mm;">
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 97.76mm;"></div>
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 7.47mm; height: 3.53mm; width: 97.76mm;">
															<span class="hrt cs13" id="documentDissCnD"></span>
														</div>
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 11.11mm; height: 3.53mm; width: 97.76mm;">
															<span class="hrt cs13" id="documentDissCnD2"></span>
														</div>
														<div class="hls ps0"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 16.76mm; height: 3.53mm; width: 97.76mm;"></div>
													</div>
												</div>
											</div>
											<div class="hce"
												style="left: 126.97mm; top: 28.42mm; width: 32.30mm; height: 32.21mm;">
												<div class="hcD" style="left: 0.66mm; top: 0mm;">
													<div class="hcI">
														<div class="hls ps3"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 31.64mm;"></div>
														<div class="hls ps1"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 3.35mm; height: 3.53mm; width: 31.64mm;">
															<span class="hrt cs10">한 국 질 병</span>
														</div>
														<div class="hls ps1"
															style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 9mm; height: 3.53mm; width: 31.64mm;">
															<span class="hrt cs10">분 류 번 호</span><br>
																<span class="hrt cs10"></span><br>
																	<span class="hrt cs13" id="documentDissClNoD"></span>

																</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 60.63mm; width: 28.55mm; height: 26.68mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 11.58mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs10">발 &nbsp;병 &nbsp;일</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 28.55mm; top: 60.63mm; width: 53.59mm; height: 26.68mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 11.58mm;">
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 52.93mm;">
																<span class="hrt cs13" id="reqDocumentRegDateD"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 82.14mm; top: 60.63mm; width: 19.97mm; height: 26.68mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 11.58mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 19.30mm;">
																<span class="hrt cs10">진 단 일</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 102.11mm; top: 60.63mm; width: 57.16mm; height: 26.68mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 3.11mm;">
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 56.49mm;">
																<span class="hrt cs13">&nbsp;</span>
															</div>
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 8.11mm; height: 3.53mm; width: 56.49mm;">
																<span class="hrt cs13" id="reqDocumentRegDateD2">&nbsp;</span>
															</div>
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 16.76mm; height: 3.53mm; width: 56.49mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 87.32mm; width: 28.55mm; height: 52.66mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 18.92mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs10">향
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;후</span>
															</div>
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 5.47mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs10">치
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;료</span>
															</div>
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 11.11mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs10">의
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;견</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 28.55mm; top: 87.32mm; width: 130.73mm; height: 52.66mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 24.57mm;">
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 130.06mm;">
																<span class="hrt cs13" id="documentOpinionD"></span><br>
															</div>
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 5.82mm; height: 3.53mm; width: 130.06mm;">
																<span class="hrt cs13" id="documentOpinionD2"</span><br>
															</div>

														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 139.98mm; width: 28.55mm; height: 14.18mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.32mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs10">비
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;고</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 28.55mm; top: 139.98mm; width: 68.62mm; height: 14.18mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.32mm;">
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 67.96mm;">
																<span class="hrt cs13" id="documentRmD"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 97.17mm; top: 139.98mm; width: 18.53mm; height: 14.18mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.32mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.86mm;">
																<span class="hrt cs10">용 도</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 115.70mm; top: 139.98mm; width: 43.58mm; height: 14.18mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.32mm;">
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 42.91mm;">
																<span class="hrt cs13" id="documentPrposD"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 154.16mm; width: 159.27mm; height: 72.70mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 18.71mm;">
															<div class="hls ps5"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 158.61mm;">
																<span class="hrt cs12">&nbsp;</span><span class="hrt cs10">&nbsp;&nbsp;&nbsp;위와
																	같이 진단함</span>
															</div>
															<div class="hls ps5"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 6.17mm; height: 3.53mm; width: 158.61mm;"></div>
															<div class="hls ps5"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 12.52mm; height: 3.53mm; width: 158.61mm;">
																<span class="hrt cs10" >&nbsp;&nbsp;&nbsp;&nbsp;발
																	&nbsp;&nbsp;&nbsp;행 &nbsp;&nbsp;&nbsp;일 :&nbsp;<span class="hrt cs10" id="documentIsuDateD"></span></span>
															</div>
															<div class="hls ps5"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 18.87mm; height: 3.53mm; width: 158.61mm;">
																<span class="hrt cs10">&nbsp;&nbsp;&nbsp;&nbsp;의 료 기 관
																	명 : 대덕 아작(나)스 병원</span>
															</div>
															<div class="hls ps5"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 25.22mm; height: 3.53mm; width: 158.61mm;">
																<span class="hrt cs10">&nbsp;&nbsp;&nbsp;&nbsp;주 소 및 명
																	칭 :</span><span class="hrt cs12">&nbsp;</span><span class="hrt cs10">대전시
																		중구 계룡로 846, 3-4층</span>
															</div>
															<div class="hls ps5"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 31.57mm; height: 3.53mm; width: 158.61mm;">
																<span class="hrt cs10">&nbsp;&nbsp;&nbsp;&nbsp;전 화 :
																	042 – 123 - 4567 &nbsp;&nbsp;&nbsp;&nbsp;FAX : 070 - 1234 -
																	5678</span>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="hls ps0"
											style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: 262.21mm; height: 3.88mm; width: 189.99mm;"></div>
									</div>
								</div>
							</div>
					</div>

						<div id="opinionDiv" style="display:none; margin-left: 40px;">
							<div style="height:68px;">
								<button id="btn_pdf_O" class="btn btn-primary"
									style="float: right;margin: 15px 53px 15px 15px;width: 80px;">완료</button>
							</div>
							<div id="areaContainerO" class="hpa" style="width: 210mm;height: 297mm; margin: 0px 0px 10px 10px;">
								<div class="hcD" style="left: 10mm; top: 10mm;">
									<div class="hcI">
										<div class="hls ps1"
											style="line-height: 30.34mm; white-space: nowrap; left: 0mm; top: 0mm; height: 30.34mm; width: 189.99mm;">
											<div class="htb"
												style="left: 0.34mm; width: 159.51mm; top: 0.55mm; height: 30.34mm; display: inline-block; position: relative; vertical-align: middle;">
												<svg class="hs" viewBox="-2.50 -2.50 164.51 35.34"
													style="left: -2.50mm; top: -2.50mm; width: 164.51mm; height: 35.34mm;">
													<path d="M51.77,11.41 L79.59,11.41"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M51.77,11.78 L79.59,11.78"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M79.59,11.41 L99.48,11.41"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M79.59,11.78 L99.48,11.78"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M99.48,11.41 L112.41,11.41"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M99.48,11.78 L112.41,11.78"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M51.77,11.41 L79.59,11.41"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M51.77,11.78 L79.59,11.78"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M79.59,11.41 L99.48,11.41"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M79.59,11.78 L99.48,11.78"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M99.48,11.41 L112.41,11.41"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M99.48,11.78 L112.41,11.78"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M129.33,0 L129.33,29.79"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M159.17,0 L159.17,29.79"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M129.27,0 L159.24,0"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M129.27,7.59 L159.24,7.59"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M129.27,29.79 L159.24,29.79"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M159.17,0 L159.17,29.79"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M129.33,0 L129.33,29.79"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M129.27,29.79 L159.24,29.79"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M129.27,0 L159.24,0"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path></svg>
												<div class="hce"
													style="left: 0mm; top: 0mm; width: 19.90mm; height: 11.60mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 3.68mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 19.23mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 19.90mm; top: 0mm; width: 31.92mm; height: 11.60mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 3.68mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 31.26mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 51.82mm; top: 0mm; width: 60.55mm; height: 11.60mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.62mm;">
															<div class="hls ps1"
																style="line-height: 5.52mm; white-space: nowrap; left: 0mm; top: -0.32mm; height: 6.35mm; width: 59.89mm;">
																<span class="hrt cs15">소 &nbsp;견 &nbsp;서</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 112.37mm; top: 0mm; width: 16.96mm; height: 11.60mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 3.68mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 16.30mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 129.33mm; top: 0mm; width: 29.84mm; height: 7.59mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 1.68mm;">
															<div class="hls ps1"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 29.18mm;">
																<span class="hrt cs9">원부대조필 인</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 129.33mm; top: 7.59mm; width: 29.84mm; height: 22.20mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 1.61mm;">
															<div class="hls ps9"
																style="line-height: 18.98mm; white-space: nowrap; left: 3mm; top: -1mm; height: 18.98mm; width: 29.18mm;">
																<div class="hsR"
																	style="top: 0mm; left: 0mm; margin-bottom: 0mm; margin-right: 0mm; width: 16.63mm; height: 18.98mm; display: inline-block; position: relative; vertical-align: middle; background-repeat: no-repeat; background-image: url('아작나스 소견서_hd1.png');">
																	<img alt="아작난 도장" src="/resources/images/stamp.jpg" style="height: 79px; width: 70px; vertical-align: baseline;"/>
																</div>
																<span class="hrt cs9">&nbsp;&nbsp;&nbsp;&nbsp;</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 11.60mm; width: 51.82mm; height: 8.59mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.18mm;">
															<div class="hls ps3"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 51.15mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 51.82mm; top: 11.60mm; width: 27.77mm; height: 8.59mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.18mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 27.11mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 79.59mm; top: 11.60mm; width: 19.90mm; height: 8.59mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.18mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 19.23mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 99.48mm; top: 11.60mm; width: 12.88mm; height: 8.59mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.18mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 12.22mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 112.37mm; top: 11.60mm; width: 16.96mm; height: 8.59mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.18mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 16.30mm;"></div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 20.19mm; width: 51.82mm; height: 9.60mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.68mm;">
															<div class="hls ps0"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 51.15mm;">
																<span class="hrt cs10">담 당 의 : \${empNm}
																</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 51.82mm; top: 20.19mm; width: 77.51mm; height: 9.60mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 2.68mm;">
															<div class="hls ps3"
																style="line-height: 3.43mm; white-space: nowrap; left: 0mm; top: -0.21mm; height: 4.23mm; width: 76.85mm;">
																<span class="hrt cs9">&nbsp;</span><span class="hrt cs22">소견서
																	번호:&nbsp;&nbsp;</span>&nbsp;<span class="hrt cs10" id="reqDocumentNoO"></span>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="hls ps1"
											style="line-height: 227.22mm; white-space: nowrap; left: 0mm; top: 32.67mm; height: 227.22mm; width: 189.99mm;">
											<div class="htb"
												style="left: 0.34mm; width: 159.61mm; top: 0.55mm; height: 227.22mm; display: inline-block; position: relative; vertical-align: middle;">
												<svg class="hs" viewBox="-2.50 -2.50 164.61 232.22"
													style="left: -2.50mm; top: -2.50mm; width: 164.61mm; height: 232.22mm;">
													<path d="M0,0 L0,226.67"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
													<path d="M28.55,0 L28.55,164.57"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M65.13,0 L65.13,14.39"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M93.99,0 L93.99,14.39"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M97.17,99.12 L97.17,164.57"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M115.70,99.12 L115.70,164.57"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M159.27,0 L159.27,226.67"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
													<path d="M0,0 L159.28,0"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
													<path d="M0,14.38 L159.28,14.38"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M0,28.93 L159.28,28.93"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M0,99.12 L159.28,99.12"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M0,164.57 L159.28,164.57"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path>
													<path d="M0,226.67 L159.28,226.67"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
													<path d="M159.27,0 L159.27,226.67"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
													<path d="M0,0 L0,226.67"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
													<path d="M0,226.67 L159.28,226.67"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path>
													<path d="M0,0 L159.28,0"
														style="stroke:#000000;stroke-linecap:butt;stroke-width:0.40;"></path></svg>
												<div class="hce"
													style="left: 0mm; top: 0mm; width: 28.55mm; height: 14.38mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.43mm;">
															<div class="hls ps4"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs11">환</span><span class="hrt cs11">자의
																	성명</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 28.55mm; top: 0mm; width: 36.58mm; height: 14.38mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.43mm;">
															<div class="hls ps5"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 35.91mm;">
																<span class="hrt cs11" id="patNameO"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 65.13mm; top: 0mm; width: 28.87mm; height: 14.38mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 3.66mm;">
															<div class="hls ps4"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 28.19mm;">
																<span class="hrt cs11">환자의</span>
															</div>
															<div class="hls ps4"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 3.35mm; height: 3.53mm; width: 28.19mm;">
																<span class="hrt cs11">주민등록번호</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 93.99mm; top: 0mm; width: 65.28mm; height: 14.38mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.43mm;">
															<div class="hls ps4"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 64.61mm;">
																<span class="hrt cs11" id="patIhidnumO"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 14.38mm; width: 28.55mm; height: 14.55mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.51mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs11">환자의 주소</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 28.55mm; top: 14.38mm; width: 130.73mm; height: 14.55mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 5.51mm;">
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 130.06mm;">
																<span class="hrt cs11" id="patAddrO"></span>
																&nbsp;&nbsp;&nbsp;&nbsp;전&nbsp;화 :<span class="hrt cs11" id="patTelO"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 28.93mm; width: 28.55mm; height: 70.19mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI">
															<div class="hls ps4"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;"></div>
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 3.35mm; height: 3.53mm; width: 27.88mm;"></div>
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 9mm; height: 3.53mm; width: 27.88mm;"></div>
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 14.64mm; height: 3.53mm; width: 27.88mm;"></div>
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 20.28mm; height: 3.53mm; width: 27.88mm;"></div>
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: 25.93mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs11">진료소견</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 28.55mm; top: 28.93mm; width: 130.73mm; height: 70.19mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI">
															<div class="hls ps7"
																style="line-height: 2.79mm; white-space: nowrap; left: 0.35mm; top: -0.18mm; height: 3.53mm; width: 129.71mm;">
																<span class="hrt cs11">&nbsp;&nbsp;</span>
															</div>
															<div class="hls ps8"
																style="line-height: 2.79mm; white-space: nowrap; left: 0.35mm; top: 3.35mm; height: 3.53mm; width: 129.71mm;">
																<span class="hrt cs11">&nbsp;</span>
															</div>
															<div class="hls ps8"
																style="line-height: 2.79mm; white-space: nowrap; left: 0.35mm; top: 6.88mm; height: 3.53mm; width: 129.71mm;"></div>
															<div class="hls ps8"
																style="line-height: 2.79mm; white-space: nowrap; left: 0.35mm; top: 10.41mm; height: 3.53mm; width: 129.71mm;">
																<span class="hrt cs11">&nbsp;</span>
															</div>
															<div class="hls ps8"
																style="line-height: 2.79mm; white-space: nowrap; left: 0.35mm; top: 25.93mm; height: 3.53mm; width: 129.71mm;">
																<span class="hrt cs11" id="documentNoteO">&nbsp;</span>
															</div>
															<div class="hls ps8"
																style="line-height: 2.79mm; white-space: nowrap; left: 0.35mm; top: 32.93mm; height: 3.53mm; width: 129.71mm;">
																<span class="hrt cs11" id="documentNoteO2">&nbsp;</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 99.12mm; width: 28.55mm; height: 65.45mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 30.96mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 27.88mm;">
																<span class="hrt cs11">비 &nbsp;&nbsp;&nbsp;고</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 28.55mm; top: 99.12mm; width: 68.62mm; height: 65.45mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 31.31mm;">
															<div class="hls ps0"
																style="line-height: 2.17mm; white-space: nowrap; left: 0mm; top: -0.14mm; height: 2.82mm; width: 67.96mm;">
																<span class="hrt cs11" id="documentRmO"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 97.17mm; top: 99.12mm; width: 18.53mm; height: 65.45mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 30.96mm;">
															<div class="hls ps1"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 17.86mm;">
																<span class="hrt cs11">용 도</span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 115.70mm; top: 99.12mm; width: 43.58mm; height: 65.45mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 30.96mm;">
															<div class="hls ps0"
																style="line-height: 2.79mm; white-space: nowrap; left: 0mm; top: -0.18mm; height: 3.53mm; width: 42.91mm;">
																<span class="hrt cs11" id="documentPrposO"></span>
															</div>
														</div>
													</div>
												</div>
												<div class="hce"
													style="left: 0mm; top: 164.57mm; width: 159.27mm; height: 62.10mm;">
													<div class="hcD" style="left: 0.66mm; top: 0mm;">
														<div class="hcI" style="top: 10.38mm;">
															<div class="hls ps6"
																style="line-height: 4.44mm; white-space: nowrap; left: 0mm; top: -0.26mm; height: 5.29mm; width: 158.61mm;">
																<span class="hrt cs16">&nbsp;</span><span class="hrt cs18">&nbsp;&nbsp;&nbsp;&nbsp;</span>
															</div>
															<div class="hls ps6"
																style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: 9.33mm; height: 3.88mm; width: 158.61mm;">
																<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;발
																	&nbsp;&nbsp;&nbsp;행 &nbsp;&nbsp;&nbsp;일 : <span class="hrt cs11" id="documentIsuDateO"></span></span>
															</div>
															<div class="hls ps6"
																style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: 16.32mm; height: 3.88mm; width: 158.61mm;">
																<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;의 료 기 관 명
																	:&nbsp;</span><span class="hrt cs11">대덕 아작(나)스 병원</span>
															</div>
															<div class="hls ps6"
																style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: 23.30mm; height: 3.88mm; width: 158.61mm;">
																<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;주 소 및 명 칭
																	:</span><span class="hrt cs12">&nbsp;</span><span class="hrt cs11">대전시
																		중구 계룡로 846, 3-4층</span>
															</div>
															<div class="hls ps6"
																style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: 30.29mm; height: 3.88mm; width: 158.61mm;">
																<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;</span><span
																	class="hrt cs11">전 화 : 042 – 1234 - 5678
																	&nbsp;&nbsp;&nbsp;&nbsp;FAX : 070 - 1234 - 5678</span>
															</div>
															<div class="hls ps6"
																style="line-height: 3.10mm; white-space: nowrap; left: 0mm; top: 37.27mm; height: 3.88mm; width: 158.61mm;">
																<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;</span>
															</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>`;



				var items = [
					{ w: 2, h: 5, x: 0, y: 0, content: gr1 },
					{ w: 4, h: 2, x: 2, y: 0, content: gr2 },
					{ w: 4, h: 3, x: 2, y: 3, content: gr3 },
					{ w: 6, h: 5, x: 6, y: 0, content: gr4 }
				];

				var grid = GridStack.init();
				grid.load(items);

				// 실행하자마자 제증명대기환자목록 불러오깅
				$(function () {
					getWaitPat();
				});

				const waitTotal2 = $('#waitTotal2');  //대기환자목록
				const waitTBody = $('#waitTBody');  //대기환자목록


				// 제증명대기 환자 목록 출력
				function getWaitPat() {

					$.ajax({
						url: `/doctor/proof/waitList/\${empNo}`,
						type: 'get',
						dataType: 'JSON',
						success: function (result) {
							console.log(result);
							if (result.length == 0) {
								let top = "";
								top += `
													<h5 class='pb-2 mb-4' style='text-align:left; margin: 0px 120px -1px 0px !important; font-weight: bold;'>
														<div style="display:flex;">
															<i class='bx bxs-user-detail' style='color:#4a5b6d; font-size:2rem;' ></i>
															<p style="margin: 8px 0px 0px 6px;"><small>발급대기 환자 0명</small></p>
														</div>
													</h5>`
								//목록 비우기
								waitTotal2.html(top)
								waitTBody.html('');
								$("#disp").hide();
							} else {
								let top = "";
								top += `
												<h5 class='pb-2 mb-4' style='text-align:left; margin: 0px 120px -1px 0px !important; font-weight: bold;'>
													<div style="display:flex;">
														<i class='bx bxs-user-detail' style='color:#4a5b6d; font-size:2rem;' ></i>
														<p style="margin: 8px 0px 0px 6px;">발급대기 : \${result.length}명</p>
													</div>
												</h5>
												<span class="bg-label-secondary" style="font-size:1.0rem; text-align:left; margin: -15px 120px 0px 0px; padding: 5px; border-radius: 7px; color: #67707b !important;">\${result[0].hosFcName}| 담당의 : \${result[0].empNm}</span>`
								waitTotal2.html(top)
								//console.log("제증명대기 목록 출력", result);
								//console.log("체키라웃",result);
								let txt = "";
								for (let i = 0; i < result.length; i++) {
									txt +=
										` 
														<tr>
															<td style="padding:1rem;">
																<h5 class="mb-0"><strong>\${result[i].patName}</strong> <small>| \${result[i].patBrthdy} | \${result[i].patGen}</small></h5>
														
																<div style="display: flex; justify-content: space-between; align-items: center;">
																	<div>
																	
																		<h6 class="mb-0" style="margin-top: 10px;">신청차트날짜 | <small>&nbsp;\${result[i].detailRegDate}</small></h6>
																		<h6 class="mb-0" style="margin-top: 10px;">신청서류 | <small>&nbsp;\${result[i].documentType}</small></h6>
																	</div>
																	<div style="margin-right: 56px;">
																	<button type="button" style="float:right; margin-top: 10px;" id="callPat" class="btn btn-danger me-3" 
																		onclick="reqInfo('\${result[i].patCode}','\${result[i].detailRegDate}','\${result[i].treatNo}')">발급</button>
																	</div>
																</div>
															</td>
														</tr> 
													`;
								}
								waitTBody.html(txt);
							}
						}
					});
				};


				//신청 내역 정보 조회 - 발급버튼 눌렀을때
				function reqInfo(patCode, detailRegDate, treatNo) {

					//console.log("reqInfo버튼 체킁");
					//console.log("patCode", patCode);
					//console.log("detailRegDate", detailRegDate);
					//console.log("treatNo", treatNo);

					allClear(); // 비우기함수
					getDate(patCode); // 날짜뿌리기
					//	showChart(detailRegDate, treatNo); // 날짜뿌리기로 진료내역 조회

					// showChart를 호출하고, 비동기 작업이 완료되면 콜백 함수 실행
					showChart(detailRegDate, patCode, treatNo, function(){
						// showChart 함수 완료 후 실행
						$(".date").each(function () {
							//console.log("버튼의 텍스트 찾았다");
							//console.log("detailRegDate", detailRegDate);
							//console.log("하이", $(this).text());

							if ($(this).text() === detailRegDate) {
								$(this).removeClass("btn btn-outline-primary date").addClass("btn btn-primary date");
							}
						});
					});


					// 호출 버튼을 클릭한 버튼 요소를 가져옵니다.
					var callButton = event.target;

					// 버튼의 스타일을 변경합니다.
					// 버튼의 클래스를 변경합니다.
					callButton.className = "btn btn-primary"; // 원하는 클래스 이름으로 변경
					callButton.innerHTML = "작성중"; // 글자를 "작성중"으로 변경

					//console.log("reqInfo버튼 체킁");

					//	let patCode2 = $("#patCode0").val();
					//console.log("이거patCode", patCode);

					let xhr = new XMLHttpRequest();
					let schURL = "/doctor/proof/reqInfo/" + patCode + "/" + treatNo;
					//console.log(schURL);
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("성공!");
							let docuWaitPatVO = xhr.responseText;
							if (docuWaitPatVO) {
								docuWaitPatVO = JSON.parse(docuWaitPatVO); //json문자열을 json객체로
								//console.log(docuWaitPatVO);

								let reqDocumentNo = docuWaitPatVO.reqDocumentNo

								//230910001 진단서 230911002 소견서
								//console.log("reqDocumentNo", reqDocumentNo);


								const values = reqDocumentNo.split(','); // 입력 문자열을 쉼표(,)를 기준으로 나눔
								//console.log("values", values);

								for (let i = 0; i < values.length; i++) {
									if (values[i].charAt(values[i].length - 4) == '0') { // 뒤에서 4번째 숫자가 0이면
										var DreqDocumentNo = values[i].trim(); // 진단서 변수에 담기
										//console.log("진단서지롱" + i);
									} else if (values[i].charAt(values[i].length - 4) == '1') { // 뒤에서 4번째 숫자가 1이면
										var OreqDocumentNo = values[i].trim(); // 소견서 변수에 담기
										//console.log("소견서지롱" + i);
									}
								}
								//console.log(DreqDocumentNo); //230910001
								//console.log(OreqDocumentNo); //230911002

								$("#OreqDocumentNo").val(OreqDocumentNo);
								$("#DreqDocumentNo").val(DreqDocumentNo);

								//$("#reqDocumentNo0").val("11111");
								$("#patCode0").val(docuWaitPatVO.patCode);
								//	$("#patName0").val(docuWaitPatVO.patName);
								$("#patTel0").val(docuWaitPatVO.patTel);
								$("#patIhidnum0").val(docuWaitPatVO.patIhidnum);
								//$("#reqDocumentNo0").val(docuWaitPatVO.reqDocumentNo);


								var patName = docuWaitPatVO.patName;
								var genCode = docuWaitPatVO.patGenCode;
								var Brthdy = docuWaitPatVO.patBrthdy;

								// 					// 테스트 | 19980813 | 여 | 내국인 | 외래
								var test = patName + " " + "|" + " " + Brthdy + " " + "|" + " " + genCode;
								$("#patName0").val(test);

								var patAddr = docuWaitPatVO.patAddr;
								var patDtlAddr = docuWaitPatVO.patDtlAddr;
								var patZip = docuWaitPatVO.patZip;

								// 대전 서구 만년로35 108동 (35201)
								var Addr = patAddr + " " + patDtlAddr + " " + " (" + patZip + ")";
								$("#patAddr0").val(Addr);

								$("#detailRegDate0").val(docuWaitPatVO.detailRegDate);
								$("#documentType0").val(docuWaitPatVO.documentType);

								docuButton(); // 진단서, 소견서 버튼 활성화

							} else {
								alert("해당 환자의 신청내역은 없습니다.");
							}
						}
					}
					xhr.send();
				}//end reqInfo()


				// 진단서, 소견서 버튼 활성화
				function docuButton() {
					// documentType0 요소의 값이 '진단서' 또는 '소견서'를 포함하고 있는 경우
					var documentTypeValue = $("#documentType0").val();

					if (documentTypeValue.indexOf('진단서') !== -1) {
						// diagno 버튼을 활성화
						$("#diagno").prop('disabled', false);
					} else {
						// diagno 버튼을 비활성화
						$("#diagno").prop('disabled', true);
					}

					//     // diagno 버튼 활성화 여부 설정
					//     $("#diagno").prop('disabled', documentTypeValue.indexOf('진단서') === -1);

					if (documentTypeValue.indexOf('소견서') !== -1) {
						// opinion 버튼을 활성화
						$("#opinion").prop('disabled', false);
					} else {
						// opinion 버튼을 비활성화
						$("#opinion").prop('disabled', true);
					}

					// opinion 버튼 활성화 여부 설정
					$("#opinion").prop('disabled', documentTypeValue.indexOf('소견서') === -1)
				}


				//날짜 뿌리기
				function getDate(patCode) {
					let xhr = new XMLHttpRequest();
					let schURL = "/doctor/proof/date/" + patCode;
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("날짜도착");
							//json문자열을 json객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText)
							let tblStr = `<div class="card-body">`;
							// tblStr += `<h5 class="pb-2 border-bottom mb-4" style="font-weight: bold;">진료내역</h5>`;

							//	console.log("환자코드테스트",patCode);
							for (let i = 0; i < rslt.length; i++) {
								tblStr += `<button type="button" class="btn btn-outline-primary date" style="width:111px;"  onclick="showChart('\${rslt[i].detailRegDate}','\${patCode}','\${rslt[i].treatNo}')">\${rslt[i].detailRegDate}</button><br>`;
							}
							tblStr += "</div>"
							dateList.innerHTML = tblStr;
						}
					}
					xhr.send();
				} //날짜뿌리기 끝

				//등록날짜로 검색한 환자차트!
				function showChart(detailRegDate, patCode, treatNo, callback) {

					//const detailRegDate = $(button).text();
					//console.log("22detailRegDate", detailRegDate);
					//console.log("22treatNo", treatNo);
					//let patCode = $("#patCode0").val();
					//console.log("진짜patCode", patCode);

					let schURL = "/doctor/proof/date/chart/" + detailRegDate + "/" + patCode + "/" + treatNo;
					let xhr = new XMLHttpRequest();
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							//	console.log("성공!");
							let chartDetailByDateVOList = xhr.responseText;
							// console.log(xhr.responseText);
							if (chartDetailByDateVOList) {
								chartDetailByDateVOList = JSON.parse(chartDetailByDateVOList); //json문자열을 json객체로

								let inspcType2 = [];
								let treContent2 = [];
								let physioContent2 = [];
								let mediItemName2 = [];

								//console.log("길이예용", chartDetailByDateVOList.length);

								for (let i = 0; i < chartDetailByDateVOList.length; i++) {

									let inspcTypeData = chartDetailByDateVOList[i].inspcType;
									let treContentData = chartDetailByDateVOList[i].treContent;
									let physioContentData = chartDetailByDateVOList[i].physioContent;
									let mediItemNameData = chartDetailByDateVOList[i].mediItemName;

									let inspcTypeindex = inspcType2.indexOf(inspcTypeData);
									let treContentindex = treContent2.indexOf(treContentData);
									let physioContentindex = physioContent2.indexOf(physioContentData);
									let mediItemNameindex = mediItemName2.indexOf(mediItemNameData);

									if (inspcTypeindex == -1) {
										inspcType2.push(inspcTypeData)
									}

									if (treContentindex == -1) {
										treContent2.push(treContentData)
									}

									if (physioContentindex == -1) {
										physioContent2.push(physioContentData)
									}

									if (mediItemNameindex == -1) {
										mediItemName2.push(mediItemNameData)
									}
								}

								$("#rceptFirstExamCode2").val(chartDetailByDateVOList[0].rceptFirstExamCode);
								$("#rceptDayCode2").val(chartDetailByDateVOList[0].rceptDayCode);
								$("#patHsptlzStatus2").val(chartDetailByDateVOList[0].patHsptlzStatus);
								$("#detailMemo2").val(chartDetailByDateVOList[0].detailMemo);
								$("#dissCodeNo2").val(chartDetailByDateVOList[0].dissCodeNo);
								$("#dissEngName2").val(chartDetailByDateVOList[0].dissEngName);
								$("#dissKorName2").val(chartDetailByDateVOList[0].dissKorName);
								//  			             	console.log($("#dissCodeNo2").val());
								//  			             	console.log($("#dissEngName2").val());
								//  			             	console.log($("#dissKorName2").val());
								$("#inspcType2").val(inspcType2);
								$("#treContent2").val(treContent2);
								$("#physioContent2").val(physioContent2);
								$("#mediItemName2").val(mediItemName2);
								$("#rcivPayment2").val(chartDetailByDateVOList[0].rcivPayment);

							}
						} // readyState의 끝
						callback();
					} //  xhr.onreadystatechange의 끝
					xhr.send();
				}// showChart end


				// 진단서 작성 모달	
				function diagno() {

					//이름만 자르기
					let patName = $("#patName0").val().split(" | ")[0];

					let patIhidnum = $("#patIhidnum0").val();
					let patAddr = $("#patAddr0").val();
					let dissCodeNo = $("#dissCodeNo2").val();
					let dissEngName = $("#dissEngName2").val();
					let dissKorName = $("#dissKorName2").val();

					let dissName = dissEngName + " | " + dissKorName;

					console.log(patName);
					console.log(patIhidnum);

					$("#patName1").val(patName); // 이름
					$("#patIhidnum1").val(patIhidnum); // 주민번호

					$("#patAddr1").val(patAddr); // 주소
					$("#documentDissCn1").val(dissName); // 병명
					$("#documentDissClNo1").val(dissCodeNo); // 질병분류번호


					console.log("모달체킁");
					console.log("모달체킁", patName);
					diagnoModal.style.display = "block";
				}

				//진단서 작성완료버튼
				function diagnoSave() {

					if ($("#documentOpinion1").val() == '' || $("#documentPrpos1").val() == '') {
						Swal.fire({
							icon: 'warning',
							title: '작성 불가',
							text: '작성 내용을 확인해 주세요.'
						});
					} else {

						$("#opinionDiv").hide();
						$("#diagnoDiv").show(); // 진단서 html
						//console.log("diagnoSave체킁");

						let DreqDocumentNo = $("#DreqDocumentNo").val();

						//	let reqDocumentNo = $("#reqDocumentNo0").val(); // 진단서신청번호
						let patName = $("#patName1").val(); // 환자명
						let patIhidnum = $("#patIhidnum1").val(); // 주민등록번호
						let patAddr = $("#patAddr1").val(); // 주소
						let documentDissCn = $("#documentDissCn1").val(); // 병명
						let documentDissClNo = $("#documentDissClNo1").val(); // 질병분류번호
						let reqDocumentRegDate = $("#detailRegDate0").val(); // 발병일
						let documentOpinion = $("#documentOpinion1").val(); // 향후치료의견
						let documentRm = $("#documentRm1").val(); // 비고
						let documentPrpos = $("#documentPrpos1").val(); // 용도

						$("#reqDocumentNoD").text(DreqDocumentNo);
						$("#patNameD").text(patName);
						$("#patIhidnumD").text(patIhidnum);
						$("#patAddrD").text(patAddr);
 
						let diss = documentDissCn;
						var parts = diss.split(" | ");

						// 첫 번째 부분을 변수에 저장
						var firstPart = parts[0];

						// 두 번째 부분을 변수에 저장
						var secondPart = parts[1];
						
						$("#documentDissCnD").text(firstPart);
						$("#documentDissCnD2").text(secondPart);
						
						$("#documentDissClNoD").text(documentDissClNo);
						$("#reqDocumentRegDateD").text(reqDocumentRegDate);
						$("#reqDocumentRegDateD2").text(reqDocumentRegDate); //진단일
						
						let opinion = documentOpinion;
						var Oparts = opinion.split(",");

						// 첫 번째 부분을 변수에 저장
						var firstOPart = Oparts[0];

						// 두 번째 부분을 변수에 저장
						var secondOPart = Oparts[1];
						
						$("#documentOpinionD").text(firstOPart);
						$("#documentOpinionD2").text(secondOPart);
						
						$("#documentRmD").text(documentRm);
						$("#documentPrposD").text(documentPrpos);

						let today = new Date();
						let year = today.getFullYear(); // 년도
						let month = (today.getMonth() + 1).toString().padStart(2, '0'); // 월
						let date = today.getDate().toString().padStart(2, '0'); // 날짜
						let day = today.getDay(); // 요일

						let realToday = year + '-' + month + '-' + date;
						$("#documentIsuDateD").text(realToday);

						closeDetailModal();
					}
				}


				//소견서작성모달
				function opinion() {

					//이름만 자르기
					let patName = $("#patName0").val().split(" | ")[0];

					let patIhidnum = $("#patIhidnum0").val();
					let patAddr = $("#patAddr0").val();
					let patTel = $("#patTel0").val();

					//console.log(patName);
					//console.log(patIhidnum);

					$("#patName2").val(patName); // 이름
					$("#patIhidnum2").val(patIhidnum); // 주민번호

					$("#patAddr2").val(patAddr); // 주소
					$("#patTel2").val(patTel); // 전화번호

				//	console.log("모달체킁");
					//console.log("모달체킁", patName);

					opinionModal.style.display = "block";
				}

				//소견서 작성완료버튼
				function opinionSave() {

					if ($("#documentNote2").val() == '' || $("#documentPrpos2").val() == '') {
						Swal.fire({
							icon: 'warning',
							title: '작성 불가',
							text: '작성 내용을 확인해 주세요.'
						});
					} else {

						$("#diagnoDiv").hide();
						$("#opinionDiv").show();

						let OreqDocumentNo = $("#OreqDocumentNo").val();

						//console.log("opinionSave체킁");
						//	let reqDocumentNo = $("#reqDocumentNo0").val(); // 소견서신청번호
						let patName = $("#patName2").val(); // 환자명
						let patIhidnum = $("#patIhidnum2").val(); // 주민등록번호
						let patAddr = $("#patAddr2").val(); // 주소
						let patTel = $("#patTel2").val(); // 연락처

						let documentNote = $("#documentNote2").val(); // 진료소견
						let documentRm = $("#documentRm2").val(); // 비고
						let documentPrpos = $("#documentPrpos2").val(); // 용도

						//console.log("진료소견이에용", documentNote);

						$("#reqDocumentNoO").text(OreqDocumentNo);
						$("#patNameO").text(patName);
						$("#patIhidnumO").text(patIhidnum);
						$("#patAddrO").text(patAddr);
						$("#patTelO").text(patTel);

						let note = documentNote;
						let partsO = note.split(",");

						// 첫 번째 부분을 변수에 저장
						let firstPartO = partsO[0];

						// 두 번째 부분을 변수에 저장
						let secondPartO = partsO[1];
						
						$("#documentNoteO").text(firstPartO);
						$("#documentNoteO2").text(secondPartO);
						$("#documentRmO").text(documentRm);
						$("#documentPrposO").text(documentPrpos);

						let today = new Date();
						let year = today.getFullYear(); // 년도
						let month = (today.getMonth() + 1).toString().padStart(2, '0'); // 월
						let date = today.getDate().toString().padStart(2, '0'); // 날짜
						let day = today.getDay(); // 요일

						let realToday = year + '-' + month + '-' + date;
						$("#documentIsuDateO").text(realToday);

						closeDetailModal();

					}
				}

				////////////////////////////////////////////////pdf 저장 함수 시작 ////////////////////////////////////////////////

				// 소견서 pdf 버튼 클릭 이벤트
				$("#btn_pdf_O").on("click", function () {
					mkPdf("areaContainerO", "_아작(나)스_소견서.pdf");
				});

				// 진단서 pdf 버튼 클릭 이벤트
				$("#btn_pdf_D").on("click", function () {
					mkPdf("areaContainerD", "_아작(나)스_진단서.pdf");
				});


				let jsPDF = jspdf.jsPDF;

				function mkPdf(containerId, pdfName) {
					html2canvas($(`#\${containerId}`)[0]).then(function (canvas) {
						// 캔버스를 이미지로 변환
						const imgData = canvas.toDataURL("image/png");

						const imgWidth = 210; // 가로(mm) (A4)
						const pageHeight = imgWidth * 1.414; // 세로 길이 (A4)
						const imgHeight = (canvas.height * imgWidth) / canvas.width;

						const doc = new jsPDF({
							orientation: "p",
							unit: "mm",
							format: "a4",
						});

						let heightLeft = imgHeight;
						let position = 0;

						// 첫 페이지 출력
						doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
						heightLeft -= pageHeight;

						// 한 페이지 이상일 경우 루프 돌면서 출력
						while (heightLeft >= 20) {
							position = heightLeft - imgHeight;
							doc.addPage();
							doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
							heightLeft -= pageHeight;
						}

						var blobPDF = doc.output('blob');
						//console.log("체킁2:", blobPDF);

						let trimmedContainerId = containerId.charAt(containerId.length - 1); // O or D
						//console.log('trimmedContainerId', trimmedContainerId);
						let reqDocumentNo = $(`#reqDocumentNo\${trimmedContainerId}`).text();
						//console.log("reqDocumentNo", reqDocumentNo);

						let formData = new FormData();
						formData.append("pdfFile", blobPDF);
						formData.append("fileName", reqDocumentNo + pdfName);
						formData.append("reqDocumentNo", reqDocumentNo);

						//console.log("fileName", formData.get("fileName"));

						let xhr = new XMLHttpRequest();
						xhr.open("post", "/doctor/pdf");
						//xhr.setRequestHeader(header, token);
						xhr.onreadystatechange = function () {
							if (xhr.readyState == 4 && xhr.status == 200) {
								console.log(xhr.responseText);
							}
						}
						xhr.send(formData);

						issuedDocu(reqDocumentNo);
						$("#diagnoDiv").hide();
						$("#opinionDiv").hide();
						allClear();
						getWaitPat();
					});
				}


				//pdf 발급완료 함수
				function issuedDocu(reqDocumentNo) {

					// 넘겨야 할 data
					let data = {
						reqDocumentNo: reqDocumentNo
					}
					//console.log("신청번호", reqDocumentNo);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/proof/issued`;
					xhr.open("put", schURL, true);
					xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");

					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							if (xhr.responseText == 1) {
								//console.log("체크", xhr.responseText); // 성공시 1이 찍힌당
								Swal.fire({
									icon: 'success',
									title: '발급완료',
									text: '발급이 완료되었습니다.',
								});

								// 웹소켓으로 제증명발급 연락!
								let msg = {
									to: "원무",
									from: "의사",
									cmd: "endDocu"
								}
								webSocket.send(JSON.stringify(msg));

								console.log(msg, "진단서완료보냈는뎅");

								$("#areaContainerD").show();
								
							} else {
								alert("뭔가 잘못되었어용");
							}
							console.log("발급완료체킁", xhr.responseText);
						}
					}
					xhr.send(JSON.stringify(data)); // 문자열 (JSON 형식의 문자열)

					
					getWaitPat();
					getDate('1234'); //allclear
				//	$("#diagnoDiv").show(); // 진단서 html
				}

				const dateList = document.querySelector("#disp"); // 차트 등록날짜 출력

				//비우기함수
				function allClear() {
					// 모든 input, textarea, date input, checkbox, table 요소를 찾습니다.
					$('.card-body').find('input[type=text], textarea, input[type=date], input[type=checkbox], table').each(function () {
						if ($(this).is('input[type=text], textarea, input[type=date]')) {
							$(this).val('');
						} else if ($(this).is('input[type=checkbox]')) {
							$(this).prop('checked', false); // 체크박스 체크 해제
						} else if ($(this).is('table')) {
							// 테이블 셀 안에 있는 내용만 삭제합니다.
							$(this).find('td').text('');
						}
					});

					$('.modal-content').find('input[type=text], textarea, input[type=date], input[type=checkbox], table').each(function () {
						if ($(this).is('input[type=text], textarea, input[type=date], input[type=checkbox]')) {
							$(this).val('');
						} else if ($(this).is('table')) {
							// 테이블 셀 안에 있는 내용만 삭제합니다.
							$(this).find('td').text('');
						}
					});
				}

				//창닫기버튼
				function closeDetailModal() {
					diagnoModal.style.display = "none";
					opinionModal.style.display = "none";
				}
				
				//자동완성버튼
				function autoComplBtnD(){
					$("#documentOpinion1").val("상기 환자는 요추 및 골반의 관절 및 인대의 탈구,염좌 및 긴장 상태로 인해 일상생활에 상당한 장애가 예상됩니다.");
					$("#documentPrpos1").val("회사 제출용");  
				}
				
				function autoComplBtnO(){
					$("#documentNote2").val("상기 환자의 현재 의료 상황을 고려하여, 다른 병원 또는 의료기관에서 추가 검사와 평가가 필요하다고 판단됨.") ;
					$("#documentPrpos2").val("병원 제출용") ; 	
					$("#documentRm2").val("만성 척추증");
				}
			</script>
		</body>
		</html>