package kr.or.ddit.employee.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.employee.mapper.EmployeeManageMapper;
import kr.or.ddit.employee.service.EmployeeManageService;
import kr.or.ddit.employee.vo.EmployeeVO;

@Service
public class EmployeeManageServiceImpl implements EmployeeManageService {

	@Autowired
	EmployeeManageMapper mapper;

	@Override
	public List<EmployeeVO> listEmp() {
		return mapper.listEmp();
	}

	@Override
	@Transactional
	public EmployeeVO detailEmp(EmployeeVO employeeVO) {
		String empNo =employeeVO.getEmpNo();
		List<AttachFileVO> list =  mapper.findFileCode(empNo);
		System.out.println("파일리스트: " + list);
		
		employeeVO = mapper.detailEmp(employeeVO);
		employeeVO.setFileList(list);
		
		return employeeVO;
	}

	@Override
	public List<AttachFileVO> findFileCode(String empNo) {
		return mapper.findFileCode(empNo);
	}

//	@Override
//	public int updateEmp(EmployeeVO employeeVO) {
//		return mapper.updateEmp(employeeVO);
//	}
	
}
