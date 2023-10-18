package kr.or.ddit.receipt.service.serviceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.clinic.mapper.ClinicMapper;
import kr.or.ddit.hospitalization.mapper.HospitalizationMapper;
import kr.or.ddit.order.vo.PrescriptionVO;
import kr.or.ddit.receipt.mapper.ReceiptionMapper;
import kr.or.ddit.receipt.service.ReceiptionService;
import kr.or.ddit.receipt.vo.HosRRoomVO;
import kr.or.ddit.receipt.vo.ReceiptionVO;
@Service
public class ReceiptionServiceImpl implements ReceiptionService{
	@Autowired
	ReceiptionMapper receiptionMapper;
	
	@Autowired
	ClinicMapper clinicMapper;
	
	@Autowired
	HospitalizationMapper hsptlzMapper;
	
	@Transactional
	@Override
	public int insertReceiption(ReceiptionVO receiptionVO) {
		String treatNo = receiptionVO.getTreatNo();
		int cnt = clinicMapper.updateClinicAfterReceiption(treatNo);
		cnt += receiptionMapper.insertReceiption(receiptionVO);
		return cnt;
	}
	@Override
	public int reqDocReceiption(String reqDocumentNo) {
		
		return receiptionMapper.reqDocReceiption(reqDocumentNo);
	}
	
	@Transactional
	@Override
	public int insertAllReceiptionWhenOutHosptlz(String detailNo) {
		String treatNo = receiptionMapper.findTreatNoByDetailNo(detailNo);
		PrescriptionVO pVO = new PrescriptionVO();
		List<PrescriptionVO> pList = new ArrayList<PrescriptionVO>();
		int rPrice = 15000; 
		rPrice += receiptionMapper.getInspcCostByDtlNo(detailNo);
		rPrice += receiptionMapper.getPhysioCostByDtlNo(detailNo);
		rPrice += receiptionMapper.getTreatCostByDtlNo(detailNo);
		pList = receiptionMapper.getPrescriptCostByDtlNo(detailNo);
		for(int i=0; i<pList.size(); i++) {
			pVO = pList.get(i);
			rPrice += pVO.getPrscrptnAmount() * pVO.getPrscrptnCount() * pVO.getPrscrptnDays() * pVO.getMediItemPrice();
		}
		ReceiptionVO receiptionVO = new ReceiptionVO();
		receiptionVO.setTreatNo(treatNo);
		receiptionVO.setRcivPayment(rPrice);
		clinicMapper.updateClinicAfterReceiption(treatNo);
		return receiptionMapper.insertReceiption(receiptionVO);
	}
}
