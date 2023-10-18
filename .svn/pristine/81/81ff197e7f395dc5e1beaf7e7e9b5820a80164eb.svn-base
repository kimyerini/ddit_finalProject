package kr.or.ddit.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.item.vo.MediItemInventoryVO;
import kr.or.ddit.order.service.TreatmentService;
import kr.or.ddit.order.vo.PrescriptionVO;
import kr.or.ddit.order.vo.TreatmentListVO;
import kr.or.ddit.order.vo.TreatmentMediVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/nurse")
public class TreatmentController {
	@Autowired
	private TreatmentService treatmentService;
	
	
	
	@GetMapping("/treatment")
	public String getInventory() {
		return "nurse/treatment";
	}
	@GetMapping(value = "/treatmentWait",produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<WaitPatVO> selectWaitTreatment(){
		log.info("뭐라도 좀 나와봐");
		return treatmentService.selectWaitTreatment();
	}
	
	@ResponseBody
	@GetMapping(value="/waitpatClick/{patCode}/{treatNo}/{detailNo}")
	public Map<String, Object> selectWaitPatInfo(@PathVariable(value="patCode") String patCode ,@PathVariable(value="treatNo",required = false) String treatNo, @PathVariable(value="detailNo") String detailNo) {
		Map<String,Object> patMap = new HashMap<String, Object>();
		
		PatientVO patientVO = new PatientVO();
		
		
		TreatmentMediVO treatmentMediVO = new TreatmentMediVO();
		TreatmentListVO treatmentListVO = new TreatmentListVO();
		PrescriptionVO prescriptionVO = new PrescriptionVO(); 
		
		
		List<TreatmentMediVO> treatmentMediVOList = new ArrayList<TreatmentMediVO>();
		List<TreatmentListVO> treatmentListVOList = new ArrayList<TreatmentListVO>();
		List<PrescriptionVO> prescriptionVOList = new ArrayList<PrescriptionVO>();
				
		patientVO.setPatCode(patCode);
		
		treatmentMediVO.setTreatNo(treatNo);
		treatmentMediVO.setDetailNo(detailNo);
		
		treatmentListVO.setDetailNo(detailNo);
		treatmentListVO.setTreatNo(treatNo);
		
		prescriptionVO.setPatCode(patCode);
		
		treatmentMediVOList =treatmentService.midePat(treatmentMediVO);
		treatmentListVOList=treatmentService.treatmentPatList(treatmentListVO);
		prescriptionVOList = treatmentService.narcoticList(prescriptionVO);
		
		
		log.info("야야야야"+patCode);
		log.info("뭐야아아아" + treatNo);
		log.info("차트차트" + detailNo);
		
		patientVO=treatmentService.selectWaitPatInfo(patientVO);
		log.info("patientVO : "+patientVO.toString());
		log.info("prescriptionVO ==>" +prescriptionVO.toString());
		
		log.info("treatmentMediVO : "+treatmentMediVOList.toString());
		log.info("treatmentListVOList 나오자 : "+treatmentListVOList.toString());
		
		patMap.put("patientVO", patientVO);
		patMap.put("prescriptionVOList", prescriptionVOList);
		patMap.put("treatmentMediVOList", treatmentMediVOList);
		
		patMap.put("treatmentListVOList", treatmentListVOList);
		return patMap;
	}
	
	@ResponseBody
	@GetMapping("/updateTreatSttus/{treatNoUp}")
	public int updateTreatSttus(@PathVariable("treatNoUp") String treatNo) {
	    log.info("TreatmentListVO =>>" + treatNo);
	    int update = treatmentService.updateTreatSttus(treatNo);
	    if(update >0) {
	    	return 1;
	    }else {
	    	return 0;
	    }
	}
	@ResponseBody
	@GetMapping("/updateTreatSttusIng/{treatNoUp}")
	public int updateTreatSttusIng(@PathVariable("treatNoUp") String treatNo) {
	    log.info("TreatmentListVO =>>" + treatNo);
	    int update = treatmentService.updateTreatSttusIng(treatNo);
	    if(update >0) {
	    	return 1;
	    }else {
	    	return 0;
	    }
	}
	@ResponseBody
	@GetMapping("/mediQty/{mediItemCode}/{prscrptnTotal}")
	public int mediQtyUpdate (@PathVariable String mediItemCode, @PathVariable int prscrptnTotal) {
		
		log.info("코드와 수량 넘어오나? ===>"+mediItemCode+prscrptnTotal);
		
		MediItemInventoryVO mediItemInventoryVO = new  MediItemInventoryVO();
		mediItemInventoryVO.setMediItemCode(mediItemCode);
		mediItemInventoryVO.setPrscrptnTotal(prscrptnTotal);
		int update = treatmentService.mediQtyUpdate(mediItemInventoryVO);
		if(update>0) {
			return 1;
		}else {
			return 0;
		}
	}
	
	
}
