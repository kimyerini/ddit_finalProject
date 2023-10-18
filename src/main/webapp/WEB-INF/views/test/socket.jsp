<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>초우간단 채팅</title>
<style>
#id_chatwin {
	width: 300px;
	height: 100%;
	background-color: blue;
	border: 1px solid pink;
}
</style>
</head>
<body>

	<div>
		<div id="id_chatwin"></div>
		<input type="text" id="id_message" /> 
		<input type="button" id="id_send" value="호출"> 
			
			<input type="button" id="test" value="test">
	</div>
</body>
<script>


        //그냥 띰띰해서 맹근 랜덤 아이디 맹그는 함쑹
       const c_alpha="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
       const f_ranID=()=>{
         let ranID ="";
         for(let i=1; i< (Math.ceil(Math.random()*5)+4); i++){
            ranID += c_alpha[Math.floor(Math.random()*c_alpha.length)];
         }
         return ranID;
      }

      let webSocket; // 페이지 바뀌면 변수가 사라진다는 사실에 주목할 필요가 있음
      let myId = f_ranID();
      const c_chatWin = document.querySelector("#id_chatwin");
      const c_message = document.querySelector("#id_message");      
      const c_send = document.querySelector("#id_send");
      const c_exit = document.querySelector("#id_exit");

      c_send.addEventListener("click", ()=>{
         send();
      });
      // 연결 끊깅
      c_exit.addEventListener("click", function () {
         disconnect();
      });

      //연결
//       connect();
//       function connect() {
//          webSocket = new WebSocket("ws://localhost:8080/ws-socket"); // End Point
// //         webSocket = new WebSocket("ws://localhost:8080/merong/ws-chat"); // End Point
//          //이벤트에 이벤트핸들러 뜽록 
//          webSocket.onopen = fOpen; // 소켓 접속되면 짜똥 실행할 함수(fOpen)
//          webSocket.onmessage = fMessage; // 써버에서 메쎄징 오면  짜똥 실행할 함수(fMessage) 
//       }

      //연결 시
      function fOpen() {
         //webSocket.send(myId + "님."); -- 원무과 등록 ( 연결 되자마자 리스트 )
         
      } 
      function send() {  //( 호출 선택시 상태 변화)
         let msg = c_message.value;
         webSocket.send(myId + " : " + msg);
         c_message.value = "";
      }
      function fMessage() {
         let data = event.data;
         c_chatWin.innerHTML = c_chatWin.innerHTML + "<br/>" + data;
      }
      function disconnect() { //써버와 인연 끊는 함쑹
         //webSocket.send(myId + "님이 뛰쳐나갔쪙");
         webSocket.close();
      }
</script>
</body>
</html>