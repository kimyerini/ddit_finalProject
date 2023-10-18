package kr.or.ddit.statistics.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.statistics.vo.ChartVO;

@Mapper
public interface ChartMapper {
	
	// 성별 환자 통계
	public List<ChartVO> patCntByGender();
	
	// 연령대별 환자 통계
	public List<ChartVO> patCntByAge();
	
	// 내원 경로
	public List<ChartVO> visitPathCnt();
	
	// 내원 사유
	public List<ChartVO> visitReasonCnt();
	
	// 월별 매출 통계
	public List<ChartVO> salesByMonth();
	
	// 물리치료 통계
	public List<ChartVO> physioList();
	
}
