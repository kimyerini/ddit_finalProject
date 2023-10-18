package kr.or.ddit.receipt.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.clinic.vo.ChartDetailByDateVO;
import kr.or.ddit.clinic.vo.ClinicVO;
import kr.or.ddit.common.vo.CommonCodeVO;
import kr.or.ddit.receipt.mapper.ReceiptMapper;
import kr.or.ddit.receipt.service.ReceiptService;
import kr.or.ddit.receipt.vo.CScheduleVO;
import kr.or.ddit.receipt.vo.ReceiptDateVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class ReceiptServiceImpl implements ReceiptService{
	@Autowired
	ReceiptMapper receiptmapper;
	
	@Override
	public List<CScheduleVO> getCSchedule() {
		return receiptmapper.getCSchedule();
	}
	
	@Override
	public String getRcepNo() {
		return receiptmapper.getRcepNo();
	}
	
	// 접수 insert 될 때 진료 테이블도 insert!!
	@Override
	public int insertReceipt(ReceiptVO receiptVO) {
		log.info("체크!"+receiptVO);
		ClinicVO clinicVO = new ClinicVO();
		clinicVO.setRceptNo(receiptVO.getRceptNo());
		log.info("clinicVO:"+clinicVO);
		int cnt  = receiptmapper.insertReceipt(receiptVO);
		cnt += receiptmapper.insertClinic(clinicVO);
		return cnt;
	}
	
	@Override
	public List<CommonCodeVO> selectPVST() {
		return receiptmapper.selectPVST();
	}
	
	
	@Override
	public List<WaitPatVO> selectWaitPat() {
		return receiptmapper.selectWaitPat();
	}
	
	@Override
	public int delWait(String treatNo) {
		return receiptmapper.delWait(treatNo);
	}
	
	@Override
	public WaitPatVO selectOneWaitPat(WaitPatVO waitPatVO) {
		return receiptmapper.selectOneWaitPat(waitPatVO);
	}
	
	@Override
	public List<ReceiptDateVO> getReceiptDate(ReceiptDateVO receiptDateVO) {
		return receiptmapper.getReceiptDate(receiptDateVO);
	}
	
	@Override
	public ChartDetailByDateVO getAllByDateAndPatCode(ChartDetailByDateVO chartDetailByDateVO) {
		return receiptmapper.getAllByDateAndPatCode(chartDetailByDateVO);
	}

}
