package kr.or.ddit.document.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.document.service.ProofService;
import kr.or.ddit.document.vo.DocuWaitPatVO;
import kr.or.ddit.document.vo.RequestDocumentVO;
import kr.or.ddit.document.mapper.ProofMapper;


@Service
public class ProofServiceImpl implements ProofService {
	
	@Autowired
	ProofMapper proofmapper;

	//의사) 제증명 발급 대기 목록 조회
	@Override
	public List<DocuWaitPatVO> docuWaitPat(DocuWaitPatVO docuWaitPatVO) {
		return proofmapper.docuWaitPat(docuWaitPatVO);
	}

	//의사) 제증명 신청내역 조회(환자코드로)
	@Override
	public DocuWaitPatVO selectDocuInfo(DocuWaitPatVO docuWaitPatVO) {
		return 	proofmapper.selectDocuInfo(docuWaitPatVO);				
	}
	
	// 의사) 제증명 발급 완료 
	@Override
	public int issuedDocu(RequestDocumentVO requestDocumentVO) {
		return proofmapper.issuedDocu(requestDocumentVO);
	}



}
