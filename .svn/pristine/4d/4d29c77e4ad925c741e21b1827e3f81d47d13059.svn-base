package kr.or.ddit.clinic.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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


@Mapper
public interface ClinicMapper {
	// 환자 접수 상세보기 
	public PatientRecieptVO receiptDetail(PatientRecieptVO patientRecieptVO);

	// 환자 호출 시 상태 변경 (CING)
	public int updateCing(ClinicVO clinicVO);
	   
	// 진료내역 등록날짜별로 조회하기
	public List<ClinicChartRecPatVO> getRegDateList(ClinicChartRecPatVO clinicChartRecPatVO);

	// 환자 정보 조회하기
	public PatientVO selectPatInfo(PatientVO patientVO);
	
//	// 대기 환자 목록 조회하기
//	public List<PatRecCliVO> getWaitPatList(WaitPatVO waitPatVO);
	
	// 등록날짜로 환자차트 조회하기
	public List<ChartDetailByDateVO> getChartByRegDate(ChartDetailByDateVO chartDetailByDateVO);
	
	// 검사오더 조회 
	public List<InspectionVO> getInspection();
	
	// 검사오더 검색 
	public List<InspectionVO> searchInspection(InspectionVO inspectionVO);
	
	// 의사) 검사완료 리스트 불러오기 
	public List<CliChtIspcVO> getEndInspcList(CliChtIspcVO cliChtIspcVO);
	
	// 의사) 조회버튼 눌렀을때 검사완료 사진 불러오기  
	public List<InspcFileVO> getInspcPhotoList(InspcFileVO inspcFileVO);

	// 의사) 접수번호로 차트번호,진료번호  출력하기 
	public ClinicChartRecPatVO getChtNoByRceptNo(ClinicChartRecPatVO clinicChartRecPatVO);

	// 처치오더 조회 
	public List<TreatmentVO> getTreat();
	
	// 처치오더 검색 
	public List<TreatmentVO> searchTreat(TreatmentVO treatmentVO);
	
	// 치료오더 조회
	public List<PhysiotherapyVO> getPhysio();
	
	// 치료오더 검색 
	public List<PhysiotherapyVO> searchPhysio(PhysiotherapyVO physiotherapyVO);
	
	// 처방오더 조회
	public List<MediItemListVO> getMedi();
	
	// 처방오더 검색 
	public List<MediItemListVO> searchMedi(MediItemListVO mediItemListVO);
		
	// 차트번호 출력
	public ChartDetailVO getChartDetailNo();
	
	// 대기 환자 목록 조회하기
	public List<WaitPatVO> selectWaitPat(WaitPatVO waitPatVO);	
	
	// 원무과) 대기환자 목록 조회
	public List<WaitPatVO> officeWaitPat();	
	
	// 진료번호 출력
	public ClinicVO getTreatNo();
		
	//차트 틀 입력 
	public int insertChartBefore(ChartDetailVO chartDetailVO);
	
	//검사오더 요청
	public int insertInspcOrder(InspectionListVO inspectionListVO);
	
	// 검사오더 요청 - 진료상태 '검사대기'로 업데이트
	public int updateInspcStatus(CliChtIspcVO cliChtIspcVO);

	//처치오더 요청
	public int insertTreatOrder(TreatmentListVO treatmentListVO);
	
	//치료오더 요청
	public int insertPhysioOrder(PhysioTherapyListVO physioTherapyListVO);
	
	// 치료오더 요청 - 진료상태 '물리치료대기'로 업데이트
	public int updatePhysioStatus(CliChtIspcVO cliChtIspcVO);
    
	//질병 조회
	public List<DiseaseVO> getDisease();
	
	//질병 검색
	public List<DiseaseVO> searchDisease(DiseaseVO diseaseVO);
	
	//처방오더 요청 
	public int insertMediOrder(PrescriptionVO prescriptionVO);
	
	// 질병코드로 그룹오더 조회
	public List<GrpOrdrVO> showGroupOrder(GrpOrdrVO grpOrdrVO);

	//진료완료 버튼 클릭 시, 환자차트에 질병코드,증상메모 update 
	public int putChartDetail(ClinicChartRecPatVO clinicChartRecPatVO);

	//입원 결정시 환자 입원일, 퇴원예정일 update 
	public int putHsptlzDate(ClinicChartRecPatVO clinicChartRecPatVO);
	
	// 입원 결정시 입원테이블 진료번호,입원번호,입원일자,퇴원일자 insert
	public int insertHosp(ClinicChartRecPatVO clinicChartRecPatVO);
		
	// 입원가능병상 count
	public int cntEmptBed();
	
	//수납 후 clinic테이블 'REND'로 업데이트
	public int updateClinicAfterReceiption(String treatNo);
	
	
	
}
