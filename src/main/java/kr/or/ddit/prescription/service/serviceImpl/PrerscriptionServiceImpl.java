package kr.or.ddit.prescription.service.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.prescription.mapper.PrescriptionMapper;
import kr.or.ddit.prescription.service.PrescriptionService;
import kr.or.ddit.prescription.vo.PreInspecVO;
import kr.or.ddit.prescription.vo.PreMediVO;
import kr.or.ddit.prescription.vo.PrePhysioVO;
import kr.or.ddit.prescription.vo.PreTreatVO;


@Service
public class PrerscriptionServiceImpl implements PrescriptionService{
	@Autowired
	PrescriptionMapper prescriptionMapper;
	
	@Override
	public Map<String, Object> getPresciprtion(String detailNo) {
		Map<String,Object> map = new HashMap<String,Object>();
		 List<PreInspecVO> preInspecList = new ArrayList<PreInspecVO>();
		 List<PreMediVO> preMediList = new ArrayList<PreMediVO>();
		 List<PrePhysioVO> prePhysioList= new ArrayList<PrePhysioVO>();
		 List<PreTreatVO> preTreatList= new ArrayList<PreTreatVO>();
		 
		preInspecList = prescriptionMapper.getPreInspec(detailNo);
		preMediList = prescriptionMapper.getPreMedi(detailNo);
		prePhysioList = prescriptionMapper.getPrePhysio(detailNo);
		preTreatList = prescriptionMapper.getPreTreat(detailNo);
		if(preInspecList!=null) map.put("preInspecList", preInspecList);
		if(preMediList!=null) map.put("preMediList", preMediList);
		if(prePhysioList!=null) map.put("prePhysioList", prePhysioList);
		if(preTreatList!=null) map.put("preTreatList", preTreatList);
		 
		 
		return map;
	}
}
