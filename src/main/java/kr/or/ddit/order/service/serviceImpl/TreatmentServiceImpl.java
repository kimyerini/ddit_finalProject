package kr.or.ddit.order.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.item.vo.MediItemInventoryVO;
import kr.or.ddit.order.mapper.TreatmentMapper;
import kr.or.ddit.order.service.TreatmentService;
import kr.or.ddit.order.vo.PrescriptionVO;
import kr.or.ddit.order.vo.TreatmentListVO;
import kr.or.ddit.order.vo.TreatmentMediVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

@Service
public class TreatmentServiceImpl implements TreatmentService{
	@Autowired
	private TreatmentMapper treatmentMapper;
	
	@Override
	public List<WaitPatVO> selectWaitTreatment(){
		return treatmentMapper.selectWaitTreatment();
	}

	@Override
	public PatientVO selectWaitPatInfo(PatientVO patienVO) {
		
		return treatmentMapper.selectWaitPatInfo(patienVO);
	}

	@Override
	public List<TreatmentMediVO> midePat(TreatmentMediVO treatMentMediVO) {
		
		return treatmentMapper.midePat(treatMentMediVO);
	}

	@Override
	public List<TreatmentListVO> treatmentPatList(TreatmentListVO treatmentListVO) {
		
		return treatmentMapper.treatmentPatList(treatmentListVO);
	}

	@Override
	public int updateTreatSttus(String treatNo) {
		return treatmentMapper.updateTreatSttus(treatNo);
	}

	@Override
	public int updateTreatSttusIng(String treatNo) {
		return treatmentMapper.updateTreatSttusIng(treatNo);
	}
	@Override
	public List<PrescriptionVO> narcoticList(PrescriptionVO prescriptionVO) {
		
		return treatmentMapper.narcoticList(prescriptionVO);
	}
	@Override
	public int mediQtyUpdate(MediItemInventoryVO mediItemInventoryVO) {
		return treatmentMapper.mediQtyUpdate(mediItemInventoryVO);
	}
	
}
