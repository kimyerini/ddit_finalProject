package kr.or.ddit.hospitalization.service;

import java.util.List;


import kr.or.ddit.hospitalization.vo.SickRoomTypeVO;
import kr.or.ddit.order.vo.HospitalizationVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.HosReceiptionVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

public interface HospitalizationService {
	public List<WaitPatVO> hosptPatWaitList();
	
	public List<SickRoomTypeVO> selectRoomData();
	
	public int updateHsptlzStatus(PatientVO patientVO,HospitalizationVO hospitalizationVO);
	public List<HospitalizationVO> selectHsptlzstatus();
	public List<HospitalizationVO> getReqHospitalizationList();
	public HospitalizationVO getReqHospitalization(String hsptlzNo);
	public int updateWhenInHospitalization(HospitalizationVO hospitalizationVO);
	public int updatePatOutHos(String patCode);
	public int updateOutHosVO(String hsptlzNo);
	public List<HosReceiptionVO> getHosReceiptionContent(String hsptlzNo);
	public int updateBdCondition(String sckrmNo, String sckBdNo);
	public int updateBdConditionEmpt(String sckrmNo, String sckBdNo);
	public int updateHosRoomPrice(String hsptlzNo);
}
