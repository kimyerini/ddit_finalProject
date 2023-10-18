package kr.or.ddit.item.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MediItemRequestVO {
	private int mediItemReqNo;
	@DateTimeFormat(pattern = "yy/MM/dd")
	private Date mediItemReqDe;
	private String mediItemReqDeStr;
	private String mediItemReqSt;
	private int mediItemReqQy;
	private String empNo;
	private String empNm;
	private String mediItemName;
	
	//MediItemRequestVO : MediItemReqDetailVO = 1 : N
	private List<MediItemReqDetailVO> mediItemReqDetailVOList;
}
