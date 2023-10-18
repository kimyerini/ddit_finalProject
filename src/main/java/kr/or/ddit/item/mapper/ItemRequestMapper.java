package kr.or.ddit.item.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.item.vo.ItemReqDetailVO;
import kr.or.ddit.item.vo.ItemReqVO;
import kr.or.ddit.item.vo.ItemWaitingListVO;
import kr.or.ddit.item.vo.MediItemReqDetailVO;
import kr.or.ddit.item.vo.MediItemRequestVO;
import kr.or.ddit.item.vo.MediItemWaitingListVO;

@Mapper
public interface ItemRequestMapper {
	
	//약품 신청 insert
	public int insertMediItemRequest(MediItemRequestVO mediItemRequestVO);
    public int insertMediItemReqDetail(List<MediItemReqDetailVO> mediItemReqDetailVOList);
    
    //비품 신청 insert
    public int insertItemRequest(ItemReqVO itemReqVO);
    public int insertItemReqDetail(List<ItemReqDetailVO> itemReqDetailVO);
    
    //약품 신청현황 List MediItemWaitingListVO.java
    public List<MediItemWaitingListVO> selectWaitingmediList(MediItemWaitingListVO search);
    //비품 신청 현황 List
    public List<ItemWaitingListVO> selectWatitingItemList(ItemWaitingListVO search);
    
    //<select id="selectWaitingUpdateList" resultMap="MediItemWaitingUpdateListMap" parameterType="mediItemRequestVO">
    public List<MediItemRequestVO> selectWaitingUpdateList(MediItemRequestVO mediItemRequestVO);
    public List<ItemReqVO> selectWaitingUpdateItemList(ItemReqVO itemReqVO);
    
    //약품 수정 update
    public int updateMediItemQy(MediItemReqDetailVO mediItemReqDetailVO);
    public int updateItemQy(ItemReqDetailVO itemReqDetailVO);
    //약품 삭제
    public int selectCountMediItemDatail(MediItemReqDetailVO mediItemReqDetailVO);
    public int deleteMediItemDatail(MediItemReqDetailVO mediItemReqDetailVO);
    public int deleteMediItemRequest(MediItemRequestVO mediItemRequestVO);
    
    public int selectCountItemDatail(ItemReqDetailVO itemReqDetailVO);
    public int deleteItemDatail(ItemReqDetailVO itemReqDetailVO);
    public int deleteItemRequest(ItemReqVO itemReqVO);
    
//    // search 약품
//    //<select id="searchRequestMedi" resultType="mediItemWaitingListVO">
//    public List<MediItemWaitingListVO> searchRequestMedi(MediItemWaitingListVO mediItemWaitingListVO);
    
}

