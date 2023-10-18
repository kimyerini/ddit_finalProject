package kr.or.ddit.order.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.order.vo.InspectionListVO;
import kr.or.ddit.order.vo.InspectionVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

public interface InspectionService {
	public List<WaitPatVO> selectWaitInspection();
	
	public Map<String, Object> patInfoInspDetail(String patCode, String treatNo,String detailNo);

	public int insertFile(InspectionListVO inspectionListVO);
	
	
	public List<InspectionVO> selectFile(InspectionListVO inspectionListVO);
	
	
	public int updateInspSttusIng (String treatNo);
	public int updateInspSttusEnd (String treatNo);
	//public PatientVO selectWaitPatInfo (PatientVO patienVO);
	
	//public List<InspectionListVO> inspectionDetail(InspectionListVO inspectionListVO);
}
