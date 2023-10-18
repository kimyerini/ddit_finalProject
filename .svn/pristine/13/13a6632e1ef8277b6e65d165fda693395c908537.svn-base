
package kr.or.ddit.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class socketController {
	
	@GetMapping("/socket")
	public String webSocket(HttpSession hSession) {
		hSession.setAttribute("myName", "suji");
		
		return "test/socket";
	}

	

}
