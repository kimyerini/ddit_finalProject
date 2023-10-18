package kr.or.ddit.receipt.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HosRInspcVO {
	private String inspcCode;
	private String inspcType;
	private int inspcCost;
	private String detailNo;
	private String detailRegDate;
}
