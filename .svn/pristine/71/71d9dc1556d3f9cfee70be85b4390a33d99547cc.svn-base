package kr.or.ddit.prescription.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.prescription.vo.PreInspecVO;
import kr.or.ddit.prescription.vo.PreMediVO;
import kr.or.ddit.prescription.vo.PrePhysioVO;
import kr.or.ddit.prescription.vo.PreTreatVO;

@Mapper
public interface PrescriptionMapper {
	 public List<PreInspecVO> getPreInspec(String detailNo);
	 public List<PreMediVO> getPreMedi(String detailNo);
	 public List<PrePhysioVO> getPrePhysio(String detailNo);
	 public List<PreTreatVO> getPreTreat(String detailNo);
}
