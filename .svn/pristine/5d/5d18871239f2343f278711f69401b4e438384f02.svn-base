package kr.or.ddit.receipt.service;

import java.util.List;

import kr.or.ddit.clinic.vo.ChartDetailByDateVO;
import kr.or.ddit.clinic.vo.ClinicVO;
import kr.or.ddit.common.vo.CommonCodeVO;
import kr.or.ddit.receipt.vo.CScheduleVO;
import kr.or.ddit.receipt.vo.ReceiptDateVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

public interface ReceiptService {
	//접수시 오늘 날짜 현재 시간에 포함되는 접수 스케줄 조회
	public List<CScheduleVO> getCSchedule(); 
	
	//rcptNo 값 가져오기
	public String getRcepNo();
	
	//receipt insert
	public int insertReceipt(ReceiptVO receiptVO);
	
	public List<CommonCodeVO> selectPVST();
	
	public List<WaitPatVO> selectWaitPat();	
	
	public int delWait(String treatNo);
	public WaitPatVO selectOneWaitPat(WaitPatVO waitPatVO);
	public List<ReceiptDateVO> getReceiptDate(ReceiptDateVO receiptDateVO);
	public ChartDetailByDateVO getAllByDateAndPatCode(ChartDetailByDateVO chartDetailByDateVO);
}
