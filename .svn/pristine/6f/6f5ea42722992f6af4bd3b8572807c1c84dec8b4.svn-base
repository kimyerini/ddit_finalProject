package kr.or.ddit.common.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.NotificationMapper;
import kr.or.ddit.common.service.NotificationService;
import kr.or.ddit.common.vo.NotiCheckVO;
import kr.or.ddit.common.vo.NotificationVO;

@Service
public class NotificationServiceImpl implements NotificationService{

   @Autowired
   private NotificationMapper notificationMapper;
   
   // 알림 insert
   @Override
   public int insertNoti(NotificationVO notificationVO) {
      return notificationMapper.insertNoti(notificationVO);
   }

	//일정 업데이트 시 알림내역 목록
   @Override
	public List<NotificationVO> selectNoti(String empNo){
		return this.notificationMapper.selectNoti(empNo);
	}
   
    //일정 확인 시 insert
    @Override
 	public int insertNotiCheck(NotiCheckVO notiCheckVO) {
 		return this.notificationMapper.insertNotiCheck(notiCheckVO);
 	}

	// 일정 내역 전체삭제버튼
	@Override
	public int deleteNotiList(String empNo) {
		return this.notificationMapper.deleteNotiList(empNo);
	}
}