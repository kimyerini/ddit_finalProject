package kr.or.ddit.item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.item.service.itemRequestService;
import kr.or.ddit.item.vo.ItemReqDetailVO;
import kr.or.ddit.item.vo.ItemReqVO;
import kr.or.ddit.item.vo.ItemWaitingListVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemRequestVO;
import kr.or.ddit.item.vo.MediItemWaitingListVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/item")
public class ItemRequestController {
	@Autowired
	itemRequestService itemRequestService;
	
	@GetMapping("/itemRequest")
	public String getitemOrder() {
		return "nurse/itemRequest";
	}
	// <input type="text" name="mediItemReqDetailVOList[0].mediItemCode" value="52400801" />
	// <input type="text" name="mediItemReqDetailVOList[0].mediItemReqQy" value="2" />
	// <input type="text" name="mediItemReqDetailVOList[1].mediItemCode" value="622700220" />
	// <input type="text" name="mediItemReqDetailVOList[1].mediItemReqQy" value="1" />
	//약품발주 신청
	@ResponseBody
	@PostMapping("/insertTbMediItemRequest")
	public String insertTbMediItemRequest( MediItemRequestVO mediItemRequestVO) {
		//MediItemRequestVO(mediItemReqNo=0, mediItemReqDe=null, mediItemReqSt=null, empNo=null, 
		//	mediItemReqDetailVOList=[
		//			MediItemReqDetailVO(mediItemReqNo=0, mediItemCode=52400801, mediItemReqQy=1, mediItemReqTotal=0), 
		//			MediItemReqDetailVO(mediItemReqNo=0, mediItemCode=640900630, mediItemReqQy=2, mediItemReqTotal=0), 
		//			MediItemReqDetailVO(mediItemReqNo=0, mediItemCode=641105900, mediItemReqQy=3, mediItemReqTotal=0)])
		mediItemRequestVO.setEmpNo(mediItemRequestVO.getMediItemReqDetailVOList().get(0).getEmpNo());
		log.info("insertTbMediItemRequest->mediItemRequestVO : " + mediItemRequestVO);
		
		
		int result = this.itemRequestService.insertMediItemRequest(mediItemRequestVO);
		
		log.info("result : " + result);
		
		return "success";
	}
	
	
	@ResponseBody
	@PostMapping("/insertTbItemRequest") 
	public String insertTbItemRequest(@RequestBody ItemReqVO itemReqVO) {
		/*
		ItemReqVO(itemReqNo=0, itemReqSt=null, itemReqDe=null, empNo=null, 
		itemReqDetailVOList=[ItemReqDetailVO(itemReqNo=0, itemCode=BP001, itemReqQy=1, itemReqTotal=0), 
		ItemReqDetailVO(itemReqNo=0, itemCode=BP002, itemReqQy=2, itemReqTotal=0), 
		ItemReqDetailVO(itemReqNo=0, itemCode=BP006, itemReqQy=3, itemReqTotal=0)])
		 */
		
		log.debug("온거 확인: {}",itemReqVO);
		
		//itemReqVO.setEmpNo(itemReqVO.getItemReqDetailVOList().get(0).getEmpNo());
		log.info("insertTbItemRequest->itemReqVO : " + itemReqVO);
		
		int result = this.itemRequestService.insertItemRequest(itemReqVO);
		
		log.info("result : " + result);
		
		return "success"; 
	}
	
	@PostMapping("/mediItemWaitingList")
	@ResponseBody
	public List<MediItemWaitingListVO> getselectWaitingmediList(@RequestBody(required = false) MediItemWaitingListVO search) {
		log.debug("search약품 -->>"+search);
		List<MediItemWaitingListVO> mediWaitingListVO = itemRequestService.selectWaitingmediList(search);
		log.debug(mediWaitingListVO.toString());
		return mediWaitingListVO;
	}
	
	@PostMapping("/ItemWaitingList")
	@ResponseBody
	public List<ItemWaitingListVO> getselectWaitingItemList(@RequestBody(required = false) ItemWaitingListVO search){
		log.debug("search비품 -->>"+search);
		List<ItemWaitingListVO> itemWaitingListVO = itemRequestService.selectWatitingItemList(search);
		log.debug(itemWaitingListVO.toString());
		return itemWaitingListVO;
	}
	//public MediItemRequestVO selectWaitingUpdateList(MediItemRequestVO mediItemRequestVO);

	// /selectWaitingUpdate
	// {mediItmeReqNo=63}
	@ResponseBody
	@PostMapping("/selectMediWaitingUpdate") 
	public List<MediItemRequestVO> getselectWaitingUpdateList(@RequestBody MediItemRequestVO mediItemRequestVO) {
		List<MediItemRequestVO> mediItemReqVoList = itemRequestService.selectWaitingUpdateList(mediItemRequestVO);
		log.info("getselectWaitingUpdateList->mediItemRequestVO : "+ mediItemReqVoList );
		return mediItemReqVoList;
	}
	//비품 상세 보기
	@ResponseBody
	@PostMapping("/selectItemWaitingUpdate")//
	public List<ItemReqVO> getSelectWaitingUpdateItemList(@RequestBody ItemReqVO itemReqVO) {
		log.info(itemReqVO.toString());
		List<ItemReqVO> itemReqVOList = itemRequestService.selectWaitingUpdateItemList(itemReqVO);
		log.info("getSelectWaitingUpdateItemList->itemReqVO : "+ itemReqVOList );
		return itemReqVOList;
	}
	
	
	@ResponseBody
	@PostMapping("/updateMediItemQy")
	public int getupdateMediItemQy(@RequestBody  MediItemReqDetailVO mediItemReqDetailVO) {
		log.info("mediItemReqDetailVO 나오냐? :"+mediItemReqDetailVO);
		int mvo = itemRequestService.updateMediItemQy(mediItemReqDetailVO);
		
		log.info("나오냐아????? : "+mvo);
		return mvo;
	}
	
	@ResponseBody
	@PostMapping("/updateItemQy")
	public int getupdateItemQy(@RequestBody ItemReqDetailVO itemReqDetailVO) {
		log.info("itemReqDetailVO 나오냐? :"+itemReqDetailVO);
		int ivo = itemRequestService.updateItemQy(itemReqDetailVO);
		
		log.info("나오냐아?????ItemUpdate : "+ivo);
		return ivo;
	}
	

	@ResponseBody
	@PostMapping ("/deleteMediItemDatail")
	public int deleteMediItemDatail(@RequestBody MediItemReqDetailVO mediItemReqDetailVO) {
		log.info("지우려고 하는데 ~~~datail" + mediItemReqDetailVO);
		
		int deleteMedi = itemRequestService.deleteMediItemDatail(mediItemReqDetailVO);
		log.info("나와라~~~~~~~좀 " + deleteMedi);
		return deleteMedi;
	}
	
	@ResponseBody
	@PostMapping ("/deleteItemDatail")
	public int deleteItemDatail(@RequestBody ItemReqDetailVO itemReqDetailVO) {
		log.info("지우려고 하는데 ~~~datail item 왜 안지워지냐" + itemReqDetailVO);
		
		int deleteItem = itemRequestService.deleteItemDatail(itemReqDetailVO);	

		log.info("나와라~~~~~~~좀 item" + deleteItem);
		return deleteItem;
	}
	
}
