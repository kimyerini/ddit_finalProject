<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>Insert title here</title>
<style>
.card-header {
	width: 10vw;
	padding: 1.5rem 1.5rem 0 1.5rem;
}
#div1 {
	display: flex;
	margin: 1vw 0 0 5vw;
}
#div2 {
	display: flex;
	margin: 1.2vw 0 0 5vw;
}
.short {
	width: 26.65vw;
	height: 38vh;
}
.long {
    width: 46vw;
    height: 40vh;
}
.card-body {
	display: flex;
	padding: 0;
}
.total-div {
	margin: 5vw 4vw 0 2vw;
}
.total-count {
	margin: 0;
}
.total-text {
	margin: 0;
	color: grey;
}
.genderChartDiv {
	margin: -1vw 0 0 1vw;
}
.ageChartDiv {
	margin: -1vw 0 0 3vw;
}
.salesChartDiv {
    width: 29vw;
    margin: 0.7vw 0 0 4vw;
}
.pathChartDiv, .reasonChartDiv, .physioChartDiv {
	margin: -1vw 0 0 8vw;
}
</style>
</head>
<body>
	<div id="div1">
		<div class="card long" id="patientChartDiv">
			<div class="card-header">
				<h4>환자 통계</h4>
			</div>
			<div class="card-body">
				<div class="total-div">
					<h1 class="total-count"></h1>
					<h5 class="total-text">Total</h5>
				</div>
				<div class="genderChartDiv">
					<canvas id="genderChart"></canvas>
				</div>
				<div class="ageChartDiv">
					<canvas id="ageChart"></canvas>
				</div>
			</div>
		</div>
		<div class="card long" style="width:37vw;margin-left:3vw;">
			<div class="card-header" style="display:flex;">
				<h4>병원 매출</h4>
<!-- 					<input class="form-control" type="month" id="currentDate"> -->
			</div>
			<div class="card-body">
				<div class="salesChartDiv">
					<canvas id="salesChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	
	<div id="div2">
		<div class="card short" id="salesChartDiv">
			<div class="card-header">
				<h4>내원 사유</h4>
			</div>
			<div class="card-body">
				<div class="reasonChartDiv">
					<canvas id="reasonChart"></canvas>
				</div>
			</div>
		</div>
		<div class="card short" id="treatChartDiv" style="margin-left:3vw;">
			<div class="card-header">
				<h4>내원 경로</h4>
			</div>
			<div class="card-body">
				<div class="pathChartDiv">
					<canvas id="pathChart"></canvas>
				</div>
			</div>
		</div>
		<div class="card short" id="" style="margin-left:3vw;">
			<div class="card-header">
				<h4>물리치료 통계</h4>
			</div>
			<div class="card-body">
				<div class="physioChartDiv">
					<canvas id="physioChart"></canvas>
				</div>
			</div>
		</div>
	</div>
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

$(function() {
	const genderChart = document.querySelector('#genderChart');
	const ageChart = document.querySelector('#ageChart');
	const salesChart = document.querySelector('#salesChart');
	const reasonChart = document.querySelector('#reasonChart');
	const pathChart = document.querySelector('#pathChart');
	const physioChart = document.querySelector('#physioChart');	
	const colors = ['#FFCC88', '#F7A894', '#E0F3DB', '#CCEBC5', '#A8DDB5'
					, '#4EB3D3', '#4EB3D3', '#2B8CBE', '#0868AC', '#084081'];

// 	$('#currentDate').val(new Date().toISOString().slice(0, 7));

	getGenderData(function() {
		// 데이터 가져온 후 성별 차트 출력
		new Chart(genderChart, {
			type: 'pie',
			data: {
				labels: genderLabels,
				datasets: [{
					label: "누적 환자 수",
					data: genderValues,
					backgroundColor: colors
				}]
			},
			options: {
				plugins: {
					title: { // default: display false
						display: true,
						text: '성별'
					},
					legend: {
						position: 'right'
					}
				},
				scales: {
					x: {
						beginAtZero: true,
						display: false
					},
					y: {
						beginAtZero: true,
						display: false
					}
				}
			}	
		});
	});
	
	getAgeData(function() {
		// 데이터 가져온 후 연령대별 차트 출력
		new Chart(ageChart, {
			type: 'pie',
			data: {
				labels: ageLabels,
				datasets: [{
					label: '누적 환자 수',
					data: ageValues,
					backgroundColor: colors
				}]
			},
			options: {
				plugins: {
					title: {
						display: true,
						text: '연령대별'
					},
					legend: {
						position: 'right'
					}
				},
				scales: {
					x: {
						beginAtZero: true,
						display: false
					},
					y: {
						beginAtZero: true,
						display: false
					}
				}
			}
		});
	});
	
	getVisitPath(function() {
		// 데이터 가져온 후 내원경로 출력
		new Chart(pathChart, {
			type: 'radar',
			data: {
				labels: pathLabels,
				datasets: [{
					label: '환자 수',
					data: pathValues,
					backgroundColor: colors
				}]
			},
			options: {
				plugins: {
					legend: {
						display: false
					}
				},
				scales: {
			        r: {
			            min: 0,
// 			            max: 10,
			            beginAtZero: true,
			            angleLines: {
							display: false
						}
		            },
				}
			}
		});
	});
	
	getVisitReason(function() {
		// 데이터 가져온 후 내원사유 출력
		new Chart(reasonChart, {
			type: 'pie',
			data: {
				labels: reasonLabels,
				datasets: [{
					label: '환자 수',
					data: reasonValues,
					backgroundColor: colors
				}]
			},
			options: {
				plugins: {
					legend: {
						position: 'right'
					}
				},
				scales: {
					x: {
						beginAtZero: true,
						display: false
					},
					y: {
						beginAtZero: true,
						display: false
					}
				}
			}
		});
	});
	
	getSalesByMonth(function() {
		// 데이터 가져온 후 월별 매출 출력
		new Chart(salesChart, {
			type: 'bar',
			data: {
				labels: salesLabels,
				datasets: [{
					label: '총 매출',
					data: salesValues,
					backgroundColor: colors
				}]
			},
			options: {
				plugins: {
					legend: {
						display: false
					}
				},
				scales: {
					x: {
						beginAtZero: true
					},
					y: {
						beginAtZero: true,
					}
				}
			}
		});
	});
	
	getPhysioList(function() {
		// 데이터 가져온 후 물리치료 통계 출력
		new Chart(physioChart, {
			type: 'pie',
			data: {
				labels: physioLabels,
				datasets: [{
					label: '횟수',
					data: physioValues,
					backgroundColor: colors
				}]
			},
			options: {
				plugins: {
					legend: {
						position: 'right'
					}
				},
				scales: {
					x: {
						beginAtZero: true,
						display: false
					},
					y: {
						beginAtZero: true,
						display: false
					}
				}
			}
		});
	});
	
});

