<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet"/> 

<link href="./resources/css/demo.css" rel="stylesheet"/> 

<style>
   .su{
      float: left;
      margin-bottom: 0;
   }
   #btn{
      float: right;
   }
   #ii{

	width: 100%;
	height: 50%;
   }
</style>
<script>
$(function() {
    $("#btn").on("click",function() {
    	var appenddiv1 = $("<div></div>").append($("#su1").clone());
    	$("#ii").append($("#su1").clone());

    	$(this).prop("disabled", true);
    });
});

</script>

<div class="grid-stack"></div>

<script type="text/javascript">
	
	// 그리드 스택 아이템 정의
	let gridStack1 = `<div id="div1" style=" height:100%; padding:40px; overflow: none;">
						<div class="input-group" id= "searchBar">
       						<span class="input-group-text"><i class="tf-icons bx bx-search"></i></span>
        					<input type="text" id="searchText"class="form-control" placeholder="Search...">
        
        					<button type="button" id="searchButton"style="margin-left:10px;">검색</button>
      					</div><br>
						<div id="buttons">
						<button type="button" id="mediItem">약품</button>
						<button type="button" id="item">비품</button>
						</div>
						<div class="card">
						 <h4 class="card-header">신청 대기 목록</h4>
						   <div class="card-body"style="max-height: 100%; overflow-y:auto;">
						  <div class="table-responsive text-nowrap" style="height:180px;">
						    <table class="table table-hover" id="waitingList">
				
						    </table>
						  </div>
						</div>
					     </div>`;
	let gridStack2 = `<div style="background-color:white; width:100%; height:100%;"><h1>승인/발주현황</h1></div>`;
	
	
    let gridStack3 = `<div id="div2" style="width:100%; height:100%; padding:10px;">
							<div id="ii" style="background-color:white;">
							<h4 id="medicheckOK" style="float: left;font-weight: bold;margin:5px;">수정</h4>
							<button>수정</button><button>삭제</button></br></br>
							
							<form>
							<input type="hidden"id="code"value="admin"/>
					        <label for="name" class="left-align">신청자명 :</label>
					        <input type="text" id="name" class="left-align" value="관리자" readonly/></br>
					        <label for="name" class="left-align" id="formItemCode">약품코드 :</label>
					        <input type="text" id="itemCode" class="left-align"readonly/><br>
					        <label for="name" class="left-align"id="formItemName">약품명 :</label>
					        <input type="text" id="itemName" class="left-align"readonly/><br>
					        <label for="name" class="left-align">신청일시 :</label>
					        <input type="date" id="reqDate" class="left-align"/><br>
					        <label for="name" class="left-align">수량 :</label>
					        <input type="number" id="reqQy" class="left-align"/><br>
					        
					        <input class="btnAll" id="cancellItem"type="button" value="취소"/>
					        <input class="btnAll" id="apcBtn" type="button" value="완료"/>
					    </form>
					</div>`;
						
		let gridStack4 = `<div style="background-color:white; width:100%; height:100%;"><h1>반려사유</h1>
		
		</div>`;
// 그리드 스택 아이템 배열
var items = [
    { w: 7, h: 3, float: false, content: gridStack1 },
    { w: 5, h: 3, float: false, content: gridStack3 },
    { w: 7, h: 3, float: false, content: gridStack2 },
    { w: 5, h: 3, float: false, content: gridStack4 }
];

// 그리드 스택 초기화
var grid = GridStack.init();
grid.load(items);
</script>



