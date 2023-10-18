package kr.or.ddit.schedule.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.service.NotificationService;
import kr.or.ddit.common.vo.NotiCheckVO;
import kr.or.ddit.common.vo.NotificationVO;
import kr.or.ddit.schedule.service.ClinicScheduleService;
import kr.or.ddit.schedule.service.HosScheduleService;
import kr.or.ddit.schedule.vo.ClinicScheduleVO;
import kr.or.ddit.schedule.vo.ClinicschFacilityEmpVO;
import kr.or.ddit.schedule.vo.HosScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/calendar")
@Controller
public class ScheduleController {

	@Autowired
	public HosScheduleService hosScheduleService;
	
	@Autowired
	public ClinicScheduleService clinicScheduleService;
	
	@Autowired
	public NotificationService notificationService;

	// go to view
	// /calendar/schedule
	// /calendar/schedule?ntcnId=12
	@GetMapping("/schedule")
	public String getSchedule(HttpSession session, Principal principal,
			@RequestParam(value="ntcnId",required=false) String ntcnId) {
		log.debug("체킁:"+session.getMaxInactiveInterval());
		
		String empNo = principal.getName();
		//ntcnId : 12,empNo : 230903130
		//ntcnId : null,empNo : 230903130
		log.info("ntcnId : " + ntcnId + ",empNo : " + empNo);
		
		//nicnId가 null이면 TB_NOTI_CHECK 테이블에 변화 없음
		NotiCheckVO notiCheckVO = new NotiCheckVO();
		if(ntcnId!=null) {
			log.info("getSchedule->개똥이");
			notiCheckVO.setNtcnId(Integer.parseInt(ntcnId));
			notiCheckVO.setEmpNo(empNo);
			//nicnId가 있으면 TB_NOTI_CHECK 테이블에 insert(알림 확인 처리)
			this.notificationService.insertNotiCheck(notiCheckVO);		
		}
		
		return "calendar/schedule";
	}
	
	// 병원일정 select list
	@ResponseBody
	@GetMapping(value="/hosSchedules", produces="application/json; charset=utf-8")
	public List<HosScheduleVO> listHosSch() {
		List<HosScheduleVO> hosSchList = hosScheduleService.listHosSch();
		log.info("여기는 병원일정 list : " + hosSchList);
		return hosSchList;
	}

//	// 병원일정 select one
//	@ResponseBody
//	@GetMapping("/docSchedule")
//	public String docCalendar() {
//		return "calendar/docSchedule";
//	}

	// 병원일정 insert
	@ResponseBody
	@PostMapping(value="/hosSchedule", produces="application/json; charset=utf-8")
	public int postHosSch(@RequestBody HosScheduleVO hosScheduleVO) {
		log.info("여기는 병원일정 post: " + hosScheduleVO);
		
		return hosScheduleService.insertHosSch(hosScheduleVO);
	}
	
	// 병원일정 update
	@ResponseBody
	@PutMapping(value="/hosSchedule", produces="application/json; charset=utf-8")
	public int putHosSch(@RequestBody HosScheduleVO hosScheduleVO) {
		log.info("여기까지오나?");
		log.info("여기는 병원일정 put: " + hosScheduleVO);
		return hosScheduleService.updateHosSch(hosScheduleVO);
	}
	
	// 병원일정 delete
	@ResponseBody
	@DeleteMapping(value="/hosSchedule/{hosSchNo}", produces="applicaytion/json; charset=utf-8")
	public int deleteHosSch(@PathVariable int hosSchNo) {
		HosScheduleVO hosScheduleVO = new HosScheduleVO();
		hosScheduleVO.setHosSchNo(hosSchNo);
		log.info("여기는 병원일정 delete : " + hosScheduleVO);
		return hosScheduleService.deleteHosSch(hosScheduleVO);
	}
	
	// 의사일정 select list
	@ResponseBody
	@GetMapping(value="/clinicSchedules")
	public List<ClinicschFacilityEmpVO> listClinicSch() {
		List<ClinicschFacilityEmpVO> clinicSchList = clinicScheduleService.listHosSch();
		log.info("여기는 의사일정 list: " + clinicSchList);
		return clinicSchList;
	}

	// 경민
	//일정 업데이트 시 알림내역 목록
	@ResponseBody
	@PostMapping("/selectNoti")
	public List<NotificationVO> selectNoti(String empNo){
		log.info("empNo : " + empNo);
		
		List<NotificationVO> notificationVOList = this.notificationService.selectNoti(empNo);
		log.info("notificationVOList : " + notificationVOList);
		
		return notificationVOList;
	}
	
	// 경민
	// 일정 내역 전체삭제버튼
	@ResponseBody
	@GetMapping("/deleteNotiList")
	public int deleteNotiList(@RequestParam String empNo) {
		log.info("empNo : " + empNo);
		
		int res = this.notificationService.deleteNotiList(empNo);
		
		return res;
	}
}









