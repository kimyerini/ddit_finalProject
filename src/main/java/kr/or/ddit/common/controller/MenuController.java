package kr.or.ddit.common.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.service.MenuService;
import kr.or.ddit.common.vo.MenuVO;
import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
@RequestMapping("/menu")
public class MenuController {
	@Autowired
	MenuService menuService;
	
	@ResponseBody
	@GetMapping("/list/{authGrpCode}")
	public List<MenuVO> getMenuList(@PathVariable(value="authGrpCode") String authGrpCode){
		List<MenuVO> list = new ArrayList<MenuVO>();
		MenuVO menuVO = new MenuVO();
		menuVO.setAuthGrpCode(authGrpCode);
		list = menuService.getMenuList(menuVO);
		log.info(list.toString());
		return list;
	}
}
