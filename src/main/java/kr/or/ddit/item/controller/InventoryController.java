 package kr.or.ddit.item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.item.service.InventoryService;
import kr.or.ddit.item.vo.ItemListVO;
import kr.or.ddit.item.vo.MediItemListVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemRequestVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/item")
public class InventoryController {
	@Autowired
	InventoryService inventoryService;

	@GetMapping("/Inventory")
	public String getInventory() {
		return "nurse/Inventory";
	}
	@GetMapping("/test")
	public String test () {
		return"nurse/test";
	}

	@GetMapping("/InventorymediList")
	@ResponseBody
	public List<MediItemListVO> getmediItemList() {
		List<MediItemListVO> milVO = inventoryService.selectAllmediItem();
		log.debug(milVO.toString());
		return milVO;
	}

	@GetMapping("/InventoryitemList")
	@ResponseBody
	public List<ItemListVO> getItemList() {
		List<ItemListVO> IlVO = inventoryService.selectAllItemList();
		log.debug("IlVO : " + IlVO.toString());
		return IlVO;

	}

	@GetMapping("/InventorySearchItem")
	@ResponseBody
	public List<ItemListVO> getsearchItem(ItemListVO searchCond) {

		log.debug("searchCode: {}",searchCond);
		List<ItemListVO> itemListVOList = inventoryService.searchItem(searchCond);
		log.debug("itemListVOList : " + itemListVOList.toString());
		return itemListVOList;

	}

	@GetMapping("/InventorySearchMediItem")
	@ResponseBody
	public List<MediItemListVO> getsearchMediItem(MediItemListVO searchCond) {

		log.debug("searchCode: {}",searchCond);
		List<MediItemListVO> mediItemListVOList = inventoryService.searchMediItem(searchCond);
		log.debug("mediItemListVOList : " + mediItemListVOList.toString());
		return mediItemListVOList;

	}

	@GetMapping("/InventoryInsertItemName")
	@ResponseBody
	public ItemListVO getItemName(@RequestParam("code") String itemCode) {
		log.debug("체크", itemCode);
		ItemListVO itemListVO = inventoryService.insertItemName(itemCode);
		log.debug("itemListVO : ",itemListVO);

		return itemListVO;
	}
	@GetMapping("/InventoryInsertmediItemName")
	@ResponseBody
	public MediItemListVO getmediItemName(@RequestParam("code") String mediItemCode) {
		log.debug("체크", mediItemCode);
		MediItemListVO mediItemListVO = inventoryService.insertMediItemName(mediItemCode);
		log.debug("mediItemListVO : ",mediItemListVO);

		return mediItemListVO;
	}


}











