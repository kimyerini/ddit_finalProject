package kr.or.ddit.order.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PrescriptionVO {
	private String patCode;
	private String mediItemCode;
	private String mediItemName;
	private String detailNo;
	private int prscrptnAmount;
	private int prscrptnCount;
	private int prscrptnDays;
	private String prscrptnStatus;
	private String empNo;
	private int mediItemPrice;
	private int calculatedValue;
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date detailRegDate;
	private String detailRegDateStr;
}
