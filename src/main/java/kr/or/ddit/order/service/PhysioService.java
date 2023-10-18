package kr.or.ddit.order.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.order.vo.BedStatusVO;
import kr.or.ddit.order.vo.BedVO;
import kr.or.ddit.order.vo.PhysioTherapyListVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

public interface PhysioService {
	
	// 대기환자 목록 조회
	public List<WaitPatVO> physioWaitPat();
	
	// 환자정보
	public PatientVO physioPatInfo(PatientVO patientVO);

	//침상배정 테이블에 insert 
	public int bedStatus(BedStatusVO bedStatusVO);

	//침상 배정 현황 목록
	public List<BedVO> bedStatusList();

	// 치료 오더 내역 
	public List<PhysioTherapyListVO> physioList(String treatNo);
	
	// 치료 내역 
	public List<PhysioTherapyListVO> physioHistory(String patCode);
	
	// 치료현황
	public List<BedStatusVO> physioStat();

	//침상번호를 알면 접수정보를 알 수 있음(PAT_CODE)
	public ReceiptVO getReceiptInfo(Map<String,Object> map);
	
	// 치료완료 버튼 (상태 업데이트 PING->PEND)
	public int physioDone(String treatNo, String bedNo);

	//환자를 알면 치료중여부와 점유 침상 번호를 안다
	public Map<String, String> getSttusBedNo(String patCode);

	//침상배정 치료내용 상태변경
	public int bedStatusUpdate(BedStatusVO bedStatusVO);


}
