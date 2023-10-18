package kr.or.ddit.item.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.mapper.TbAttachFileMapper;
import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.item.service.itemOrderService;
import kr.or.ddit.item.vo.ItemOrderVO;
import kr.or.ddit.item.vo.ItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemOrderVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/order")
public class ItemOrderController {
	
	@Autowired
	private itemOrderService service;
	@Autowired
	private TbAttachFileMapper fileMapper; // pdf 파일 저장
	
	// [view] 약품 메인 view
	@GetMapping(value="/mediItem")
	public String getMediItemView() {
		log.info("<<< 여기는 getMediItemView >>>");
		
		return "order/mediItem";
	}
	
	// [view] 비품 메인 view
	@GetMapping(value="/equipItem")
	public String getEquipItemView() {
		log.info("<<< 여기는 getEquipItemView >>>");
		
		return "order/equipItem";
	}
	
	// [select List] 약품 신청 조회
	@ResponseBody
	@GetMapping(value="/mediList", produces="application/json; charset=utf-8")
	public List<MediItemReqDetailVO> getMediItemList() {
		log.info("<<< 여기는 getMediItemList >>>");
		
		List<MediItemReqDetailVO> mediItemList = service.getMediItemList();
		return mediItemList; 
	}
	
	// [select List] 비품 신청 조회
	@ResponseBody
	@GetMapping(value="/equipList", produces="application/json; charset=utf-8")
	public List<ItemReqDetailVO> getEquipItemList() {
		log.info("<<< 여기는 getEquipItemList >>>");
		
		List<ItemReqDetailVO> equipItemList = service.getEquipItemList();
		
		return equipItemList;
	}
	
	// [select] 약품리스트에 있는 거래처 조회 (발주모달의 select option)
	@ResponseBody
	@GetMapping(value="/mediCompanyList", produces="application/json; charset=utf-8")
	public List<MediItemReqDetailVO> getMediCompanyName() {
		log.info("<<< 여기는 getCompanyName >>>");
		
		List<MediItemReqDetailVO> companyList = service.getMediCompanyName();
		return companyList;
	}
	
	// [select] 비품리스트에 있는 거래처 조회 (발주모달의 select option)
	@ResponseBody
	@GetMapping(value="/equipCompanyList", produces="application/json; charset=utf-8")
	public List<ItemReqDetailVO> getItemCompanyName() {
		log.info("<<< 여기는 getItemCompanyName >>>");
		
		List<ItemReqDetailVO> companyList = service.getItemCompanyName();
		return companyList;
	}
	
	// [select] 거래처별 약품리스트 (발주모달의 table)
	@ResponseBody
	@GetMapping(value="/mediListByCompany/{companyName}", produces="application/json; charset=utf-8")
	public List<MediItemReqDetailVO> mediItemByCompany(@PathVariable String companyName) {
		log.info("<<< 여기는 mediItemByCompany >>>");
		
		List<MediItemReqDetailVO> listByCompany = service.mediItemByCompany(companyName);
		
		return listByCompany;
	}
	
	// [select] 거래처별 비품리스트 (발주모달의 table)
	@ResponseBody
	@GetMapping(value="/equipListByCompany/{companyName}", produces="application/json; charset=utf-8")
	public List<ItemReqDetailVO> equipItemByCompany(@PathVariable String companyName) {
		log.info("<<< 여기는 mediItemByCompany >>>");
		
		List<ItemReqDetailVO> listByCompany = service.equipItemByCompany(companyName);
		
		return listByCompany;
	}
	
	// [update] 약품 발주 승인
	@ResponseBody
	@Transactional
	@PutMapping(value="/approveMedi", produces="application/json; charset=utf-8")
	public int approveMedi(@RequestBody List<MediItemReqDetailVO> mediArray, Principal principal) {
		log.info("<<< 여기는 approveMedi >>>");

		int result = 0;
		String nextNo = service.getMediOrderNum();
		String empNo = principal.getName();
		
		// 하나의 발주번호를 insert
		MediItemOrderVO mediVO = new MediItemOrderVO();
		mediVO.setEmpNo(empNo);
		mediVO.setMediItemOrderNo(nextNo);
		result += service.insertMediOrder(mediVO);
		
		for(int i=0; i<mediArray.size(); i++) {
//			log.info("mediArray[" + i + "]: " + mediArray.get(i));
			mediArray.get(i).setMediItemOrderNo(nextNo);
//			log.info("controller에서 모두 set한 vo: " + mediArray.get(i));
			// 발주 승인
			result += service.approveMedi(mediArray.get(i));
			result += service.addMediInventory(mediArray.get(i));
		}
		
		return result;
	}
	
