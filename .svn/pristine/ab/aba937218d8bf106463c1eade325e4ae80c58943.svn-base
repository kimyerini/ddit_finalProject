package kr.or.ddit.receipt.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.document.vo.ProofReqVO;
import kr.or.ddit.hospitalization.service.HospitalizationService;
import kr.or.ddit.receipt.service.ReceiptionService;
import kr.or.ddit.receipt.vo.HosReceiptionVO;
import kr.or.ddit.receipt.vo.ReceiptionVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value = "/receiption")
public class ReceiptionController {
	@Autowired
	ReceiptionService receiptionService;
	@Autowired
	HospitalizationService hospitalizationService;
	
	
	@PostMapping(value = "/insert")
	@ResponseBody
	public int insertReceiption(@RequestBody ReceiptionVO receiptionVO) {
		log.info("receiptionVO:"+receiptionVO);
		int cnt = receiptionService.insertReceiption(receiptionVO);
		return cnt;
	}
	
	@GetMapping("/reqDocument/{reqDocumentNo}")
	@ResponseBody
	public int proofReceiption(@PathVariable(value="reqDocumentNo")String reqDocumentNo) {
		return receiptionService.reqDocReceiption(reqDocumentNo);
	}
	
	@GetMapping("/hospitalization/{hsptlzNo}")
	@ResponseBody
	public List<HosReceiptionVO> getHosReceiptionVO(@PathVariable(value="hsptlzNo") String hsptlzNo) {
		return hospitalizationService.getHosReceiptionContent(hsptlzNo);
	}
	
	@PostMapping("/outHosReceiption")
	@ResponseBody
	public int outHosReceiptionAll(@RequestBody Map<String,Object> data) {
		log.info("전송된 리스트 !!" + data);
		List<String> detailNoList = (List<String>) data.get("detailNoList");
		int cnt = 0;
		String hsptlzNo = (String) data.get("hsptlzNo");
		String patCode = (String) data.get("patCode");
		hospitalizationService.updatePatOutHos(patCode);
		hospitalizationService.updateHosRoomPrice(hsptlzNo);
		for(int i = 0; i<detailNoList.size(); i++) {
			cnt += receiptionService.insertAllReceiptionWhenOutHosptlz(detailNoList.get(i));
		}
		return cnt;
	}
}
