package kr.or.ddit.order.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.order.vo.BedStatusVO;
import kr.or.ddit.order.vo.BedVO;
import kr.or.ddit.order.vo.PhysioTherapyListVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.ReceiptVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

@Mapper
public interface PhysiotheraphyMapper {
	
	// 대기환자 목록 조회
	public List<WaitPatVO> physioWaitPat();
	
	// 환자정보
	public PatientVO physioPatInfo(PatientVO patientVO);

	//대기인원 목록에서 치료대기->치료중으로 변경 시 PHWT에서 PING로  update
	//<update id="physioStatusUpdate" parameterType="String">
	public int physioStatusUpdate(String treatNo);
	
	//침상배정 테이블에 insert 
	//<insert id="bedStatus" parameterType="BedStatusVO">
	public int bedStatus(BedStatusVO bedStatusVO);
	
	//침상 배정 현황 목록
	//<select id="bedStatusList" resultType="BedVO">
	public List<BedVO> bedStatusList();
	
	// 치료 오더 내역 
	// <select id="physioList" parameterType="String" resultType="PhysioTherapyListVO">
	public List<PhysioTherapyListVO> physioList(String treatNo);
	
	// 치료 내역 
	// <select id="physioHistory" parameterType="String" resultType="PhysioTherapyListVO">
	public List<PhysioTherapyListVO> physioHistory(String patCode);
	
	// 치료현황
	// <select id="physioStat" resultType="BedStatusVO">
	public List<BedStatusVO> physioStat();
	
	// 침상번호를 알면 접수정보를 알 수 있음(PAT_CODE) -->
	//<select id="getReceiptInfo" parameterType="hashMap" resultMap="ReceiptMap">
	public ReceiptVO getReceiptInfo(Map<String,Object> map);
	
	// 치료완료 버튼 (상태 업데이트 PING->PEND)
	// <update id="updateStat" parameterType="String">
	public int updateStat(String treatNo);
	
	// 치료완료 버튼 클릭 시 침대상태 삭제 
	// <delete id="deleteBedStat">
	public int deleteBedStat(String bedNo );
	
	//환자를 알면 치료중여부와 점유 침상 번호를 안다
	public Map<String,String> getSttusBedNo(String patCode);

	//침상배정 치료내용 상태 초기화
	public int bedStatusInit(BedStatusVO bedStatusVO);
	
	//침상배정 치료내용 상태변경
	public int bedStatusUpdate(BedStatusVO bedStatusVO);
}


