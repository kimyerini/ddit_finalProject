package kr.or.ddit.common.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AttachFileVO {
	private String fileCode;
	private int fileNo;
	private String fileName;
	private String fileSaveName;
	private String filePhysicPath;
	private String fileWebPath;
	private long fileSize;
	private int fileDownCnt;
	private String fileContType;
	private Date fileRegDate;
	private String regUserId;
	private Date fileUpdDate;
	private String updUserId;
	private String fileDeleteYn;
	
	private int fileCount; // 공지사항 글 하나당 파일 개수
}
