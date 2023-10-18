package kr.or.ddit.common.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.mapper.MenuMapper;
import kr.or.ddit.common.service.MenuService;
import kr.or.ddit.common.vo.MenuVO;
@Service
public class MenuServiceImpl implements MenuService{
	@Autowired
	MenuMapper menuMapper;
		
	@Override
	public List<MenuVO> getMenuList(MenuVO menuVO) {
		return menuMapper.getMenuList(menuVO);
	}
}
