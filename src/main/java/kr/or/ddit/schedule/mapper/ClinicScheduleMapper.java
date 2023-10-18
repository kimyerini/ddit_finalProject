package kr.or.ddit.schedule.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.schedule.vo.ClinicScheduleVO;
import kr.or.ddit.schedule.vo.ClinicschFacilityEmpVO;

@Mapper // DAO
public interface ClinicScheduleMapper {

	// select List
	public List<ClinicschFacilityEmpVO> listClinicSch();
}