// 성별 데이터 가져오기
const getGenderData = (callback) => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/chart/gender", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
			console.log("가져온 성별 데이터", result);
			
			// 성별 데이터를 저장할 배열 변수
			genderLabels = []; // 남, 여
			genderValues = []; // 1, 4
			let genderTotal = 0;
			
			for(let i=0; i<result.length; i++) {
				genderLabels.push(result[i].dataLabel);
				genderValues.push(result[i].dataVal);
				genderTotal += Number(result[i].dataVal);
// 				console.log("genderTotal: " + genderTotal);
			}
// 			console.log("최종 genderLabel", genderLabels);
// 			console.log("최종 genderValues", genderValues);
			
			$('#patientChartDiv h1').text(genderTotal); // 전체 환자 수
			
			callback();
		}
	}
	xhr.send();
}

// 연령대별 데이터 가져오기
const getAgeData = (callback) => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/chart/age", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
			console.log("가져온 연령대 데이터", result);
			
			// 연령대 데이터를 저장할 배열 변수
			ageLabels = [];
			ageValues = [];
			
			for(let i=0; i<result.length; i++) {
				ageLabels.push(result[i].dataLabel);
				ageValues.push(result[i].dataVal);
			}
			callback();
		}
	}
	xhr.send();
}

// 내원경로 데이터 가져오기
const getVisitPath = (callback) => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/chart/path", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
			console.log("가져온 내원경로: ", result);
			
			// 내원경로 데이터를 저장할 배열함수
			pathLabels = [];
			pathValues = [];
			
			for(let i=0; i<result.length; i++) {
				pathLabels.push(result[i].dataLabel);
				pathValues.push(result[i].dataVal);
			}
			callback();
		}
	}
	xhr.send();
}

// 내원사유 데이터 가져오기
const getVisitReason = (callback) => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/chart/reason", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
			console.log("가져온 내원사유: ", result);
			
			// 내원사유 데이터를 저장할 배열 함수
			reasonLabels = [];
			reasonValues = [];
			
			for(let i=0; i<result.length; i++) {
				reasonLabels.push(result[i].dataLabel);
				reasonValues.push(result[i].dataVal);
			}
			callback();
		}
	}
	xhr.send();
}

// 월별 매출 데이터 가져오기
const getSalesByMonth = (callback) => {

// 	let currentDate = $('#currentDate').val().replace("-", "");
// 	console.log("오늘날짜는?", currentDate);
	
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/chart/sales", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
			console.log("가져온 월별 매출데이터: ", result);
			
			// 월별 매출 데이터를 저장할 배열 함수
			salesLabels = [];
			salesValues = [];
			
			for(let i=0; i<result.length; i++) {
				salesLabels.push(result[i].dataLabel);
				salesValues.push(result[i].dataVal);
			}
			callback();
			
		}
	}
	xhr.send();
}

// 물리치료 통계 데이터 가져오기
const getPhysioList = (callback) => {
	let xhr = new XMLHttpRequest();
	xhr.open("get", "/chart/physio", true);
	xhr.onreadystatechange = function() {
		if(xhr.readyState == 4 && xhr.status == 200) {
			let result = JSON.parse(xhr.responseText);
			console.log("가져온 물리치료 통계데이터: ", result);
			
			// 물리치료 통계데이터를 저장할 배열 함수
			physioLabels = [];
			physioValues = [];
			
			for(let i=0; i<result.length; i++) {
				physioLabels.push(result[i].dataLabel);
				physioValues.push(result[i].dataVal);
			}
			callback();
		}
	}
	xhr.send();
}

</script>
</html>