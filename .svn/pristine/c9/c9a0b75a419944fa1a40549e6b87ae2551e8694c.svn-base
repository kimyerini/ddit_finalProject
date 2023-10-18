package kr.or.ddit.document.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.document.service.ProofRequestService;
import kr.or.ddit.document.vo.ProofReqVO;
import kr.or.ddit.document.vo.RequestDocumentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/document")
public class DocumentController {
	@Autowired
	ProofRequestService proofRequestService;
	
	@PostMapping("/insertReq")
	@ResponseBody
	public int insertDocReq(@RequestBody RequestDocumentVO requestDocumentVO) {
		log.info("더콰이엇:"+requestDocumentVO);
		int cnt = proofRequestService.insertProofReq(requestDocumentVO);
		return cnt;
	}
	
	@GetMapping("/list")
	@ResponseBody
	public List<ProofReqVO> getProofReqList(){
		return proofRequestService.getProofReqList();
	}
	
	@GetMapping("/getDoc/{reqDocumentNo}")
	@ResponseBody
	public AttachFileVO getFile(@PathVariable(value="reqDocumentNo") String reqDocumentNo) {
		return proofRequestService.getFileByDocNo(reqDocumentNo);
	}
	
	@GetMapping("/receiptModal/{reqDocumentNo}")
	@ResponseBody
	public ProofReqVO getProofReq(@PathVariable(value="reqDocumentNo")String reqDocumentNo) {
		return proofRequestService.getOneProofRequest(reqDocumentNo);
	}
	
	
	
}
