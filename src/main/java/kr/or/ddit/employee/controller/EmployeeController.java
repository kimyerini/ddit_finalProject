package kr.or.ddit.employee.controller;

import java.security.Principal;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.hc.core5.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.or.ddit.employee.service.EmployeeService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.UserAuthoritiesVO;
import kr.or.ddit.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp")
public class EmployeeController {

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private EmployeeService employeeService;
	
	

	// 로그인 폼
	@GetMapping("/login")
	public String login() {

		return "login/login2/loginForm";
	}
	
	// 로그인 실패
	@RequestMapping("/loginFailed")
	public String loginFailed() {
		log.info("loginFailed에 왔다");
		return "login/login2/loginFailed";
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		
		req.getSession().invalidate();
		
		return "redirect:/emp/login";
	}
	
	// 정보수정 
	@PostMapping("/updateMyInfo")
	@ResponseBody
	public String update(@RequestBody EmployeeVO employeeVO) {
		//EmployeeVO(enabled=null, firstLogin=null, empNo=230903130, empPassword=12, empNm=null, empEmail=null
		//, empTelno=010-3609-4541, empBrthdy=null, empAddr=대전 대덕구 동춘당로 151, empDtlAddr=그린타운아파트, empZip=34407
		//, empEncpn=null, empRtcpn=null, empRegDate=null, deptCode=null, empSignImgPath=null, comCodeName=null
		//, userAuthList=null, search=null)
		log.info("update->employeeVO : " + employeeVO);
		
		//비밀번호 암호화
		employeeVO.setEmpPassword(passwordEncoder.encode(employeeVO.getEmpPassword()));
		//이메일 변경 처리
		//1) 이메일이 동일 -> 변경 안됨
		if(employeeVO.getEmpOriginEmail().equals(employeeVO.getEmpEmail())) {
			/*
			 <if test="empEmail!=null and empEmail!=''">
		    , EMP_EMAIL =샵{empEmail}
		     </if>
			 */
			employeeVO.setEmpEmail("");
		}else {
			//2) 이메일이 다름 -> 변경
		}
		
		int res = employeeService.updatemyInfo(employeeVO);
		log.debug("체크하기 : ",res);
		
		return res +"";
	}
	

	// 비번update + 최초로그인여부update (폼)
	@GetMapping("/updatePwForm")
	public String updatePwFrstForm() {
		return "login/login2/updatePwForm";
	}

	// 비번up + 상태up
	@PostMapping("/updatePwForm")
	public String updatePwFrst(String empPassword, Authentication auth, HttpServletResponse resp,
			HttpServletRequest req, RedirectAttributes redirect) throws Exception {

		if (auth == null) {
			resp.sendRedirect("/login");
		} else {

			log.debug("새암호:" + empPassword);
			log.debug("시큐리티정보:{}", auth.getName()); // 로그인한 사용자 id
			log.debug("시큐리티정보:{}", auth.getAuthorities()); // 로그인한 사용자 ROLE들
			log.debug("시큐리티정보:{}", (CustomUser) auth.getPrincipal()); // 시큐리티 사용자 정보에 덧붙인 정보
			log.debug("시큐리티정보:{}", ((CustomUser) auth.getPrincipal()).getEmployee()); // 시큐리티 사용자 정보에 덧붙인 정보

			String empNo = auth.getName();
			String newEncPassword = passwordEncoder.encode(empPassword);

			// 요걸 가지고 암호를 Update해야함, 다시 로그인을 하라 하기도 하공, 그대로 인증을 살려주기도 함!
			// 다시 로그인 하게 하려면 어켕?!
			EmployeeVO employeeVO = new EmployeeVO();
			employeeVO.setEmpNo(empNo);
			employeeVO.setEmpPassword(newEncPassword);

			log.debug("km employeeVO {}", employeeVO);

			employeeService.updatePwFrst(employeeVO);

			req.getSession().invalidate(); // 세션을 무효화 시킴!

			redirect.addFlashAttribute("relogin", ""); 

		}
		return "redirect:/emp/login";

	}

//	// 회원가입 폼
//	@GetMapping("/register")
//	public String registerForm() { // 회원가입
//		return "login/login2/registerForm";
//	}

	/*
	// 회원가입
	@PostMapping(value = "/register")
	@ResponseBody // ajax는 요걸로
	public String register(@RequestBody EmployeeVO employeeVO) {
		
		// 다음에 입력될 사번 가져오기 - 예린
		String empNo = employeeService.getEmpNo();
		
		// 임시비밀번호 랜덤 생성 - 예린
		Random rnd = new Random();
		StringBuffer password = new StringBuffer();
		for(int i=0; i<6; i++) {
			// rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. 
			// true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer에 append 한다.
			if(rnd.nextBoolean()) {
				password.append((char)((int)(rnd.nextInt(26))+97));
			} else {
				password.append((rnd.nextInt(10)));
			}
		}
		
		// 제대로 받았는지 꼬옥 누느로 확인
		String imsiPassword = passwordEncoder.encode("java"); // 임시 비밀번호
		employeeVO.setEmpPassword(imsiPassword);
		
		int resNum1 = employeeService.insert(employeeVO);
		log.debug("employVO {}", employeeVO);

		
		UserAuthoritiesVO userAuthsVO = new UserAuthoritiesVO();
		userAuthsVO.setEmpNo(employeeVO.getEmpNo());
		
		String authGrpCode = "";
		switch(employeeVO.getDeptCode()){
			case "D001": 
				authGrpCode = "ROLE_DOCTOR";
				break;
			case "D002": 
				authGrpCode ="ROLE_NURSE";
				break;
			case "D003": 
				authGrpCode ="ROLE_OFFICE";
				break;
			case "D004": 
				authGrpCode ="ROLE_PHYSIO";
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

		int resNum2 = employeeService.insertAuth(userAuthsVO);

		
		String result = "success"; // 디폴트 성공
		if ((resNum1+ resNum2) != 2) {
			result = "fail"; // 실패
		}
		log.info("결과체킁", result);
		return result;
	}
	*/
	
