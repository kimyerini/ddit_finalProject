package kr.or.ddit.order.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.order.service.InspectionService;
import kr.or.ddit.order.vo.InspectionListVO;
import kr.or.ddit.order.vo.InspectionVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/insp")
public class InspectionController {
	@Autowired
	private InspectionService inspService;
	
	@Autowired
	
	@GetMapping("/insp")
	public String getInspection() {
		return "insp/inspection";
	}
	@GetMapping(value = "/waitInspection",produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<WaitPatVO> selectWaitInspection(){
		log.info("뭐라도 좀 나와봐");
		List<WaitPatVO> li = inspService.selectWaitInspection();
		log.info("리스트 나와라 얍 -->"+li);
		
		return li;
	}
	@ResponseBody
	@GetMapping(value="/waitpatClick/{patCode}/{treatNo}/{detailNo}")
	public Map<String, Object> patInfoInspDetail(@PathVariable(value="patCode") String patCode ,@PathVariable(value="treatNo",required = false) String treatNo, @PathVariable(value="detailNo") String detailNo){
	    Map<String, Object> result = inspService.patInfoInspDetail(patCode, treatNo, detailNo);
	    return result;
	}
	// 
	@PostMapping("/insertFile")
	@ResponseBody
	public int insertFile(InspectionListVO inspectionListVO) {
		log.info("=================== 파일 들어오는곳이다 ====================" +inspectionListVO);
		return inspService.insertFile(inspectionListVO);
	}
	@GetMapping("/selectFile/{detailNo2}")
	@ResponseBody
	public List<InspectionVO> selectFile(@PathVariable(value="detailNo2") String detailNo){
		InspectionListVO inspectionListVO = new InspectionListVO();
		inspectionListVO.setDetailNo(detailNo);
		log.info("inspectionListVO으아아아앙"+inspectionListVO);
		List<InspectionVO> iList = new ArrayList<InspectionVO>();
		iList = inspService.selectFile(inspectionListVO);
		log.info("쉬는쉬간"+iList);
		return iList;
	}
	
	@ResponseBody
	@GetMapping("/updateInspSttusIng/{treatNoUp}")
	public int updateInspSttusIng(@PathVariable("treatNoUp") String treatNo) {
	    log.info("InspectionListVO =>>" + treatNo);
	    int update = inspService.updateInspSttusIng(treatNo);
	    if(update >0) {
	    	return 1;
	    }else {
	    	return 0;
	    }
	}
	
	@ResponseBody
	@GetMapping("/updateInspSttusEnd/{treatNoUp}")
	public int updateInspSttusEnd(@PathVariable("treatNoUp") String treatNo) {
	    log.info("InspectionListVO =>>" + treatNo);
	    int update = inspService.updateInspSttusEnd(treatNo);
	    if(update >0) {
	    	return 1;
	    }else {
	    	return 0;
	    }
	}
}
