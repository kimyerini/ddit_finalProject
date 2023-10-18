<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication property="principal.employee" var="empVO" />
<sec:authentication property="principal.employee" var="imsiVO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/resources/js/jquery-3.6.0.js"></script>
<script>
        // Ignore this in your implementation
        window.isMbscDemo = true;
    </script>

<title>schedule</title>

<!-- Mobiscroll JS and CSS Includes -->
<link rel="stylesheet" href="/resources/css/mobiscroll.javascript.min.css">
<script src="/resources/js/mobiscroll.javascript.min.js"></script>

<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

body, html {
	height: 100%;
}

/* free/busy 가리기.. 뭔지 모르겠음 */
.mbsc-material.mbsc-segmented {
	display: none !important;
}

.mbsc-grid .mbsc-col-md-4 {
	max-width: 100%;
}

.docInfo {
	display: flex;
}

#docInfoDiv {
	display: flex;
	justify-content: center;
}

.mbsc-material.mbsc-calendar-width-md .mbsc-calendar-label-text {
	text-align: center;
}

</style>

</head>

<body>
	<div class="nav-align-top mb-4" style="margin-top:10px;">
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item">
				<button type="button" class="nav-link active" role="tab"
					data-bs-toggle="tab" data-bs-target="#hospitalTab"
					aria-controls="navs-top-home" aria-selected="true">병원일정</button>
			</li>
			<li class="nav-item">
				<button type="button" class="nav-link" role="tab"
					data-bs-toggle="tab" data-bs-target="#doctorTab"
					aria-controls="navs-top-profile" aria-selected="false">의사일정</button>
			</li>
		</ul>

		<div class="tab-content" style="padding:0px 0px 0px 0px; height:77vh;">

			<!-- /////////////// 병원 일정 시작 /////////////// -->
			<!-- 탭 박스 시작 -->
			<div class="tab-pane fade active show" id="hospitalTab"
				role="tabpanel">

				<!-- 캘린더 시작 -->
				<div mbsc-page class="demo-create-read-update-delete-CRUD"
					style="height: 68vh;">
					<div style="height: 100%">
						<div id="demo-add-delete-event"></div>
						<!-- /////////////// 모달 시작 /////////////// -->
						<div style="display: none">
							<div id="demo-add-popup">
								<div class="mbsc-form-group">
									<label> 분류 <input mbsc-input id="ctgrValue"
										data-dropdown="true" />
									</label> <select id="ctgrList">
										<option value="1">휴진</option>
										<option value="2">교육</option>
										<option value="3">학회</option>
										<option value="4">기타</option>
										<option value="5">공휴일</option>
									</select> <label> 일정제목 <input mbsc-input id="event-title">
									</label> <label> 메모 <textarea mbsc-textarea id="event-desc"></textarea>
									</label>
								</div>
								<div class="mbsc-form-group">
									<label style="padding: 0em 4em 0em 1em;"> 하루종일 <input
										mbsc-switch id="event-all-day" type="checkbox" />
									</label> <label> 시작 <input mbsc-input id="start-input" />
									</label> <label> 종료 <input mbsc-input id="end-input" />
									</label>

									<div id="event-date"></div>

									<label> Show as busy <input id="event-status-busy"
										mbsc-segmented type="radio" name="event-status" value="busy">
									</label> <label> Show as free <input id="event-status-free"
										mbsc-segmented type="radio" name="event-status" value="free">
									</label>

									<div class="mbsc-button-group">
										<button class="mbsc-button-block" id="event-delete"
											mbsc-button data-color="danger" data-variant="outline">일정삭제</button>
									</div>

								</div>
							</div>
						</div>
						<!-- /////////////// 모달 끝 /////////////// -->
					</div>
				</div>
				<!-- 캘린더 끝 -->
			</div>
			<!-- 탭 박스 끝 -->
			<!-- /////////////// 병원 일정 끝 /////////////// -->

			<!-- /////////////// 의사 일정 시작 /////////////// -->
			<div class="tab-pane fade" id="doctorTab" role="tabpanel">
			    <div mbsc-page class="demo-custom-event-tooltip">
			        <div style="height:100%">
		                <div id="custom-event-tooltip-popup" class="md-tooltip">
					        <div id="tooltip-event-header" class="md-tooltip-header">
					            <span id="tooltip-event-name-age" class="md-tooltip-name-age"></span>
					            <span id="tooltip-event-time" class="md-tooltip-time"></span>
					        </div>
				    	</div>
					    <div id="demo-custom-event-tooltip"></div>
			        </div>
			    </div>
				<br>
