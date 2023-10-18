package kr.or.ddit.item.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class ItemWaitingListVO {

	private int itemReqNo;
	private String itemName;
	@DateTimeFormat(pattern = "yy/MM/dd")
	private Date itemReqDe;
	private String itemReqDeStr;
	private String empNm;
	private int countItem;
	private String itemConfirmYsno;
	
	private String searchType;
	private String keyword;

}
