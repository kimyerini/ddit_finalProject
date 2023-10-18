package kr.or.ddit.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SocketVO {
	   private String to;   // 받는 사람
	   private String from; // 보내는 사람
	   private String cmd;  // command
	   private Object data; // 데이터
}
