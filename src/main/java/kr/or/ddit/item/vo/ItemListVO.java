package kr.or.ddit.item.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class ItemListVO {
	private String itemCode;
	private String itemName;
	private String itemMakr;
	private String itemUsage;
	private int itemPrice;

	private int itemReqNo;
	private int itemReqQy;
	private int itemReqTotal;
	
	private int itemInvrQty;
	private int itemInvrLeastQty;
	@DateTimeFormat(pattern = "yy/MM/dd")
	private Date itemInvrRegDate;
	private String itemInvrRegDateStr;
	private String searchType;
	private String keyword;
}
