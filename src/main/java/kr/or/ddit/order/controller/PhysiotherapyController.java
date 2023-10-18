package kr.or.ddit.order.controller;

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

import kr.or.ddit.clinic.vo.ClinicVO;
import kr.or.ddit.order.service.PhysioService;
import kr.or.ddit.order.vo.BedStatusVO;
import kr.or.ddit.order.vo.BedVO;
import kr.or.ddit.order.vo.PhysioTherapyListVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/physio")
public class PhysiotherapyController {
	
	@Autowired
	private PhysioService physioService;
	
	@GetMapping("/main")
	public String test() {
		return "physiotherapy/physioMain";
	}
	
	// 대기목록
	@GetMapping(value="/physioWait", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<WaitPatVO> physioWaitPat(){
		return physioService.physioWaitPat();
	}
	
	// 환자정보
	@ResponseBody
	@GetMapping(value="/main/{patCode}/{treatNo}", produces = "application/json;charset=utf-8")
	public PatientVO physioPatInfo(@PathVariable String patCode, @PathVariable String treatNo) {
		//patCode : 230901012, treatNo : 230905036
		log.info("patCode : " + patCode + ", treatNo : " + treatNo);
		PatientVO patientVO = new PatientVO();
		patientVO.setPatCode(patCode);
		patientVO.setTreatNo(treatNo);
		patientVO = physioService.physioPatInfo(patientVO);
		
		log.info("patientVO보자보자 : " + patientVO);
		
		return patientVO;
	}
	

	//침상배정
	@ResponseBody
	@PostMapping("/bedStatus")
	public List<BedVO> bedStatus(@RequestBody BedStatusVO bedStatusVO) {
		//BedStatusVO(physioCode=null, detailNo=null, bedNo=1, bedStatDate=null, patCode=230901012)
		log.info("bedStatusVO : " + bedStatusVO);
		
		//patCode=230901012 이 환자가 침상 점유여부를 떠나서 치료중인지 체킹
//		Map<String,String> map = this.physioService.getSttusBedNo(bedStatusVO.getPatCode());
//		
//		log.info("bedStatus->map : " + map);
		
		//침상 배경이 일어남
		int result = this.physioService.bedStatus(bedStatusVO);
//		log.info("bedStatus->result : " + result);
		//침상 사용 현황 목록
		List<BedVO> bedVOList = this.physioService.bedStatusList();
		
		return bedVOList;
	}
	
	//침상배정 처음 불러오기
	@ResponseBody
	@PostMapping("/bedStatusList")
	public List<BedVO> bedStatusList() {
		//침상 사용 현황 목록
		List<BedVO> bedVOList = this.physioService.bedStatusList();
		log.info("bedStatusList->bedVOList : " + bedVOList);
		
		return bedVOList;
	}
	
	//침상배정 치료내용 상태변경
	@ResponseBody
	@PostMapping("/bedStatusUpdate")
	public int bedStatusUpdate(BedStatusVO bedStatusVO) {
		//BedStatusVO(physioCode=null, physioContent=null, detailNo=null, bedNo=3, 
		//bedStatDate=null, patCode=null, physioYn=null, patName=null, patBrthdy=null,
		//clnicSttusCode=null, physioCodes=[음압치료, 파라핀치료])
		log.info("bedStatusVO : " + bedStatusVO);
		//침상배정 치료내용 상태변경
		 int result = this.physioService.bedStatusUpdate(bedStatusVO);
		log.info("result : " + result);
		
		return 1;
	}
	
	
	
	// 처치 오더 내역
	@ResponseBody
	@PostMapping("/physioList/{treatNo}")
	public List<PhysioTherapyListVO> physioList(@PathVariable String treatNo){
		
//		PhysioTherapyListVO physioTheraphyListVO = null;
		
		log.info("뭐라도 좀 찍히라고" + treatNo);
		
		//log.info("physioTheraphyListVO: {}" , physioService.physioList(treatNo));
		
		return physioService.physioList(treatNo);
		
	}
	
	// 치료내역
	@ResponseBody
	@PostMapping("/physioHistory/{patCode}")
	public List<PhysioTherapyListVO> physioHistory(@PathVariable String patCode){
		
		PhysioTherapyListVO physioTherapyListVO = new PhysioTherapyListVO();
		physioTherapyListVO.setPatCode(patCode);
		
		log.info("치료내역 찍히라고" + patCode);
		
		return physioService.physioHistory(patCode);
	}
	
	// 치료현황
	@ResponseBody
	@PostMapping("/physioStat")
	public List<BedStatusVO> physioStat(){
		
		List<BedStatusVO> bedStatList = this.physioService.physioStat();
		log.info("bedStatList : " + bedStatList);
		
		return bedStatList;
		
	}
	
	//침상번호를 알면 접수정보를 알 수 있음(PAT_CODE)
	@ResponseBody
	@PostMapping("/getReceiptInfo")
	public ReceiptVO getReceiptInfo(@RequestBody Map<String,Object> map){
		ReceiptVO receiptVO =  this.physioService.getReceiptInfo(map);

		log.info("receiptVO : " + receiptVO);
		
		return receiptVO;
	}
	
	// 치료완료버튼(상태업데이트)
	@ResponseBody
	@PostMapping("/updateStat/{treatNo}/{bedNo}")
	public int physioDone(@PathVariable String treatNo, @PathVariable String bedNo) {
		
		log.info("치료완료버튼 treatno",treatNo);
		
		return physioService.physioDone(treatNo, bedNo);
		
	}
	
}





