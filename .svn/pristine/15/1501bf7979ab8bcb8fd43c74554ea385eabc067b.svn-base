package kr.or.ddit.item.service;

import java.util.List;

import kr.or.ddit.item.vo.ItemReqDetailVO;
import kr.or.ddit.item.vo.ItemReqVO;
import kr.or.ddit.item.vo.ItemWaitingListVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemRequestVO;
import kr.or.ddit.item.vo.MediItemWaitingListVO;

public interface itemRequestService {
	
	// 약품 신청
	public int insertMediItemRequest(MediItemRequestVO mediItemRequestVO);
	//비품 신청
	public int insertItemRequest(ItemReqVO itemReqVO);

	//신청 대기 목록 조회 
	public List<MediItemWaitingListVO> selectWaitingmediList(MediItemWaitingListVO search);
	public List<ItemWaitingListVO> selectWatitingItemList(ItemWaitingListVO search);
	
	public List<MediItemRequestVO> selectWaitingUpdateList(MediItemRequestVO mediItemRequestVO);
	public List<ItemReqVO> selectWaitingUpdateItemList(ItemReqVO itemReqVO);

	public int updateMediItemQy(MediItemReqDetailVO mediItemReqDetailVO);
	public int updateItemQy(ItemReqDetailVO itemReqDetailVO);
	
    public int deleteMediItemDatail(MediItemReqDetailVO mediItemReqDetailVO);
    
    public int deleteItemDatail(ItemReqDetailVO itemReqDetailVO);
    
    
}	 
