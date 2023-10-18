package kr.or.ddit.employee.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.employee.service.EmployeeManageService;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/employee")
public class EmployeeManageController {
	
	@Autowired
	EmployeeManageService service;

	// go to view
	@GetMapping("/index")
	public String getView() {
		log.info("<<< 여기는 getView >>>");
		return "emp/empManagement";
	}
	
	// list
	@ResponseBody
	@GetMapping(value="/list", produces="application/json; charset=utf-8")
	public List<EmployeeVO> getList() {
		log.info("<<< 여기는 getList >>> " + service.listEmp());
		return service.listEmp();
	}
	
	// detail
	@ResponseBody
	@GetMapping(value="/{empNo}", produces="application/json; charset=utf-8")
	public EmployeeVO getDetail(@PathVariable String empNo) {
		log.info("넘어온 empno:" + empNo);
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmpNo(empNo);
		log.info("<<< 여기는 getDetail >>> " + service.detailEmp(employeeVO));
		return service.detailEmp(employeeVO);
	}
	
	// update
//	@ResponseBody
//	@PutMapping(value="/update", produces="application/json; charset=utf-8")
//	public int updateEmp(@RequestBody EmployeeVO employeeVO) {
//		log.info("<<< 여기는 updateEmp >>> " + service.updateEmp(employeeVO));
//		return service.updateEmp(employeeVO);
//	}
	
	// 파일 웹 경로 가져오기
	@RequestMapping(value="", method = RequestMethod.GET)
	public ModelAndView findFileCode(ModelAndView mav, Principal principal) {
		log.info("principal : " + principal);
		
		String empNo = principal.getName();
		log.info("empNo: " + empNo);
		
		List<AttachFileVO> fileList = service.findFileCode(empNo);
		log.info("findFileCode가 들어왔는지 확인: " + fileList);
		
		mav.addObject("fileList", fileList);
		
		mav.setViewName("header");
		return mav;
	}
	
	
}
