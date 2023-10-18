package kr.or.ddit.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.common.vo.SocketVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSocket
public class SocketHandler extends TextWebSocketHandler {
	private static List<WebSocketSession> list = new ArrayList<WebSocketSession>();

	private ObjectMapper objMapper = new ObjectMapper();

	// sessionid로는 구분이 어려우닝, 사용자로그인 ID와 sessionID를 map을 이용해서 연결
	// private static Map<String, WebSocketSession> loginMap = new HashMap<String,
	// WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		list.add(session);
		log.info("## 누군가 접속" + session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("## 누군가 떠남");
		list.remove(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		String uMsg = message.getPayload();
		log.debug("요청 메세지확인:{}", uMsg);

		SocketVO msgVO = objMapper.readValue(uMsg, SocketVO.class); // JSON문자열을 자바객체로 매핑하기

		log.debug("메세지 변환 확인: {}", msgVO);

		//if (msgVO.getTo().equals("all")) {
			String retMsg = objMapper.writeValueAsString(msgVO); // 자바객체를 JSON문자열로 맵핑하기
			for (WebSocketSession webSocketSession : list) {
			//	if (webSocketSession != session) { // 본인은 제외하기
					webSocketSession.sendMessage(new TextMessage(retMsg));
			//	}
			}
		//}

		/*
		msgVO.setFrom("E7E");
		msgVO.setData("경민이가 보냈어용");
		if (msgVO.getTo().equals("me")) { // 메세지 보낸 사람에게 에코
			String retMsg = objMapper.writeValueAsString(msgVO); // 자바객체를 JSON문자열로 맵핑하기
			session.sendMessage(new TextMessage(retMsg));
		}
		*/

		/*
		 * 은비 소켓 핸들러 내용
		 *  try { // JSON 문자열을 CumMSG 객체로 변환 ObjectMapper objectMapper = new
		 * ObjectMapper(); CumMSG cumMsg = objectMapper.readValue(uMsg, CumMSG.class);
		 * 
		 * log.debug("cumMsg: {}", cumMsg); log.debug("ck1: {}", cumMsg.getEid());
		 * log.debug("ck2: {}", cumMsg.getCmd()); log.debug("ck3: {}",
		 * cumMsg.getClient());
		 * 
		 * // 필요한 로직 수행
		 * 
		 * 
		 * for (WebSocketSession webSocketSession : list) { if(webSocketSession.getId()
		 * != session.getId()) { webSocketSession.sendMessage(new
		 * TextMessage(objectMapper.writeValueAsString(cumMsg))); }
		 * 
		 * }
		 * 
		 * // 응답을 클라이언트에게 보냄 // session.sendMessage(new
		 * TextMessage(objectMapper.writeValueAsString(cumMsg))); } catch
		 * (JsonProcessingException e) { log.error("Failed to parse JSON: {}",
		 * e.getMessage()); // 예외 메시지 출력 }
		 * 
		 * log.debug("체킁:"+uMsg); log.debug("ID: " + uMsg.split(",")[0]);
		 * log.debug("FROM: " + uMsg.split(",")[1]);
		 * 
		 * loginMap.put(uMsg.split(",")[0], session); log.debug("체킁2:{}",loginMap);
		 * 
		 * 
		 * if(loginMap.get("원무과") != null) { log.debug("잘 실행되었낭?");
		 * loginMap.get("원무과").sendMessage(new TextMessage("호출")); }
		 * 
		 * 
		 * for (WebSocketSession webSocketSession : loginMap.values()) {
		 * webSocketSession.sendMessage(message); }
		 */
	}
}
