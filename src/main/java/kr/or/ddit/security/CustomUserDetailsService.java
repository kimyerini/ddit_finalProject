package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.employee.mapper.EmployeeMapper;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("ckk{}"+username);
	
		EmployeeVO employeeVO = employeeMapper.selectEmployeeByNo(username);
		if(employeeVO != null) {
			log.info("체크크크크 : "+employeeVO.toString());
			return new CustomUser(employeeVO);
		}else {
			throw new UsernameNotFoundException(username);
		}
	}

}