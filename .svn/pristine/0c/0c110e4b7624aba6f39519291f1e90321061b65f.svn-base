package kr.or.ddit.common.service;

import java.util.List;

import kr.or.ddit.common.vo.NotiCheckVO;
import kr.or.ddit.common.vo.NotificationVO;

public interface NotificationService {
   
   // 알림 insert
   public int insertNoti(NotificationVO notificationVO);

   //일정 업데이트 시 알림내역 목록
   public List<NotificationVO> selectNoti(String empNo);

   //일정 확인 시 insert
   public int insertNotiCheck(NotiCheckVO notiCheckVO);
   
	// 일정 내역 전체삭제버튼
	public int deleteNotiList(String empNo);

}