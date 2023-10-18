package kr.or.ddit.order.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BedStatusVO {
	private String physioCode;
	private String physioContent;
	private String detailNo;
	private int bedNo;
	private Date bedStatDate;
	private String patCode;
	private String physioYn;//치료내용 상태(Y/null)
	
	private String patName;
	private String patBrthdy;
	private String clnicSttusCode;
	
	//음압치료,파라핀치료,
	private String[] physioCodes;

}
