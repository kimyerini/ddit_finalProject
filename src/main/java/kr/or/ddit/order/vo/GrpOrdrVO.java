package kr.or.ddit.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GrpOrdrVO {
	private int grpOrdrNo;
	private String grpOrdrNm;
	private String dissCodeNo;
	private String ordrCode;
	private String ordrContent;
	private String ordrClass;
	private int ordrCost;
}
