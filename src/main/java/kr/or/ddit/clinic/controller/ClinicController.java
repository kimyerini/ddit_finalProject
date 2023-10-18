package kr.or.ddit.clinic.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.clinic.service.ClinicService;
import kr.or.ddit.clinic.vo.ChartDetailByDateVO;
import kr.or.ddit.clinic.vo.ChartDetailVO;
import kr.or.ddit.clinic.vo.CliChtIspcVO;
import kr.or.ddit.clinic.vo.ClinicChartRecPatVO;
import kr.or.ddit.clinic.vo.ClinicVO;
import kr.or.ddit.clinic.vo.DiseaseVO;
import kr.or.ddit.clinic.vo.PatientRecieptVO;
import kr.or.ddit.item.vo.MediItemListVO;
import kr.or.ddit.order.vo.GrpOrdrVO;
import kr.or.ddit.order.vo.InspcFileVO;
import kr.or.ddit.order.vo.InspectionListVO;
import kr.or.ddit.order.vo.InspectionVO;
import kr.or.ddit.order.vo.PhysioTherapyListVO;
import kr.or.ddit.order.vo.PhysiotherapyVO;
import kr.or.ddit.order.vo.PrescriptionVO;
import kr.or.ddit.order.vo.TreatmentListVO;
import kr.or.ddit.order.vo.TreatmentVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/doctor")
public class ClinicController {
	
	@Autowired
	private ClinicService clinicSVC;
	
	
	@GetMapping("/clinic")
	public String getView() {
		
		log.info("clinic 도착!");
		return "clinic/clinic";
	}
	

	@GetMapping("/pdfTest")
	public String getView2() {
		
		log.info("pdfTest 도착!");
		return "pdfTest/pdfTest";
	}
	
	//환자 접수 상세정보 조회
	@ResponseBody
	@GetMapping(value="/clinic/receipt/{rceptNo}",produces = "application/json;charset=utf-8")
	public PatientRecieptVO receiptDetail(@PathVariable String rceptNo) {
		PatientRecieptVO patientRecieptVO = new PatientRecieptVO();
		patientRecieptVO.setRceptNo(rceptNo);
		patientRecieptVO = clinicSVC.receiptDetail(patientRecieptVO);
		log.info("환자 접수상세정보 rceptNo 도착!");
		log.info("VO : " + patientRecieptVO);
		return patientRecieptVO;
	}
		
	
	//환자 정보 조회
	@Transactional
	@ResponseBody
	@GetMapping(value="/clinic/{treatNo}/{patCode}",produces = "application/json;charset=utf-8")
	public PatientVO selectPatInfo(@PathVariable String treatNo, @PathVariable String patCode) {
		PatientVO patientVO = new PatientVO();
		patientVO.setPatCode(patCode);
		patientVO = clinicSVC.selectPatInfo(patientVO);
		
		ClinicVO clinicVO = new ClinicVO();
		clinicVO.setTreatNo(treatNo);
		//log.info("CING!",treatNo);
		
		// 환자 호출 시 환자 상태 CING 업데이트
		clinicSVC.updateCing(clinicVO);
		log.info("환자상태 update",clinicVO);
		
		log.info("환자정보 patCode 도착!");
		log.info("VO : " + patientVO);
		return patientVO;
	}
	
	
	// 대기 환자 목록 조회하기	
//	@ResponseBody
//	@GetMapping(value="/clinic/waitList",produces = "application/json;charset=utf-8")
//	public List<PatRecCliVO> getWaitPatList() {
//		return clinicSVC.getWaitPatList();
//	}
	
	
	//환자 차트 날짜별 리스트 조회
	@ResponseBody
	@GetMapping(value="/clinic/date/{patCode}",produces = "application/json;charset=utf-8")
	public List<ClinicChartRecPatVO> getRegDateList(@PathVariable String patCode) {
		ClinicChartRecPatVO clinicChartRecPatVO = new ClinicChartRecPatVO();
		clinicChartRecPatVO.setPatCode(patCode);
		
		log.info("차트날짜VO : " + clinicChartRecPatVO);
		return clinicSVC.getRegDateList(clinicChartRecPatVO);
	}
	
	
	// 등록날짜로 환자차트 조회하기	
	// vo 생성후, 서비스에 전달하여 결과를 얻고, vo에 결과를 저장, 이를 반환한다.
	@ResponseBody
	@GetMapping(value="/clinic/date/chart/{detailRegDate}/{patCode}/{treatNo}", produces = "application/json;charset=utf-8")
	public List<ChartDetailByDateVO> getChartByRegDate(@PathVariable String detailRegDate,@PathVariable(value = "patCode",required = false) String patCode,@PathVariable String treatNo) {
	    ChartDetailByDateVO chartDetailByDateVO = new ChartDetailByDateVO();
	    chartDetailByDateVO.setDetailRegDate(detailRegDate);
	    chartDetailByDateVO.setPatCode(patCode);
	    chartDetailByDateVO.setTreatNo(treatNo);

	    log.info("detailRegDate 제발제발" + detailRegDate);
	    log.info("patCode 제발제발" + patCode);
	    log.info("treatNo 제발제발" + treatNo);
	    List<ChartDetailByDateVO> chartDetailByDateVOList = clinicSVC.getChartByRegDate(chartDetailByDateVO);
	   // chartDetailByDateVO = clinicSVC.getChartByRegDate(chartDetailByDateVO);
	    log.info("날짜로 검색한 환자차트 detailRegDate 도착!");
	    log.info("VO : " + chartDetailByDateVO);
	    return chartDetailByDateVOList;
	}

