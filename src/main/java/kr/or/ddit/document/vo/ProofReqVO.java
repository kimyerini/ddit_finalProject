package kr.or.ddit.document.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ProofReqVO {
	private String reqDocumentNo       ;
	private String patCode             ;
	private String patName             ;
	private String empNm               ;
	private int reqDocumentPayment     ;
	private String reqDocumentRegDate  ;
	private String reqDocumentStatus   ;
	private String fileWebPath         ;
	private String patBrthdy           ;
	private String documentType        ;
}                                        