<!-- 				<div id="docInfoDiv"> -->
<!-- 					<div class="docInfo"> -->
<!-- 						<div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material" style="background: #FAF3F0"></div> -->
<!-- 						<div class="docInfo"> -->
<!-- 							<h6 -->
<!-- 								style="padding-top: 6px; font-size: 12px; color: #4F709C; font-weight: 600;">&nbsp;[1진료실]</h6> -->
<!-- 							<h5 style="padding-top: 3px; font-size: 17px;">&nbsp;김예린&nbsp;&nbsp;&nbsp;&nbsp;</h5> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="docInfo"> -->
<!-- 						<div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material" style="background: #D4E2D4"></div> -->
<!-- 						<div class="docInfo"> -->
<!-- 							<h6 style="padding-top: 6px; font-size: 12px; color: #4F709C; font-weight: 600;">&nbsp;[2진료실]</h6> -->
<!-- 							<h5 style="padding-top: 3px; font-size: 17px;">&nbsp;이마크&nbsp;&nbsp;&nbsp;&nbsp;</h5> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="docInfo"> -->
<!-- 						<div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material" style="background: #FFCACC"></div> -->
<!-- 						<div class="docInfo"> -->
<!-- 							<h6 style="padding-top: 6px; font-size: 12px; color: #4F709C; font-weight: 600;">&nbsp;[3진료실]</h6> -->
<!-- 							<h5 style="padding-top: 3px; font-size: 17px;">&nbsp;윤강혁&nbsp;&nbsp;&nbsp;&nbsp;</h5> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="docInfo"> -->
<!-- 						<div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material" style="background: #DBC4F0"></div> -->
<!-- 						<div class="docInfo"> -->
<!-- 							<h6 style="padding-top: 6px; font-size: 12px; color: #4F709C; font-weight: 600;">&nbsp;[4진료실]</h6> -->
<!-- 							<h5 style="padding-top: 3px; font-size: 17px;">&nbsp;정은비&nbsp;&nbsp;&nbsp;&nbsp;</h5> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
			</div>
			<!-- /////////////// 의사 일정 끝 /////////////// -->
		</div>
	</div>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.employee" var="empVO" />
</sec:authorize>

<script>

