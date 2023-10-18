package kr.or.ddit.patient.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.patient.mapper.PatientMapper;
import kr.or.ddit.patient.service.OfficeService;
import kr.or.ddit.patient.vo.PatientVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class OfficeServiceImpl implements OfficeService{
	@Autowired
	PatientMapper patientMapper;
	
	
	@Override
	public int insertPat(PatientVO patientVO) {
		return patientMapper.insertPat(patientVO);
	}
	@Override
	public List<PatientVO> selectByName(PatientVO patientVO) {
		return patientMapper.selectByName(patientVO);
	}
	@Override
	public int deletePat(PatientVO patientVO) {
		return patientMapper.deletePat(patientVO);
	}
	@Override
	public PatientVO selectByCode(PatientVO patientVO) {
		return patientMapper.selectByCode(patientVO);
	}
	@Override
	public List<PatientVO> selectPats(PatientVO patientVO) {
		return patientMapper.selectPats(patientVO);
	}
	@Override
	public int updatePat(PatientVO patientVO) {
		return patientMapper.updatePat(patientVO);
	}
	@Override
	public PatientVO selectPatNoByName(PatientVO patientVO) {
		return patientMapper.selectPatNoByName(patientVO);
	}
	@Override
	public int updatePatLastDate(PatientVO patientVO) {
		return patientMapper.updatePatLastDate(patientVO);
	}
}
