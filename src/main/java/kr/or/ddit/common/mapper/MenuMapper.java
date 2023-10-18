package kr.or.ddit.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.MenuVO;

@Mapper
public interface MenuMapper {
	public List<MenuVO> getMenuList(MenuVO menuVO);
}
