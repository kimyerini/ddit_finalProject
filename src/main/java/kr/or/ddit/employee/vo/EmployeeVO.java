package kr.or.ddit.employee.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.common.vo.AttachFileVO;
import lombok.Getter;
import lombok.ToString;
import lombok.Setter;

@Getter
@Setter
@ToString
public class EmployeeVO {
	private String enabled; 
	private String firstLogin; // 최초로그인여부
	private String empNo;
	private String empPassword;
	private String empNm;
	private String empEmail;
	private String empOriginEmail;
	private String empTelno;
	private String empBrthdy;
	private String empAddr;
	private String empDtlAddr;
	private String empZip;
	private String empEncpn;
	private String empRtcpn;
	private String empRegDate;
	private String deptCode;
	private String empSignImgPath;
	private String comCodeName;
	private List<UserAuthoritiesVO> userAuthList;
	private String empResignYsno;
	
	private String regUserId; // emp 사진을 등록하는 인사총무과 직원 아이디
	private MultipartFile files; // 저장할 직원 사진 파일들
	private List<AttachFileVO> fileList; // 파일 웹경로 리스트
	
}