//-------------------- 웹소켓 ----------------------
function fMessage() { // 받는 쪽에 작성
	let serverMsg = JSON.parse(event.data);

	if(serverMsg.cmd == "alarm") {
// 		alert("알람!");
		getNotiList();
	}
}
//-------------------- /웹소켓 ----------------------

		$(function() {
			hosEventList(); // 병원일정 리스트 뿌리기 
			clinicEventList(); // 의사일정 리스트 뿌리기
			
		});
		
		// 의사일정 뿌리기(list)
		const clinicEventList = function() {
			let xhr = new XMLHttpRequest();
			xhr.open("get", "/calendar/clinicSchedules", true);
			xhr.onreadystatechange = function() {
				if(xhr.readyState == 4 && xhr.status == 200) {
					console.log("의사일정 출력 시작");
					let result = JSON.parse(xhr.responseText);
					let clinicData = [];
					
					for(let i=0; i<result.length; i++) {
						let item = result[i];
						let clinicItem = {
								title: "[" + item.hosFcName + "]" + item.empNm,
								start: item.schdStart,
								end: item.schdEnd,
								color: item.hosFcColor
						}
						clinicData.push(clinicItem);
					}
					console.log("전체의사일정(clinicData): ", clinicData)
					docCalendar.addEvent(clinicData);
				}
			}
			xhr.send();
		}
		
		// 병원일정 뿌리기(list)
		const hosEventList = function() {
			let xhr = new XMLHttpRequest();
			xhr.open("get", "/calendar/hosSchedules", true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					console.log("병원일정 출력 시작");
					// json 문자열을 json객체로
					let result = JSON.parse(xhr.responseText);
					let myData = [];

					for (let i = 0; i < result.length; i++) {
						let item = result[i];
						let dataItem = {
							no : item.hosSchNo,
							title : item.hosSchTitle,
							description : item.hosSchCont,
							start : item.hosSchStart,
							end : item.hosSchEnd,
							allday : item.hosSchAllDay,
							color : item.hosSchColor
						}
						myData.push(dataItem);
					}
					console.log("전체병원일정(myData): ", myData);

					calendar.addEvent(myData);
				}
			}
			xhr.send();
		};

		// 병원일정 insert
		const insertEvent = function(event) {
			console.log("insertEvent로 넘어온 event", event);
			// 넘길 데이터
			let hosScheduleVO = {
				hosSchTitle : event.title,
				hosSchCont : event.description,
				hosSchStart : event.start,
				hosSchEnd : event.end,
				//    			hosSchUrl: ,
				hosSchColor : event.color,
				hosSchAllDay : event.allDay
			}
			console.log("insertEvent에서 저장된 VO ", hosScheduleVO);

			let xhr = new XMLHttpRequest();
			xhr.open('post', "/calendar/hosSchedule", true);
			xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					console.log("일정 등록 체크: ", xhr.responseText);
					// 웹소켓으로 일정등록을 연락!
					let msg = {
						to: "all", 
						from: "경민",
				        cmd: "alarm",  
					    data: "새로운 병원 일정이 등록되었습다."	
					}
					webSocket.send(JSON.stringify(msg));

					//일정 업데이트 시 알림내역 목록
					let empNo = "${empVO.empNo}";
					console.log("로그인 한 empNo : " + empNo);
					
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
							console.log("result :" +JSON.stringify(result));
							//result : List<NotificationVO>
							let str = "";
							let cnt = 0;
							$.each(result,function(index,notificationVO){
								str += "<li><a class='dropdown-item' href='/calendar/schedule?ntcnId="+notificationVO.ntcnId+"'>";
								str += "<i class='fa fa-bell me-2'></i> <span class='align-middle'>"+notificationVO.ntcnContent+"</span></a>";
								str += "</li><li><div class='dropdown-divider'></div></li>";
								cnt++;
							});
							$("#ulNoti").html(str);
							$("#circle").html(cnt);
						},
						error: function(xhr, status, error) {
				    	    console.log("code: " + xhr.status);
				    	    console.log("message: " + xhr.responseText);
				    	    console.log("error: " + error);
				    	}
					});
				}
			}
			xhr.send(JSON.stringify(hosScheduleVO)); // json으로 변경 후 전송
		}

		// 병원일정 update
		const updateEvent = function(event) {
			// 넘길 데이터
			let hosScheduleVO = {
				hosSchNo : event.no,
				hosSchTitle : event.title,
				hosSchCont : event.description,
				hosSchStart : event.start,
				hosSchEnd : event.end,
				//    			hosSchUrl: ,
				hosSchColor : event.color,
				hosSchAllDay : event.allDay
			}
			console.log("updateEvent에서 저장된 VO ", hosScheduleVO);

			let xhr = new XMLHttpRequest();
			xhr.open("put", "/calendar/hosSchedule", true)
			xhr.setRequestHeader("Content-Type",
					"application/json; charset=utf-8");
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					console.log("일정수정 체크", xhr.responseText); // update 된 행의 수
				}
			}
			xhr.send(JSON.stringify(hosScheduleVO));
		}

		// 병원일정 delete
		const delEvent = function(event) {
			let xhr = new XMLHttpRequest();
			let url = "/calendar/hosSchedule/" + event.no;
			console.log("url : " + url);
			//     	console.log("delEvent에 넘어온 event.no", event.no);
			xhr.open("delete", url, true);
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					console.log("일정삭제체크", xhr.responseText); // delete 된 행의 개수
					hosEventList();
				}
			}
			xhr.send();
		}

		// 지역, 테마 설정
		mobiscroll.setOptions({
			locale : mobiscroll.localeKo,
			theme : 'material',
			themeVariant : 'light'
		});

		var myData = []; // 저장된 병원일정이 담길 배열
		var clinicData = []; // 저장된 의사일정이 담길 배열
		var oldEvent, // 이전 이벤트를 저장하기 위한 변수
		tempEvent = {}, // 현재 작업중인 이벤트를 저장하기 위한 변수(추가/수정 시 사용)
		deleteEvent, // 이벤트를 삭제하는 동작여부 (boolean)
		restoreEvent, // 이벤트 복원 동작여부 (boolean)

		// HTML 요소에 대한 참조를 저장하는 변수들
		ctgrValue = document.getElementById('ctgrValue'), ctgrList = document
				.getElementById('ctgrList'), titleInput = document
				.getElementById('event-title'), descriptionTextarea = document
				.getElementById('event-desc'), allDaySwitch = document
				.getElementById('event-all-day'), startInput = document
				.getElementById('start-input'), endInput = document
				.getElementById('end-input'), freeSegmented = document
				.getElementById('event-status-free'), busySegmented = document
				.getElementById('event-status-busy'), deleteButton = document
				.getElementById('event-delete'),

		// 날짜 및 시간 선택기의 옵션을 정의하는 변수들(화면 크기에 따라)
		datePickerResponsive = {
			medium : {
				controls : [ 'calendar' ],
				touchUi : false
			}
		}, datetimePickerResponsive = {
			medium : {
				controls : [ 'calendar', 'time' ],
				touchUi : false
			}
		}
		
		// 카테고리별 색상 지정
		var myResources = [ {
			id : 1,
			name : '휴진',
			color : '#C8F2EF'
		}, {
			id : 2,
			name : '교육',
			color : '#FFF2CC'
		}, {
			id : 3,
			name : '학회',
			color : '#E9EDC9'
		}, {
			id : 4,
			name : '기타',
			color : '#E9E8E8'
		}, {
			id : 5,
			name : '공휴일',
			color : '#ED7B7B'
		} ];
		

		// 일정 등록 모달 설정
		function createAddPopup(elm) {
			deleteButton.style.display = 'none'; // 삭제 버튼 숨기기

			deleteEvent = true;
			restoreEvent = false;

			// 일정 등록
			popup.setOptions({
				headerText : '일정 등록', // 모달 헤더명
				buttons : [ 'cancel', {
					text : '등록',
					keyCode : 'enter',
					handler : function() {
						console.log("createAddPopup", tempEvent); // tempEvent는 현재 작업 중인 이벤트
						var eventCtgr = ctgrList.value;
						var eventTitle = titleInput.value.trim();

						if (eventCtgr === "") {
							alert("분류는 필수 입력 항목입니다.");
							return;
						}

						if (eventTitle === "" || eventTitle === "New Event") {
							alert("일정제목은 필수 입력 항목입니다.");
							return;
						}

						insertEvent(tempEvent); // DB에 insert
						calendar.updateEvent(tempEvent); // New event -> 생성이벤트 타이틀
						calendar.navigateToEvent(tempEvent); // 일정 등록 후 사용자에게 해당 위치를 보여줌
						deleteEvent = false;
						popup.close();
					},
					cssClass : 'mbsc-popup-button-primary'
				} ]
			});

			// 일정 등록시 기본값
			mobiscroll.getInst(titleInput).value = '';
			titleInput.placeholder = "New Event";
			ctgrValue.value = "Category";
			mobiscroll.getInst(ctgrList).value = '';
			mobiscroll.getInst(descriptionTextarea).value = '';
			mobiscroll.getInst(allDaySwitch).checked = true;
			range.setVal([ tempEvent.start, tempEvent.end ]);
			mobiscroll.getInst(busySegmented).checked = true;
			range.setOptions({
				controls : [ 'date' ],
				responsive : datePickerResponsive
			});

			if (tempEvent.color) {
				mobiscroll.getInst(titleInput).setOptions({
					color : tempEvent.color
				});
			}

			// set anchor for the popup
			popup.setOptions({
				anchor : elm
			});

			popup.open();
		}

		// !!!!!!!!!!!!!!! 일정 조회만 가능한 모달 설정 - 인사총무과 제외 !!!!!!!!!!!!!!!
		function createDetailPopup(args) {
			var ev = args.event;

			deleteButton.style.display = 'none'; // 삭제버튼 안보이게

			deleteEvent = false;
			restoreEvent = true;

			// 버튼
			popup.setOptions({
				headerText : '일정 조회',
				buttons : [ {
					text : '닫기',
					keyCode : 'enter',
					handler : function() {
						popup.close();
					},
					cssClass : 'mbsc-popup-button-primary'
				} ]
			});

			// fill popup with the selected event data
			var matchResource = myResources.find(function(resource) {
				return resource.color == ev.color;
			});
			if (matchResource) {
				ctgrValue.value = matchResource.name;
			} else {
				ctgrValue.value = "Category";
			}
			mobiscroll.getInst(titleInput).value = ev.title || '';
			titleInput.disabled = true;
			mobiscroll.getInst(descriptionTextarea).value = ev.description
					|| '';
			descriptionTextarea.disabled = true;
			mobiscroll.getInst(allDaySwitch).checked = ev.allDay || false;
			allDaySwitch.disabled = true;
			range.setVal([ ev.start, ev.end ]);
			range.disabled = true;
			startInput.disabled = true;
			endInput.disabled = true;
			ctgrValue.disabled = true;
			if (ev.free) {
				mobiscroll.getInst(freeSegmented).checked = true;
			} else {
				mobiscroll.getInst(busySegmented).checked = true;
			}

			// change range settings based on the allDay
			range.setOptions({
				controls : ev.allDay ? [ 'date' ] : [ 'datetime' ],
				responsive : ev.allDay ? datePickerResponsive
						: datetimePickerResponsive
			});

			// set anchor for the popup
			popup.setOptions({
				anchor : args.domEvent.currentTarget
			});
			popup.open();
		}
		
		// 일정 조회(수정,삭제) 모달 설정 - 인사총무과
		function createEditPopup(args) {
			var ev = args.event;

			deleteButton.style.display = 'block'; // 삭제버튼 보이게

			deleteEvent = false;
			restoreEvent = true;

			// 일정 수정
			popup.setOptions({
				headerText : '일정 조회',
				buttons : [ 'cancel', {
					text : '수정',
					keyCode : 'enter',
					handler : function() {
						var date = range.getVal();
						var eventToSave = { // 입력했던 값들 받아오기
							no : ev.no,
							title : titleInput.value,
							description : descriptionTextarea.value,
							allDay : mobiscroll.getInst(allDaySwitch).checked,
							start : date[0],
							end : date[1],
							color : ev.color
						};
						console.log("edit popup이다", eventToSave);
						updateEvent(eventToSave);
						calendar.updateEvent(eventToSave); // 수정 버튼 클릭시 update
						// navigate the calendar to the correct view
						calendar.navigateToEvent(eventToSave);
						restoreEvent = false;
						popup.close();
					},
					cssClass : 'mbsc-popup-button-primary'
				} ]
			});

			// fill popup with the selected event data
			var matchResource = myResources.find(function(resource) {
				return resource.color == ev.color;
			});
			if (matchResource) {
				ctgrValue.value = matchResource.name;
			} else {
				ctgrValue.value = "Category";
			}
			mobiscroll.getInst(titleInput).value = ev.title || '';
			mobiscroll.getInst(descriptionTextarea).value = ev.description
					|| '';
			mobiscroll.getInst(allDaySwitch).checked = ev.allDay || false;
			range.setVal([ ev.start, ev.end ]);

			if (ev.free) {
				mobiscroll.getInst(freeSegmented).checked = true;
			} else {
				mobiscroll.getInst(busySegmented).checked = true;
			}

			// change range settings based on the allDay
			range.setOptions({
				controls : ev.allDay ? [ 'date' ] : [ 'datetime' ],
				responsive : ev.allDay ? datePickerResponsive
						: datetimePickerResponsive
			});

			// set anchor for the popup
			popup.setOptions({
				anchor : args.domEvent.currentTarget
			});
			popup.open();
		}

		// 인사총무과만 등록 가능하게 수정
		var clickToCreateValue;
		var deptCode = "${empVO.deptCode}";
