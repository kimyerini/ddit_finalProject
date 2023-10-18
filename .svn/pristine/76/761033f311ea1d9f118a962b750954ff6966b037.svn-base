package kr.or.ddit.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.common.vo.AttachFileVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Controller
public class FileUploadUtils {
	
	// 1. 업로드 폴더 정보
	@Autowired
	public String uploadFolder; // root-context.xml의 자바빈을 의존성 주입함
	@Autowired
	private TbAttachFileMapper tbAttachFileMapper; // TB_ATTACH_FILE 테이블에 insert 하기 위해 주입

	// 2. 연월일 폴더 생성
	public String getFolder() {
		// 간단날짜형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("sdf: " + sdf);

		Date date = new Date();
		String str = sdf.format(date);
		// File.separator : 윈도우 경로 (\\)
		return str.replace("-", File.separator);
	}

	// 3. 이미지인지 판단(썸네일은 이미지만 가능함)
	public boolean checkImageType(File file) {
		/*
			<MIME타입>
			text / image / audio / video / application 으로 나뉨
			
			참고) .jpeg 와 .jpg의 MIME타입: image/jpeg
		 */
		// file.toPath(): 파일객체를 path객체로 변환
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath()); // file의 MIME타입을 contentType에 저장
			log.info("contentType : " + contentType);
			// MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image"); // TRUE or FALSE를 리턴
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

	// 4. 다중업로드 처리 (전사적 코드, 등록자 아이디, 파일 객체)
	public List<AttachFileVO> multiUpload(String fileCode, String regUserId, MultipartFile[] files) {
		
		log.info("넘어온 fildCode: " + fileCode);
		log.info("넘어온 regUserId: " + regUserId);
		log.info("넘어온 files: " + files);
		// 업로드 폴더가 없는 경우 처리
		if(uploadFolder == null) {
			uploadFolder = "D:\\mytool\\sts3WS\\202303F_Team1\\src\\main\\webapp\\resources\\upload";
		}
		
		// 업로드 경로(upload 폴더까지의 경로/연/월/일) 처리
		File uploadPath = new File(uploadFolder, getFolder()); // (upload폴더, 연월일 폴더)
		log.info("uploadPath : " + uploadPath);
		// 해당 연/월/일 폴더가 없는 경우 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		// !!! 리턴 대상(최종 목표) = List<AttachFileVO> !!!
		List<AttachFileVO> attachFileVOList = new ArrayList<AttachFileVO>();

		// 파일 웹경로를 담을 변수
		String result = "";
		
		// 파일객체 배열로부터 파일을 하나씩 꺼내옴
		for (MultipartFile file : files) {
//			AttachFileVO AttachFileVO = new AttachFileVO(); // 비어있는 vo객체 생성
			
			log.info("--------------------------");
			log.info("파일명 : " + file.getOriginalFilename());
			log.info("파일크기 : " + file.getSize());
			log.info("MIME타입 : " + file.getContentType());
			
			// C:\\images\\개똥이.jpg 라고 되어 있는 경우 => 개똥이.jpg만 가져와야 함
			String uploadFileName = file.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); // "\" 다음인 "개"부터 끝까지

			//------------------ 같은 날 동일한 이미지 업로드 시 파일 중복 방지 처리 ------------------
			// 임의의 값 생성
			UUID uuid = UUID.randomUUID();
			// 기존 파일 이름과 구분하기 위해 _를 붙임 ex) asdfg_개똥이.jpg
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			//-------------------- 같은날 같은 이미지를 업로드 시 파일 중복 방지 끝 --------------------

			// File 객체 설계(복사할 대상 경로, 파일명)
			File saveFile = new File(uploadPath, uploadFileName);

			try {
				// 원본파일객체.transferTo(설계한파일객체): 설계한 파일객체에 원본 파일객체 복사
				file.transferTo(saveFile);
				
				result = "\\" + getFolder() + "\\" + uploadFileName; // ... \\2023\\08\\08\\s_asdfasdf_개똥이.jpg
				result = result.replace("\\", "/"); // ... /2023/08/08/s_asdfasdf_개똥이.jpg
				
				//----------------썸네일 처리 시작----------------
//				if (checkImageType(saveFile)) { // 이미지라면
//					// 설계
//					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
//					// 썸네일 생성(원본, 설계, 가로크기, 세로크기)
//					Thumbnailator.createThumbnail(file.getInputStream(), thumbnail, 100, 100);
//					thumbnail.close();
//				}
				//-----------------썸네일 처리 끝-----------------
				
				//---------TB_ATTACH_FILE 테이블에 insert 시작---------
				AttachFileVO attachFileVO = new AttachFileVO();
				attachFileVO.setFileCode(fileCode);
				attachFileVO.setFileName(file.getOriginalFilename());
				attachFileVO.setFileSaveName(uploadFileName);
				attachFileVO.setFilePhysicPath(uploadPath + "\\" + uploadFileName);
				attachFileVO.setFileWebPath(result);
				attachFileVO.setFileSize(file.getSize());
				attachFileVO.setFileContType(file.getContentType());
				attachFileVO.setRegUserId(regUserId);
				
				log.info("하나의 attachFileVO: " + attachFileVO);
				
				attachFileVOList.add(attachFileVO);
				log.info("attachFileVOList 하나씩: " + attachFileVOList);
				//----------TB_ATTACH_FILE 테이블에 insert 끝----------		

			} catch (IllegalStateException e) {
				log.error(e.getMessage());
				return null;
			} catch (IOException e) {
				log.error(e.getMessage());
				return null;
			}
		} // end for

