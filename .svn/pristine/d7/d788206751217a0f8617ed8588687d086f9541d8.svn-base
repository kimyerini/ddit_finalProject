package kr.or.ddit.schedule.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HosScheduleVO {
	private int hosSchNo;
	private String hosSchTitle;
	private String hosSchCont;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date hosSchStart;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date hosSchEnd;
	
	private String hosSchUrl;
	private String hosSchColor;
	private String hosSchAllDay;
	private String hosSchId;
}
