package kr.or.ddit.schedule.service;

import java.util.List;

import kr.or.ddit.schedule.vo.ClinicScheduleVO;
import kr.or.ddit.schedule.vo.ClinicschFacilityEmpVO;

public interface ClinicScheduleService {

	// select List
	public List<ClinicschFacilityEmpVO> listHosSch();
	
}
