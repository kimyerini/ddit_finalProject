package kr.or.ddit.item.vo;

import java.sql.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MediItemListVO {
	private String mediItemCode;
	private String mediItemName;
	private String mediItemMakr;
	private String mediItemUnit;
	private String mediItemUsage;
	private String narcoticYn;
	private int mediItemPrice;
	
	private int mediItemReqQy;
	private int mediItemReqTotal;
	private int mediItemReqNo;
	private String searchMedi;//검색용
	private String searchType;
	private String keyword;
	private int mediItemInvrQty;
	private int mediItemLeastQty;
	@DateTimeFormat(pattern = "yy/MM/dd HH:mm:ss")
	private Date mediItemRegDate;
	private List<MediItemReqDetailVO> mediItemReqDetailVOList;
	
}
