package kr.or.ddit.schedule.service;

import java.util.List;

import kr.or.ddit.common.vo.NotificationVO;
import kr.or.ddit.schedule.vo.HosScheduleVO;

public interface HosScheduleService {
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
