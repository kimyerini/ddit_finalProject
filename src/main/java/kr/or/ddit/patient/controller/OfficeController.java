package kr.or.ddit.patient.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.clinic.service.ClinicService;
import kr.or.ddit.common.vo.CommonCodeVO;
import kr.or.ddit.patient.mapper.PatientMapper;
import kr.or.ddit.patient.service.OfficeService;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.mapper.ReceiptMapper;
import kr.or.ddit.receipt.service.ReceiptService;
import kr.or.ddit.receipt.vo.CScheduleVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/office")
@Slf4j
public class OfficeController {
	@Autowired
	OfficeService officeService;
	@Autowired
	ReceiptService receiptService;
	@Autowired
	ClinicService clinicService;
	
	
	 
	@GetMapping("/main")
	public String officeMain() {
		return "office/officeMain";
	}
	
	@GetMapping("/receipt")
	public String officeReceipt() {
		return "office/receipt";
	}
	
	@ResponseBody
	@PostMapping("/insertPat")
	public int insertPat(@ModelAttribute PatientVO patientVO) {
		log.info("pVO : " + patientVO);
		
		return officeService.insertPat(patientVO);
	}
	
	@ResponseBody
	@GetMapping("/searchPat/{patName}")
	public List<PatientVO> searchPat(@PathVariable(value="patName",required=false) String patName){
		List<PatientVO> pVOList = null;
		PatientVO patientVO = new PatientVO();
		if(patName == null || patName.equals("")) {
			return null;
		} else {
			log.info("patName : " + patName);
			patientVO.setPatName(patName);
			pVOList = officeService.selectByName(patientVO);
		}
		return pVOList;
	}
	
	@ResponseBody
	@GetMapping("/setPat/{patCode}")
	public Map<String, Object> setPat(@PathVariable(value="patCode",required=false) String patCode) {
		Map<String, Object> myMap = new HashMap<>();
		log.info("patCode"+patCode);
		PatientVO patientVO = new PatientVO();
		patientVO.setPatCode(patCode);
		patientVO = officeService.selectByCode(patientVO);
		String rcptNo = receiptService.getRcepNo();
		List<CScheduleVO> schList = receiptService.getCSchedule();
		List<CommonCodeVO> comList = receiptService.selectPVST();
		log.info("리스틍"+schList);
		myMap.put("patientVO",patientVO);
		myMap.put("rcptNo", rcptNo);
		myMap.put("schList", schList);
		myMap.put("comList", comList);
		return myMap;
	}
	
	@ResponseBody
	@GetMapping("/patList")
	public List<WaitPatVO> getList(){
		List<WaitPatVO> list = new ArrayList<WaitPatVO>();
		list = clinicService.officeWaitPat();
		return list;
	}
	
	@ResponseBody
	@GetMapping("/scheduleList")
	public List<CScheduleVO> getCSchedule(){
		List<CScheduleVO> list = new ArrayList<CScheduleVO>();
		list = receiptService.getCSchedule();
		return list;
	}
	
	@ResponseBody
	@GetMapping("/getPat/{patCode}")
	public PatientVO getPatByCode(@PathVariable(value="patCode", required = false) String patCode){
		log.info(patCode);
		PatientVO patientVO = new PatientVO();
		patientVO.setPatCode(patCode);
		patientVO = officeService.selectByCode(patientVO);
		return patientVO;
	}
	
	@ResponseBody
	@PostMapping("/selectPatNoByName")
	public PatientVO selectPatNoByName(@ModelAttribute PatientVO patientVO) {
		log.info("selectPatNoByName:"+patientVO);
		patientVO = officeService.selectPatNoByName(patientVO);
		return patientVO;
	}
	
	@GetMapping("/document")
	public String officeDocument() {
		return "office/officeDocument";
	}
}
