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

public class ItemReqVO {
	private int itemReqNo;
	@DateTimeFormat(pattern = "yy/MM/dd")
	private Date itemReqDe;
	private String itemReqDeStr;
	private String itemReqSt;
	private int itemReqQy;
	private String empNo;
	private String empNm;
	private String itemName;
	
	private List<ItemReqDetailVO> itemReqDetailVOList;
}
