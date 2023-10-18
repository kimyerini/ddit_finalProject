package kr.or.ddit.receipt.controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.hospitalization.service.HospitalizationService;
import kr.or.ddit.order.vo.HospitalizationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reqHospitalizaton")
public class ReqHospitalizationController {
	@Autowired
	HospitalizationService hService;
	
	@Autowired
	private TbAttachFileMapper tbAttachFileMapper;
	
	@GetMapping(value="/main")
	public String ReqHospitalizationMain() {
		return "office/officeHospitalization";
	}
	
	@GetMapping(value="/list")
	@ResponseBody
	public List<HospitalizationVO> getList(){
		return hService.getReqHospitalizationList();
	}
	
	@GetMapping(value="/get/{hsptlzNo}")
	@ResponseBody
	public HospitalizationVO getHospitalization(@PathVariable(value="hsptlzNo") String hsptlzNo) {
		
		return hService.getReqHospitalization(hsptlzNo);
	}
	
	@PostMapping(value="/pdfUpload")
	@ResponseBody
	public int upLoadPdf(MultipartFile pdfFile, String hosNo, String fileName) throws Exception {
		
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
//			
			

			String filename = fileName;
			log.debug("fileName",fileName);
			String savePath = "d:/myTool/sts3WS/202303F_Team1/src/main/webapp/resources/upload/pdf/" + filename;
			log.info("savePath", savePath);
			log.info("아아아아아아");
			pdfFile.transferTo(new File(savePath));
			
//			//---------TB_ATTACH_FILE 테이블에 insert 시작---------
			AttachFileVO attachFileVO = new AttachFileVO();
			attachFileVO.setFileCode(hosNo);
			attachFileVO.setFileName(filename);
			//attachFileVO.setFileSaveName(uploadFileName);
			attachFileVO.setFilePhysicPath(savePath);
			attachFileVO.setFileWebPath("/pdffiles/" + filename);
			attachFileVO.setFileSize(pdfFile.getSize());
			attachFileVO.setFileContType(pdfFile.getContentType());
			//attachFileVO.setRegUserId(regUserId);
			
			log.info("하나의 attachFileVO: " + attachFileVO);

			// TB_ATTACH_FILE 테이블에 insert
			int cnt = tbAttachFileMapper.attachFileRegist(attachFileVO);
//			//----------TB_ATTACH_FILE 테이블에 insert 끝----------		
			
			return cnt;
	}
	
	@PostMapping("/inHospt")
	@ResponseBody
	public int updateWhenInHosptalization(@RequestBody HospitalizationVO hospitalizationVO) {
		log.info(hospitalizationVO.toString());
		return hService.updateWhenInHospitalization(hospitalizationVO);
	}
	
	//입원테이블에 총액 insert, 해당 detailNo마다 receiption테이블에 insert, 환자 코드 받아서 상태 1로 바꿔주기!!!!!!!!!!!!!!!
	@PostMapping("/outHospt")
	@ResponseBody
	public int updateWhenOutHosptalization(@RequestBody HospitalizationVO hospitalizationVO) {
		return 0;
	}
}
