package kr.or.ddit.patient.service;

import java.util.List;

import kr.or.ddit.patient.vo.PatientVO;

public interface OfficeService {
	//환자 정보 등록
	public int insertPat(PatientVO patientVO);
	public int updatePat(PatientVO patientVO);
	public int deletePat(PatientVO patientVO);
	public List<PatientVO> selectPats(PatientVO patientVO);
	public PatientVO selectByCode(PatientVO patientVO);
	
	// 환자 이름으로 여럿 조회
	public List<PatientVO> selectByName(PatientVO patientVO);
	
	public PatientVO selectPatNoByName(PatientVO patientVO);
	public int updatePatLastDate(PatientVO patientVO);
}
