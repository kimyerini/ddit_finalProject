package kr.or.ddit.document.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class DocumentVO {
	private int documentNo; //제증명번호  -진단서,소견서
	private String reqDocumentNo; //제증명신청번호  -진단서,소견서
	private String documentDocNm; //발급의사  -진단서,소견서
	private String documentSignImgPath; //서명이미지파일경로  -진단서,소견서
	private String documentIsuDate; //발행일  -진단서,소견서
	private String documentDissCn; //질병내용 -진단서
	private String documentDissClNo; //질병분류번호 -진단서
	private String documentOpinion; //향후치료의견  -진단서
	private String documentRm; //비고  -진단서,소견서
	private String documentPrpos; //용도  -진단서,소견서
	private String documentNote; //진료소견 -소견서
	private String documentType; // 제증명구분  -진단서,소견서
}
