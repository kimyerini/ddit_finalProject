package kr.or.ddit.document.controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.clinic.service.ClinicService;
import kr.or.ddit.clinic.vo.ChartDetailByDateVO;
import kr.or.ddit.clinic.vo.ClinicChartRecPatVO;
import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.common.vo.PdfVO;
import kr.or.ddit.document.service.ProofService;
import kr.or.ddit.document.vo.DocuWaitPatVO;
import kr.or.ddit.document.vo.RequestDocumentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/doctor")

public class ProofController {

	@Autowired
	private ProofService proofSVC;
	
	@Autowired
	private ClinicService clinicSVC;
	
	@Autowired
	private TbAttachFileMapper tbAttachFileMapper; // TB_ATTACH_FILE 테이블에 insert 하기 위해 주입
	
	@GetMapping("/proof")
	public String getView() {
		
		log.info("proof 도착!");
		return "clinic/proof";
	}

	// 제증명 대기 환자 목록 조회하기 (담당 환자만)	
	@ResponseBody
	@GetMapping(value="/proof/waitList/{empNo}",produces = "application/json;charset=utf-8")
	public List<DocuWaitPatVO> docuWaitPat(@PathVariable String empNo) {
		DocuWaitPatVO docuWaitPatVO = new DocuWaitPatVO();
		docuWaitPatVO.setEmpNo(empNo);
		
		log.info("제증명대기 환자 목록 출력하깅");
		log.info("제증명대기 환자 목록 출력하깅" + empNo);
		
		List<DocuWaitPatVO> docuWaitPatVOList = proofSVC.docuWaitPat(docuWaitPatVO);
		log.info("제증명대기 환자 목록 출력하깅" + docuWaitPatVO);
		return docuWaitPatVOList;
	}

	// 제증명 신청내역 조회(환자코드로)	
	@ResponseBody
	@GetMapping(value="/proof/reqInfo/{patCode}/{treatNo}",produces = "application/json;charset=utf-8")
	public DocuWaitPatVO selectDocuInfo(@PathVariable String patCode,@PathVariable String treatNo) {
		DocuWaitPatVO docuWaitPatVO = new DocuWaitPatVO();
		docuWaitPatVO.setPatCode(patCode);
		docuWaitPatVO.setTreatNo(treatNo);
		
		log.info("제증명 신청내역 조회" + docuWaitPatVO );
		log.info("제증명 신청내역 조회 환자코드" + patCode);
		log.info("제증명 신청내역 조회 treatNo" + treatNo);
		
		return proofSVC.selectDocuInfo(docuWaitPatVO);
	}
	
	
	//환자 차트 날짜별 리스트 조회
	@ResponseBody
	@GetMapping(value="/proof/date/{patCode}",produces = "application/json;charset=utf-8")
	public List<ClinicChartRecPatVO> getRegDateList(@PathVariable String patCode) {
		ClinicChartRecPatVO clinicChartRecPatVO = new ClinicChartRecPatVO();
		clinicChartRecPatVO.setPatCode(patCode);
		
		log.info("차트날짜VO : " + clinicChartRecPatVO);
		return clinicSVC.getRegDateList(clinicChartRecPatVO);
	}

	
	// 등록날짜로 환자차트 조회하기	
	// vo 생성후, 서비스에 전달하여 결과를 얻고, vo에 결과를 저장, 이를 반환한다.
	@ResponseBody
	@GetMapping(value="/proof/date/chart/{detailRegDate}/{patCode}/{treatNo}", produces = "application/json;charset=utf-8")
	public List<ChartDetailByDateVO> getChartByRegDate(@PathVariable String detailRegDate,@PathVariable String patCode,@PathVariable(value = "treatNo",required = false) String treatNo) {
	    ChartDetailByDateVO chartDetailByDateVO = new ChartDetailByDateVO();
	    chartDetailByDateVO.setDetailRegDate(detailRegDate);
	    chartDetailByDateVO.setPatCode(patCode);
	    chartDetailByDateVO.setTreatNo(treatNo);

	    List<ChartDetailByDateVO> chartDetailByDateVOList = clinicSVC.getChartByRegDate(chartDetailByDateVO);
	   // chartDetailByDateVO = clinicSVC.getChartByRegDate(chartDetailByDateVO);
	    log.info("날짜로 검색한 환자차트 detailRegDate 도착!");
	    log.info("VO : " + chartDetailByDateVO);
	    return chartDetailByDateVOList;
	}
	
	@ResponseBody
	@PostMapping("/pdf")
	public String pdfUpload(MultipartFile pdfFile, String reqDocumentNo, String fileName) throws Exception {
		//체킁 이름: pdfFile
		log.debug("체킁 이름: {}",pdfFile.getName());
		
		//체킁 리소스: MultipartFile resource [pdfFile]
		log.debug("체킁 리소스: {}",pdfFile.getResource());
		
		// 체킁 타입: application/pdf
		log.debug("체킁 타입: {}",pdfFile.getContentType());
		
		//체킁 사이즈: 3570300
		log.debug("체킁 사이즈: {}",pdfFile.getSize());
		
		//체킁 파일네임: blob
		log.debug("체킁 파일네임: {}",pdfFile.getOriginalFilename());
//		
//		PdfVO pdfVO = new PdfVO();
//		pdfVO.setFileName(pdfFile.getName());
//		
//		log.debug("체킁 getFileName:",pdfVO.getFileName());
//		log.debug("체킁 getName:",pdfVO.getPdfFile().getName());
//		log.debug("체킁 getSize:",pdfVO.getPdfFile().getSize());
//		log.debug("체킁 getOriginalFilename:",pdfVO.getPdfFile().getOriginalFilename());
//		log.debug("체킁 pdfVO:",pdfVO);	
		
		//요기서 테이블에 update하자
		// 파일 업로드할때 공통파일 테이블에 insert, 신청번호를 pk로 가지고 전사적코드로 들어감
		// 동시에 신청내역 테이블에 상태 update
		

		String filename = fileName;
		log.debug("fileName",fileName);
		String savePath = "d:/myTool/sts3WS/202303F_Team1/src/main/webapp/resources/upload/pdf/" + filename;
		log.info("savePath", savePath);
		log.info("아아아아아아");
		pdfFile.transferTo(new File(savePath));
		
//		//---------TB_ATTACH_FILE 테이블에 insert 시작---------
		AttachFileVO attachFileVO = new AttachFileVO();
		attachFileVO.setFileCode(reqDocumentNo);
		attachFileVO.setFileName(filename);
		//attachFileVO.setFileSaveName(uploadFileName);
		attachFileVO.setFilePhysicPath(savePath);
		attachFileVO.setFileWebPath("/pdffiles/" + filename);
		attachFileVO.setFileSize(pdfFile.getSize());
		attachFileVO.setFileContType(pdfFile.getContentType());
		//attachFileVO.setRegUserId(regUserId);
		
		log.info("하나의 attachFileVO: " + attachFileVO);

		// TB_ATTACH_FILE 테이블에 insert
		tbAttachFileMapper.attachFileRegist(attachFileVO);
//		//----------TB_ATTACH_FILE 테이블에 insert 끝----------		
		
		return "OK";
	}
	
	
	// 의사) 제증명 발급 완료 
	@ResponseBody
	@PutMapping(value="/proof/issued",produces = "application/json;charset=utf-8")
	public int issuedDocu(@RequestBody RequestDocumentVO requestDocumentVO) {	
		log.info("제증명 발급 완료");
		log.info(requestDocumentVO.toString());	
		
		int cnt = 0;
		cnt += proofSVC.issuedDocu(requestDocumentVO);

		return cnt;
}
}
