package kr.or.ddit.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.NotiCheckVO;
import kr.or.ddit.common.vo.NotificationVO;

@Mapper
public interface NotificationMapper {
	
	// 알림 insert
	public int insertNoti(NotificationVO notificationVO);
	
	//일정 업데이트 시 알림내역 목록
	//<select id="selectNoti" parameterType="String" resultType="NotificationVO">
	public List<NotificationVO> selectNoti(String empNo);
	
	//일정 확인 시 insert 
	//<insert id="insertNotiCheck" parameterType="NotiCheckVO">
	public int insertNotiCheck(NotiCheckVO notiCheckVO);
	
	// 일정 내역 전체삭제버튼
	public int deleteNotiList(String empNo);
	
}
