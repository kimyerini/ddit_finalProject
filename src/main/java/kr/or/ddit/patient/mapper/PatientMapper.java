package kr.or.ddit.patient.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.patient.vo.PatientVO;

@Mapper
public interface PatientMapper {
	//환자 정보 등록
	public int insertPat(PatientVO patientVO);
	public int updatePat(PatientVO patientVO);
	public int deletePat(PatientVO patientVO);
	public List<PatientVO> selectPats(PatientVO patientVO);
	public PatientVO selectByCode(PatientVO patientVO);
	
	// 환자 이름으로 여럿 조회
	public List<PatientVO> selectByName(PatientVO patientVO);
	
	// 환자 이름, 주민번호로 환자코드 조회
	public PatientVO selectPatNoByName(PatientVO patientVO);
	
	public int updatePatLastDate(PatientVO patientVO);
}
