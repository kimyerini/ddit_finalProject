package kr.or.ddit.hospitalization.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class hosptPatVO {

	private String hsptlzNo;
	private String hsptlzInDate;
	private String hsptlzOutDate;
	private String patCode;
	private String treatNo;
	private String patName;
	private String patBrthdy;
	private String patGenCode;
	private String patHsptlzStatus;
}
