package kr.or.ddit.document.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.document.vo.ProofReqVO;
import kr.or.ddit.document.vo.RequestDocumentVO;

@Mapper
public interface ProofRequestMapper {
	public int insertDProofReq (RequestDocumentVO requestDocumentVO);
	public int insertOProofReq (RequestDocumentVO requestDocumentVO);
	public List<ProofReqVO> getProofReqList();
	public AttachFileVO getFileByDocNo(AttachFileVO attachFileVO);
	public ProofReqVO getOneProofRequest(ProofReqVO proofReqVO);
}
