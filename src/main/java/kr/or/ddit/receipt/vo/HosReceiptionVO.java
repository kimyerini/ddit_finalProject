package kr.or.ddit.receipt.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HosReceiptionVO {
	private String detailNo;
	private String patName;
	private String patCode;
	private String hsptlzInDate;
	private String hsptlzOutDate;
	private String sckrmNo;
	private int sckrmTypePrice;
	private int hosRoomTotalPrice;
	private List<HosRInspcVO> hosRInspcVOList;
	private List<HosRPhysioVO> hosRPhysioVOList;
	private List<HosRPrescriptionVO> hosRPrescriptionVOList;
	private List<HosRTreatVO> hosRTreatVOList;
}
