package kr.or.ddit.common.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.SmsMapper;
import kr.or.ddit.common.service.SmsService;
import kr.or.ddit.common.vo.SmsVO;

@Service
public class SmsServiceImpl implements SmsService{
	@Autowired
	SmsMapper smsMapper;
	
	@Override
	public List<SmsVO> getSmsList() {
		return smsMapper.getSmsList();
	}
	
	@Override
	public SmsVO getSms(SmsVO smsVO) {
		return smsMapper.getSms(smsVO);
	}
	
	@Override
	public int insertSms(SmsVO smsVO) {
		
		return smsMapper.insertSms(smsVO);
	}
	
	@Override
	public int updateSms(SmsVO smsVO) {
		return smsMapper.updateSms(smsVO);
	}
	
	@Override
	public int deleteSms(SmsVO smsVO) {
		return smsMapper.deleteSms(smsVO);
	}
}
