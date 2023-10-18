package kr.or.ddit.board.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.board.service.NoticeService;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.common.service.NotificationService;
import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.common.vo.NotiCheckVO;
import kr.or.ddit.employee.service.EmployeeManageService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.util.ArticlePage;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class NoticeController {

	@Autowired
	NoticeService noticeService;
	@Autowired
	TbAttachFileMapper fileMapper;
	@Autowired
	NotificationService notificationService;
	
	// [VIEW/select] 공지사항 list (공지사항 메인) + 페이징
	@Transactional
	@GetMapping("/notice")
	public String getListView(Model model,
						@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage,
						@RequestParam(value="size", required=false, defaultValue="10") int size,
						@RequestParam(value="keyword", required=false, defaultValue="") String keyword,
						@RequestParam(value="category", required=false, defaultValue="") String category) {
		log.info("<<< 여기는 getListView >>>");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage); // 기본값 1
		map.put("size", size); // 기본값 10
		map.put("category", category); // 기본 "제목"
		map.put("keyword", keyword); // 기본 ""
		
		log.info("map은?!?!?!?!: " + map);
		
		// 데이터 저장
		List<NoticeBoardVO> noticeBoardVO = noticeService.noticeList(map);
		log.info("noticeBoardVO" + noticeBoardVO);
		
		// TB_NOTICE_BOARD 테이블의 전체 행 수
		int noticeCount = noticeService.countNotice(map);
		model.addAttribute("noticeCount", noticeCount);

		// 페이징 처리한 data: ArticlePage 활용
		model.addAttribute("data", new ArticlePage<NoticeBoardVO>(noticeCount, currentPage, size, noticeBoardVO)); // 10은 size
		
		return "board/noticeList";
	}
	
	// [VIEW/select] 공지사항 1개 조회
	@GetMapping("/detail/{ntbdCode}")
	public String getDetailView(@PathVariable String ntbdCode, Model model,
			HttpSession session, Principal principal) {
		log.info("<<< 여기는 getDetailView >>>");
		
		NoticeBoardVO noticeBoardVO = new NoticeBoardVO();
		noticeBoardVO.setNtbdCode(ntbdCode);
		
		// 조회수 증가
		noticeService.updateHit(noticeBoardVO);
		
		// get one notice
		noticeBoardVO = noticeService.oneNotice(ntbdCode);
		log.info("getDetailView->noticeBoardVO : " + noticeBoardVO);
		
		model.addAttribute("noticeBoardVO", noticeBoardVO);
			
		return "board/noticeDetail";
	}
	
	// 알림내역에서 공지사항 디테일로 
	@Transactional
	@GetMapping("/noti/{ntbdCode}/{ntcnId}")
	public String getDetailView(@PathVariable String ntbdCode, Model model,
			HttpSession session, Principal principal,
			@PathVariable String ntcnId) {
		log.info("알림내역에서 공지사항 선택");
		
		// noti-check테이블에  insert
		String empNo = principal.getName();
		
		log.info("ntcnId : " + ntcnId + ",empNo : " + empNo);
		
		NotiCheckVO notiCheckVO = new NotiCheckVO();
		if(ntcnId!=null) {
			log.info("왔냐고 ntcnId : " + ntcnId);
			notiCheckVO.setNtcnId(Integer.parseInt(ntcnId));
			notiCheckVO.setEmpNo(empNo);
			//nicnId가 있으면 TB_NOTI_CHECK 테이블에 insert(알림 확인 처리)
			this.notificationService.insertNotiCheck(notiCheckVO);		
		}
		
		return "redirect:/board/detail/" + ntbdCode;
	}

	// [VIEW] 공지사항 작성 폼
	@GetMapping("/write")
	public String getWriteView() {
		log.info("<<< 여기는 getWriteView >>> ");
		
		return "board/noticeWrite";
	}
	
	// insert 공지사항
	@PostMapping("/write")
	public String insertNotice(NoticeBoardVO noticeBoardVO) {
		log.info("<<< 여기는 insertNotice >>>");
		
		noticeService.insertNotice(noticeBoardVO);
		log.info("insertNotice의 result: " + noticeBoardVO);
		
		// redirect
		return "redirect:/board/notice?result=1";
	}
	
	// delete 공지사항
	@ResponseBody
	@DeleteMapping("/delete/{ntbdCode}")
	public int deleteNotice(@PathVariable String ntbdCode) {
		log.info("<<< 여기는 deleteNotice >>>");
		
		int result = noticeService.deleteNotice(ntbdCode);
		result += noticeService.deleteAllFile(ntbdCode);
		
		return result;
	}
	
	// [VIEW/update] 공지사항 수정
	@GetMapping("/update/{ntbdCode}")
	public String getUpdateView(@PathVariable String ntbdCode, Model model) {
		log.info("<<< 여기는 getUpdateView >>>");
		
		NoticeBoardVO noticeBoardVO = new NoticeBoardVO();
		noticeBoardVO.setNtbdCode(ntbdCode);
		
		noticeBoardVO = noticeService.oneNotice(ntbdCode);
		model.addAttribute("noticeBoardVO", noticeBoardVO);
		
		return "board/noticeModify";
	}
	
	// update 공지사항
	@Transactional
	@PutMapping("/update")
	public String updateNotice(NoticeBoardVO noticeBoardVO) {
		log.info("<<< 여기는 updateNotice >>>");
		
		int[] chkFilesParam = noticeBoardVO.getChkFilesParam();
		log.info("넘어온 체크박스" + chkFilesParam);
		
		int fileDeleteResult = 0;
		for(int i=0; i<chkFilesParam.length; i++) {
			log.info("처리할 chkFileParam[" + i + "]: " + chkFilesParam[i]);
			fileDeleteResult += noticeService.deleteOneFile(chkFilesParam[i]);
		}
		log.info("삭제한 파일 개수: " + fileDeleteResult);
		
		noticeService.updateNotice(noticeBoardVO);
		log.info("noticeBoardVO: " + noticeBoardVO);
		
		return "redirect:/board/detail/" + noticeBoardVO.getNtbdCode() + "?result=1";
	}
	
	// delete 파일 부분삭제
	@DeleteMapping("/deleteFile")
	public int deleteFile(String fileNo) {
		log.info("<<< 여기는 deleteFile >>>");
		
		return fileMapper.deleteFile(fileNo);
	}
	
}
