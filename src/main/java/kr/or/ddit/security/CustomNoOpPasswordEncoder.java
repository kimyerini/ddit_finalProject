package kr.or.ddit.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	// 비밀번호를 받아서 인코딩 해주는 메소드
	@Override
	public String encode(CharSequence rawPassword) {

		log.warn("befor encode : " + rawPassword);
		// 보안상 디코딩(역산)은 지원안함!
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		rawPassword = bCryptPasswordEncoder.encode(rawPassword);
		log.warn("after encode : " + rawPassword);

		return rawPassword.toString();
	}

	// 비밀번호를 받은 거랑 DB 테이블의 비밀번호랑 비교
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.warn("matches : " + rawPassword + " : " + encodedPassword);
		// 일치하면 true를 리턴, 불일치하면 false를 리턴
		return rawPassword.toString().equals(encodedPassword);
	}
}
