package kr.or.ddit.order.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InspcFileVO {
	private String fileCode;
	private int fileNo;
	private String fileName;
	private String fileSaveName;
	private String filePhysicPath;
	private String fileWebPath;
	private long fileSize;
	private String fileContType;
	private Date fileRegDate;
	private String regUserId;
	private String updUserId;
	
	private String detailNo;
	private String inspcCode;
	private String inspcStatus;
	private String inspcType;
	private String empNo;
	private String inspcMemo;
	private String comFileCode;
	private Date inspcDate;
	private int inspcCost;
	
}
