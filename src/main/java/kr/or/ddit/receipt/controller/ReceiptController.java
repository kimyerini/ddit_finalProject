package kr.or.ddit.receipt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.clinic.service.ClinicService;
import kr.or.ddit.clinic.vo.ChartDetailByDateVO;
import kr.or.ddit.clinic.vo.ClinicChartRecPatVO;
import kr.or.ddit.patient.service.OfficeService;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.prescription.service.PrescriptionService;
import kr.or.ddit.receipt.mapper.ReceiptMapper;
import kr.or.ddit.receipt.service.ReceiptService;
import kr.or.ddit.receipt.vo.ReceiptDateVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/receipt")
public class ReceiptController {
	@Autowired
	ReceiptService receiptService;
	
	@Autowired
	OfficeService officeService;
	
	@Autowired
	PrescriptionService prescriptionService;
	
	@PostMapping("/insert")
	@ResponseBody
	public int insertReceipt(@RequestBody ReceiptVO receiptVO) {
		log.info("접수!!receiptVO : " + receiptVO);
		PatientVO pVO = new PatientVO();
		pVO.setPatCode(receiptVO.getPatCode());
		officeService.updatePatLastDate(pVO);
		return receiptService.insertReceipt(receiptVO);
	}
	
	@GetMapping("/getWait")
	@ResponseBody
	public List<WaitPatVO> getWaitPat(){
		List<WaitPatVO> list = new ArrayList<WaitPatVO>();
		list = receiptService.selectWaitPat();
		log.info("리스트쳌"+list);
		return list;
	}
	
	@GetMapping("/delWait/{treatNo}")
	@ResponseBody
	public int delWaitPat(@PathVariable String treatNo) {
		
		int cnt = receiptService.delWait(treatNo);
		return cnt;
	}
	
	@GetMapping("/detailPat/{patCode}/{treatNo}/{receptTime}")
	@ResponseBody
	public Map<String,Object> getOneWaitPat(@PathVariable(value = "patCode",required = false) String patCode, @PathVariable(value="treatNo",required = false) String treatNo, @PathVariable(value="receptTime",required= false) String receptTime) {
		Map<String,Object> myMap = new HashMap<String, Object>();
		WaitPatVO waitPatVO = new WaitPatVO();
		PatientVO patientVO = new PatientVO();
		patientVO.setPatCode(patCode);
		log.info("patCode:" + patCode);
		log.info("treatNo:" + treatNo);
		
		patientVO = officeService.selectByCode(patientVO);
		waitPatVO.setTreatNo(treatNo);
		waitPatVO = receiptService.selectOneWaitPat(waitPatVO);
		log.info("patientVO : "+patientVO.toString());
		if(waitPatVO !=null) {
			
			myMap.put("waitPatVO", waitPatVO);
		}
		myMap.put("patientVO", patientVO);
		
		ChartDetailByDateVO cVO = new ChartDetailByDateVO();
		cVO.setDetailRegDate(receptTime);
		cVO.setPatCode(patCode);
		cVO.setTreatNo(treatNo);
		cVO = receiptService.getAllByDateAndPatCode(cVO);
		if(cVO !=null) {
			myMap.put("cVO", cVO);
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2 = prescriptionService.getPresciprtion(cVO.getDetailNo());
			if(map2.containsKey("preInspecList")) myMap.put("preInspecList",map2.get("preInspecList"));
			if(map2.containsKey("preMediList")) myMap.put("preMediList",map2.get("preMediList"));
			if(map2.containsKey("prePhysioList")) myMap.put("prePhysioList",map2.get("prePhysioList"));
			if(map2.containsKey("preTreatList")) myMap.put("preTreatList",map2.get("preTreatList"));
		}
		log.info(myMap.toString());
		return myMap;
	}
	
	@GetMapping("/date/{patCode}")
	@ResponseBody
	public List<ReceiptDateVO> getDates(@PathVariable(value="patCode") String patCode){
		log.info(patCode);
		ReceiptDateVO rVO = new ReceiptDateVO();
		List<ReceiptDateVO> list = new ArrayList<ReceiptDateVO>();
		log.info("리스트!!",list);
		rVO.setPatCode(patCode);
		list = receiptService.getReceiptDate(rVO);
		return list;
	}
	
	@GetMapping("/getChart/{receptTime}/{patCode}")
	@ResponseBody
	public ChartDetailByDateVO getAllByDateAndPatCode(@PathVariable(value="receptTime") String receptTime, @PathVariable(value="patCode") String patCode) {
		ChartDetailByDateVO cVO = new ChartDetailByDateVO();
		cVO.setDetailRegDate(receptTime);
		cVO.setPatCode(patCode);
		cVO = receiptService.getAllByDateAndPatCode(cVO);
		return cVO;
	}
}
