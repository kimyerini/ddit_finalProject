package kr.or.ddit.common.service;

import java.util.List;

import kr.or.ddit.common.vo.MenuVO;

public interface MenuService {
	public List<MenuVO> getMenuList(MenuVO menuVO);
}
