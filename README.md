# 👩‍⚕️진료이즈백 EMR 프로젝트

## 📋프로젝트 소개
병원 관리 시스템을 구현한 프로젝트입니다.
<br>

## ⏱️개발 기간
23.09.07 ~ 23.10.16

## 👥 멤버 구성
* 김예린 - 직원 관리, 발주, 공지사항, 캘린더, 통계
* 윤강혁 - 환자 관리 및 접수, 제증명, 문자, 입퇴원 수속
* 이경민 - 로그인, 알림, 물리치료
* 정수지 - 처방 및 처치, 병동 관리, 소모품 발주 신청, 엑스레이 파일 등록
* 정은비 - 환자 진료차트 작성, 제증명

## ⚙️개발 환경
* Java 8
* JDK 1.8.0
* IDE: STS 3.9
* Framework : Spring(5.3.x)
* DataBase : Oracle DB(11xe)
* ORM : MyBatis
* 협업 툴 : SVN

## 🫡담당 기능
### ☑️ 직원 관리
* **구현 기능** : 전체 직원 조회 / 직원 상세 조회 / 직원 등록 / 직원 수정
* 전체 직원 조회는 agGrid API 사용
* agGrid API를 사용하여 검색, csv로 다운로드 구현
* 직원 등록 시 카카오 우편번호 서비스 API 사용
* 직원 등록 시 직원 프로필 사진은 이미지 형식의 파일만 업로드 가능
* 직원 삭제 대신 직원 퇴사일자를 입력하면 해당 직원 퇴사 처리
* **CODE**
    
    `🖥️ controller`
    <details>
        <summary>EmployeeManageController.java</summary>
      
        @Slf4j
        @Controller
        @RequestMapping("/employee")
        public class EmployeeManageController {
        
            @Autowired
            EmployeeManageService service;

            // go to view
            @GetMapping("/index")
            public String getView() {
                log.debug("<<< 여기는 getView >>>");
                return "emp/empManagement";
            }
            
            // list
            @ResponseBody
            @GetMapping(value="/list", produces="application/json; charset=utf-8")
            public List<EmployeeVO> getList() {
                log.debug("<<< 여기는 getList >>> " + service.listEmp());
                return service.listEmp();
            }
            
            // detail
            @ResponseBody
            @GetMapping(value="/{empNo}", produces="application/json; charset=utf-8")
            public EmployeeVO getDetail(@PathVariable String empNo) {
                log.info("넘어온 empno:" + empNo);
                EmployeeVO employeeVO = new EmployeeVO();
                employeeVO.setEmpNo(empNo);
                log.debug("<<< 여기는 getDetail >>> " + service.detailEmp(employeeVO));
                return service.detailEmp(employeeVO);
            }
        }
    </details>
    <details>
        <summary>EmployeeController.java</summary>
      
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

            // 직원 등록
            @PostMapping(value="/register")
            public String register(EmployeeVO employeeVO, Principal principal) {
            log.info("register->employeeVO : " + employeeVO);

            //로그인한 아이디
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

            // 직원 수정
            @PostMapping(value="/modify")
            public String modify(EmployeeVO employeeVO) {
            log.info("modify->employeeVO: " + employeeVO);

            int result = this.employeeService.updateEmp(employeeVO);
            log.info("result: " + result);

            // redirect
            return "redirect:/employee/index?result=3";
            }
        }
    </details>

    `🖥️ serviceImpl`
    <details>
        <summary>EmployeeServiceImpl</summary>
            
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

            // 직원 등록
            @Transactional
            @Override
            public int insertEmp(EmployeeVO employeeVO) {
                    
                // 이번에 등록될 사번값 가져오기
                String empNo = employmapper.getEmpNo();

                // 임시비밀번호 랜덤 생성
                Random rnd = new Random();
                StringBuffer password = new StringBuffer();
                for (int i = 0; i < 6; i++) {
                    if (rnd.nextBoolean()) {
                        password.append((char) ((int) (rnd.nextInt(26)) + 97));
                    } else {
                        password.append((rnd.nextInt(10)));
                    }
                }

                // employeeVO에 사번과 임시비밀번호 set
                employeeVO.setEmpNo(empNo);
                employeeVO.setEmpPassword(passwordEncoder.encode(password));
                log.info("employeeVO(password set): " + employeeVO);

                // employeeVO에 나머지 값 set
                int resNum1 = this.employmapper.insertEmp(employeeVO);
                log.debug("employeeVO(모든 값 set): ", employeeVO);

                // 사용자 권한 set
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

                // 성공여부 확인
                String result = "success";
                if ((resNum1 + resNum2) != 2) {
                    result = "fail"; // 실패
                }
                
                // 파일업로드 처리 (전사적코드, 현재 로그인 한 아이디, MultipartFile객체)
                String webPath = fileUploadUtils.singleUpload(empNo, employeeVO.getRegUserId(), employeeVO.getFiles());
                log.info("webPath : " + webPath);

                // 성공 시 메일 전송
                String subject = "[아작(나)스 병원] " + employeeVO.getEmpNm() + "님의 사번과 임시비밀번호가 발급되었습니다.";
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

                    // 메일 내용
                    mailHelper.setFrom(from);
                    mailHelper.setTo(to);
                    mailHelper.setSubject(subject);
                    mailHelper.setText(content, true);

                    mailSender.send(mail);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                return resNum1 + resNum2;
            }

            @Override
            public int updateEmp(EmployeeVO employeeVO) {
                
                int result = this.employmapper.updateEmp(employeeVO);
                log.info("employeeVO: ", employeeVO);

                return result;
            }
        }
    </details>
    <details>
        <summary>EmployeeManageServiceImpl</summary>
      
        @Service
        public class EmployeeManageServiceImpl implements EmployeeManageService {

            @Autowired
            EmployeeManageMapper mapper;

            @Override
            public List<EmployeeVO> listEmp() {
            return mapper.listEmp();
            }

            @Override
            @Transactional
            public EmployeeVO detailEmp(EmployeeVO employeeVO) {
            String empNo =employeeVO.getEmpNo();
            List<AttachFileVO> list =  mapper.findFileCode(empNo);
            System.out.println("파일리스트: " + list);

            employeeVO = mapper.detailEmp(employeeVO);
            employeeVO.setFileList(list);

            return employeeVO;
            }
        }
    </details>

    `🖥️ mapper`
    <details>
        <summary>EmployeeManage-Mapper.xml</summary>
      
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
        <mapper namespace="kr.or.ddit.employee.mapper.EmployeeManageMapper">
            <!-- 전체 직원 리스트 -->
            <select id="listEmp" resultType="employeeVO">
            /* kr.or.ddit.employee.mapper.EmployeeManageMapper.listEmp */
            SELECT
                a.emp_no
                , b.com_code_name
                , a.emp_nm
                , a.emp_telno
                , a.emp_email
                , to_char(a.emp_encpn,'yyyy-mm-dd') emp_encpn
                , to_char(a.emp_rtcpn,'yyyy-mm-dd') emp_rtcpn
            FROM
                tb_employee a
            JOIN
                tb_common_code b
            ON
                a.dept_code = b.com_code
            </select>

            <!-- 직원 상세정보 조회 -->
            <select id="detailEmp" resultType="employeeVO" parameterType="employeeVO">
            /* kr.or.ddit.employee.mapper.EmployeeManageMapper.detailEmp */
            SELECT
                a.emp_nm
                , b.com_code_name
                , a.dept_code
                , a.emp_no
                , to_char(to_date(replace(a.emp_brthdy,'-',''),'yyyymmdd'),'yyyy-mm-dd') emp_brthdy
                , a.emp_addr
                , a.emp_dtl_addr
                , a.emp_zip
                , a.emp_telno
                , a.emp_email
                , to_char(a.emp_encpn,'yyyy-mm-dd') emp_encpn
                , to_char(a.emp_rtcpn,'yyyy-mm-dd') emp_rtcpn
            FROM
                tb_employee a
            JOIN
                tb_common_code b
            ON
                a.dept_code = b.com_code
            WHERE
                a.emp_no = #{empNo}
            </select>
        </mapper>
    </details>
    <details>
        <summary>Employee-Mapper.xml</summary>
      
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
        <mapper namespace="kr.or.ddit.employee.mapper.EmployeeMapper">
        <!-- 다음에 생성될 사번 번호 select -->
        <select id="getEmpNo" resultType="String">
        /* kr.or.ddit.employee.mapper.EmployeeMapper.getEmpNo*/
        SELECT
            TO_CHAR(SYSDATE, 'YYMM')
            || '03'
            || TRIM(TO_CHAR
            (NVL((SELECT MAX(TO_NUMBER(SUBSTR(emp_no,-3)))
        FROM
            tb_employee
        WHERE
            emp_no LIKE TO_CHAR(sysdate,'YYMM') || '%'), 0) + 1, '000')
        )
        FROM DUAL
        </select>

        <!-- 직원 등록 -->
        <insert id="insertEmp" parameterType="employeeVO">
        /* kr.or.ddit.employee.mapper.EmployeeMapper.insertEmp */
        INSERT INTO
            tb_employee (
                emp_no
                , emp_nm
                , emp_email
                , emp_Password
                , emp_telno
                , emp_brthdy
                , emp_addr
                , emp_dtl_addr
                , emp_zip
                , dept_code
            )
        VALUES (
            #{empNo}
            , #{empNm}
            , #{empEmail}
            , #{empPassword}
            , #{empTelno}
            , #{empBrthdy}
            , #{empAddr}
            , #{empDtlAddr}
            , #{empZip}
            , #{deptCode}
        )
        </insert>

        <!-- 직원 수정 (예린) -->
        <update id="updateEmp" parameterType="employeeVO">
            <!-- kr.or.ddit.employee.mapper.EmployeeMapper.updateEmp -->
            UPDATE
                tb_employee
            SET
                emp_email = #{empEmail}
                , emp_telno = #{empTelno}
                , emp_addr = #{empAddr}
                , emp_dtl_addr = #{empDtlAddr}
                , emp_zip = #{empZip}
                , emp_rtcpn = #{empRtcpn}
                , emp_resign_ysno =
            CASE WHEN
                #{empRtcpn} IS NULL THEN '0'
            ELSE
                '1'
            END
            WHERE
                emp_no = #{empNo}
        </update>
        </mapper>
    </details>

    `🖥️ script`
    <details>
        <summary>empManagement.jsp</summary>

        // 이 곳에는 주요 코드만 작성하였습니다!

        // 직원 등록 시 파일이 이미지타입인지 검사
        const fileCheck = (obj) => {
            pathPoint = obj.value.lastIndexOf(".");
            filePoint = obj.value.substring(pathPoint + 1, obj.length);
            fileType = filePoint.toLowerCase();
            if(fileType == 'jpg' || fileType == 'jpeg' || fileType == 'png') {
                // 정상적인 파일인 경우
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '이미지 파일을 선택해주세요.',
                    text: 'jpg/jpeg/png 파일만 등록할 수 있습니다.'
                });
                parentObj = obj.parentNode;
                node = parentObj.replaceChild(obj.cloneNode(true), obj);
                return false;
            }
        }

        // 우편번호 검색
        function zipSearch() {
            new daum.Postcode({
                //다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
                oncomplete: function (data) {
                    $('input[name="empZip"]').val(data.zonecode);
                    $('input[name="empAddr"]').val(data.address);
                    $('input[name="empDtlAddr"]').val(data.buildingName);
                }
            }).open();
        }

        // 날짜 자동 하이픈 추가
        const hyphenDate = (target) => {
        target.value = target.value
            .replace(/[^0-9]/g, '') // 숫자와 하이픈(-)만 허용
            .replace(/^(\d{4})(\d{1,2})(\d{2})$/, `$1-$2-$3`); // 년-월-일 형식으로 변경
        };

        // agGrid에 세팅할 데이터 가져오기
        function getData(){
            let xhr = new XMLHttpRequest();
            xhr.open("get","/employee/list", true);
            xhr.onreadystatechange = function() {
                
                rowData.length = 0;
                gridOptions.api.setRowData(rowData);
                
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
                    console.log("result", result);
                    
                    for(let i=0; i< result.length; i++) {
                        
                        let item = {
                            empno : result[i].empNo,
                            dept : result[i].comCodeName,
                            name : result[i].empNm,
                            phone : result[i].empTelno,
                            email : result[i].empEmail,
                            enterDate : result[i].empEncpn,
                            resignDate : result[i].empRtcpn
                        }
                        rowData.push(item);
                    }
                    
                    // 아작스로 가져온 row데이터를 agGrid에 세팅하는 api
                    gridOptions.api.setRowData(rowData);
                }
            }
            xhr.send();
        }
    </details>

    `🖥️ view`
    <details>
        <summary>화면1</summary>
        ![직원리스트](https://github.com/kimyerini/ddit_finalProject/assets/142777918/366b4aa6-e998-4d69-8836-2ed04d3bcef9)
    </details>
    <details>
        <summary>화면2</summary>
        ![직원등록](https://github.com/kimyerini/ddit_finalProject/assets/142777918/77503e70-1a12-4600-a79c-ec8cdd52058b)
    </details>
    <details>
        <summary>화면3</summary>
        ![직원수정](https://github.com/kimyerini/ddit_finalProject/assets/142777918/f19bd734-a5fc-4786-b6c5-8350e12b9b7d)
    </details>

