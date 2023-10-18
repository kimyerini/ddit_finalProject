package kr.or.ddit.order.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PhysioTherapyListVO {
	private String physoDate;
	private String physioCode;
	private String detailNo;
	private String physioStatus;
	private String empNo;
	private int physioCost;

	// table에 없는 컬럼 확장!
	private String physioContent;
	private String treatNo;
	private String patCode;
}
