package kr.or.ddit.item.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MediItemOrderVO {
	private String mediItemOrderNo;
	private String empNo;

	// 추가
	private String empNm;
	private String mediItemOrderDate;
	private List<MediItemListVO> mediItemList;
}
