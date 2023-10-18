package kr.or.ddit.prescription.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PrePhysioVO {
	private String detailNo      ;
	private String physioCode    ;
	private String physioContent ;
	private String physioCost    ;
}
