package kr.or.ddit.schedule.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.schedule.mapper.ClinicScheduleMapper;
import kr.or.ddit.schedule.service.ClinicScheduleService;
import kr.or.ddit.schedule.vo.ClinicScheduleVO;
import kr.or.ddit.schedule.vo.ClinicschFacilityEmpVO;

@Service
public class ClinicScheduleServiceImpl implements ClinicScheduleService {

	@Autowired
	ClinicScheduleMapper clinicScheduleMapper;
	
	@Override
	public List<ClinicschFacilityEmpVO> listHosSch() {
		return clinicScheduleMapper.listClinicSch();
	}


}
