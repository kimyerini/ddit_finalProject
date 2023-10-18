package kr.or.ddit.order.service.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.order.mapper.PhysiotheraphyMapper;
import kr.or.ddit.order.service.PhysioService;
import kr.or.ddit.order.vo.BedStatusVO;
import kr.or.ddit.order.vo.BedVO;
import kr.or.ddit.order.vo.PhysioTherapyListVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PhysioServiceImpl implements PhysioService {
	
	@Autowired
	PhysiotheraphyMapper physioMapper;

	// 대기목록
	@Override
	public List<WaitPatVO> physioWaitPat() {
		return physioMapper.physioWaitPat() ;
	}

	// 환자정보
	@Override
	public PatientVO physioPatInfo(PatientVO patientVO) {
		physioMapper.physioStatusUpdate(patientVO.getTreatNo());
		
		return physioMapper.physioPatInfo(patientVO);
	}
	
	//침상배정 테이블에 insert 
	@Override
	public int bedStatus(BedStatusVO bedStatusVO) {
		return physioMapper.bedStatus(bedStatusVO);
	}
	
	//침상 배정 현황 목록
	@Override 
	public List<BedVO> bedStatusList(){
		return physioMapper.bedStatusList();
	}
	
	// 치료 오더 내역 
	@Override
	public List<PhysioTherapyListVO> physioList(String treatNo){
		return physioMapper.physioList(treatNo);
	}
	
	// 치료 내역
	@Override
	public List<PhysioTherapyListVO> physioHistory(String patCode) {
		return physioMapper.physioHistory(patCode);
	}
	
	// 치료현황
	@Override
	public List<BedStatusVO> physioStat() {
		return physioMapper.physioStat();
	}
	
	//침상번호를 알면 접수정보를 알 수 있음(PAT_CODE)
	@Override
	public ReceiptVO getReceiptInfo(Map<String,Object> map){
		return physioMapper.getReceiptInfo(map);
	}
	
	// 치료완료 버튼
	@Override
	@Transactional
	public int physioDone(String treatNo, String bedNo) {
		
		 int delete = physioMapper.deleteBedStat(bedNo);
		 int update = physioMapper.updateStat(treatNo);
		 
		 
		 return delete + update;
	}

	//환자를 알면 치료중여부와 점유 침상 번호를 안다
	@Override
	public Map<String,String> getSttusBedNo(String patCode){
		return this.physioMapper.getSttusBedNo(patCode);
	}

	//침상배정 치료내용 상태변경
	@Transactional
	@Override
	public int bedStatusUpdate(BedStatusVO bedStatusVO) {
		//BedStatusVO(physioCode=null, physioContent=null, detailNo=null, bedNo=3, 
		//bedStatDate=null, patCode=null, physioYn=null, patName=null, patBrthdy=null,
		//clnicSttusCode=null, physioCodes=[음압치료, 파라핀치료])
		String[] physioCodes = bedStatusVO.getPhysioCodes();
		
		//1) 침상배정 치료내용 상태 초기화
		int result = this.physioMapper.bedStatusInit(bedStatusVO);
		log.info("result : " + result);
		log.info("physioCodes.length : " + physioCodes.length + ", physioCodes : " + physioCodes);
		
		for(String physioCode : physioCodes) {
			BedStatusVO vo = new BedStatusVO();
			vo.setPhysioContent(physioCode);
			vo.setBedNo(bedStatusVO.getBedNo());
			//physioContent=파라핀치료, detailNo=null, bedNo=3
			log.info("vo : " + vo);
			
			result += this.physioMapper.bedStatusUpdate(vo);
		}
		
		return result;
	}
	
}











