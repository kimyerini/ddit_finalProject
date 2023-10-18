package kr.or.ddit.receipt.vo;

import java.util.Date;
import java.util.List;

import kr.or.ddit.clinic.vo.ChartDetailVO;
import kr.or.ddit.clinic.vo.ClinicVO;
import kr.or.ddit.order.vo.BedStatusVO;
import kr.or.ddit.patient.vo.PatientVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReceiptVO {
	private String rceptNo;
	private String patCode;
	private String rceptPathCode;
	private String rceptFirstExamCode;
	private String rceptDayCode;
	private String rceptMemo;
	private String schdNo;
	private String receptTime;
	
	private PatientVO patientVO;
	private ClinicVO  clinicVO;
	private ChartDetailVO chartDetailVO;
	private List<BedStatusVO> bedStatusVO;
}
