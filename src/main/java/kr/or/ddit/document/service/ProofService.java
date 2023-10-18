package kr.or.ddit.document.service;


import java.util.List;

import kr.or.ddit.document.vo.DocuWaitPatVO;
import kr.or.ddit.document.vo.RequestDocumentVO;


public interface ProofService  {

	//의사) 제증명 발급 대기 목록 조회
	public List<DocuWaitPatVO> docuWaitPat(DocuWaitPatVO docuWaitPatVO);
	
	//의사) 제증명 신청내역 조회(환자코드로)
	public DocuWaitPatVO selectDocuInfo(DocuWaitPatVO docuWaitPatVO);
	
	// 의사) 제증명 발급 완료 
	public int issuedDocu(RequestDocumentVO requestDocumentVO);
}