	// 이메일 중복 확인
	@GetMapping(value = "/emailCheck") // 조회 기능이기 때문에 getmapping쓰는것이 좋은데 비교만 할 뿐이니까 postmapping도 가능
	@ResponseBody
	public String emailCheck(String email) { // ajax에서 이름 준대로 String email

		log.debug("확인하기:" + email);

		int checkNum = employeeService.check(email);

		String res = "success";
		if (checkNum != 0) {
			res = "fail"; // db에 이미 있는거
		}
		log.debug(res);

		return res;
	}

	// 비밀번호찾기 (폼)
	@GetMapping("/findPw")
	public String findPwForm() {
		return "login/login2/findPwForm";
	}

	// 비밀번호찾기
	@PostMapping("/findPw")
	public String findPw(EmployeeVO employeeVO) {
		log.info("개똥이 employeeVO {} : " , employeeVO  );
		
		// 임시비밀번호 랜덤생성
		Random rnd = new Random();
		StringBuffer buf = new StringBuffer();
		for(int i=0; i<6; i++) {
			// rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. 
			// true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer에 append 한다.
			if(rnd.nextBoolean()) {
				 buf.append((char)((int)(rnd.nextInt(26))+97));
			} else {
				buf.append((rnd.nextInt(10)));
			}
		}
		
		int num = employeeService.checkEmp(employeeVO);
		
		if (num == 1) {

			// 메일 내용
			String subject = "임시비밀번호입니다.";
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
							"                                    <span style=\"color:#e5362c\"> <span style=\"color:#e5362c\">임시비밀번호</span>가\r\n" + 
							"                                    발급되었습니다.\r\n" + 
							"                                </p>\r\n" + 
							"                                <p style=\"font-size:12px;color:#191919;padding-top:16px;line-height:22px;\">임시비밀번호를\r\n" + 
							"                                    사용하여 시스템에 로그인 후 새로운 비밀번호로 변경하시기 바랍니다.</p>\r\n" + 
							"                            </td>\r\n" + 
							"                        </tr>\r\n" + 
							"                        <tr>\r\n" + 
							"                            <td style=\"padding-bottom:30px;\">\r\n" + 
							"                                <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width:100%;padding:10px 0;\">\r\n" + 
							"                                    <tbody>\r\n" + 
							"                                        <tr>\r\n" + 
							"                                            <td style=\"width:98px;padding:8px 0 7px 0;font-weight:bold;\">임시비밀번호</td>\r\n" + 
							"                                            <td style=\"padding:8px 0 7px 0;\">" + buf + "</td>\r\n" + 
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

			employeeVO.setEmpPassword(passwordEncoder.encode(buf)); // (암호화된)임시비밀번호 set
			// 임시비밀번호 update
			employeeService.updateimsiPw(employeeVO);
		

			// 보내는 사람
			String from = "hyokee5115@naver.com";

			// 받는 사람
			String to = employeeVO.getEmpEmail();

			try {

				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

				// 메일 내용을 채워줌
				mailHelper.setFrom(from); // 보내는 사람 셋팅
				mailHelper.setTo(to); // 받는 사람 셋팅
				mailHelper.setSubject(subject); // 제목 셋팅
				mailHelper.setText(content,true); // 내용 셋팅
				
				// 메일 전송
				mailSender.send(mail);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			return "/findPw";
		}

		return "redirect:/emp/login";
	}
	
	
//-------------------------------------------------------------------------------------------------------------
	
	// 직원 등록 (예린)
	@PostMapping(value="/register")
	public String register(EmployeeVO employeeVO, Principal principal) {
		log.info("register->employeeVO : " + employeeVO);
		
		//로그인한 아이디
//		log.info("principal이 null인가? " + principal);
		if(principal==null) {
			return "redirect:/employee/index?result=1";
		}
		String regUserId = principal.getName();
		
		
		employeeVO.setRegUserId(regUserId);
		log.info("regUserId : " + regUserId);
		
		int result = this.employeeService.insertEmp(employeeVO);
		log.info("result : " + result);
		
		//redirect
		return "redirect:/employee/index?result=2";
	}
	
	// 직원 수정 (예린)
	@PostMapping(value="/modify")
	public String modify(EmployeeVO employeeVO) {
		log.info("modify->employeeVO: " + employeeVO);
		
		int result = this.employeeService.updateEmp(employeeVO);
		log.info("result: " + result);
		
		// redirect
		return "redirect:/employee/index?result=3";
	}

}
