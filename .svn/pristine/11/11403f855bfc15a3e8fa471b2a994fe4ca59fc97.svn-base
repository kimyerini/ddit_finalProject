package kr.or.ddit.order.service;

import java.util.List;

import kr.or.ddit.item.vo.MediItemInventoryVO;
import kr.or.ddit.order.vo.PrescriptionVO;
import kr.or.ddit.order.vo.TreatmentListVO;
import kr.or.ddit.order.vo.TreatmentMediVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

public interface TreatmentService {

	
	public List<WaitPatVO> selectWaitTreatment();
	
	public PatientVO selectWaitPatInfo (PatientVO patienVO);
	
	public List<TreatmentMediVO> midePat (TreatmentMediVO treatMentMediVO);
	
	public List<TreatmentListVO> treatmentPatList (TreatmentListVO treatmentListVO);
	
	public int updateTreatSttus (String treatNo);
	public int updateTreatSttusIng (String treatNo);
	public List<PrescriptionVO> narcoticList(PrescriptionVO prescriptionVO);
	
	public int mediQtyUpdate(MediItemInventoryVO mediItemInventoryVO);
}