// 		console.log("하이deptcode는", deptCode);
		if(deptCode == 'D006' || deptCode == 'D000') {
			clickToCreateValue = 'double'
		} else {
			clickToCreateValue = false
		}
		
		// event 설정
		var calendar = mobiscroll.eventcalendar('#demo-add-delete-event', {
			clickToCreate : clickToCreateValue,
			dragToCreate : true, // More info about dragToCreate: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-dragToCreate
			//         dragToMove: true,                                             // More info about dragToMove: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-dragToMove
			//         dragToResize: true,                                           // More info about dragToResize: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-dragToResize
			view : { // More info about view: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-view
				calendar : {
					labels : true
				}
			},
			height: 700,
			data : myData, // 들어갈 data
			resources : myResources,
			onEventClick : function(args) { // More info about onEventClick: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#event-onEventClick
				oldEvent = Object.assign({}, args.event);
				tempEvent = args.event;

				if (!popup.isVisible()) {
					var deptCode = "${empVO.deptCode}";
					if(deptCode === 'D006' || deptCode === 'D000') {
						createEditPopup(args); // 수정 또는 조회 팝업 띄우기
					} else {
						createDetailPopup(args);
					}
				}
			},
			onEventCreated : function(args) { // More info about onEventCreated: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#event-onEventCreated
				popup.close();
				// store temporary event
				tempEvent = args.event;
				createAddPopup(args.target);
			},
			onEventDeleted : function() { // More info about onEventDeleted: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#event-onEventDeleted
				mobiscroll.snackbar({
					button : {
						action : function() {
							calendar.addEvent(args.event);
						},
						text : 'Undo'
					},
					message : 'Event deleted'
				});
			},
			onEventDragEnd : function(event, inst) {
				console.log("onEventDragEnd 호출");
				event.start = inst.start;
				event.end = inst.end;

				updateEvent(event);
			},
			onEventResize : function(event, inst) {
				console.log("onEventResize 호출");
				event.start = inst.start;
				event.end = inst.end;

				updateEvent(event);
			}

		});

		var popup = mobiscroll.popup('#demo-add-popup', {
			display : 'bottom', // Specify display mode like: display: 'bottom' or omit setting to use default
			contentPadding : false,
			fullScreen : true,
			onClose : function() { // More info about onClose: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#event-onClose
				if (deleteEvent) {
					calendar.removeEvent(tempEvent);
				} else if (restoreEvent) {
					calendar.updateEvent(oldEvent);
				}
			},
			responsive : { // More info about responsive: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-responsive
				medium : {
					display : 'anchored', // Specify display mode like: display: 'bottom' or omit setting to use default
					width : 400, // More info about width: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-width
					fullScreen : false,
					touchUi : false
				}
			}
		});

		titleInput.addEventListener('input', function(ev) {
			// update current event's title
			tempEvent.title = ev.target.value;
		});

		descriptionTextarea.addEventListener('change', function(ev) {
			// update current event's title
			tempEvent.description = ev.target.value;
		});

		allDaySwitch.addEventListener('change', function() {
			var checked = this.checked
			// change range settings based on the allDay
			range.setOptions({
				controls : checked ? [ 'date' ] : [ 'datetime' ],
				responsive : checked ? datePickerResponsive
						: datetimePickerResponsive
			});

			// update current event's allDay property
			tempEvent.allDay = checked;
		});

		// 날짜 다중선택 시
		var range = mobiscroll.datepicker('#event-date', {
			controls : [ 'date' ],
			select : 'range',
			startInput : '#start-input',
			endInput : '#end-input',
			showRangeLabels : false,
			touchUi : true,
			responsive : datePickerResponsive, // More info about responsive: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-responsive
			onChange : function(args) {
				var date = args.value;
				// update event's start date
				tempEvent.start = date[0];
				tempEvent.end = date[1];
			}
		});

		document.querySelectorAll('input[name=event-status]').forEach(
				function(elm) {
					elm.addEventListener('change',
							function() {
								// update current event's free property
								tempEvent.free = mobiscroll
										.getInst(freeSegmented).checked;
							});
				});

		deleteButton.addEventListener('click', function() {
			// delete current event on button click
			calendar.removeEvent(tempEvent);

			// save a local reference to the deleted event
			var deletedEvent = tempEvent;

			console.log("deleteButton을 누른 event", tempEvent);
			delEvent(tempEvent); // 이벤트 삭제

			popup.close();

			mobiscroll.snackbar({
				button : {
					action : function() {
						calendar.addEvent(deletedEvent);
					}
				//         		,
				//                 text: 'Undo'
				},
				message : 'Event deleted'
			});
		});

		ctgrList.addEventListener('change', function() {
			var thisSelect = this.value;
			//         console.log("select 값: ", thisSelect);
			var thisResource = myResources.find(function(resource) {
				return resource.id == thisSelect;
			});

			if (thisResource) {
				tempEvent.color = thisResource.color;
			}
		});

		mobiscroll.select(ctgrList, {
			inputElement : ctgrValue,
			touchUi : false
		});
		
		mobiscroll.setOptions({
	        locale: mobiscroll.localeEn,  // Specify language like: locale: mobiscroll.localePl or omit setting to use default
	        theme: 'material',                 // Specify theme like: theme: 'ios' or omit setting to use default
	        themeVariant: 'light'         // More info about themeVariant: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-themeVariant
	    });

		var docCalendar = mobiscroll.eventcalendar('#demo-custom-event-tooltip', {
            view: {                                  // More info about view: https://docs.mobiscroll.com/5-27-1/javascript/eventcalendar#opt-view
                calendar: {
                	labels: 4,
                    type: 'month'
                }
            },
            height: 700,    
            data: clinicData
		});
		
	</script>

</body>

</html>