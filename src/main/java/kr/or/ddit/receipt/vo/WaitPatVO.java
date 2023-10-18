package kr.or.ddit.receipt.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WaitPatVO {
	private String treatNo ;
	private String rceptNo ;
	private String patName ;
	private String patCode ;
	private String patAge  ;
	private String patGen  ;
	private String patWait ;
	private String patPath ;
	private String patFirst;
	private String patDay ; 
	private String empNm;
	private String hosFcName;
	private String patBrthdy;
	private String receptTime;
	private String rceptMemo;
	private String empNo;
	private String detailNo;
	private String patHsptlzStatus;
	private String patHsptlzInDate;
	private String patHsptlzOutPlan;
	private String clinicSttusCode;
}
