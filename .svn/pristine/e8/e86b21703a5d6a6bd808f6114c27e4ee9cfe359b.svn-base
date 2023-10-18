package kr.or.ddit.hospitalization.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.hospitalization.service.HospitalizationService;
import kr.or.ddit.hospitalization.vo.SickRoomTypeVO;
import kr.or.ddit.hospitalization.vo.SickbedVO;
import kr.or.ddit.order.vo.HospitalizationVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/nurse")
public class HospitalizationController {
	
	@Autowired
	private HospitalizationService hospService;
	
	@GetMapping("/hospit")
	public String getInventory() {
		return "nurse/hospitalization";
	}
	
	@GetMapping("/hospWait")
	@ResponseBody
	public List<WaitPatVO> hosptPatWaitList(){
		log.info("뭐라도 좀 나와봐");
		return  hospService.hosptPatWaitList();
	}
	@GetMapping("/selectRoom")
	@ResponseBody
	public List<SickRoomTypeVO> selectRoomData() {
		List<SickRoomTypeVO> si = hospService.selectRoomData();
		log.info("방방방 번호 호실 방방"+si);
		return si;
	}
	@ResponseBody
	@GetMapping("/updatehospitStatus/{patCode}/{sckrmNo}/{sckBdNo}")
	public int updatehospitStatus(@PathVariable(value="patCode") String patCode,@PathVariable(value="sckrmNo") String sckrmNo,@PathVariable(value="sckBdNo") String sckBdNo){
		log.info("patCode:"+patCode);
		log.info("sckrmNo:"+sckrmNo);
		log.info("sckBdNo:"+sckBdNo);
		PatientVO patientVO = new PatientVO();
		HospitalizationVO hospitalizationVO = new HospitalizationVO();
		patientVO.setPatCode(patCode);
		hospitalizationVO.setPatCode(patCode);
		int sckrmNo1 = Integer.parseInt(sckrmNo);
		int sckBdNo1 = Integer.parseInt(sckBdNo);
		hospitalizationVO.setSckrmNo(sckrmNo1);
		hospitalizationVO.setSckBdNo(sckBdNo1);
		log.info("patientVO수징:"+patientVO);
		log.info("hospitalizationVO수징:"+hospitalizationVO);
		return hospService.updateHsptlzStatus(patientVO,hospitalizationVO);

	} 
	@ResponseBody
	@GetMapping("/selectHsptlzstatus")
	public List<HospitalizationVO> selectHsptlzstatus() {
		return hospService.selectHsptlzstatus();
	}
	@ResponseBody
	@GetMapping("/updateBdCondition/{sckrmNo}/{sckBdNo}")
	public int updateBdCondition(@PathVariable String sckrmNo,@PathVariable String sckBdNo) {
		log.info("sckrmNo -FULL:"+sckrmNo);
		log.info("sckBdNo-FULL :"+sckBdNo);
		
		return hospService.updateBdCondition(sckrmNo,sckBdNo);
	}
	@ResponseBody
	@GetMapping("/updateBdConditionEmpt/{sckrmNo}/{sckBdNo}")
	public int updateBdConditionEmpt(@PathVariable String sckrmNo,@PathVariable String sckBdNo) {
		log.info("sckrmNov- EMPT:"+sckrmNo);
		log.info("sckBdNo- EMPT:"+sckBdNo);
		
		
		return hospService.updateBdConditionEmpt(sckrmNo,sckBdNo);
	}

}
