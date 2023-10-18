package kr.or.ddit.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.order.vo.InspectionListVO;
import kr.or.ddit.order.vo.InspectionVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

@Mapper
public interface InspectionMapper {
	public List<WaitPatVO> selectWaitInspection();
	
	public PatientVO selectWaitPatInfo (PatientVO patientVO);
	
	public List<InspectionListVO> inspectionDetail(InspectionListVO inspListVO);
	
	public List<InspectionVO> selectFile(InspectionListVO inspectionListVO);
	
	public int updateInspSttusEnd (String treatNo);
	public int updateInspSttusIng (String treatNo);
}