		log.info("multiUpload에서 모두 set된 attachFileVOList: " + attachFileVOList);
		// TB_ATTACH_FILE 테이블에 insert
		tbAttachFileMapper.attachFileMultiRegist(attachFileVOList);
		
		return attachFileVOList;
	}

	// 5) 단일업로드 처리(전사적 코드, 등록자 아이디, 파일객체)
	public String singleUpload(String fileCode, String regUserId, MultipartFile file) {
		// uploadFolder가 없는 경우
		if(uploadFolder==null) {
			uploadFolder = "D:\\mytool\\sts3WS\\202303F_Team1\\src\\main\\webapp\\resources\\upload";
		}
		
		// 업로드 경로(upload 폴더까지의 경로/연/월/일) 처리
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("uploadPath : " + uploadPath);
		// 만약 해당 연/월/일 폴더가 없으면 생성
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		log.info("--------------------------");
		log.info("파일명 : " + file.getOriginalFilename());
		log.info("파일크기 : " + file.getSize());
		log.info("MIME타입 : " + file.getContentType());
		String uploadFileName = file.getOriginalFilename();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

		// ------------------ 같은날 같은 이미지를 업로드 시 파일 중복 방지 시작 ------------------
		UUID uuid = UUID.randomUUID();

		uploadFileName = uuid.toString() + "_" + uploadFileName;
		// ------------------ 같은날 같은 이미지를 업로드 시 파일 중복 방지 끝 ------------------

		// File 객체 설계(복사할 대상 경로, 파일명)
		File saveFile = new File(uploadPath, uploadFileName);
		// 파일 웹 경로
		String result = "";

		try {
			file.transferTo(saveFile);
			
			result = "\\" + getFolder() + "\\" + uploadFileName;
			result = result.replace("\\", "/");

			// ----------썸네일 처리 시작-----------------
			// 이미지인지 체킹
//			if (checkImageType(saveFile)) {
//				// ... upload\\2023\\08\\08 \\ s_asdfasdf_개똥이.jpg
//				// 설계
//				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
//				// 썸네일 생성(원본,설계,가로크기,세로크기)
//				Thumbnailator.createThumbnail(picture.getInputStream(), thumbnail, 100, 100);
//				thumbnail.close();
//			}
			// ----------썸네일 처리 끝-----------------
			
			//---------------TB_ATTACH_FILE 테이블에 insert 시작---------------
			AttachFileVO attachFileVO = new AttachFileVO();
			attachFileVO.setFileCode(fileCode);
			attachFileVO.setFileName(file.getOriginalFilename());
			attachFileVO.setFileSaveName(uploadFileName);
			attachFileVO.setFilePhysicPath(uploadPath + "\\" + uploadFileName);
			attachFileVO.setFileWebPath(result);
			attachFileVO.setFileSize(file.getSize());
			attachFileVO.setFileContType(file.getContentType());
			attachFileVO.setRegUserId(regUserId);
			
			log.info("singleUpload에 set 된 attachFileVO : " + attachFileVO);
			
			// TB_ATTACH_FILE 테이블에 insert
			tbAttachFileMapper.attachFileRegist(attachFileVO);
			
			//-----------------TB_ATTACH_FILE 테이블에 insert 끝-----------------
			
		} catch (IllegalStateException e) {
			log.error(e.getMessage());
			return "0";
		} catch (IOException e) {
			log.error(e.getMessage());
			return "0";
		}

		return result;
	}

	// 파일객체를 던지면 Full경로 + 파일명 리턴 (중호쌤이 단톡에 올려주신 것)
	public String getFileUrl(MultipartFile picture) {

		// c:\\img\\개똥이.jpg => 개똥이.jpg
		String uploadFileName = picture.getOriginalFilename();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

		// ------------------ 같은날 같은 이미지를 업로드 시 파일 중복 방지 시작 ------------------
		
		UUID uuid = UUID.randomUUID(); // 임의의 값 생성
		
		// 원래의 파일 이름과 구분하기 위해 _를 붙임 ex) asdfg_개똥이.jpg
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		// ------------------ 같은날 같은 이미지를 업로드 시 파일 중복 방지 끝 ------------------

		// ... \\2023\\08\\08\\s_asdfasdf_개똥이.jpg
		String result = "\\" + getFolder() + "\\" + uploadFileName;
		result = result.replace("\\", "/"); // /2023/08/08/asdfasdf_개똥이.jpg
		return result;
	}
	
	// 파일 다운로드 (중호쌤이 단톡에 올려주신 것)
	// localhost/upload/download?fileName=2022/07/25/cd862ebd-10a2-4220-bbbb-5bbf8ffdadd7_phone01.jpg
	@ResponseBody
	@GetMapping("/download")
	public ResponseEntity<Resource> download(@RequestParam String fileName){
		log.info("넘어온 fileName : " + fileName);
	
		// resource : 다운로드 받을 파일(자원)
		Resource resource = new FileSystemResource( // FileSystemResource: 절대경로 등 파일시스템에서 리소스를 찾는 방식
			uploadFolder + "\\" + fileName
		);
	  	// cd862ebd-10a2-4220-bbbb-5bbf8ffdadd7_phone01.jpg
		String resourceName = resource.getFilename();
		// header : 인코딩 정보, 파일명 정보
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition", "attachment;filename="+
					new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			log.info(e.getMessage());
		}
			return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		}
	}