	//검사오더 조회
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/inspc",produces = "application/json;charset=utf-8")
	public List<InspectionVO> getInspection() {
		return clinicSVC.getInspection();
	}	
		
	//검사오더 검색하기
	// vo 생성 후 서비스에 전달하여 결과를 얻고 List(그대로) 반환한다.
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/inspc/{searchInspc}",produces = "application/json;charset=utf-8")
	public List<InspectionVO> searchInspection(@PathVariable String searchInspc) {
		InspectionVO inspectionVO = new InspectionVO();
		inspectionVO.setSearchInspc(searchInspc);
		
		log.info("검사부위양 : " + searchInspc);
		log.info("검사검색VO : " + inspectionVO);
		return clinicSVC.searchInspection(inspectionVO);
	}
	
	
	//차트번호 출력하기
	@ResponseBody
	@GetMapping(value="/clinic/chart/detailNo",produces = "application/json;charset=utf-8")
	public ChartDetailVO getChartDetailNo() {
		log.info("차트번호출력하깅");
		return clinicSVC.getChartDetailNo();
	}
	
	// 대기 환자 목록 조회하기 (담당 환자만)	
	@ResponseBody
	@GetMapping(value="/clinic/waitList/{empNo}",produces = "application/json;charset=utf-8")
	public List<WaitPatVO> selectWaitPat(@PathVariable String empNo) {
		WaitPatVO waitPatVO = new WaitPatVO();
		waitPatVO.setEmpNo(empNo);
		
		log.info("대기 환자 목록 출력하깅");
		log.info("대기 환자 목록 출력하깅" + empNo);
		return clinicSVC.selectWaitPat(waitPatVO);
	}
	
	//진료번호 출력하기
	@ResponseBody
	@GetMapping(value="/clinic/chart/treatNo",produces = "application/json;charset=utf-8")
	public ClinicVO getTreatNo() {
		log.info("진료번호출력하깅");
		return clinicSVC.getTreatNo();
	}
	
	
	//차트 틀 입력 
	@ResponseBody
	@PostMapping(value="/clinic/chart/before",produces = "application/json;charset=utf-8")
	public String insertChartBefore(@RequestBody ChartDetailVO chartDetailVO) {
		log.info("차트틀만들었당");
		return Integer.toString(clinicSVC.insertChartBefore(chartDetailVO));
	}
	

