package kr.or.ddit.item.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.item.mapper.ItemOrderMapper;
import kr.or.ddit.item.service.itemOrderService;
import kr.or.ddit.item.vo.ItemOrderVO;
import kr.or.ddit.item.vo.ItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemOrderVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class itemOrderServiceImpl implements itemOrderService {

	@Autowired
	private ItemOrderMapper mapper;
	
	@Override
	public List<MediItemReqDetailVO> getMediItemList() {
		return mapper.getMediItemList();
	}
	
	@Override
	public List<ItemReqDetailVO> getEquipItemList() {
		return mapper.getEquipItemList();
	}

	@Override
	public List<MediItemReqDetailVO> getMediCompanyName() {
		return mapper.getMediCompanyName();
	}
	
	@Override
	public List<ItemReqDetailVO> getItemCompanyName() {
		return mapper.getItemCompanyName();
	}
	
	@Override
	public List<MediItemReqDetailVO> mediItemByCompany(String companyName) {
		return mapper.mediItemByCompany(companyName);
	}

	@Override
	public List<ItemReqDetailVO> equipItemByCompany(String companyName) {
		return mapper.equipItemByCompany(companyName);
	}

	@Override
	@Transactional
	public int approveMedi(MediItemReqDetailVO mediItemReqDetailVO) {
		return mapper.approveMedi(mediItemReqDetailVO);
	}

	@Override
	@Transactional
	public int approveEquip(ItemReqDetailVO itemReqDetailVO) {
		return mapper.approveEquip(itemReqDetailVO);
	}

	@Override
	public int rejectReasonMedi(MediItemReqDetailVO mediItemReqDetailVO) {
		return mapper.rejectReasonMedi(mediItemReqDetailVO);
	}
	
	@Override
	public int rejectMedi(MediItemReqDetailVO mediItemReqDetailVO) {
		return mapper.rejectMedi(mediItemReqDetailVO);
	}

	@Override
	public int rejectReasonEquip(ItemReqDetailVO itemReqDetailVO) {
		return mapper.rejectReasonEquip(itemReqDetailVO);
	}
	
	@Override
	public int rejectEquip(ItemReqDetailVO itemReqDetailVO) {
		return mapper.rejectEquip(itemReqDetailVO);
	}

	@Override
	public MediItemReqDetailVO rejectMediList(MediItemReqDetailVO mediItemReqDetailVO) {
		return mapper.rejectMediList(mediItemReqDetailVO);
	}

	@Override
	public ItemReqDetailVO rejectEquipList(ItemReqDetailVO itemReqDetailVO) {
		return mapper.rejectEquipList(itemReqDetailVO);
	}

	@Override
	public String getMediOrderNum() {
		return mapper.getMediOrderNum();
	}

	@Override
	public String getEquipOrderNum() {
		return mapper.getEquipOrderNum();
	}

	@Override
	public int insertMediOrder(MediItemOrderVO mediItemOrderVO) {
		return mapper.insertMediOrder(mediItemOrderVO);
	}

	@Override
	public int insertEquipOrder(ItemOrderVO itemOrderVO) {
		return mapper.insertEquipOrder(itemOrderVO);
	}

	@Override
	public List<MediItemOrderVO> getMediOrderList() {
		return mapper.getMediOrderList();
	}

	@Override
	public List<ItemOrderVO> getEquipOrderList() {
		return mapper.getEquipOrderList();
	}

	@Override
	public List<MediItemOrderVO> getMediOrderDetail(String orderNo) {
		return mapper.getMediOrderDetail(orderNo);
	}

	@Override
	public List<ItemOrderVO> getEquipOrderDetail(String orderNo) {
		return mapper.getEquipOrderDetail(orderNo);
	}

	@Override
	public int addMediInventory(MediItemReqDetailVO mediItemReqDetailVO) {
		return mapper.addMediInventory(mediItemReqDetailVO);
	}

	@Override
	public int addEquipInventory(ItemReqDetailVO itemReqDetailVO) {
		return mapper.addEquipInventory(itemReqDetailVO);
	}

}
