package kr.or.ddit.clinic.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChartDetailByDateVO {
	// 차트
	private String detailNo;
	private String dissCodeNo;
	private String treatNo;
	private String detailRegDate;
	private String pDetailNo;
	private String detailMemo;
	
	//접수
	private String rceptNo;
	private String patCode;
	private String rceptPathCode;
	private String rceptFirstExamCode;
	private String rceptDayCode;
	private String rceptMemo;
	private String schdCode;
	private Date receptTime;
	
	//진료
	private String clnicSttusCode;
	private String dissEngName;
	private String dissKorName;

	//환자
	private String patHsptlzStatus; // 입원상태코드) 1:default, 2:입원결정, 3:수속완료, 4:입원완료, 5:퇴원완료
	
	//수납
	private String rcivCode;
	private Date rcivDe;
	private String rcivAt;
	private int rcivPayment;
	private String empNo;
	private String empNm;

	//처치
	private String treCode;
	private int treCosts;
	private String treContent;
	private String treStatus;
	
	//물리치료
	private Date physoDate;
	private String physioCode;
	private String physioStatus;
	private int physioCost;
	private String physioContent;
	private String inspcCode;
	
	//검사	
	private int inspcCost;
	private String inspcType;
	private String inspcStatus;
	
	//약품
	private String mediItemCode;
	private String mediItemName;
	private String mediItemMakr;
	private String mediItemUnit;
	private String mediItemUsage;
	private String narcoticYn;
	private int mediItemPrice;
	private int mediItemInvrQty;
	private int mediItemLeastQty;
	
	//처방내역
	@DateTimeFormat(pattern = "yy/MM/dd HH:mm:ss")
	private Date mediItemRegDate;
	private int prscrptnAmount;
	private int prscrptnCount;
	private int prscrptnDays;
}