	// 검사오더 요청 - 진료상태 '검사대기'로 업데이트
	@Transactional
	@ResponseBody
	@PostMapping(value = "/clinic/chart/order/inspc/{treatNo}", produces = "application/json;charset=utf-8")
	public String insertInspcOrder(@RequestBody List<InspectionListVO> inspectionListVOlist, @PathVariable(value = "treatNo",required = false) String treatNo) {
	    log.info("검사요청이 되었당");
	    
	    int cnt = 0;
	    for (InspectionListVO inspectionListVO : inspectionListVOlist) {
	        cnt += clinicSVC.insertInspcOrder(inspectionListVO);
	    }
	    
	    CliChtIspcVO cliChtIspcVO = new CliChtIspcVO();
	    cliChtIspcVO.setTreatNo(treatNo);
	    log.info("검사요청이 되었당" + treatNo);
	    
	    cnt += clinicSVC.updateInspcStatus(cliChtIspcVO);
	    
	    String result = "success";
	    if (cnt != inspectionListVOlist.size() + 1) {
	        result = "fail";
	    }
	    return result;
	}

	
	// 의사) 검사완료 리스트 불러오기 	
	// vo 생성 후 서비스에 전달하여 결과를 얻고 List(그대로) 반환한다.
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/inspc/end/{detailNo}",produces = "application/json;charset=utf-8")
	public List<CliChtIspcVO> getEndInspcList(@PathVariable String detailNo) {
		CliChtIspcVO cliChtIspcVO = new CliChtIspcVO();
		cliChtIspcVO.setDetailNo(detailNo);
		
		log.info("검사완료 리스트 불러오기  : " + detailNo);
		return clinicSVC.getEndInspcList(cliChtIspcVO);
	}

	
	// 의사) 조회버튼 눌렀을때 검사완료 사진 불러오기  	
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/inspc/end/photo/{detailNo}/{inspcCode}",produces = "application/json;charset=utf-8")
	public List<InspcFileVO> getInspcPhotoList(@PathVariable String detailNo, @PathVariable String inspcCode) {
		InspcFileVO inspcFileVO = new InspcFileVO();
		inspcFileVO.setDetailNo(detailNo);
		inspcFileVO.setInspcCode(inspcCode);
		
		log.info("검사완료 사진 리스트 불러오기  : " + detailNo);
		log.info("검사완료 사진 리스트 불러오기  : " + inspcCode);
		return clinicSVC.getInspcPhotoList(inspcFileVO);
	}

	
	// 의사) 접수번호로 차트번호,진료번호  출력하기 
	@ResponseBody
	@GetMapping(value="/clinic/pat/{recptNo}",produces = "application/json;charset=utf-8")
	public ClinicChartRecPatVO getChtNoByRceptNo(@PathVariable String recptNo) {
		ClinicChartRecPatVO clinicChartRecPatVO = new ClinicChartRecPatVO();
		clinicChartRecPatVO.setRceptNo(recptNo);
		clinicChartRecPatVO = clinicSVC.getChtNoByRceptNo(clinicChartRecPatVO);
		
		log.info("접수번호로 차트번호,진료번호  출력하기  도착!");
		
		log.info("VO : " + clinicChartRecPatVO);
		
		return clinicChartRecPatVO;
	}
	
	
	//처치오더 조회
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/treat",produces = "application/json;charset=utf-8")
	public List<TreatmentVO> getTreat() {
		return clinicSVC.getTreat();
	}
	
