package kr.or.ddit.employee.service.serviceImpl;

import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.employee.mapper.EmployeeMapper;
import kr.or.ddit.employee.service.EmployeeService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.UserAuthoritiesVO;
import kr.or.ddit.util.FileUploadUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeMapper employmapper; // crud
	@Autowired
	private PasswordEncoder passwordEncoder; // 패스워드 인코딩을 위함
	@Autowired
	private JavaMailSender mailSender; // 메일 전송을 위함
	@Autowired
	private FileUploadUtils fileUploadUtils; // 파일 업로드를 위함

	@Override
	public EmployeeVO selectEmployeeByNo(String empNo) {
		return employmapper.selectEmployeeByNo(empNo);
	}

	@Override
	public int delete(String empNo) {
		return employmapper.delete(empNo);
	}

	/*
	 * // 회원가입 (경민)
	 * 
	 * @Override public int insert(EmployeeVO employeeVO) { return
	 * employmapper.insert(employeeVO); }
	 */

	// 권한 insert
	@Override
	public int insertAuth(UserAuthoritiesVO userAuthoritiesVO) {
		return employmapper.insertAuth(userAuthoritiesVO);
	}

	@Override
	public List<EmployeeVO> listEmployee() {
		return employmapper.listEmployee();
	}

	// 이메일 중복확인
	@Override
	public int check(String empEmail) {
		return employmapper.check(empEmail);
	}

	// 비밀번호변경 : 비번up + 상태up
	@Override
	public int updatePwFrst(EmployeeVO employeeVO) {
		return employmapper.updatePwFrst(employeeVO);
	}

	// 비밀번호찾기 (입력한 회원이 있는지 확인)
	@Override
	public int checkEmp(EmployeeVO employeeVO) {
		return employmapper.checkEmp(employeeVO);
	}

	// 임시비밀번호 업데이트
	@Override
	public int updateimsiPw(EmployeeVO employeeVO) {
		return employmapper.updateimsiPw(employeeVO);
	}

	// 정보수정
	@Override
	public int updatemyInfo(EmployeeVO employeeVO) {
		return employmapper.updatemyInfo(employeeVO);
	}

