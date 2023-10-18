package kr.or.ddit.board.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.AttachFileVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class NoticeBoardVO {
	private String ntbdCode; // 게시글 번호
	private String ntbdSubject; // 게시글 제목
	private String ntbdContent; // 게시글 내용
	private String ntbdRegDate; // 게시글 등록일자
	private String writerEmpNo; // 게시글 등록한 사번
	private int ntbdHit; // 게시글 조회수
	private Date ntbdUpdDate; // 게시글 수정일자 - 안쓸듯
	private String comFileCode;
	private String updaterEmpNo; // 게시글 수정한 사번 - 안쓸듯
	
	// vo에만 있는 변수
	private String empName; // 직원 이름
	private String deptName; // 부서 이름
	private MultipartFile[] files; // 저장할 파일들
	private List<AttachFileVO> fileList; // 파일 웹경로 리스트
	private int rnum2; // 행 번호
	private int[] chkFilesParam; // 수정 시 체크박스에 들어있는 파일번호 배열
}
