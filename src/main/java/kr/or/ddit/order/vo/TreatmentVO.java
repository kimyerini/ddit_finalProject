package kr.or.ddit.order.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TreatmentVO {
	private String treCode;
	private int treCosts;
	private String treContent;
	
	private String searchTreat; //검색용
	
}
