package kr.or.ddit.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.common.vo.AttachFileVO;

@Mapper
public interface NoticeMapper {

	// select List
	public List<NoticeBoardVO> noticeList(Map<String, Object> map);
	
	// select one
	public NoticeBoardVO oneNotice(String ntbdCode);
	
	// insert
	public int insertNotice(NoticeBoardVO noticeBoardVO);
	
	// update
	public int updateNotice(NoticeBoardVO noticeBoardVO);
	
	// get emp info
	public NoticeBoardVO getEmpInfo(String writerEmpNo);
	
	// 조회수 증가
	public int updateHit(NoticeBoardVO noticeBoardVO);

	// delete
	public int deleteNotice(String ntbdCode);
	
	// 게시글 개수 세리기
	public int countNotice(Map<String, Object> map);
	
	// 파일 부분 삭제 - 글 수정 시
	public int deleteOneFile(int chkFileNo);
	
	// 파일 전체 삭제 - 글 삭제 시
	public int deleteAllFile(String ntbdCode);
}
