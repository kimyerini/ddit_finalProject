package kr.or.ddit.clinic.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PatRecCliVO {
	private String patCode;
	private String patName;
	private String patTel;
	private String patIhidnum;
	private String patBrthdy;
	private String patGenCode;
	private String patAddr;
	private String patDtlAddr;
	private String patZip;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date patFirstDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date patLastDate;
	private String patFrgnrYn;
	private String patHsptlzStatus; // 입원상태코드) 1:default, 2:입원결정, 3:수속완료, 4:입원완료, 5:퇴원완료
	private String rceptNo;
	private String rceptPathCode;
	private String rceptFirstExamCode;
	private String rceptDayCode;
	private String rceptMemo;
	private String schdCode;
	private Date receptTime;
	private String treatNo;
	private String clnicSttusCode;
}
