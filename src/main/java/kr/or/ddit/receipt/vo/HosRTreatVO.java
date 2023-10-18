package kr.or.ddit.receipt.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HosRTreatVO {
	private String treCode;
	private String treContent;
	private int treCosts;
	private String detailNo;
	private String detailRegDate;
}
