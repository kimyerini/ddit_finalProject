package kr.or.ddit.patient.vo;

import java.util.Date;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PatientVO {
	private String patCode;
	private String patName;
	private String patTel;
	private String patIhidnum;
	private String patBrthdy;
	private String patGenCode;
	private String patAddr;
	private String patDtlAddr;
	private String patZip;
	private String patFirstDate;
	private String patLastDate;
	private String patFrgnrYn;
	private String patHsptlzStatus; // 입원상태코드) 1:default, 2:입원결정, 3:수속완료, 4:입원완료, 5:퇴원완료
	private String patHsptlzInDate;
	private String patHsptlzOutPlan;	
	
	private String treatNo;
	
	
}
