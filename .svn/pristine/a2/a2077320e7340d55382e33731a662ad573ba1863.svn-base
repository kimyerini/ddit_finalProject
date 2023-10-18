package kr.or.ddit.hospitalization.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.hospitalization.vo.SickRoomTypeVO;
import kr.or.ddit.hospitalization.vo.SickbedVO;
import kr.or.ddit.hospitalization.vo.hosptPatVO;
import kr.or.ddit.order.vo.HospitalizationVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.HosRRoomVO;
import kr.or.ddit.receipt.vo.HosReceiptionVO;
import kr.or.ddit.receipt.vo.WaitPatVO;

@Mapper
public interface HospitalizationMapper {

	public List<WaitPatVO> hosptPatWaitList();
	
	public List<SickRoomTypeVO> selectRoomData();
	
	public int updateHsptlzStatus(PatientVO patientVO);
	public int updateHsptlzRoom(HospitalizationVO hospitalizationVO);
	public List<HospitalizationVO> selectHsptlzstatus();
	public List<HospitalizationVO> getReqHospitalizationList();
	public HospitalizationVO getReqHospitalization(HospitalizationVO hospitalizationVO);
	public int updatePatInHos(String patCode);
	public int updateInHosVO(String hsptlzNo);
	public int updatePatOutHos(String patCode);
	public int updateOutHosVO(String hsptlzNo);
	public List<HosReceiptionVO> getDetailNoDuringInHos(String hsptlzNo);
	public int updateBdCondition(SickbedVO sickbedVO);
	public int updateBdConditionEmpt(SickbedVO sickbedVO);
	public int getRoomPrice(String hsptlzNo);
	public int updateHosRoomPrice(HosRRoomVO hsptlzNo);
}
