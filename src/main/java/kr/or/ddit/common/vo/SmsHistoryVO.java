package kr.or.ddit.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SmsHistoryVO {
	private String smsHisNo;
	private String smsHisCn;
	private String smsHisSender;
	private String smsHisReceiver;
	private String smsHisSendDate;
	private String smsHisReceiverName;
}
