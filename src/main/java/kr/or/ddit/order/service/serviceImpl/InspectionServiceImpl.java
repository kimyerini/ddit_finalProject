package kr.or.ddit.order.service.serviceImpl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.order.mapper.InspectionMapper;
import kr.or.ddit.order.service.InspectionService;
import kr.or.ddit.order.vo.InspectionListVO;
import kr.or.ddit.order.vo.InspectionVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import kr.or.ddit.util.FileUploadUtils;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class InspectionServiceImpl implements InspectionService{
	@Autowired
	private InspectionMapper inspMapper;
	@Autowired
	FileUploadUtils fileUploadUtils; // 파일 업로드를 위함
	@Override
	public List<WaitPatVO> selectWaitInspection() {
		return inspMapper.selectWaitInspection();
	}

	@Override
	public Map<String, Object> patInfoInspDetail(String patCode, String treatNo,String detailNo) {
		Map<String,Object> myMap = new HashMap<String, Object>();
		PatientVO patientVO = new PatientVO();
		
		InspectionListVO inspListVO = new InspectionListVO();
		
		patientVO.setPatCode(patCode);
		
		inspListVO.setDetailNo(detailNo);
		inspListVO.setTreatNo(treatNo);
		
		 PatientVO selectedPatient = inspMapper.selectWaitPatInfo(patientVO);
	    log.info("patientVO ==>"+selectedPatient.toString());
	    
	    List<InspectionListVO> inspectionDetails = inspMapper.inspectionDetail(inspListVO);
	    log.info("inspListVO ==>"+inspectionDetails.toString());
	    
	    myMap.put("patientVO", selectedPatient);
	    myMap.put("inspListVO", inspectionDetails);
	    
	    return myMap;
	}
	
	@Override
	public int insertFile(InspectionListVO inspectionListVO) {
		log.info("파일 넘어 왔냐==>>>>" + inspectionListVO );
		
		MultipartFile[] files = inspectionListVO.getFiles();
		
		List<AttachFileVO> attachFileVOList = fileUploadUtils.multiUpload(inspectionListVO.getInCode(), inspectionListVO.getEmpNo(), files);
		inspectionListVO.setFileList(attachFileVOList);
		
		return 1;
	}

	@Override
	public List<InspectionVO> selectFile(InspectionListVO inspectionListVO) {
		return inspMapper.selectFile(inspectionListVO);
	}


	@Override
	public int updateInspSttusIng(String treatNo) {
		return inspMapper.updateInspSttusIng(treatNo);
	}
	
	@Override
	public int updateInspSttusEnd(String treatNo) {
		return inspMapper.updateInspSttusEnd(treatNo);
	}


}
