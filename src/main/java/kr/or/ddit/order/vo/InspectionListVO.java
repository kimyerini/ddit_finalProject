package kr.or.ddit.order.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.AttachFileVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class InspectionListVO {
	private String detailNo;
	private String inspcCode;
	private String inspcStatus;
	private String empNo;
	private String inspcMemo;
	private String comFileCode;
	@DateTimeFormat(pattern = "yy/MM/dd")
	private Date inspcDate;
	private Date inspcDateStr;
	private int inspcCost;
	
	//vo 에만
	private String treatNo;
	private String inspcType;
	private String fileName;
	private String filePhysicPath;
	private String inCode;
	private String empName; // 직원 이름
	private MultipartFile[] files; // 저장할 파일들
	
	private List<AttachFileVO> fileList; // 파일 웹경로 리스트
	
	private int rnum; // 행 번호
}
