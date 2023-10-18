package kr.or.ddit.clinic.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChartDetailVO {
	private String detailNo;
	private String dissCodeNo;
	private String treatNo;
	private Date detailRegDate;
	private String pDetailNo;
	private String detailMemo;
	
	
}
