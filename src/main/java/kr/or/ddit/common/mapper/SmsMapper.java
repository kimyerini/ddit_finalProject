package kr.or.ddit.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.SmsVO;

@Mapper
public interface SmsMapper {
	public List<SmsVO> getSmsList();
	
	public SmsVO getSms(SmsVO smsVO);
	
	public int insertSms(SmsVO smsVO);
	
	public int updateSms(SmsVO smsVO);
	
	public int deleteSms(SmsVO smsVO);
}
