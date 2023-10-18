package kr.or.ddit.schedule.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.NotificationVO;
import kr.or.ddit.schedule.vo.HosScheduleVO;

@Mapper // DAO
public interface HosScheduleMapper {

	// select List
	public List<HosScheduleVO> listHosSch();
	
	// select one
	public HosScheduleVO oneHosSch(HosScheduleVO hosScheduleVO);
	
	// insert
	public int insertHosSch(HosScheduleVO hosScheduleVO);
	
	// update
	public int updateHosSch(HosScheduleVO hosScheduleVO);
	
	// delete
	public int deleteHosSch(HosScheduleVO hosScheduleVO);
	
	//public int insertHosSch(HosScheduleVO hosScheduleVO, NotificationVO notificationVO);
}
