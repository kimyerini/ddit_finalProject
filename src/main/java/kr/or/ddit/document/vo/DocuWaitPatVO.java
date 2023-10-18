package kr.or.ddit.document.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DocuWaitPatVO {
	
	//담당의
	private String empNo;
	private String empNm;
	
	//제증명
	private int documentNo;
	private String reqDocumentNo;
	private String documentDocNm;
	private String documentSignImgPath;
	private Date documentIsuDate;
	private String documentDissCn;
	private String documentDissClNo;
	private String documentOpinion;
	private String documentRm;
	private String documentPrpos;
	private String documentNote;
	private String documentType;
	
	//제증명신청내역
	private String detailNo;
	private String reqDocumentRegDate;
	private String reqDocumentStatus;
	private int reqDocumentPayment;
	private String documentUrl;


	//차트
	private String dissCodeNo;
	private String treatNo;
	private String detailRegDate;
	private String pDetailNo;
	private String detailMemo;
	
	//진료
	private String rceptNo;
	private String clnicSttusCode;
	
	//환자
	private String patCode;
	private String patName;
	private String patTel;
	private String patIhidnum;
	private String patBrthdy;
	private String patGenCode; 
	private String patGen;
	private String patAddr;
	private String patDtlAddr;
	private String patZip;
	private String patFirstDate;
	private String patLastDate;
	private String patFrgnrYn;
	private String patHsptlzStatus;
	private String patHsptlzInDate;
	private String patHsptlzOutPlan;	
	
	//접수
	private String rceptPathCode;
	private String rceptFirstExamCode;
	private String rceptDayCode;
	private String rceptMemo;
	private String schdNo;
	private Date receptTime;
	
	private String hosFcName;
}
