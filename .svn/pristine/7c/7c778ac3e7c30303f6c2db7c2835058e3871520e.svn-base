package kr.or.ddit.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.AttachFileVO;

@Mapper
public interface TbAttachFileMapper {

	// 단일 업로드
	// <insert id="attachFileregist" parameterType="AttachFileVO">
	public int attachFileRegist(AttachFileVO attachFileVO);

	// 다중 업로드
	public int attachFileMultiRegist(List<AttachFileVO> attachFileVOList);
	
	// 파일 개별 삭제
	public int deleteFile(String fileNo);
}
