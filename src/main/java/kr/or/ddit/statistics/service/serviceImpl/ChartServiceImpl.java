package kr.or.ddit.statistics.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.statistics.mapper.ChartMapper;
import kr.or.ddit.statistics.service.ChartService;
import kr.or.ddit.statistics.vo.ChartVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChartServiceImpl implements ChartService {

	@Autowired
	private ChartMapper mapper;
	
	@Override
	public List<ChartVO> patCntByGender() {
		return mapper.patCntByGender();
	}

	@Override
	public List<ChartVO> patCntByAge() {
		return mapper.patCntByAge();
	}

	@Override
	public List<ChartVO> visitReasonCnt() {
		return mapper.visitReasonCnt();
	}

	@Override
	public List<ChartVO> visitPathCnt() {
		return mapper.visitPathCnt();
	}
	
	@Override
	public List<ChartVO> salesByMonth() {
		return mapper.salesByMonth();
	}

	@Override
	public List<ChartVO> physioList() {
		return mapper.physioList();
	}
	
}
