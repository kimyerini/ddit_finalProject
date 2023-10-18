package kr.or.ddit.order.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RadiologyVO {
	private String radioNo;
	private String detailNo;
	private String radioRegn;
	private String radioType;
	private Date radioDate;
	private String radioPhotoFlpth;
	private String rceptNo;
	private String inspcCode;
}
