package kr.or.ddit.item.service;

import java.util.List;

import kr.or.ddit.item.vo.ItemOrderVO;
import kr.or.ddit.item.vo.ItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemOrderVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;

public interface itemOrderService {
	
	// select 약품리스트
	public List<MediItemReqDetailVO> getMediItemList();
	
	// select 비품리스트
	public List<ItemReqDetailVO> getEquipItemList();

	// select 약품리스트에 있는 거래처명
	public List<MediItemReqDetailVO> getMediCompanyName();

	// select 비품리스트에 있는 거래처명
	public List<ItemReqDetailVO> getItemCompanyName();
	
	// select 거래처별 약품리스트
	public List<MediItemReqDetailVO> mediItemByCompany(String companyName);
	
	// select 거래처별 비품리스트
	public List<ItemReqDetailVO> equipItemByCompany(String companyName);
	
	// select 다음에 들어갈 약품 발주 번호
	public String getMediOrderNum();
	
	// select 다음에 들어갈 비품 발주 번호
	public String getEquipOrderNum();
	
	// update 약품상태 승인
	public int approveMedi(MediItemReqDetailVO mediItemReqDetailVO);
	
	// update 비품상태 승인
	public int approveEquip(ItemReqDetailVO itemReqDetailVO);
	
	// update 약품 재고 늘리기
	public int addMediInventory(MediItemReqDetailVO mediItemReqDetailVO);
	
	// update 비품 재고 늘리기
	public int addEquipInventory(ItemReqDetailVO itemReqDetailVO);
	
	// insert 약품 발주정보
	public int insertMediOrder(MediItemOrderVO mediItemOrderVO);
	
	// insert 비품 발주정보
	public int insertEquipOrder(ItemOrderVO itemOrderVO);
	
	// select 약품 반려리스트
	public MediItemReqDetailVO rejectMediList(MediItemReqDetailVO mediItemReqDetailVO);
	
	// select 비품 반려리스트
	public ItemReqDetailVO rejectEquipList(ItemReqDetailVO itemReqDetailVO);
	
	// update 약품 반려사유
	public int rejectReasonMedi(MediItemReqDetailVO mediItemReqDetailVO);
	
	// update 약품 반려
	public int rejectMedi(MediItemReqDetailVO mediItemReqDetailVO);
	
	// update 비품 반려사유
	public int rejectReasonEquip(ItemReqDetailVO itemReqDetailVO);
	
	// update 비품 반려
	public int rejectEquip(ItemReqDetailVO itemReqDetailVO);
	
	// select 약품 발주내역
	public List<MediItemOrderVO> getMediOrderList();
	
	// select 비품 발주내역
	public List<ItemOrderVO> getEquipOrderList();
	
	// select 약품 발주 상세
	public List<MediItemOrderVO> getMediOrderDetail(String orderNo);
	
	// select 비품 발주 상세
	public List<ItemOrderVO> getEquipOrderDetail(String orderNo);
	
}