	//처치오더 검색하기
	// vo 생성 후 서비스에 전달하여 결과를 얻고 List(그대로) 반환한다.
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/treat/{searchTreat}",produces = "application/json;charset=utf-8")
	public List<TreatmentVO> searchTreat(@PathVariable String searchTreat) {
		TreatmentVO treatmentVO = new TreatmentVO();
		treatmentVO.setSearchTreat(searchTreat);
		
		log.info("처치오더양 : " + searchTreat);
		log.info("처치검색VO : " + treatmentVO);
		return clinicSVC.searchTreat(treatmentVO);
	}

	
	//처치오더 요청
	@ResponseBody
	@PostMapping(value="/clinic/chart/order/treat",produces = "application/json;charset=utf-8")
	public String insertTreatOrder(@RequestBody List<TreatmentListVO> treatmentListVOlist) {
		log.info("처치요청이 되었당");

		int cnt = 0;
		for (TreatmentListVO treatmentListVO : treatmentListVOlist) {
			log.info("TreatmentListVO 내용: " + treatmentListVO.toString());
			cnt += clinicSVC.insertTreatOrder(treatmentListVO);
		}
		
		String result = "success";
		if(cnt != treatmentListVOlist.size()) {
			result = "fail";
		}
		return result;
	}
	
	//치료오더 조회
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/physio",produces = "application/json;charset=utf-8")
	public List<PhysiotherapyVO> getPhysio() {
		return clinicSVC.getPhysio();
	}
	
	//치료오더 검색하기
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/physio/{searchPhysio}",produces = "application/json;charset=utf-8")
	public List<PhysiotherapyVO> searchPhysio(@PathVariable String searchPhysio) {
		PhysiotherapyVO physiotherapyVO = new PhysiotherapyVO();
		physiotherapyVO.setSearchPhysio(searchPhysio);
		
		log.info("치료오더양 : " + searchPhysio);
		log.info("치료검색VO : " + physiotherapyVO);
		return clinicSVC.searchPhysio(physiotherapyVO);
	}
	
	
	// 치료오더 요청 - 진료상태 '물리치료대기'로 업데이트
	@Transactional
	@ResponseBody
	@PostMapping(value="/clinic/chart/order/physio/{treatNo}",produces = "application/json;charset=utf-8")
	public String insertPhysioOrder(@RequestBody List<PhysioTherapyListVO> physioTherapyListVOlist, @PathVariable(value = "treatNo",required = false) String treatNo) {
		log.info("치료요청이 되었당");

		int cnt = 0;
		for (PhysioTherapyListVO physioTherapyListVO : physioTherapyListVOlist) {
			cnt += clinicSVC.insertPhysioOrder(physioTherapyListVO);
		}
		
	    CliChtIspcVO cliChtIspcVO = new CliChtIspcVO();
	    cliChtIspcVO.setTreatNo(treatNo);
	    log.info("검사요청이 되었당" + treatNo);
	    
	    cnt += clinicSVC.updatePhysioStatus(cliChtIspcVO);
	    
		String result = "success";
		if(cnt != physioTherapyListVOlist.size() + 1) {
			result = "fail";
		}
		return result;
	}
	
	//질병 조회
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/diss",produces = "application/json;charset=utf-8")
	public List<DiseaseVO> getDisease() {
		return clinicSVC.getDisease();
	}
	
	//질병 검색하기
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/diss/{searchDiss}",produces = "application/json;charset=utf-8")
	public List<DiseaseVO> searchDisease(@PathVariable String searchDiss) {
		DiseaseVO diseaseVO = new DiseaseVO();
		diseaseVO.setSearchDiss(searchDiss);
		
		log.info("처치오더양 : " + searchDiss);
		log.info("처치검색VO : " +  diseaseVO);
		return clinicSVC.searchDisease(diseaseVO);
	}
	
	//처방오더 조회
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/medi",produces = "application/json;charset=utf-8")
	public List<MediItemListVO> getMedi() {
		return clinicSVC.getMedi();
	}
	