	// [update] 비품 발주 승인
	@Transactional
	@ResponseBody
	@PutMapping(value="/approveEquip", produces="application/json; charset=utf-8")
	public int approveEquip(@RequestBody List<ItemReqDetailVO> equipArray, Principal principal) {
		log.info("<<< 여기는 approveEquip >>>");
		
		int result = 0;
		String nextNo = service.getEquipOrderNum();
		String empNo = principal.getName();
		
		// 발주테이블에 insert
		ItemOrderVO equipVO = new ItemOrderVO();
		equipVO.setEmpNo(empNo);
		equipVO.setItemOrderNo(nextNo);
		result += service.insertEquipOrder(equipVO);
		
		for(int i=0; i<equipArray.size(); i++) {
			equipArray.get(i).setItemOrderNo(nextNo);
			result += service.approveEquip(equipArray.get(i));
			result += service.addEquipInventory(equipArray.get(i));
		}
		return result;
	}
	
	// [select] 약품 상세조회
	@ResponseBody
	@PostMapping(value="/rejectMediList", produces="application/json; charset=utf-8")
	public List<MediItemReqDetailVO> rejectMediList(@RequestBody List<MediItemReqDetailVO> mediArray) {
		log.info("<<< 여기는 rejectMediList >>>");
		List<MediItemReqDetailVO> mediList = new ArrayList<MediItemReqDetailVO>();
		MediItemReqDetailVO mediVO = new MediItemReqDetailVO();
		
		for(int i=0; i<mediArray.size(); i++) {
//			log.info("mediArray[" + i + "]: " + mediArray);
			mediVO = service.rejectMediList(mediArray.get(i));
//			log.info(i + "번째 MediVO: " + mediVO);
			mediList.add(mediVO);
		}
		return mediList;
	}
	
	// [select] 비품 상세조회
	@ResponseBody
	@PostMapping(value="/rejectEquipList", produces="application/json; charset=utf-8")
	public List<ItemReqDetailVO> rejectEquipList(@RequestBody List<ItemReqDetailVO> equipArray) {
		log.info("<<< 여기는 rejectEquipList >>>");
		List<ItemReqDetailVO> equipList = new ArrayList<ItemReqDetailVO>();
		ItemReqDetailVO equipVO = new ItemReqDetailVO();
		
		for(int i=0; i<equipArray.size(); i++) {
			log.info("equipArray[" + i + "]: " + equipArray);
			equipVO = service.rejectEquipList(equipArray.get(i));
			equipList.add(equipVO);
		}
		return equipList;
	}
	
	// [update] 약품 발주 반려
	@ResponseBody
	@PutMapping(value="/rejectMedi", produces="application/json; charset=utf-8")
	public int rejectMedi(@RequestBody List<MediItemReqDetailVO> mediArray) {
		log.info("<<< 여기는 rejectMedi >>>");
		int result = 0;
		
		for(int i=0; i<mediArray.size(); i++) {
			log.info("mediArray[" + i + "]: " + mediArray.get(i));
			result += service.rejectReasonMedi(mediArray.get(i));
			result += service.rejectMedi(mediArray.get(i));
		}
		return result;
	}
	
	// [update] 약품 발주 반려
	@ResponseBody
	@PutMapping(value="/rejectEquip", produces="application/json; charset=utf-8")
	public int rejectEquip(@RequestBody List<ItemReqDetailVO> equipArray) {
		log.info("<<< 여기는 rejectEquip >>>");
		int result = 0;
		
		for(int i=0; i<equipArray.size(); i++) {
			log.info("equipArray[" + i + "]" + equipArray.get(i));
			result += service.rejectReasonEquip(equipArray.get(i));
			result += service.rejectEquip(equipArray.get(i));
		}
		return result;
	}
	
