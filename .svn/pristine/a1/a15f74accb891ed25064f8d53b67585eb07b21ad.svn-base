package kr.or.ddit.schedule.service.serviceImpl;

import java.util.List;

import org.apache.maven.doxia.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.mapper.NotificationMapper;
import kr.or.ddit.common.vo.NotificationVO;
import kr.or.ddit.schedule.mapper.HosScheduleMapper;
import kr.or.ddit.schedule.service.HosScheduleService;
import kr.or.ddit.schedule.vo.HosScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HosScheduleServiceImpl implements HosScheduleService {

	@Autowired
	HosScheduleMapper hosScheduleMapper;

	@Autowired
	NotificationMapper notificationMapper;
	
	@Autowired 

	@Override
	public List<HosScheduleVO> listHosSch() {
		return hosScheduleMapper.listHosSch();
	}

	@Override
	public HosScheduleVO oneHosSch(HosScheduleVO hosScheduleVO) {
		return hosScheduleMapper.oneHosSch(hosScheduleVO);
	}

	/*
	@Override
	public int insertHosSch(HosScheduleVO hosScheduleVO) {
		return hosScheduleMapper.insertHosSch(hosScheduleVO);
	}
	*/

	@Override
	public int updateHosSch(HosScheduleVO hosScheduleVO) {
		return hosScheduleMapper.updateHosSch(hosScheduleVO);
	}

	@Override
	public int deleteHosSch(HosScheduleVO hosScheduleVO) {
		return hosScheduleMapper.deleteHosSch(hosScheduleVO);
	}

	// 경민
	@Transactional
	@Override
	public int insertHosSch(HosScheduleVO hosScheduleVO) {

		NotificationVO notiVO = new NotificationVO();

		notiVO.setNtcnTitle(hosScheduleVO.getHosSchTitle()); // 일정 제목(=알림제목)
		log.info("hosScheduleVO.getHosSchTitle()" + hosScheduleVO.getHosSchTitle());
		notiVO.setNtcnContent("새로운 병원일정("+hosScheduleVO.getHosSchTitle()+")이 등록되었습니다.");
		notiVO.setNtcnGubun("일정");

		log.info("notiVO" + notiVO);

		int result = hosScheduleMapper.insertHosSch(hosScheduleVO);
		result += notificationMapper.insertNoti(notiVO);

		log.info("result : " + result);

		return result;
	}

}