	//처방오더 검색하기
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/medi/{searchMedi}",produces = "application/json;charset=utf-8")
	public List<MediItemListVO> searchMedi(@PathVariable String searchMedi) {
		MediItemListVO mediItemListVO = new MediItemListVO();
		mediItemListVO.setSearchMedi(searchMedi);
		
		log.info("처방오더양 : " + searchMedi);
		log.info("처방검색VO : " +  mediItemListVO);
		return clinicSVC.searchMedi(mediItemListVO);
	}
	
	
	//처방오더 요청하기
	@ResponseBody
	@PostMapping(value="/clinic/chart/order/medi",produces = "application/json;charset=utf-8")
	public String insertMediOrder(@RequestBody List<PrescriptionVO> prescriptionVOList) {
		log.info("처방요청이 되었당");

		int cnt = 0;
		for (PrescriptionVO prescriptionVO : prescriptionVOList) {
			cnt += clinicSVC.insertMediOrder(prescriptionVO);
		}
		
		String result = "success";
		if(cnt != prescriptionVOList.size()) {
			result = "fail";
		}
		return result;
	}
	

	// 질병코드로 그룹오더 조회
	// vo 생성 후 서비스에 전달하여 결과를 얻고 List(그대로) 반환한다.
	@ResponseBody
	@GetMapping(value="/clinic/chart/order/grpord/{dissCodeNo}",produces = "application/json;charset=utf-8")
	public List<GrpOrdrVO> showGroupOrder(@PathVariable String dissCodeNo) {
		GrpOrdrVO grpOrdrVO = new GrpOrdrVO();
		grpOrdrVO.setDissCodeNo(dissCodeNo);
		
		log.info("질병코드얌 그룹오더 : " + dissCodeNo);
		log.info("그룹오더VO : " + grpOrdrVO);
		return clinicSVC.showGroupOrder(grpOrdrVO);
	}
	

	//진료완료 버튼 클릭 시, 환자차트에 질병코드,증상메모 update 	
	@Transactional
	@ResponseBody
	@PutMapping(value="/clinic/chart/done",produces = "application/json;charset=utf-8")
	public int putChartDetail(@RequestBody ClinicChartRecPatVO clinicChartRecPatVO) {	
		log.info("진료오나나나나나나료");
		log.info(clinicChartRecPatVO.toString());	
		
	    String patHsptlzStatus = clinicChartRecPatVO.getPatHsptlzStatus();
		
	    int cnt = 0;
	    cnt += clinicSVC.putChartDetail(clinicChartRecPatVO); // 외래,입원결정,입원중,퇴원

		  //입원결정,입원중,퇴원
		  if ("2".equals(patHsptlzStatus) || "4".equals(patHsptlzStatus) || "5".equals(patHsptlzStatus)) {
			  	//입원 결정시 환자 입원일, 퇴원예정일 update 
		        cnt += clinicSVC.putHsptlzDate(clinicChartRecPatVO); 
		        //입원결정
		        if ("2".equals(patHsptlzStatus)) {
		        	// 입원 결정시 입원테이블 진료번호,입원번호,입원일자,퇴원일자 insert 
		            cnt += clinicSVC.insertHosp(clinicChartRecPatVO); 
		        }
		    }
		  
		return cnt;
}

		
	// 입원가능병상 count
	@ResponseBody
	@GetMapping(value="/clinic/chart/cntbed",produces = "application/json;charset=utf-8")
	public int cntEmptBed() {

		log.info("입원가능병상도착");		
		int cnt = 0;
		cnt += clinicSVC.cntEmptBed();
			
		log.info("입원가능병상결과",cnt);		
		
		return cnt; 
	}
	
	//환자 조회 ( 강혁)
	@ResponseBody
	@GetMapping(value="/clinic/{patCode}",produces = "application/json;charset=utf-8")
	public PatientVO selectSearchPatInfo(@PathVariable String patCode) {
		PatientVO patientVO = new PatientVO();
		patientVO.setPatCode(patCode);
		patientVO = clinicSVC.selectPatInfo(patientVO);
		log.info("환자정보 patCode 도착!");
		log.info("VO : " + patientVO);
		return patientVO;
	}
}