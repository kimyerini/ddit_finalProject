package kr.or.ddit.statistics.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.statistics.service.ChartService;
import kr.or.ddit.statistics.vo.ChartVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chart")
public class ChartController {

	@Autowired
	private ChartService service;
	
	@GetMapping
	public String getChart() {
		log.info("<<< 여기는 getChart >>>");
		
		return "statistics/chart";
	}
	
	@ResponseBody
	@GetMapping(value="/gender", produces="application/json; charset=utf-8")
	public List<ChartVO> getGenderData() {
		log.info("<<< 여기는 getGenderData >>>");
		
		List<ChartVO> genderData = service.patCntByGender();
//		log.info("안찍혀?");
		log.info("genderData" + genderData);
		
		return genderData;
	}
	
	@ResponseBody
	@GetMapping(value="/age", produces="application/json; charset=utf-8")
	public List<ChartVO> getAgeData() {
		log.info("<<< 여기는 getAgeData >>>");
		
		List<ChartVO> ageData = service.patCntByAge();
		log.info("ageData" + ageData);
		
		return ageData;
	}
	
	@ResponseBody
	@GetMapping(value="/reason", produces="application/json; charset=utf-8")
	public List<ChartVO> getVisitReason() {
		log.info("<<< 여기는 getVisitReason >>>");
		
		List<ChartVO> reasonData = service.visitReasonCnt();
		log.info("reasonData" + reasonData);
		
		return reasonData;
	}
	
	@ResponseBody
	@GetMapping(value="/path", produces="application/json; charset=utf-8")
	public List<ChartVO> getVisitPath() {
		log.info("<<< 여기는 getVisitPath >>>");
		
		List<ChartVO> pathData = service.visitPathCnt();
		log.info("pathData" + pathData);
		
		return pathData;
	}
	
	@ResponseBody
	@GetMapping(value="/sales", produces="application/json; charset=utf-8")
	public List<ChartVO> getSalesByMonth() {
		log.info("<<< 여기는 getSalesByMonth >>>");
		
		List<ChartVO> salesData = service.salesByMonth();
		log.info("salesData" + salesData);
		
		return salesData;
	}
	
	@ResponseBody
	@GetMapping(value="/physio", produces="application/json; charset=utf-8")
	public List<ChartVO> getPhysioList() {
		log.info("<<< 여기는 getPhysioList >>>");
		
		List<ChartVO> physioData = service.physioList();
		
		return physioData;
	}
	
}
