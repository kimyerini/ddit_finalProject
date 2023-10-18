package kr.or.ddit.receipt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.clinic.vo.ChartDetailByDateVO;
import kr.or.ddit.clinic.vo.ClinicVO;
import kr.or.ddit.common.vo.CommonCodeVO;
import kr.or.ddit.receipt.vo.CScheduleVO;
import kr.or.ddit.receipt.vo.ReceiptDateVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

@Mapper
public interface ReceiptMapper {
	public List<CScheduleVO> getCSchedule();
	public String getRcepNo();
	public int insertReceipt(ReceiptVO receiptVO);
	public int insertClinic(ClinicVO clinicVO);
	public List<CommonCodeVO> selectPVST();
	public List<WaitPatVO> selectWaitPat();	
	public int delWait(String treatNo);
	public WaitPatVO selectOneWaitPat(WaitPatVO waitPatVO);
	public List<ReceiptDateVO> getReceiptDate(ReceiptDateVO receiptDateVO);
	public ChartDetailByDateVO getAllByDateAndPatCode(ChartDetailByDateVO chartDetailByDateVO);
		
}
