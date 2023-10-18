package kr.or.ddit.clinic.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CliChtIspcVO {
	private String treatNo;
	private String rceptNo;
	private String clnicSttusCode;
	private String detailNo;
	private String dissCodeNo;
	private Date detailRegDate;
	private String pDetailNo;
	private String detailMemo;
	
	private String inspcCode;
	private String inspcStatus;
	private String empNo;
	private String inspcMemo;
	private String comFileCode;
	private Date inspcDate;
	private int inspcCost;
	private String inspcType;
	
	private String treCode;
	private String treStatus;
	private Date treDate;
	private int treCosts;
	private String treMemo;
	
	private Date physoDate;
	private String physioCode;
	private String physioStatus;
	private int physioCost;
}
