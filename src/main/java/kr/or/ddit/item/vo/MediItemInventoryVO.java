package kr.or.ddit.item.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MediItemInventoryVO {
	private String mediItemCode;
	private int mediItemInvrQty;
	private int mediItemLeastQty;
	private Date mediItemRegDate;
	private int prscrptnTotal;
}
