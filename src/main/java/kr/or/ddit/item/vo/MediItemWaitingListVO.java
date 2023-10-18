package kr.or.ddit.item.vo;


import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MediItemWaitingListVO {
	private int mediItemReqNo;
	private String mediItemName;
	@DateTimeFormat(pattern = "yy/MM/dd")
	private Date mediItemReqDe;
	private String mediItemReqDeStr;
	private String empNm;
	private int countMediItem;
	private String mediItemConfirmYsno;
	
	private String searchMedi; //검색용
	private String searchType;
	private String keyword;

}
