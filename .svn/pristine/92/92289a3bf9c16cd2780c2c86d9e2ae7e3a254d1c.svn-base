package kr.or.ddit.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.UserAuthoritiesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse res, Authentication auth)
			throws IOException, ServletException {
		log.info("auth success");
		log.info(auth.getName());
		log.info(auth.getAuthorities().toString());
		
		
		String referer = req.getHeader("Referer");  // 로그인 전  URL
		log.debug("체크:" + referer);
		
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		EmployeeVO employeeVO = customUser.getEmployee();
		
		String isFirst = employeeVO.getFirstLogin();   // Y or N
		List<UserAuthoritiesVO> authList = employeeVO.getUserAuthList();
		String authCode = authList.get(0).getAuthGrpCode();
		
		
		log.debug("첫번째 로그인 여부" + isFirst);
		String redirectURL = "/home";
		
		if(isFirst.equals("Y")) {
			redirectURL ="/emp/updatePwForm"; // 맞으면 비번 업데이트 진행
		}else { // 아니면 권한별로 페이지 이동
			switch (authCode) {
		        case "ROLE_ADMIN":
		        	redirectURL ="/office/main";
		            break;
		        case "ROLE_ORDER":
		        	redirectURL ="/nurse/treatment";
		        	break;
		        case "ROLE_DOCTOR":
		        	redirectURL ="/doctor/clinic";
		            break;
		        case "ROLE_NURSE":
		        	redirectURL ="/nurse/treatment";
		            break;
		        case "ROLE_OFFICE":           
		        	redirectURL ="/office/main";
		            break;
		        case "ROLE_HRD":           
		        	redirectURL ="/employee/index";
		            break;
		        case "ROLE_PHYSIO":           
		        	redirectURL ="/physio/main";
		            break;
		        case "ROLE_RADIO":           
		        	redirectURL ="/insp/insp";
		            break;
		        default:        
		        	redirectURL ="/emp/updatePwForm";
		            break;    
		    }
		}
		res.sendRedirect(redirectURL);
	}
}