//------------------------------------------------------

	// 다음에 insert 될 사번 가져오기 (예린)
	@Override
	public String getEmpNo() {
		return employmapper.getEmpNo();
	}

	// 직원 등록 (예린)
	@Transactional
	@Override
	public int insertEmp(EmployeeVO employeeVO) {
		
		// 1. 다음에 insert 될 사번 가져오기
		String empNo = employmapper.getEmpNo();

		// 2. 임시비밀번호 랜덤 생성
		Random rnd = new Random();
		StringBuffer password = new StringBuffer();
		for (int i = 0; i < 6; i++) {
			// rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴.
			// true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer에 append 한다.
			if (rnd.nextBoolean()) {
				password.append((char) ((int) (rnd.nextInt(26)) + 97));
			} else {
				password.append((rnd.nextInt(10)));
			}
		}

		// 3. employeeVO에 사번, 비밀번호 set
		employeeVO.setEmpNo(empNo);
		employeeVO.setEmpPassword(passwordEncoder.encode(password));
		log.info("employeeVO(password set): " + employeeVO);

		// 4. employeeVO에 사번, 비밀번호를 제외한 나머지 값 set
		int resNum1 = this.employmapper.insertEmp(employeeVO);
		log.debug("employeeVO(모든 값 set): ", employeeVO);

		// 5. 사용자 권한 테이블에 set - 경민이언니가 한 거 그대로 복붙
		UserAuthoritiesVO userAuthsVO = new UserAuthoritiesVO();
		userAuthsVO.setEmpNo(employeeVO.getEmpNo());

		String authGrpCode = "";
		switch (employeeVO.getDeptCode()) {
		case "D001":
			authGrpCode = "ROLE_DOCTOR";
			break;
		case "D002":
			authGrpCode = "ROLE_NURSE";
			break;
		case "D003":
			authGrpCode = "ROLE_OFFICE";
			break;
		case "D004":
			authGrpCode = "ROLE_PHYSIO";
			break;
		case "D005":
			authGrpCode = "ROLE_RADIO";
			break;
		case "D006":
			authGrpCode = "ROLE_HRD";
			break;
		default:
			authGrpCode = "ROLE_WHO";
		}
		userAuthsVO.setAuthGrpCode(authGrpCode);

		log.debug("userAuthoritiesVO {}", userAuthsVO);

		int resNum2 = employmapper.insertAuth(userAuthsVO);

		// 6. 성공여부 확인
		String result = "success"; // 디폴트 성공
		if ((resNum1 + resNum2) != 2) {
			result = "fail"; // 실패
		}
		
		// 7. 파일업로드 처리(전사적코드, 로그인아이디, MultipartFile객체)
		String webPath = fileUploadUtils.singleUpload(empNo, employeeVO.getRegUserId(), employeeVO.getFiles());
		log.info("webPath : " + webPath);

		// 8. 성공 시 메일 전송
		String subject = "[아작(나)스 병원] " + employeeVO.getEmpNm() + "님의 사번과 임시비밀번호가 발급되었습니다.";
//		String content = employeeVO.getEmpNm() + "님, 사번 및 임시비밀번호 안내 드립니다.<br>"
//				+ "최초 로그인 시 비밀번호 변경을 해주세요.<br>"
//				+ "사번: " + empNo + "<br>임시비밀번호: " + password;
		String content =
				"<table align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin:0;padding:0;width:40%;font-family:'나눔고딕',NanumGothic,'맑은고딕',Malgun Gothic,dotum,'돋움',Dotum,Helvetica;color:#191919;font-size:12px;\">\r\n" + 
				"    <tbody>\r\n" + 
				"        <tr>\r\n" + 
				"            <td style=\"padding:0 32px;width:100%;\">\r\n" + 
				"                <table align=\"center\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:100%\">\r\n" + 
				"                    <tbody>\r\n" + 
				"                        <tr>\r\n" + 
				"                            <td style=\"padding:40px 0 30px;\">\r\n" + 
				"                                <p\r\n" + 
				"                                    style=\"font-weight:bold;font-size:22px;color:#191919;line-height:32px;text-align:left;\">\r\n" + 
				"                                    <span style=\"color:#e5362c\">사번</span> 및 <span style=\"color:#e5362c\">임시비밀번호</span>가\r\n" + 
				"                                    발급되었습니다.\r\n" + 
				"                                </p>\r\n" + 
				"                                <p style=\"font-size:12px;color:#191919;padding-top:16px;line-height:22px;\">임시비밀번호를\r\n" + 
				"                                    사용하여 시스템에 로그인 후 새로운 비밀번호로 변경하시기 바랍니다.</p>\r\n" + 
				"                            </td>\r\n" + 
				"                        </tr>\r\n" + 
				"                        <tr>\r\n" + 
				"                            <td style=\"font-size:14px;font-weight:bold;padding:16px 0 15px 0;border-bottom:1px solid #191919;\">\r\n" + 
				"                                사번 및 비밀번호 안내\r\n" + 
				"                            </td>\r\n" + 
				"                        </tr>\r\n" + 
				"                        <tr>\r\n" + 
				"                            <td style=\"padding-bottom:30px;\">\r\n" + 
				"                                <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:100%;border-bottom:1px solid #eeeeee;padding:10px 0;\">\r\n" + 
				"                                    <tbody>\r\n" + 
				"                                        <tr>\r\n" + 
				"                                            <td style=\"width:98px;padding:8px 0 7px 0;font-weight:bold;\">아이디</td>\r\n" + 
				"                                            <td style=\"padding:8px 0 7px 0;\">" + empNo + "</td>\r\n" + 
				"                                        </tr>\r\n" + 
				"                                        <tr>\r\n" + 
				"                                            <td style=\"width:98px;padding:8px 0 7px 0;font-weight:bold;\">임시비밀번호</td>\r\n" + 
				"                                            <td style=\"padding:8px 0 7px 0;\">" + password + "</td>\r\n" + 
				"                                        </tr>\r\n" + 
				"                                    </tbody>\r\n" + 
				"                                </table>\r\n" + 
				"                            </td>\r\n" + 
				"                        </tr>\r\n" + 
				"                    </tbody>\r\n" + 
				"                </table>\r\n" + 
				"            </td>\r\n" + 
				"        </tr>\r\n" + 
				"    </tbody>\r\n" + 
				"</table>";

		String from = "hyokee5115@naver.com"; // 발신인
		String to = employeeVO.getEmpEmail(); // 수신인

		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

			// 메일 내용을 채워줌
			mailHelper.setFrom(from); // 발신인 셋팅
			mailHelper.setTo(to); // 수신인 셋팅
			mailHelper.setSubject(subject); // 제목 셋팅
			mailHelper.setText(content, true); // 내용 셋팅

			mailSender.send(mail); // 메일 전송
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 9. 결과 확인 ? (원래 있던 코드 ..)
		log.info("결과체킁", result);

		return resNum1 + resNum2;
	}

	@Override
	public int updateEmp(EmployeeVO employeeVO) {
		
		int result = this.employmapper.updateEmp(employeeVO);
		log.debug("employeeVO(파일 제외 set): ", employeeVO);

		return result;
	}
	

}
