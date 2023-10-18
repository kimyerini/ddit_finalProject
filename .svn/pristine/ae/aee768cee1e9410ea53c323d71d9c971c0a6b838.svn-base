package kr.or.ddit.common.service.serviceImpl;

import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.SmsHistoryMapper;
import kr.or.ddit.common.service.SmsHistoryService;
import kr.or.ddit.common.vo.SmsHistoryVO;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
@Slf4j
@Service
public class SmsHistoryServiceImpl implements SmsHistoryService{
	@Autowired
	SmsHistoryMapper smsHistoryMapper;
	
	@Override
	public int insertSMSHis(List<SmsHistoryVO> smsHisVOList) {
		String api_key = "NCSHQFELWTVBURCZ";
		String api_secret = "6BMIWU0EJVDLMMTDHYXEY5YMP8T9WYXG";
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> set = new HashMap<String, String>();
		SmsHistoryVO smsHisVO = new SmsHistoryVO();
		int cnt = 0;
		for(int i=0; i<smsHisVOList.size(); i++ ) {
			smsHisVO = smsHisVOList.get(i);
			smsHisVO.setSmsHisSender("01028667196");
			log.info("다중문자!!!:"+smsHisVO);
			set.put("to", smsHisVO.getSmsHisReceiver()); // 수신번호
			set.put("from", smsHisVO.getSmsHisSender()); // 발신번호
			set.put("text", smsHisVO.getSmsHisCn()); // 문자내용
			set.put("type", "sms"); // 문자 타입
			set.put("app_version", "test app 1.2"); 
			log.info("문자입니당" + set.toString());
			try {
				JSONObject result = coolsms.send(set); // 보내기&전송결과받기
				  
				log.info("문자전송결과:"+result.toString());
				  
				  
			} catch (CoolsmsException e) {
				log.info("에러:"+e.getMessage());
				log.info("에러러:"+e.getCode()+"");
			}
			cnt += smsHistoryMapper.insertSMSHis(smsHisVO);
			log.info("결과는:" + cnt);
		}
		return cnt;
	}
	
	@Override
	public List<SmsHistoryVO> getSMSHisList() {
		return smsHistoryMapper.getSMSHisList();
	}
}
