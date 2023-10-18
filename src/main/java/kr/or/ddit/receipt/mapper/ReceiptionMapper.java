package kr.or.ddit.receipt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.order.vo.PrescriptionVO;
import kr.or.ddit.receipt.vo.ReceiptionVO;

@Mapper
public interface ReceiptionMapper {
	public int insertReceiption(ReceiptionVO receiptionVO);
	public int reqDocReceiption(String reqDocumentNo);
	public int getInspcCostByDtlNo(String detailNo);
	public int getPhysioCostByDtlNo(String detailNo);
	public int getTreatCostByDtlNo(String detailNo);
	public List<PrescriptionVO> getPrescriptCostByDtlNo(String detailNo);
	public String findTreatNoByDetailNo(String detailNo);
}
