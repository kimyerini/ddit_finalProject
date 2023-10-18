package kr.or.ddit.mapper;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.or.ddit.employee.mapper.EmployeeMapper;
import kr.or.ddit.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("classpath:config/spring/root-context.xml")
public class EmployeeTest {
	@Autowired
	private EmployeeMapper empMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@Test
	@DisplayName("test")
	@Disabled
	public void delete(){
		EmployeeVO empVO = null;
		empVO = empMapper.selectEmployeeByNo("admin");
		log.info("empVO:"+empVO);
	}
	
//	@Test
//	@DisplayName("UserRegister")
//	public void insertUsers() {
//		EmployeeVO empVO = new EmployeeVO();
//		empVO.setEmpNo("230903001");
//		empVO.setEmpPassword(passwordEncoder.encode("java"));
//		empVO.setEmpNm("이경민");
//		empVO.setEmpEmail("rudals03030@naver.com");
//		empVO.setEmpTelno("010-3609-4541");
//		empVO.setEmpBrthdy("960722");
//		empVO.setEmpAddr("대전 대덕구 법동 ");
//		empVO.setEmpDtlAddr("704");
//		empVO.setEmpZip("12345");
//
//		int cnt = empMapper.insert(empVO);
//	}
	
//	@Test
//	@DisplayName("UserRegister")
//	public void insertUsers() {
//		EmployeeVO empVO = new EmployeeVO();
//		empVO.setEmpNo("admin");
//		empVO.setEmpPassword(passwordEncoder.encode("java"));
//		empVO.setEmpNm("관리자");
//		empVO.setEmpEmail("rudals@gmail.com");
//		empVO.setEmpTelno("010-4307-5115");
//		empVO.setEmpBrthdy("941226");
//		empVO.setEmpAddr("대전 서구 탄방동 55-6");
//		empVO.setEmpDtlAddr("403호");
//		empVO.setEmpZip("12345");
//		
//		int cnt = empMapper.insert(empVO);
		
	}

