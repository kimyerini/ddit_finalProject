package kr.or.ddit.employee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.employee.vo.EmployeeVO;

@Mapper // DAO
public interface EmployeeManageMapper {
	
	// listEmp
	public List<EmployeeVO> listEmp();
	
	// detailEmp
	public EmployeeVO detailEmp(EmployeeVO employeeVO);
	
//	// updateEmp
//	public int updateEmp(EmployeeVO employeeVO);
	
	// 웹경로 담기
	public List<AttachFileVO> findFileCode(String empNo);
	
	
	
}