	// [view] 발주 내역 
	@GetMapping("/detail")
	public String getDetailView() {
		log.info("<<< 여기는 getDetailView >>>");
		
		return "order/detail";
	}
	
	// [select] 약품 발주리스트
	@ResponseBody
	@GetMapping(value="/mediOrderList", produces="application/json; charset=utf-8")
	public List<MediItemOrderVO> getMediOrderList() {
		log.info("<<< 여기는 getMediOrderList >>>");
		
		List<MediItemOrderVO> mediOrderList = service.getMediOrderList();
//		log.info("mediOrderList는 " + mediOrderList);
		
		return mediOrderList;
	}
	
	// [select] 비품 발주리스트
	@ResponseBody
	@GetMapping(value="/equipOrderList", produces="application/json; charset=utf-8")
	public List<ItemOrderVO> getEquipItemOrderList() {
		log.info("<<< 여기는 getEquipItemOrderList >>>");
		
		List<ItemOrderVO> equipOrderList = service.getEquipOrderList();
		
		return equipOrderList;
	}
	
	// [select] 발주서에 들어갈 약품발주 상세내용
	@ResponseBody
	@GetMapping(value="/mediOrderDetail/{orderNo}", produces="application/json; charset=utf-8")
	public List<MediItemOrderVO> getMediOrderDetail(@PathVariable String orderNo) {
		log.info("<<< 여기는 getMediOrderDetail >>>");
		
		List<MediItemOrderVO> mediItemDetail = service.getMediOrderDetail(orderNo);
		log.info("mediItemOrderVO는? ", mediItemDetail);
		
		return mediItemDetail;
	}
	
	// [select] 발주서에 들어갈 비품발주 상세내용
	@ResponseBody
	@GetMapping(value="/equipOrderDetail/{orderNo}", produces="application/json; charset=utf-8")
	public List<ItemOrderVO> getEquipOrderDetail(@PathVariable String orderNo) {
		log.info("<<< 여기는 getEquipOrderDetail >>>");
		
		List<ItemOrderVO> itemOrderDetail = service.getEquipOrderDetail(orderNo);
		log.info("itemOrderVO는?" + itemOrderDetail);
		
		return itemOrderDetail;
	}
	
	// [download] pdf 다운로드
	@ResponseBody
	@PostMapping(value="/pdf", produces="application/json; charset=utf-8")
	public String pdfDownload(MultipartFile pdfFile, String orderNo, String fileName, Principal principal) throws Exception {
		log.info("orderNo가 안들어가나? " + orderNo);
		
		log.debug("이름: {}", pdfFile.getName()); // pdfFile
		log.debug("리소스: {}", pdfFile.getResource()); // MultipartFile resource [pdfFile]
		log.debug("타입: {}", pdfFile.getContentType()); // application/pdf
		log.debug("사이즈: {}", pdfFile.getSize()); // 3570300
		log.debug("파일네임: {}", pdfFile.getOriginalFilename()); // blob

		log.debug("fileName" + fileName);
		String savePath = "d:/myTool/sts3WS/202303F_Team1/src/main/webapp/resources/upload/pdf/" + fileName;
		log.info("savePath" + savePath);
		pdfFile.transferTo(new File(savePath));
		
		// AttachFileVO에 값 세팅
		AttachFileVO attachFileVO = new AttachFileVO();
		attachFileVO.setFileCode(orderNo);
		attachFileVO.setFileName(fileName);
		attachFileVO.setFilePhysicPath(savePath);
		attachFileVO.setFileWebPath("/pdffiles/" + fileName);
		attachFileVO.setFileSize(pdfFile.getSize());
		attachFileVO.setFileContType(pdfFile.getContentType());
		attachFileVO.setRegUserId(principal.getName());
		
		log.info("attachFileVO는!!! " + attachFileVO);

		// TB_ATTACH_FILE 테이블에 insert
		fileMapper.attachFileRegist(attachFileVO);
		
		return "/pdf/" + fileName;
	}
}
