package kr.or.ddit.board.service.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.board.mapper.NoticeMapper;
import kr.or.ddit.board.service.NoticeService;
import kr.or.ddit.board.vo.NoticeBoardVO;
import kr.or.ddit.common.mapper.NotificationMapper;
import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.common.vo.NotificationVO;
import kr.or.ddit.util.FileUploadUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeMapper noticeMapper;
	@Autowired
	FileUploadUtils fileUploadUtils; // 파일 업로드를 위함
	@Autowired
	NotificationMapper notificationMapper; // 실시간 알림

	@Override
	public List<NoticeBoardVO> noticeList(Map<String, Object> map) {
		return noticeMapper.noticeList(map);
	}

	@Override
	public NoticeBoardVO oneNotice(String ntbdCode) {
		return noticeMapper.oneNotice(ntbdCode);
	}

	@Transactional
	@Override
	public int insertNotice(NoticeBoardVO noticeBoardVO) {

		log.info("serviceImpl에 넘어온 noticeBoardVO: " + noticeBoardVO);
		int result = noticeMapper.insertNotice(noticeBoardVO);
		//noticeBoardVO.ntbdCode이 selectKey에 의해 생성됨
		
		// 파일 처리
		MultipartFile[] files = noticeBoardVO.getFiles();
		log.info("files[0].getOriginalFilename().length() : " + files[0].getOriginalFilename().length());

		if(files[0].getOriginalFilename().length()>0) { // 파일이 있을 때만 insert
			List<AttachFileVO> attachFileVOList = fileUploadUtils.multiUpload(noticeBoardVO.getNtbdCode(),
					noticeBoardVO.getWriterEmpNo(), files);
			noticeBoardVO.setFileList(attachFileVOList);
		}
		
		NotificationVO notiVO = new NotificationVO();
		notiVO.setNtcnContent("새로운 공지사항("+noticeBoardVO.getNtbdSubject()+")이 등록되었습니다.");
		notiVO.setNtcnGubun("공지사항");
		notiVO.setNtcnUrl(noticeBoardVO.getNtbdCode());

		result += notificationMapper.insertNoti(notiVO);
		log.info("result : " + result);

		return result;
	}

	@Override
	public int updateNotice(NoticeBoardVO noticeBoardVO) {
		return noticeMapper.updateNotice(noticeBoardVO);
	}

	@Override
	public int deleteNotice(String ntbdCode) {
		return noticeMapper.deleteNotice(ntbdCode);
	}

	@Override
	public int updateHit(NoticeBoardVO noticeBoardVO) {
		return noticeMapper.updateHit(noticeBoardVO);
	}

	@Override
	public int countNotice(Map<String, Object> map) {
		return noticeMapper.countNotice(map);
	}

	@Override
	public int deleteOneFile(int chkFileNo) {
		return noticeMapper.deleteOneFile(chkFileNo);
	}

	@Override
	public int deleteAllFile(String ntbdCode) {
		return noticeMapper.deleteAllFile(ntbdCode);
	}


}
