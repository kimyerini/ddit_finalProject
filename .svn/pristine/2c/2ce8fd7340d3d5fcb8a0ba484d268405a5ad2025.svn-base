package kr.or.ddit.item.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.item.mapper.ItemRequestMapper;
import kr.or.ddit.item.service.itemRequestService;
import kr.or.ddit.item.vo.ItemReqDetailVO;
import kr.or.ddit.item.vo.ItemReqVO;
import kr.or.ddit.item.vo.ItemWaitingListVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemRequestVO;
import kr.or.ddit.item.vo.MediItemWaitingListVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class itemRequestServiceImpl implements itemRequestService {
	@Autowired
	private ItemRequestMapper itemRequestMapper;

	@Transactional
	@Override
	public int insertMediItemRequest(MediItemRequestVO mediItemRequestVO) {

		// 1) 부모(TB_MEDI_ITEM_REQUEST) insert : mediItemRequestVO 활용 => insert
		int result = this.itemRequestMapper.insertMediItemRequest(mediItemRequestVO); // 수정된 메서드 호출

		// 2) 자식들(TB_MEDI_ITEM_REQ_DETAIL) insert : List<MediItemReqDetailVO>
		// mediItemReqDetailVOList => insert all
		List<MediItemReqDetailVO> mediItemReqDetailVOList = mediItemRequestVO.getMediItemReqDetailVOList();
		log.info("쳌쳌" + mediItemRequestVO);
		for (MediItemReqDetailVO vo : mediItemReqDetailVOList) {
			vo.setMediItemReqNo(mediItemRequestVO.getMediItemReqNo());
		}
		log.info("췍2" + mediItemReqDetailVOList);
		// [MediItemReqDetailVO(mediItemReqNo=37, mediItemCode=641602350,
		// mediItemReqQy=53, mediItemReqTotal=0),
		// MediItemReqDetailVO(mediItemReqNo=37, mediItemCode=641602350,
		// mediItemReqQy=33, mediItemReqTotal=0)]
		log.info("insertMediItemRequest->mediItemReqDetailVOList : " + mediItemReqDetailVOList);
		result += this.itemRequestMapper.insertMediItemReqDetail(mediItemReqDetailVOList);
//		log.info("췍3" + mediItemReqDetailVOList);

		return result;
	}
	@Transactional
	@Override
	public int insertItemRequest(ItemReqVO itemReqVO) {
	      int result = this.itemRequestMapper.insertItemRequest(itemReqVO);
	      
	      List<ItemReqDetailVO> itemReqDetailVOList=  itemReqVO.getItemReqDetailVOList();
	      log.info("쳌쳌" + itemReqVO);
	      for(ItemReqDetailVO vo : itemReqDetailVOList) {
	    	 vo.setItemReqNo(itemReqVO.getItemReqNo());
	    	 log.info("이거 확인해보자 : " + vo);
	      }
	      log.info("췍2" + itemReqDetailVOList);
	      result += this.itemRequestMapper.insertItemReqDetail(itemReqDetailVOList);
	      return result;
	   }
	@Override
	public List<MediItemWaitingListVO> selectWaitingmediList(MediItemWaitingListVO search){
		return itemRequestMapper.selectWaitingmediList(search);
	}
	@Override
	public List<ItemWaitingListVO> selectWatitingItemList(ItemWaitingListVO search){
		return itemRequestMapper.selectWatitingItemList(search);
	}
	
	@Override
	public List<MediItemRequestVO> selectWaitingUpdateList(MediItemRequestVO mediItemRequestVO) {
	    return itemRequestMapper.selectWaitingUpdateList(mediItemRequestVO);
	}
	@Override
	public List<ItemReqVO> selectWaitingUpdateItemList(ItemReqVO itemReqVO) {
		return itemRequestMapper.selectWaitingUpdateItemList(itemReqVO);
	}
	@Override
	public int updateMediItemQy(MediItemReqDetailVO mediItemReqDetailVO) {
		return itemRequestMapper.updateMediItemQy(mediItemReqDetailVO);
	}
	@Override
	public int updateItemQy(ItemReqDetailVO itemReqDetailVO) {
		return itemRequestMapper.updateItemQy(itemReqDetailVO);
	}

	@Override
	public int deleteMediItemDatail(MediItemReqDetailVO mediItemReqDetailVO) {
	    // select Datail의 medi코드 갯수 구하기
	    int selectCount = itemRequestMapper.selectCountMediItemDatail(mediItemReqDetailVO);
	    log.info("갯수 나오냐 ~~~ : " + selectCount);

	    // 선택한 자식 테이블의 레코드를 삭제하는 로직을 추가
	    if (selectCount > 0) {
	        // 선택한 자식 테이블의 레코드를 삭제하는 메서드를 호출
	    	 int deletedRowCount = itemRequestMapper.deleteMediItemDatail(mediItemReqDetailVO);
	        // 삭제된 레코드 수에 따라 결과 반환
	        if (deletedRowCount > 0) {
	            return 1; // 삭제 성공

	    }

	    // 만약 Datail의 코드 갯수가 0 이면 부모테이블 request도 삭제
	    if (selectCount == 0) {
	        MediItemRequestVO requestVO = new MediItemRequestVO();
	        requestVO.setMediItemReqNo(mediItemReqDetailVO.getMediItemReqNo());
	        itemRequestMapper.deleteMediItemRequest(requestVO);
	        log.info("부모테이블 뭐오냐~~~~~~ : " + requestVO);
	    }

	    }
	    return 0;

	}
	@Override
	public int deleteItemDatail(ItemReqDetailVO itemReqDetailVO) {
		 int selectItemCount = itemRequestMapper.selectCountItemDatail(itemReqDetailVO);
		 
		  log.info("갯수 나오냐 Item 22~~~ : " + selectItemCount);
		  if (selectItemCount > 0) {
			  int deletedRowCount= itemRequestMapper.deleteItemDatail(itemReqDetailVO);
			   if (deletedRowCount > 0) {
		            return 1; // 삭제 성공

		    }

		    if (selectItemCount == 0) {
		        ItemReqVO itemReqVO = new ItemReqVO();
		        itemReqVO.setItemReqNo(itemReqDetailVO.getItemReqNo());
		        itemRequestMapper.deleteItemRequest(itemReqVO);
		        log.info("부모테이블 뭐오냐222~~~~~~ : " + itemReqVO);
		    }

		    }
		    return 0;

	}
}