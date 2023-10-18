package kr.or.ddit.clinic.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.clinic.mapper.ClinicMapper;
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

@Service
public class ClinicServiceImpl implements ClinicService {
	
	@Autowired
	ClinicMapper clinicmapper;

	// 환자 접수 상세정보 출력하기
	@Override
	public PatientRecieptVO receiptDetail(PatientRecieptVO patientRecieptVO) {
		return clinicmapper.receiptDetail(patientRecieptVO);
	}

	// 환자 호출 시 환자 상태 CING 업데이트
	@Override
	public int updateCing(ClinicVO clinicVO) {
		return clinicmapper.updateCing(clinicVO);
	}
	
	// 환자 진료 내역 날짜 출력하기
	@Override
	public List<ClinicChartRecPatVO> getRegDateList(ClinicChartRecPatVO clinicChartRecPatVO) {
		return clinicmapper.getRegDateList(clinicChartRecPatVO);
	}

    // 환자 정보 조회하기
	@Override
	public PatientVO selectPatInfo(PatientVO patientVO) {
		return clinicmapper.selectPatInfo(patientVO);
	}

	
//	// 대기 환자 목록 조회하기
//	@Override
//	public List<PatRecCliVO> getWaitPatList() {
//		return clinicmapper.getWaitPatList();	
//	}
	
	// 등록날짜로 환자차트 조회하기
	@Override
	public List<ChartDetailByDateVO> getChartByRegDate(ChartDetailByDateVO chartDetailByDateVO) {
		return clinicmapper.getChartByRegDate(chartDetailByDateVO);
	}

	// 검사오더 조회 
	@Override
	public List<InspectionVO> getInspection() {
		return clinicmapper.getInspection();
	}
	
	// 검사오더 검색 
	@Override
	public List<InspectionVO> searchInspection(InspectionVO inspectionVO) {
		return clinicmapper.searchInspection(inspectionVO);
	}
	
	// 처치오더 검색 
	@Override
	public List<TreatmentVO> searchTreat(TreatmentVO treatmentVO) {
		return  clinicmapper.searchTreat(treatmentVO);
	}
	
	// 치료오더 검색 
	@Override
	public List<PhysiotherapyVO> searchPhysio(PhysiotherapyVO physiotherapyVO) {
		return  clinicmapper.searchPhysio(physiotherapyVO);
	}


	// 차트번호 출력
	@Override
	public ChartDetailVO getChartDetailNo() {
		return clinicmapper.getChartDetailNo();
	}

	// 의사) 대기 환자 목록 조회하기
	public List<WaitPatVO> selectWaitPat(WaitPatVO waitPatVO) {
		return clinicmapper.selectWaitPat(waitPatVO);
	}

	// 원무과) 대기환자 목록 조회	
	@Override
	public List<WaitPatVO> officeWaitPat() {
		return clinicmapper.officeWaitPat();
	}
	
	// 진료번호 출력
	@Override
	public ClinicVO getTreatNo() {
		return clinicmapper.getTreatNo();
	}

	// 차트 틀 입력
	@Override
	public int insertChartBefore(ChartDetailVO chartDetailVO) {
		return clinicmapper.insertChartBefore(chartDetailVO);
	}

	//검사오더 요청
	@Override
	public int insertInspcOrder(InspectionListVO inspectionListVO) {
		return clinicmapper.insertInspcOrder(inspectionListVO);
	}

	// 검사오더 요청 - 진료상태 '검사대기'로 업데이트
	@Override
	public int updateInspcStatus(CliChtIspcVO cliChtIspcVO) {
		return clinicmapper.updateInspcStatus(cliChtIspcVO);
	}
	
	// 의사) 검사완료 리스트 불러오기 
	@Override
	public List<CliChtIspcVO> getEndInspcList(CliChtIspcVO cliChtIspcVO) {
		return clinicmapper.getEndInspcList(cliChtIspcVO);
	}
	
	// 의사) 조회버튼 눌렀을때 검사완료 사진 불러오기  	
	@Override
	public List<InspcFileVO> getInspcPhotoList(InspcFileVO inspcFileVO) {
		return clinicmapper.getInspcPhotoList(inspcFileVO);
	}
	
	// 의사) 접수번호로 차트번호,진료번호  출력하기 
	@Override
	public ClinicChartRecPatVO getChtNoByRceptNo(ClinicChartRecPatVO clinicChartRecPatVO) {
		return clinicmapper.getChtNoByRceptNo(clinicChartRecPatVO);
	}
	
	//처치오더 요청
	@Override
	public int insertTreatOrder(TreatmentListVO treatmentListVO) {
		return clinicmapper.insertTreatOrder(treatmentListVO);
	}

	//치료오더 요청
	@Override
	public int insertPhysioOrder(PhysioTherapyListVO physioTherapyListVO) {
		return clinicmapper.insertPhysioOrder(physioTherapyListVO);
	}

	// 치료오더 요청 - 진료상태 '물리치료대기'로 업데이트
	@Override
	public int updatePhysioStatus(CliChtIspcVO cliChtIspcVO) {
		return clinicmapper.updatePhysioStatus(cliChtIspcVO);
	}
	
	//질병 검색
	@Override
	public List<DiseaseVO> searchDisease(DiseaseVO diseaseVO) {
		return  clinicmapper.searchDisease(diseaseVO);
	}
	
	// 처방오더 검색 
	@Override
	public List<MediItemListVO> searchMedi(MediItemListVO mediItemListVO) {
		return  clinicmapper.searchMedi(mediItemListVO);
	}

	// 처방오더 요청
	@Override
	public int insertMediOrder(PrescriptionVO prescriptionVO) {
		return  clinicmapper.insertMediOrder(prescriptionVO);
	}

	// 질병코드로 그룹오더 조회
	@Override
	public List<GrpOrdrVO> showGroupOrder(GrpOrdrVO grpOrdrVO) {
		return clinicmapper.showGroupOrder(grpOrdrVO);
	}

	//진료완료 버튼 클릭 시, 환자차트에 질병코드,증상메모 update 	
	@Override
	public int putChartDetail(ClinicChartRecPatVO clinicChartRecPatVO) {
		return clinicmapper.putChartDetail(clinicChartRecPatVO);
	}
	
	//입원 결정시 환자 입원일, 퇴원예정일 update 
	@Override
	public int putHsptlzDate(ClinicChartRecPatVO clinicChartRecPatVO) {
		return clinicmapper.putHsptlzDate(clinicChartRecPatVO);
	}

	// 입원가능병상 count
	@Override
	public int cntEmptBed() {
		return clinicmapper.cntEmptBed();
	}

	// 처치오더 조회 
	@Override
	public List<TreatmentVO> getTreat() {
		return clinicmapper.getTreat();
	}

	// 치료오더 조회
	@Override
	public List<PhysiotherapyVO> getPhysio() {
		return clinicmapper.getPhysio();
	}

	// 처방오더 조회
	@Override
	public List<MediItemListVO> getMedi() {
		return clinicmapper.getMedi();
	}
	
	//질병 조회
	@Override
	public List<DiseaseVO> getDisease() {
		return clinicmapper.getDisease();
	}

	
	// 입원 결정시 입원테이블 진료번호,입원번호,입원일자,퇴원일자 insert
	@Override
	public int insertHosp(ClinicChartRecPatVO clinicChartRecPatVO) {
		return clinicmapper.insertHosp(clinicChartRecPatVO);
	}





}
