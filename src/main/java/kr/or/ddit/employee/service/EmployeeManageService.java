package kr.or.ddit.employee.service;

import java.util.List;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.employee.vo.EmployeeVO;

public interface EmployeeManageService {

	// listEmp
	public List<EmployeeVO> listEmp();
	
	// detailEmp
	public EmployeeVO detailEmp(EmployeeVO employeeVO);
	
	// updateEmp
//	public int updateEmp(EmployeeVO employeeVO);
	
	// 웹경로 담기
	public List<AttachFileVO> findFileCode(String empNo);
	
}
