package kr.or.ddit.item.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.item.mapper.InventoryMapper;
import kr.or.ddit.item.service.InventoryService;
import kr.or.ddit.item.vo.ItemListVO;
import kr.or.ddit.item.vo.MediItemInventoryVO;
import kr.or.ddit.item.vo.MediItemListVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemRequestVO;

@Service
public class InventoryServiceImpl implements InventoryService{
	@Autowired
	private InventoryMapper inventoryMapper;
	
	@Override
	public List<MediItemListVO> selectAllmediItem(){
		return inventoryMapper.selectAllmediItem();
	}

	@Override
	public List<ItemListVO> selectAllItemList(){
		return inventoryMapper.selectAllItemList();
	}

	@Override
	public List<MediItemListVO> searchMediItem(MediItemListVO searchCond){
		return inventoryMapper.searchMediItem(searchCond);
	}

	@Override
	public List<ItemListVO> searchItem(ItemListVO searchCond) {
		return inventoryMapper.searchItem(searchCond );
	}
	@Override
	public MediItemListVO insertMediItemName(String code) {
		return inventoryMapper.insertMediItemName(code);
	}
	@Override
	public ItemListVO insertItemName(String code) {
		return inventoryMapper.insertItemName(code);
	}


	

	

	
}
