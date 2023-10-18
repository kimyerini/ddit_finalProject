package kr.or.ddit.receipt.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReceiptionVO {
	private String rcivCode;
	private String treatNo;
	private Date rcivDe;
	private int rcivPayment;
}
