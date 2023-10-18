package kr.or.ddit.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.common.vo.AttachFileVO;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Getter
public class CustomUser extends User {
	private static final long serialVersionUID = 1L;
	private EmployeeVO employee;
	
	public CustomUser(String username, String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
 
	public CustomUser(EmployeeVO vo) {
		super(vo.getEmpNo(), vo.getEmpPassword(), vo.getUserAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuthGrpCode())).collect(Collectors.toList()));
		this.employee = vo;

		String deptCode = employee.getDeptCode();

		switch (deptCode) {
		case "D001":
			vo.setComCodeName("의사");
			break;
			//comCodeName = "의사";
		case "D002":
			//comCodeName = "간호사";
			vo.setComCodeName("간호사");
			break;
		case "D003":
			//comCodeName = "원무과";
			vo.setComCodeName("원무과");
			break;
		case "D004":
			//comCodeName = "물리치료과";
			vo.setComCodeName("물리치료과");
			break;
		case "D005":
			//comCodeName = "영상의학과";
			vo.setComCodeName("영상의학과");
			break;
		case "D006":
			//comCodeName = "인사총무과";
			vo.setComCodeName("인사총무과");
			break;
		case "D000":
			vo.setComCodeName("행정관리자");
			break;
		case "D999":
			vo.setComCodeName("오더관리자");
			break;
		}
		
		
		
		
		
	}
}