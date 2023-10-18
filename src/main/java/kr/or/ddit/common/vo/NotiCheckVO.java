package kr.or.ddit.common.vo;

import java.util.Date;

import lombok.Data;

@Data
public class NotiCheckVO {
	private int ntcnId;
	private String empNo;
	private Date checkDate;
}
