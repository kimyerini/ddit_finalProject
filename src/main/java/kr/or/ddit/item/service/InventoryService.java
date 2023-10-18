package kr.or.ddit.item.service;

import java.util.List;

import kr.or.ddit.item.vo.ItemListVO;
import kr.or.ddit.item.vo.MediItemListVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemRequestVO;

public interface InventoryService {
	
	public List<MediItemListVO> selectAllmediItem();
	public List<MediItemListVO> searchMediItem(MediItemListVO searchCond);
	
	public List<ItemListVO> selectAllItemList();
	public List<ItemListVO> searchItem(ItemListVO searchCond);
	public MediItemListVO insertMediItemName(String code);
	public ItemListVO insertItemName(String code);
	
}
