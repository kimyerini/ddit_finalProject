package kr.or.ddit.document.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.document.mapper.ProofRequestMapper;
import kr.or.ddit.document.service.ProofRequestService;
import kr.or.ddit.document.vo.ProofReqVO;
import kr.or.ddit.document.vo.RequestDocumentVO;

@Service
public class ProofRequestServiceImpl implements ProofRequestService{
	@Autowired
	ProofRequestMapper proofRequestMapper;
		
	@Override
	@Transactional
	public int insertProofReq(RequestDocumentVO requestDocumentVO) {
		String type = requestDocumentVO.getDocumentType();
		int cnt = 0;
		if(type.equals("진단서")) {
			cnt = proofRequestMapper.insertDProofReq(requestDocumentVO);
		}else if(type.equals("소견서")) {
			cnt = proofRequestMapper.insertOProofReq(requestDocumentVO);
		}
		return cnt;
	}
	
	@Override
	public List<ProofReqVO> getProofReqList() {
		return proofRequestMapper.getProofReqList();
	}
	
	@Override
	public AttachFileVO getFileByDocNo(String reqDocumentNo) {
		AttachFileVO attachFileVO = new AttachFileVO();
		attachFileVO.setFileCode(reqDocumentNo);
		return proofRequestMapper.getFileByDocNo(attachFileVO);
	}
	
	@Override
	public ProofReqVO getOneProofRequest(String reqDocumentNo) {
		ProofReqVO pVO = new ProofReqVO();
		pVO.setReqDocumentNo(reqDocumentNo);
		return proofRequestMapper.getOneProofRequest(pVO);
	}
}
