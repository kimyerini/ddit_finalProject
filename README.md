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

        // 주요 코드 위주로 첨부하였습니다!

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
        <summary>직원 조회</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/366b4aa6-e998-4d69-8836-2ed04d3bcef9">
    </details>
    
    <details>
        <summary>직원 등록</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/77503e70-1a12-4600-a79c-ec8cdd52058b">
    </details>

    <details>
        <summary>직원 수정</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/f19bd734-a5fc-4786-b6c5-8350e12b9b7d">
    </details>

### ☑️ 공지사항
* **구현 기능** : 공지사항 조회 / 공지사항 등록(파일 다중업로드) / 공지사항 수정(파일 부분삭제) / 공지사항 삭제
* 페이징 처리
* 카테고리별 검색 기능
* 파일 형식 구분 -> 이미지 형식이면 본문에 출력, 아닌 경우에는 첨부파일란에 출력하여 다운로드 가능
* 공지사항 수정 시 파일 부분(전체)삭제 가능
* **CODE**
  
    `🖥️ controller`
    <details>
        <summary>NoticeController.java</summary>

        @Slf4j
        @Controller
        @RequestMapping("/board")
        public class NoticeController {

            @Autowired
            NoticeService noticeService;
            @Autowired
            TbAttachFileMapper fileMapper;
            @Autowired
            NotificationService notificationService;
            
            // [VIEW-메인] select 공지사항 리스트 + 페이징
            @Transactional
            @GetMapping("/notice")
            public String getListView(Model model,
                                @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage,
                                @RequestParam(value="size", required=false, defaultValue="10") int size,
                                @RequestParam(value="keyword", required=false, defaultValue="") String keyword,
                                @RequestParam(value="category", required=false, defaultValue="") String category) {
                log.debug("<<< 여기는 getListView >>>");
                
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("currentPage", currentPage); // 기본값 1
                map.put("size", size); // 기본값 10
                map.put("category", category); // 기본 "제목"
                map.put("keyword", keyword); // 기본 ""
                
                log.info("map은?!?!?!?!: " + map);
                
                // 데이터 저장
                List<NoticeBoardVO> noticeBoardVO = noticeService.noticeList(map);
                log.info("noticeBoardVO" + noticeBoardVO);
                
                // TB_NOTICE_BOARD 테이블의 전체 행 수
                int noticeCount = noticeService.countNotice(map);
                model.addAttribute("noticeCount", noticeCount);

                // 페이징 처리한 data: ArticlePage 활용
                model.addAttribute("data", new ArticlePage<NoticeBoardVO>(noticeCount, currentPage, size, noticeBoardVO)); // 10은 size
                
                return "board/noticeList";
            }
            
            // [VIEW] select 공지사항 1개 조회
            @GetMapping("/detail/{ntbdCode}")
            public String getDetailView(@PathVariable String ntbdCode, Model model,
                    HttpSession session, Principal principal) {
                log.debug("<<< 여기는 getDetailView >>>");
                
                NoticeBoardVO noticeBoardVO = new NoticeBoardVO();
                noticeBoardVO.setNtbdCode(ntbdCode);
                
                // 조회수 증가
                noticeService.updateHit(noticeBoardVO);
                
                // get one notice
                noticeBoardVO = noticeService.oneNotice(ntbdCode);
                log.info("getDetailView->noticeBoardVO : " + noticeBoardVO);
                
                model.addAttribute("noticeBoardVO", noticeBoardVO);
                    
                return "board/noticeDetail";
            }

            // 알림 클릭 시 공지사항 상세조회로 이동
            @Transactional
            @GetMapping("/noti/{ntbdCode}/{ntcnId}")
            public String getDetailView(@PathVariable String ntbdCode, Model model,
                    HttpSession session, Principal principal,
                    @PathVariable String ntcnId) {
                log.debug("알림내역에서 공지사항 선택");
                
                // noti-check테이블에 insert
                String empNo = principal.getName();
                
                log.info("ntcnId : " + ntcnId + ",empNo : " + empNo);
                
                NotiCheckVO notiCheckVO = new NotiCheckVO();
                if(ntcnId!=null) {
                    log.info("ntcnId : " + ntcnId);
                    notiCheckVO.setNtcnId(Integer.parseInt(ntcnId));
                    notiCheckVO.setEmpNo(empNo);
                    
                    //nicnId가 있으면 TB_NOTI_CHECK 테이블에 insert(알림 확인 처리)
                    this.notificationService.insertNotiCheck(notiCheckVO);		
                }
                
                return "redirect:/board/detail/" + ntbdCode;
            }
            
            // [VIEW] 공지사항 작성 폼
            @GetMapping("/write")
            public String getWriteView() {
                log.debug("<<< 여기는 getWriteView >>> ");
                
                return "board/noticeWrite";
            }
            
            // insert 공지사항
            @PostMapping("/write")
            public String insertNotice(NoticeBoardVO noticeBoardVO) {
                log.debug("<<< 여기는 insertNotice >>>");
                
                noticeService.insertNotice(noticeBoardVO);
                log.info("insertNotice의 result: " + noticeBoardVO);
                
                // redirect
                return "redirect:/board/notice?result=1";
            }
            
            // delete 공지사항
            @ResponseBody
            @DeleteMapping("/delete/{ntbdCode}")
            public int deleteNotice(@PathVariable String ntbdCode) {
                log.debug("<<< 여기는 deleteNotice >>>");
                
                int result = noticeService.deleteNotice(ntbdCode);
                result += noticeService.deleteAllFile(ntbdCode);
                
                return result;
            }
            
            // [VIEW/update] 공지사항 수정
            @GetMapping("/update/{ntbdCode}")
            public String getUpdateView(@PathVariable String ntbdCode, Model model) {
                log.debug("<<< 여기는 getUpdateView >>>");
                
                NoticeBoardVO noticeBoardVO = new NoticeBoardVO();
                noticeBoardVO.setNtbdCode(ntbdCode);
                
                noticeBoardVO = noticeService.oneNotice(ntbdCode);
                model.addAttribute("noticeBoardVO", noticeBoardVO);
                
                return "board/noticeModify";
            }
            
            // update 공지사항
            @Transactional
            @PutMapping("/update")
            public String updateNotice(NoticeBoardVO noticeBoardVO) {
                log.debug("<<< 여기는 updateNotice >>>");
                
                int[] chkFilesParam = noticeBoardVO.getChkFilesParam();
                log.info("넘어온 체크박스" + chkFilesParam);
                
                int fileDeleteResult = 0;
                for(int i=0; i<chkFilesParam.length; i++) {
                    log.info("처리할 chkFileParam[" + i + "]: " + chkFilesParam[i]);
                    fileDeleteResult += noticeService.deleteOneFile(chkFilesParam[i]);
                }
                log.info("삭제한 파일 개수: " + fileDeleteResult);
                
                noticeService.updateNotice(noticeBoardVO);
                log.info("noticeBoardVO: " + noticeBoardVO);
                
                return "redirect:/board/detail/" + noticeBoardVO.getNtbdCode() + "?result=1";
            }
            
            // delete 파일 부분삭제
            @DeleteMapping("/deleteFile")
            public int deleteFile(String fileNo) {
                log.debug("<<< 여기는 deleteFile >>>");
                
                return fileMapper.deleteFile(fileNo);
            }
            
        }
    </details>
    
    <details>
        <summary>FileUploadUtils.java</summary>
        
        @Slf4j
        @Controller
        public class FileUploadUtils {
            
            // 1. 업로드 폴더 정보
            @Autowired
            public String uploadFolder; // root-context.xml의 자바빈을 의존성 주입
            @Autowired
            private TbAttachFileMapper tbAttachFileMapper; // TB_ATTACH_FILE 테이블에 insert 하기 위해 주입

            // 2. 연월일 폴더 생성
            public String getFolder() {

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                System.out.println("sdf: " + sdf);

                Date date = new Date();
                String str = sdf.format(date);

                return str.replace("-", File.separator);
            }

            // 3. 이미지인지 판단
            public boolean checkImageType(File file) {
                String contentType;
                try {
                    contentType = Files.probeContentType(file.toPath()); // file의 MIME타입을 contentType에 저장
                    log.info("contentType : " + contentType);
                    
                    // MIME 타입 정보가 image로 시작하는지 여부
                    return contentType.startsWith("image"); // TRUE or FALSE
                } catch (IOException e) {
                    e.printStackTrace();
                    return false;
                }
            }

            // 4. 다중업로드 처리 (전사적 코드, 등록자 아이디, 파일 객체)
            public List<AttachFileVO> multiUpload(String fileCode, String regUserId, MultipartFile[] files) {
                
                log.debug("넘어온 fildCode: " + fileCode);
                log.debug("넘어온 regUserId: " + regUserId);
                log.debug("넘어온 files: " + files);
                // 업로드 폴더가 없는 경우 처리
                if(uploadFolder == null) {
                    uploadFolder = "D:\\mytool\\sts3WS\\202303F_Team1\\src\\main\\webapp\\resources\\upload";
                }
                
                // 업로드 경로(upload 폴더까지의 경로/연/월/일) 처리
                File uploadPath = new File(uploadFolder, getFolder()); // (upload폴더, 연월일 폴더)
                log.info("uploadPath : " + uploadPath);
                // 해당 연/월/일 폴더가 없는 경우 생성
                if (uploadPath.exists() == false) {
                    uploadPath.mkdirs();
                }
                
                List<AttachFileVO> attachFileVOList = new ArrayList<AttachFileVO>();

                // 파일 웹경로를 담을 변수
                String result = "";
                
                // 파일객체 배열로부터 파일을 하나씩 꺼내옴
                for (MultipartFile file : files) {
                    
                    log.debug("--------------------------");
                    log.debug("파일명 : " + file.getOriginalFilename());
                    log.debug("파일크기 : " + file.getSize());
                    log.debug("MIME타입 : " + file.getContentType());
                    
                    String uploadFileName = file.getOriginalFilename();
                    uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1); // "\" 다음인 파일명부터 끝까지

                    // 같은 날 동일한 이미지 업로드 시 파일 중복 방지 처리
                    UUID uuid = UUID.randomUUID();
                    uploadFileName = uuid.toString() + "_" + uploadFileName;

                    // File 객체 설계(복사할 대상 경로, 파일명)
                    File saveFile = new File(uploadPath, uploadFileName);

                    try {
                        file.transferTo(saveFile);
                        
                        result = "\\" + getFolder() + "\\" + uploadFileName;
                        result = result.replace("\\", "/");
                        
                        //---------TB_ATTACH_FILE 테이블에 insert 시작---------
                        AttachFileVO attachFileVO = new AttachFileVO();
                        attachFileVO.setFileCode(fileCode);
                        attachFileVO.setFileName(file.getOriginalFilename());
                        attachFileVO.setFileSaveName(uploadFileName);
                        attachFileVO.setFilePhysicPath(uploadPath + "\\" + uploadFileName);
                        attachFileVO.setFileWebPath(result);
                        attachFileVO.setFileSize(file.getSize());
                        attachFileVO.setFileContType(file.getContentType());
                        attachFileVO.setRegUserId(regUserId);
                        
                        log.info("하나의 attachFileVO: " + attachFileVO);
                        
                        attachFileVOList.add(attachFileVO);
                        log.info("attachFileVOList 하나씩: " + attachFileVOList);
                        //----------TB_ATTACH_FILE 테이블에 insert 끝----------		

                    } catch (IllegalStateException e) {
                        log.error(e.getMessage());
                        return null;
                    } catch (IOException e) {
                        log.error(e.getMessage());
                        return null;
                    }
                } // end for

                log.info("multiUpload에서 모두 set된 attachFileVOList: " + attachFileVOList);
                // TB_ATTACH_FILE 테이블에 insert
                tbAttachFileMapper.attachFileMultiRegist(attachFileVOList);
                
                return attachFileVOList;
            }

            // 5) 단일업로드 처리(전사적 코드, 등록자 아이디, 파일객체)
            public String singleUpload(String fileCode, String regUserId, MultipartFile file) {
                if(uploadFolder==null) {
                    uploadFolder = "D:\\mytool\\sts3WS\\202303F_Team1\\src\\main\\webapp\\resources\\upload";
                }
                
                File uploadPath = new File(uploadFolder, getFolder());
                log.info("uploadPath : " + uploadPath);

                if (uploadPath.exists() == false) {
                    uploadPath.mkdirs();
                }

                log.debug("--------------------------");
                log.debug("파일명 : " + file.getOriginalFilename());
                log.debug("파일크기 : " + file.getSize());
                log.debug("MIME타입 : " + file.getContentType());
                String uploadFileName = file.getOriginalFilename();
                uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

                // 같은날 같은 이미지를 업로드 시 파일 중복 방지
                UUID uuid = UUID.randomUUID();
                uploadFileName = uuid.toString() + "_" + uploadFileName;

                File saveFile = new File(uploadPath, uploadFileName);
                String result = "";

                try {
                    file.transferTo(saveFile);
                    
                    result = "\\" + getFolder() + "\\" + uploadFileName;
                    result = result.replace("\\", "/");

                    //---------------TB_ATTACH_FILE 테이블에 insert 시작---------------
                    AttachFileVO attachFileVO = new AttachFileVO();
                    attachFileVO.setFileCode(fileCode);
                    attachFileVO.setFileName(file.getOriginalFilename());
                    attachFileVO.setFileSaveName(uploadFileName);
                    attachFileVO.setFilePhysicPath(uploadPath + "\\" + uploadFileName);
                    attachFileVO.setFileWebPath(result);
                    attachFileVO.setFileSize(file.getSize());
                    attachFileVO.setFileContType(file.getContentType());
                    attachFileVO.setRegUserId(regUserId);
                    
                    log.info("singleUpload에 set 된 attachFileVO : " + attachFileVO);
                    
                    // TB_ATTACH_FILE 테이블에 insert
                    tbAttachFileMapper.attachFileRegist(attachFileVO);
                    //-----------------TB_ATTACH_FILE 테이블에 insert 끝-----------------
                    
                } catch (IllegalStateException e) {
                    log.error(e.getMessage());
                    return "0";
                } catch (IOException e) {
                    log.error(e.getMessage());
                    return "0";
                }

                return result;
            }
            
            // 파일 다운로드 처리
            @ResponseBody
            @GetMapping("/download")
            public ResponseEntity<Resource> download(@RequestParam String fileName){
                log.info("넘어온 fileName : " + fileName);
            
                // resource : 다운로드 받을 파일(자원)
                Resource resource = new FileSystemResource( // FileSystemResource: 절대경로 등 파일시스템에서 리소스를 찾는 방식
                    uploadFolder + "\\" + fileName
                );
                String resourceName = resource.getFilename();
                HttpHeaders headers = new HttpHeaders(); // header : 인코딩 정보, 파일명 정보
                try {
                    headers.add("Content-Disposition", "attachment;filename="+
                            new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
                } catch (UnsupportedEncodingException e) {
                    log.info(e.getMessage());
                }
                    return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
                }
            }
    </details>

    `🖥️ serviceImpl`
    <details>
        <summary>NoticeServiceImpl.java</summary>

        @Slf4j
        @Service
        public class NoticeServiceImpl implements NoticeService {

            @Autowired
            NoticeMapper noticeMapper;
            @Autowired
            FileUploadUtils fileUploadUtils; // 파일 업로드를 위함

            @Override
            public List<NoticeBoardVO> noticeList(Map<String, Object> map) {
                return noticeMapper.noticeList(map);
            }

            @Override
            public NoticeBoardVO oneNotice(String ntbdCode) {
                return noticeMapper.oneNotice(ntbdCode);
            }

            @Transactional
            @Override
            public int insertNotice(NoticeBoardVO noticeBoardVO) {

                log.info("serviceImpl에 넘어온 noticeBoardVO: " + noticeBoardVO);
                int result = noticeMapper.insertNotice(noticeBoardVO);
                //noticeBoardVO.ntbdCode이 selectKey에 의해 생성됨
                
                // 파일 처리
                MultipartFile[] files = noticeBoardVO.getFiles();
                log.info("files[0].getOriginalFilename().length() : " + files[0].getOriginalFilename().length());

                if(files[0].getOriginalFilename().length()>0) { // 파일이 있을 때만 insert
                    List<AttachFileVO> attachFileVOList = fileUploadUtils.multiUpload(noticeBoardVO.getNtbdCode(),
                            noticeBoardVO.getWriterEmpNo(), files);
                    noticeBoardVO.setFileList(attachFileVOList);
                }
                
                return result;
            }

            @Override
            public int updateNotice(NoticeBoardVO noticeBoardVO) {
                return noticeMapper.updateNotice(noticeBoardVO);
            }

            @Override
            public int deleteNotice(String ntbdCode) {
                return noticeMapper.deleteNotice(ntbdCode);
            }

            @Override
            public int updateHit(NoticeBoardVO noticeBoardVO) {
                return noticeMapper.updateHit(noticeBoardVO);
            }

            @Override
            public int countNotice(Map<String, Object> map) {
                return noticeMapper.countNotice(map);
            }

            @Override
            public int deleteOneFile(int chkFileNo) {
                return noticeMapper.deleteOneFile(chkFileNo);
            }

            @Override
            public int deleteAllFile(String ntbdCode) {
                return noticeMapper.deleteAllFile(ntbdCode);
            }
        }
    </details>

    `🖥️ mapper`
    <details>
        <summary>Notice-Mapper.xml</summary>
        
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
        <mapper namespace="kr.or.ddit.board.mapper.NoticeMapper">

            <sql id="where">
                <!-- 전체검색 -->
                <if test="keyword!=null and keyword!=''">
                    <choose>
                        <when test="category=='제목'">
                            AND  ntc.ntbd_subject LIKE '%' || #{keyword} || '%'
                        </when>
                        <when test="category=='작성자'">
                            AND  emp.emp_nm LIKE '%' || #{keyword} || '%'
                        </when>
                        <when test="category=='내용'">
                            AND  ntc.NTBD_CONTENT LIKE '%' || #{keyword} || '%'
                        </when>
                    </choose>
                </if>
            </sql>
            
            <resultMap type="NoticeBoardVO" id="noticeMap">
                <id property="ntbdCode" column="NTBD_CODE" />
                <result property="rnum2" column="RNUM2" />
                <result property="ntbdSubject" column="NTBD_SUBJECT" />
                <result property="ntbdContent" column="NTBD_CONTENT" />
                <result property="ntbdHit" column="NTBD_HIT" />
                <result property="ntbdUpdDate" column="NTBD_UPD_DATE" />
                <result property="updaterEmpNo" column="UPDATER_EMP_NO" />
                <result property="comFileCode" column="COM_FILE_CODE" />
                <result property="ntbdRegDate" column="ntbdRegDate" />
                <result property="writerEmpNo" column="writerEmpNo" />
                <result property="deptName" column="deptName" />
                <result property="empName" column="empName" />
                <collection property="fileList" resultMap="fileMap" notNullColumn="FILE_CODE" />
            </resultMap>
            
            <resultMap type="AttachFileVO" id="fileMap">
                <result property="fileCode" column="FILE_CODE" />
                <result property="fileNo" column="FILE_NO" />
                <result property="fileName" column="FILE_NAME" />
                <result property="fileSaveName" column="FILE_SAVE_NAME" />
                <result property="filePhysicPath" column="FILE_PHYSIC_PATH" />
                <result property="fileWebPath" column="FILE_WEB_PATH" />
                <result property="fileSize" column="FILE_SIZE" />
                <result property="fileDownCnt" column="FILE_DOWN_CNT" />
                <result property="fileContType" column="FILE_CONT_TYPE" />
                <result property="fileRegDate" column="FILE_REG_DATE" />
                <result property="regUserId" column="REG_USER_ID" />
                <result property="fileUpdDate" column="FILE_UPD_DATE" />
                <result property="updUserId" column="UPD_USER_ID" />
            </resultMap>
            
            <select id="noticeList" parameterType="hashMap" resultMap="noticeMap">
            /* kr.or.ddit.mapper.NoticeMapper.noticeList */
            SELECT U.*
            FROM ( SELECT DENSE_RANK() OVER(ORDER BY Y.RNUM2 DESC) RNUM, Y.*
                FROM ( WITH X AS ( SELECT DENSE_RANK() OVER( ORDER BY to_number(t.ntbd_code) ASC ) RNUM2, T.*
                    FROM (
                        SELECT
                            ntc.ntbd_code,
                            cmn.com_code_name AS deptname,
                            ntc.ntbd_subject,
                            to_char(ntc.ntbd_reg_date, 'YYYY-MM-DD') AS ntbdregdate,
                            emp.emp_nm AS empname,
                            emp.emp_no AS writerempno,
                            ntc.ntbd_hit,
                            af.file_code,
                            af.file_no,
                            af.file_name,
                            af.file_cont_type,
                            af.file_reg_date,
                            af.reg_user_id
                        FROM
                            tb_notice_board ntc
                        LEFT OUTER JOIN
                            tb_attach_file af
                        ON
                            ntc.ntbd_code = af.file_code
                        JOIN
                            tb_employee emp
                        ON
                            ntc.writer_emp_no = emp.emp_no
                        JOIN
                            tb_common_code  cmn
                        ON
                            emp.dept_code = cmn.com_code
                        WHERE 1 = 1
                            <include refid="where"></include>
                        ) T
                    )
                    SELECT X.*
                    FROM X
                ) Y
            ) U
            WHERE U.RNUM BETWEEN (#{currentPage} * #{size}) - (#{size} - 1)
            AND (#{currentPage} * #{size})
            </select>
            
            <select id="countNotice" parameterType="hashMap" resultType="int">
            /* kr.or.ddit.board.mapper.NoticeMapper.countNotice */
                SELECT
                    count(*)
                FROM
                    tb_notice_board ntc
                JOIN
                    tb_employee emp
                ON 
                    ntc.writer_emp_no = emp.emp_no
                JOIN
                    tb_common_code cmn
                ON 
                    emp.dept_code = cmn.com_code
                WHERE 1 = 1
                <include refid="where"></include>
            </select>

            <select id="oneNotice" parameterType="String" resultMap="noticeMap">
            /* kr.or.ddit.board.mapper.NoticeMapper.noticeOne */
                SELECT
                    ntc.ntbd_code
                    , cmn.com_code_name AS deptName
                    , ntc.ntbd_subject
                    , TO_CHAR(ntc.ntbd_reg_date, 'YYYY-MM-DD') AS ntbdRegDate
                    , emp.emp_nm AS empName
                    , emp.emp_no AS writerEmpNo
                    , ntc.ntbd_hit
                    , af.file_code
                    , af.file_no
                    , af.file_name
                    , ntc.ntbd_content
                    , af.file_save_name
                    , af.file_physic_path
                    , af.file_web_path
                    , af.file_size
                    , af.file_down_cnt
                    , af.file_cont_type
                    , af.file_reg_date
                    , af.reg_user_id
                    , af.file_upd_date
                    , af.upd_user_id
                FROM
                    tb_notice_board ntc
                LEFT JOIN
                    tb_attach_file af
                ON
                    ntc.ntbd_code = af.file_code
                JOIN
                    tb_employee emp
                ON
                    ntc.writer_emp_no = emp.emp_no
                JOIN
                    tb_common_code cmn
                ON
                    emp.dept_code = cmn.com_code
                where ntbd_code = #{ntbdCode}
                ORDER BY
                    TO_NUMBER(ntc.ntbd_code) DESC
            </select>
            
            <update id="updateHit" parameterType="noticeBoardVO">
            /* kr.or.ddit.board.mapper.NoticeMapper.updateHit */
                UPDATE
                    tb_notice_board
                SET
                    ntbd_hit = ntbd_hit + 1
                WHERE
                    ntbd_code = #{ntbdCode}
            </update>
            
            <insert id="insertNotice" parameterType="noticeBoardVO">
            /* kr.or.ddit.board.mapper.NoticeMapper.insertNotice */
                <selectKey resultType="String" order="BEFORE" keyProperty="ntbdCode">
                    SELECT NVL(MAX(TO_NUMBER(ntbd_code)), 0) + 1 FROM tb_notice_board
                </selectKey>
                INSERT INTO
                    tb_notice_board (
                        ntbd_code
                        , writer_emp_no
                        , ntbd_reg_date
                        , ntbd_subject
                        , ntbd_content
                    )
                VALUES (
                    #{ntbdCode}
                    , #{writerEmpNo}
                    , SYSDATE
                    , #{ntbdSubject}
                    , #{ntbdContent}
                )
            </insert>

            <delete id="deleteNotice" parameterType="String">
            /* kr.or.ddit.board.mapper.NoticeMapper.deleteNotice */
                DELETE FROM
                    tb_notice_board
                WHERE
                    ntbd_code = #{ntbdCode}
            </delete>
            
            <update id="updateNotice" parameterType="noticeBoardVO">
            /* kr.or.ddit.board.mapper.NoticeMapper.updateNotice */
                UPDATE
                    tb_notice_board
                SET
                    ntbd_subject = #{ntbdSubject}
                    , ntbd_content = #{ntbdContent}
                WHERE
                    ntbd_code = #{ntbdCode}
            </update>
            
            <delete id="deleteOneFile" parameterType="int">
            /* kr.or.ddit.board.mapper.NoticeMapper.deleteOneFile */
                DELETE FROM
                    tb_attach_file
                WHERE
                    file_no = #{fileNo}
            </delete>
            
            <delete id="deleteAllFile" parameterType="String">
            /* kr.or.ddit.board.mapper.NoticeMapper.deleteAllFile */
                DELETE FROM
                    tb_attach_file
                WHERE
                    file_code = #{ntbdCode}
            </delete>
            
        </mapper>
    </details>

    `🖥️ jsp`
    <details>
        <summary>noticeList.jsp</summary>

        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
        <sec:authentication property="principal.employee" var="empVO" />
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <script src="/resources/js/jquery-3.6.0.js"></script>
        </head>
        <body>
            <div class="card">
                <div id="wrapper">
                    <!-- notice header 시작 -->
                    <form name="searchForm" id="searchForm">
                        <input type="hidden" name="category" value="제목" />
                        <div id="noticeHeader">
                            <div>
                                <h4 class="card-header">공지사항</h4>
                                <p style="margin:13px 0px 13px 25px;">🔔 총 ${noticeCount}개의 게시글이 있습니다.</p>
                            </div>
                            <div class="btn-group">
                                <button type="button" id="searchCtgr" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"></button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item searchCtgr" id="seachCtgr1" href="javascript:void(0);">제목</a></li>
                                    <li><a class="dropdown-item searchCtgr" id="seachCtgr2" href="javascript:void(0);">작성자</a></li>
                                    <li><a class="dropdown-item searchCtgr" id="seachCtgr3" href="javascript:void(0);">내용</a></li>
                                </ul>
                            </div>
                            <div class="input-group input-group-merge" id="noticeSearch">
                                <span class="input-group-text noticeSearchSpan" id="basic-addon-search31">
                                    <i class="bx bx-search"></i></span>
                                <input type="text" class="form-control" name="keyword" value="${param.keyword}" 
                                    placeholder="검색" id="searchInput" aria-label="Search..." aria-describedby="basic-addon-search31">
                            </div>
                        </div><!-- notice header 끝 -->
                    </form>
                    
                    <!-- 테이블 처리 -->
                    <div class="table-responsive text-nowrap">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>제목</th>
                                    <th>첨부</th>
                                    <th>등록일자</th>
                                    <th>작성자</th>
                                    <th>조회수</th>
                                </tr>
                            </thead>
                            <tbody class="table-border-bottom-0">
                                <!-- list : List<NoticeBoardVO> -->
                                <c:forEach var="noticeVO" items="${data.content}" varStatus="stat">
                                    <tr>
                                        <td>${noticeVO.rnum2}</td>
                                        <td><a href='/board/detail/${noticeVO.ntbdCode}'>
                                            <span class="badge bg-label-secondary">${noticeVO.deptName}</span>&nbsp;${noticeVO.ntbdSubject}</a>
                                        </td>
                                        <td>
                                            <c:set var="imageCnt" value="0" />
                                            <c:if test="${fn:length(noticeVO.fileList)>0}">
                                                <c:forEach var="attachFileVO" items="${noticeVO.fileList}">						            		
                                                    <c:if test="${not fn:contains(attachFileVO.fileContType,'image')}">
                                                        <c:set var="imageCnt" value="1" />
                                                    </c:if>					            			
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${imageCnt>0}">	
                                                <img src="/resources/images/file_clip.png" style="width:15px; margin-left:4px;">
                                            </c:if>
                                        </td>
                                        <td>${noticeVO.ntbdRegDate}</td>
                                        <td>${noticeVO.empName}</td>
                                        <td>${noticeVO.ntbdHit}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${data.hasNoArticles()}">
                                    <tr>
                                        <td colspan="6" style="text-align:center; font-size:15px; font-weight:500;">
                                            <br><br><br><br><br><br>
                                            조회할 게시글이 없습니다.
                                            <br><br><br><br><br><br>
                                            <br><br><br><br><br><br>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div><!-- table div 끝 -->
                    
                    <c:if test="${empVO.deptCode == 'D006' || empVO.deptCode == 'D003' || empVO.deptCode == 'D000'}">
                        <button type="button" class="btn btn-info" id="writeBtn" onclick="location.href='/board/write'">등록</button>
                    </c:if>

                    <c:if test="${param.currentPage==null}">
                        <c:set var="currentPage" value="1" />
                    </c:if>
                    <c:if test="${param.currentPage!=null}">
                        <c:set var="currentPage" value="${param.currentPage}" />
                    </c:if>

                    <!-- 페이징 처리 -->
                    <div id="noticeFooter">
                        <c:if test="${data.hasArticles()}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination" style="justify-content:center;">
                                    <li class="page-item prev <c:if test='${data.startPage lt 6}'>disabled</c:if>">
                                    <a class="page-link" href="/board/notice?currentPage=${currentPage-5}&size=${data.size}">
                                        <i class="tf-icon bx bx-chevrons-left"></i></a>
                                    </li>
                                    
                                    <c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
                                        <li class='page-item <c:if test="${currentPage eq pNo}">active</c:if>'>
                                            <a class="page-link" href="/board/notice?currentPage=${pNo}&size=${data.size}&keyword=${param.keyword}">${pNo}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <li class='page-item next <c:if test="${data.endPage ge data.totalPages}">disabled</c:if>'>
                                    <a class="page-link" href="/board/notice?currentPage=${data.startPage+5}&size=${data.size}">
                                        <i class="tf-icon bx bx-chevrons-right"></i></a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div><!-- noticeFooter 끝 -->
                    
                </div><!-- wrapper 끝 -->
            </div><!-- card 끝 -->
        </body>
        <script>

        //-------------------- 웹소켓 ----------------------
        function fMessage() { // 받는 쪽에 작성
            let serverMsg = JSON.parse(event.data);

            if(serverMsg.cmd == "alarm") {
                getNotiList();
            }
        }
        //-------------------- /웹소켓 ----------------------

        $(function(){
            
            // 기본값을 제목으로
            $('#searchCtgr').text("제목");
            $('#searchCtgr').on('click', function() {
                // 현재 선택된 버튼값
                let nowText = $('#searchCtgr').text();
                    
                // 드롭다운 메뉴의 모든 값 표시
                $('.dropdown-menu li').show(); 
                
                // 현재 선택된 버튼값과 같은 li 숨김
                $('.dropdown-menu li:contains(' + nowText + ')').hide(); 
            });
            
            // 드롭다운 메뉴 선택 시 변경
            var oldBtnVal = "";
            $('.dropdown-menu').on('click', '.searchCtgr', function () {
                // 선택한 드롭다운 메뉴
                let newBtnVal = $(this).text();

                // 버튼값 업데이트
                $('#searchCtgr').text(newBtnVal); 

                $("input[name='category']").val(newBtnVal);
                
                // 이전 버튼값을 다시 드롭다운 메뉴에 추가
                if (oldBtnVal !== "") {
                    $('.dropdown-menu').append(oldBtnVal);
                }

                // 클릭된 항목의 부모인 <li> 태그를 삭제
                oldBtnVal = $(this).parent();
                oldBtnVal.remove();
            });
            
            // 검색 시 엔터 클릭 이벤트 
            $('#searchInput').keyup(function(event) {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    $("#searchForm").submit();
                }
            });
            
            // 검색 후 드롭다운 유지 처리
            let category = "${param.category}";
            console.log("category : " + category);
            if(category!=null) {
                if(category=="작성자") {
                    $("#searchCtgr").text("작성자");
                    $("input[name='category']").val("작성자");
                } else if(category=="내용") {
                    $("#searchCtgr").text("내용");
                    $("input[name='category']").val("내용");
                } else{
                    $("#searchCtgr").text("제목");
                    $("input[name='category']").val("제목");
                }
            }
            
            if ("${param.result}" == "1") {
                Swal.fire({
                    icon: 'success',
                    title: '공지사항이 등록되었습니다.'
                });
                
                let msg = {
                    to : "all",
                    from : "예린",
                    cmd : "alarm",
                    data : "새로운 공지사항이 등록되었습니다."
                }
                webSocket.send(JSON.stringify(msg));
            }
        });
        </script>
        </html>
    </details>

    <details>
        <summary>noticeWrite.jsp</summary>

        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
        <sec:authentication property="principal.employee" var="empVO" />
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
        <script src="/resources/js/jquery-3.6.0.js"></script>
        </head>
        <body>
            <div class="card">
                <div id="wrapper">
                    <div class="noticeHeader">
                        <h4 class="card-header">공지사항 작성</h4>
                    </div><!-- notice header 끝 -->

                    <form id="writeForm" action="/board/write" method="post" enctype="multipart/form-data">
                        <div class="noticeBody">
                            <div class="flex">
                                <label for="smallInput" class="form-label writeLabel" style="width:61px;">제목</label>
                                <input id="smallInput" class="form-control form-control-sm writeInput-long" type="text" name="ntbdSubject">
                            </div>
                            <div class="flex">
                                <input type="hidden" name="writerEmpNo" value="${empVO.empNo}">
                                <label for="smallInput" class="form-label writeLabel" style="width:37px;">작성자</label>
                                <input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="empName" value="${empVO.empNm}" readonly>
                                <label for="smallInput" class="form-label writeLabel">부서</label>
                                <input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="deptName" value="${empVO.comCodeName}" readonly>
                                <label for="smallInput" class="form-label writeLabel">작성일자</label>
                                <input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="ntbdRegDate" readonly>
                            </div>
                            <div class="flex">
                                <label for="smallInput" class="form-label writeLabel" style="width:74px;">첨부</label>
                                <input id="formFileMultiple" class="form-control form-control-sm" type="file" name="files" multiple>
                            </div>
                            <div class="flex" style="margin-right:40px;">
                                <label for="smallInput" class="form-label writeLabel" style="margin-right:10px;width:52px;">내용</label>
                                <textarea class="form-control" name="ntbdContent"></textarea>
                            </div>
                        </div>
                    
                    <div class="noticeFooter" id="insertBtns">
                        <button type="submit" class="btn btn-primary" id="insertBtn">등록</button>
                        <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
                    </div><!-- noticeFooter 끝 -->
                    </form>	
                </div><!-- wrapper 끝 -->
            </div><!-- card 끝 -->
        </body>
        <script>

        //-------------------- 웹소켓 ----------------------
        function fMessage() { // 받는 쪽에 작성
            let serverMsg = JSON.parse(event.data);

            if(serverMsg.cmd == "alarm") {
                getNotiList();
            }
        }
        //-------------------- /웹소켓 ----------------------

        $(function(){
            $('input[name=ntbdRegDate]').val(getToday());
            
        });

        function getToday() {
            var date = new Date();
            var year = date.getFullYear();
            var month = ("0" + (1 + date.getMonth())).slice(-2);
            var day = ("0" + date.getDate()).slice(-2);

            return year + "-" + month + "-" + day;
        }

        // 글쓰기 취소
        $('#cancelBtn').on('click', function() {
            Swal.fire({
                title: '공지사항 등록을 취소하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                location.href='/board/notice';
            });
        });

        // CKEDITOR 설정
        CKEDITOR.replace("ntbdContent", {
            height: 290, width: 1562
        });
            
        </script>
        </html>
    </details>

    <details>
        <summary>noticeModify.jsp</summary>

        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <sec:authentication property="principal.employee" var="empVO" />
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
        <script src="/resources/js/jquery-3.6.0.js"></script>
        </head>
        <body>
            <div class="card">
                <div id="wrapper">
                    <div class="noticeHeader">
                        <h4 class="card-header">공지사항 수정</h4>
                    </div><!-- notice header 끝 -->

                    <form id="writeForm" action="/board/update" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="_method" value="put"/>
                        <div style="width:70vw;height:65vh;overflow:auto;">
                            <div class="noticeBody">
                                <div class="flex">
                                    <input type="hidden" name="ntbdCode" value="${noticeBoardVO.ntbdCode}">
                                    <label for="smallInput" class="form-label writeLabel" style="width:61px;">제목</label>
                                    <input id="smallInput" class="form-control form-control-sm writeInput-long" type="text" value="${noticeBoardVO.ntbdSubject}" name="ntbdSubject">
                                </div>
                                <div class="flex">
                                    <input type="hidden" name="writerEmpNo" value="${empVO.empNo}">
                                    <label for="smallInput" class="form-label writeLabel" style="width:37px;">작성자</label>
                                    <input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="empName" value="${empVO.empNm}" readonly>
                                    <label for="smallInput" class="form-label writeLabel">부서</label>
                                    <input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="deptName" value="${empVO.comCodeName}" readonly>
                                    <label for="smallInput" class="form-label writeLabel">작성일자</label>
                                    <input id="smallInput" class="form-control form-control-sm writeInput-short" type="text" name="ntbdRegDate" value="${noticeBoardVO.ntbdRegDate}" readonly>
                                </div>
                                <div style="display:flex; margin-left:24px;">
                                    <label for="smallInput" class="form-label writeLabel" style="width:29px;">첨부</label>
                                    <div style="margin-left:18px;width:63.8vw;">
                                        <input type="hidden" name="chkFilesParam" id="chkFilesParam">
                                        <c:forEach var="fileList" items="${noticeBoardVO.fileList}">
                                            <div class="eachFile">
                                                <input class="form-check-input" type="checkbox" name="chkFileNo" value="${fileList.fileNo}" id="defaultCheck3" checked>
                                                &nbsp;${fileList.fileName}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="flex" style="margin-right:40px; overflow:auto;">
                                    <label for="smallInput" class="form-label writeLabel" style="margin-right:10px;width:52px;">내용</label>
                                    <textarea class="form-control" name="ntbdContent">${noticeBoardVO.ntbdContent}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="noticeFooter" id="updateBtns">
                            <button type="submit" class="btn btn-primary" id="updateBtn">등록</button>
                            <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
                        </div><!-- notice Footer 끝 -->
                    </form>
                </div><!-- wrapper 끝 -->
            </div><!-- card 끝 -->
        </body>
        <script>
        //-------------------- 웹소켓 ----------------------
        function fMessage() { // 받는 쪽에 작성
            let serverMsg = JSON.parse(event.data);

            if(serverMsg.cmd == "alarm") {
                getNotiList();
            }
        }
        //-------------------- /웹소켓 ----------------------

        $(function(){
            $('input[name=ntbdRegDate]').val(getToday());
            CKEDITOR.instances.ntbdContent.getData();
        });

        $('#updateBtn').on('click', function() {
            // 체크박스 선택된 파일만 배열에 넣기
            console.log("파일 배열에 넣을거다");
            let chkFiles = [];
            $('input:checkbox[name=chkFileNo]:not(:checked)').each(function() {
                chkFiles.push(this.value);
                console.log("push!" + chkFiles);
            });
            console.log("체크 해제된 파일들: ", chkFiles);
            $('#chkFilesParam').val(chkFiles); // input type hidden에 value set
            $('#writeForm').submit();
        });

        // 오늘 날짜 가져오기 (작성일자)
        function getToday() {
            var date = new Date();
            var year = date.getFullYear();
            var month = ("0" + (1 + date.getMonth())).slice(-2);
            var day = ("0" + date.getDate()).slice(-2);

            return year + "-" + month + "-" + day;
        }

        //글수정 취소
        $('#cancelBtn').on('click', function() {
            Swal.fire({
                title: '공지사항 작성을 취소하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                location.href='/board/notice';
            });
        });

        // CKEDITOR 설정
        CKEDITOR.replace("ntbdContent", {
            height: 250, width: 1562
        });
            
        </script>
        </html>
    </details>

    `🖥️ view`
    <details>
        <summary>공지사항 조회</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/b3460303-e3ce-41e6-9e21-fb5dff93f75a">
    </details>
    
    <details>
        <summary>공지사항 검색</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/04c48fa6-5831-4c56-8a1c-01bd814c719c">
    </details>

    <details>
        <summary>공지사항 상세조회</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/4a749ad1-cf4b-463b-9934-068d99f24ffa">
    </details>
    <details>
        <summary>공지사항 작성</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/b58e0f8c-4767-4153-905c-2c4d9c589d9d">
    </details>
    <details>
        <summary>공지사항 수정</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/7ff77e37-f8bb-4960-a675-b8f4320848a1">
    </details>

### ☑️ 발주
* **구현 기능** : 발주 신청 약품(비품) 조회 / 신청 약품(비품) 반려 / 신청 약품(비품) 거래처별 승인 / 발주내역 PDF로 출력 및 다운로드
* 약품(비품)별 신청내역 조회
* 체크박스를 사용하여 약품(비품) 반려
* 거래처별 약품(비품) 조회 후 발주 승인 처리
* 발주 승인 시 발주내역에서 조회 가능
* 발주내역에서는 jdPDF API를 사용하여 PDF로 출력 및 다운로드 가능
* **CODE**
  
    `🖥️ controller`
    <details>
        <summary>ItemOrderController.java</summary>

        @Controller
        @Slf4j
        @RequestMapping("/order")
        public class ItemOrderController {
            
            @Autowired
            private itemOrderService service;
            @Autowired
            private TbAttachFileMapper fileMapper; // pdf 파일 저장
            
            // [view] 약품 메인 view
            @GetMapping(value="/mediItem")
            public String getMediItemView() {
                log.debug("<<< 여기는 getMediItemView >>>");
                
                return "order/mediItem";
            }
            
            // [view] 비품 메인 view
            @GetMapping(value="/equipItem")
            public String getEquipItemView() {
                log.debug("<<< 여기는 getEquipItemView >>>");
                
                return "order/equipItem";
            }
            
            // [select List] 약품 신청 조회
            @ResponseBody
            @GetMapping(value="/mediList", produces="application/json; charset=utf-8")
            public List<MediItemReqDetailVO> getMediItemList() {
                log.debug("<<< 여기는 getMediItemList >>>");
                
                List<MediItemReqDetailVO> mediItemList = service.getMediItemList();
                return mediItemList; 
            }
            
            // [select List] 비품 신청 조회
            @ResponseBody
            @GetMapping(value="/equipList", produces="application/json; charset=utf-8")
            public List<ItemReqDetailVO> getEquipItemList() {
                log.debug("<<< 여기는 getEquipItemList >>>");
                
                List<ItemReqDetailVO> equipItemList = service.getEquipItemList();
                
                return equipItemList;
            }
            
            // [select] 약품리스트에 있는 거래처 조회 (발주모달의 select option)
            @ResponseBody
            @GetMapping(value="/mediCompanyList", produces="application/json; charset=utf-8")
            public List<MediItemReqDetailVO> getMediCompanyName() {
                log.debug("<<< 여기는 getCompanyName >>>");
                
                List<MediItemReqDetailVO> companyList = service.getMediCompanyName();
                return companyList;
            }
            
            // [select] 비품리스트에 있는 거래처 조회 (발주모달의 select option)
            @ResponseBody
            @GetMapping(value="/equipCompanyList", produces="application/json; charset=utf-8")
            public List<ItemReqDetailVO> getItemCompanyName() {
                log.debug("<<< 여기는 getItemCompanyName >>>");
                
                List<ItemReqDetailVO> companyList = service.getItemCompanyName();
                return companyList;
            }
            
            // [select] 거래처별 약품리스트 (발주모달의 table)
            @ResponseBody
            @GetMapping(value="/mediListByCompany/{companyName}", produces="application/json; charset=utf-8")
            public List<MediItemReqDetailVO> mediItemByCompany(@PathVariable String companyName) {
                log.debug("<<< 여기는 mediItemByCompany >>>");
                
                List<MediItemReqDetailVO> listByCompany = service.mediItemByCompany(companyName);
                
                return listByCompany;
            }
            
            // [select] 거래처별 비품리스트 (발주모달의 table)
            @ResponseBody
            @GetMapping(value="/equipListByCompany/{companyName}", produces="application/json; charset=utf-8")
            public List<ItemReqDetailVO> equipItemByCompany(@PathVariable String companyName) {
                log.debug("<<< 여기는 mediItemByCompany >>>");
                
                List<ItemReqDetailVO> listByCompany = service.equipItemByCompany(companyName);
                
                return listByCompany;
            }
            
            // [update] 약품 발주 승인
            @ResponseBody
            @Transactional
            @PutMapping(value="/approveMedi", produces="application/json; charset=utf-8")
            public int approveMedi(@RequestBody List<MediItemReqDetailVO> mediArray, Principal principal) {
                log.debug("<<< 여기는 approveMedi >>>");

                int result = 0;
                String nextNo = service.getMediOrderNum();
                String empNo = principal.getName();
                
                // 하나의 발주번호를 insert
                MediItemOrderVO mediVO = new MediItemOrderVO();
                mediVO.setEmpNo(empNo);
                mediVO.setMediItemOrderNo(nextNo);
                result += service.insertMediOrder(mediVO);
                
                for(int i=0; i<mediArray.size(); i++) {
        //			log.info("mediArray[" + i + "]: " + mediArray.get(i));
                    mediArray.get(i).setMediItemOrderNo(nextNo);
        //			log.info("controller에서 모두 set한 vo: " + mediArray.get(i));
                    // 발주 승인
                    result += service.approveMedi(mediArray.get(i));
                    result += service.addMediInventory(mediArray.get(i));
                }
                
                return result;
            }
            
            // [update] 비품 발주 승인
            @Transactional
            @ResponseBody
            @PutMapping(value="/approveEquip", produces="application/json; charset=utf-8")
            public int approveEquip(@RequestBody List<ItemReqDetailVO> equipArray, Principal principal) {
                log.debug("<<< 여기는 approveEquip >>>");
                
                int result = 0;
                String nextNo = service.getEquipOrderNum();
                String empNo = principal.getName();
                
                // 발주테이블에 insert
                ItemOrderVO equipVO = new ItemOrderVO();
                equipVO.setEmpNo(empNo);
                equipVO.setItemOrderNo(nextNo);
                result += service.insertEquipOrder(equipVO);
                
                for(int i=0; i<equipArray.size(); i++) {
                    equipArray.get(i).setItemOrderNo(nextNo);
                    result += service.approveEquip(equipArray.get(i));
                    result += service.addEquipInventory(equipArray.get(i));
                }
                return result;
            }
            
            // [select] 약품 상세조회
            @ResponseBody
            @PostMapping(value="/rejectMediList", produces="application/json; charset=utf-8")
            public List<MediItemReqDetailVO> rejectMediList(@RequestBody List<MediItemReqDetailVO> mediArray) {
                log.debug("<<< 여기는 rejectMediList >>>");
                List<MediItemReqDetailVO> mediList = new ArrayList<MediItemReqDetailVO>();
                MediItemReqDetailVO mediVO = new MediItemReqDetailVO();
                
                for(int i=0; i<mediArray.size(); i++) {
        //			log.info("mediArray[" + i + "]: " + mediArray);
                    mediVO = service.rejectMediList(mediArray.get(i));
        //			log.info(i + "번째 MediVO: " + mediVO);
                    mediList.add(mediVO);
                }
                return mediList;
            }
            
            // [select] 비품 상세조회
            @ResponseBody
            @PostMapping(value="/rejectEquipList", produces="application/json; charset=utf-8")
            public List<ItemReqDetailVO> rejectEquipList(@RequestBody List<ItemReqDetailVO> equipArray) {
                log.debug("<<< 여기는 rejectEquipList >>>");
                List<ItemReqDetailVO> equipList = new ArrayList<ItemReqDetailVO>();
                ItemReqDetailVO equipVO = new ItemReqDetailVO();
                
                for(int i=0; i<equipArray.size(); i++) {
                    log.info("equipArray[" + i + "]: " + equipArray);
                    equipVO = service.rejectEquipList(equipArray.get(i));
                    equipList.add(equipVO);
                }
                return equipList;
            }
            
            // [update] 약품 발주 반려
            @ResponseBody
            @PutMapping(value="/rejectMedi", produces="application/json; charset=utf-8")
            public int rejectMedi(@RequestBody List<MediItemReqDetailVO> mediArray) {
                log.debug("<<< 여기는 rejectMedi >>>");
                int result = 0;
                
                for(int i=0; i<mediArray.size(); i++) {
                    log.info("mediArray[" + i + "]: " + mediArray.get(i));
                    result += service.rejectReasonMedi(mediArray.get(i));
                    result += service.rejectMedi(mediArray.get(i));
                }
                return result;
            }
            
            // [update] 약품 발주 반려
            @ResponseBody
            @PutMapping(value="/rejectEquip", produces="application/json; charset=utf-8")
            public int rejectEquip(@RequestBody List<ItemReqDetailVO> equipArray) {
                log.debug("<<< 여기는 rejectEquip >>>");
                int result = 0;
                
                for(int i=0; i<equipArray.size(); i++) {
                    log.info("equipArray[" + i + "]" + equipArray.get(i));
                    result += service.rejectReasonEquip(equipArray.get(i));
                    result += service.rejectEquip(equipArray.get(i));
                }
                return result;
            }
            
            // [view] 발주 내역 
            @GetMapping("/detail")
            public String getDetailView() {
                log.debug("<<< 여기는 getDetailView >>>");
                
                return "order/detail";
            }
            
            // [select] 약품 발주리스트
            @ResponseBody
            @GetMapping(value="/mediOrderList", produces="application/json; charset=utf-8")
            public List<MediItemOrderVO> getMediOrderList() {
                log.debug("<<< 여기는 getMediOrderList >>>");
                
                List<MediItemOrderVO> mediOrderList = service.getMediOrderList();
        //		log.info("mediOrderList는 " + mediOrderList);
                
                return mediOrderList;
            }
            
            // [select] 비품 발주리스트
            @ResponseBody
            @GetMapping(value="/equipOrderList", produces="application/json; charset=utf-8")
            public List<ItemOrderVO> getEquipItemOrderList() {
                log.debug("<<< 여기는 getEquipItemOrderList >>>");
                
                List<ItemOrderVO> equipOrderList = service.getEquipOrderList();
                
                return equipOrderList;
            }
            
            // [select] 발주서에 들어갈 약품발주 상세내용
            @ResponseBody
            @GetMapping(value="/mediOrderDetail/{orderNo}", produces="application/json; charset=utf-8")
            public List<MediItemOrderVO> getMediOrderDetail(@PathVariable String orderNo) {
                log.debug("<<< 여기는 getMediOrderDetail >>>");
                
                List<MediItemOrderVO> mediItemDetail = service.getMediOrderDetail(orderNo);
                log.info("mediItemOrderVO는? ", mediItemDetail);
                
                return mediItemDetail;
            }
            
            // [select] 발주서에 들어갈 비품발주 상세내용
            @ResponseBody
            @GetMapping(value="/equipOrderDetail/{orderNo}", produces="application/json; charset=utf-8")
            public List<ItemOrderVO> getEquipOrderDetail(@PathVariable String orderNo) {
                log.debug("<<< 여기는 getEquipOrderDetail >>>");
                
                List<ItemOrderVO> itemOrderDetail = service.getEquipOrderDetail(orderNo);
                log.info("itemOrderVO는?" + itemOrderDetail);
                
                return itemOrderDetail;
            }
            
            // [download] pdf 다운로드
            @ResponseBody
            @PostMapping(value="/pdf", produces="application/json; charset=utf-8")
            public String pdfDownload(MultipartFile pdfFile, String orderNo, String fileName, Principal principal) throws Exception {
                
                log.debug("이름: {}", pdfFile.getName()); // pdfFile
                log.debug("리소스: {}", pdfFile.getResource()); // MultipartFile resource [pdfFile]
                log.debug("타입: {}", pdfFile.getContentType()); // application/pdf
                log.debug("사이즈: {}", pdfFile.getSize()); // 3570300
                log.debug("파일네임: {}", pdfFile.getOriginalFilename()); // blob

                log.debug("fileName" + fileName);
                String savePath = "d:/myTool/sts3WS/202303F_Team1/src/main/webapp/resources/upload/pdf/" + fileName;
                log.info("savePath" + savePath);
                pdfFile.transferTo(new File(savePath));
                
                // AttachFileVO에 값 세팅
                AttachFileVO attachFileVO = new AttachFileVO();
                attachFileVO.setFileCode(orderNo);
                attachFileVO.setFileName(fileName);
                attachFileVO.setFilePhysicPath(savePath);
                attachFileVO.setFileWebPath("/pdffiles/" + fileName);
                attachFileVO.setFileSize(pdfFile.getSize());
                attachFileVO.setFileContType(pdfFile.getContentType());
                attachFileVO.setRegUserId(principal.getName());
                
                log.info("attachFileVO는!!! " + attachFileVO);

                // TB_ATTACH_FILE 테이블에 insert
                fileMapper.attachFileRegist(attachFileVO);
                
                return "/pdf/" + fileName;
            }
        }

    </details>

    `🖥️ mapper`
    <details>
        <summary>ItemOrder-Mapper.xml</summary>
        
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
        <mapper namespace="kr.or.ddit.item.mapper.ItemOrderMapper">
                
            <!-- select 약품리스트 -->
            <select id="getMediItemList" resultType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.getMediItemList */
                SELECT
                    req.medi_item_req_no
                    , detail.medi_item_code
                    , item.medi_item_name
                    , item.medi_item_makr
                    , item.medi_item_price
                    , detail.medi_item_req_qy
                    , detail.medi_item_req_total
                    , to_char(req.medi_item_req_de, 'YYYY-MM-DD') AS mediItemReqDe
                    , req.emp_no, emp.emp_nm
                FROM
                    tb_medi_item_req_detail detail
                JOIN
                    tb_medi_item_list item
                ON
                    detail.medi_item_code = item.medi_item_code
                JOIN
                    tb_medi_item_request req
                ON
                    detail.medi_item_req_no = req.medi_item_req_no
                JOIN
                    tb_employee emp
                ON
                    req.emp_no = emp.emp_no
                WHERE detail.medi_item_confirm_ysno = '0'
                ORDER BY
                    req.medi_item_req_de DESC
            </select>
            
            <!-- select 비품리스트 -->
            <select id="getEquipItemList" resultType="itemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.getEquipItemList */
                SELECT req.item_req_no
                    , detail.item_code
                    , item.item_name
                    , item.item_makr
                    , item.item_price
                    , detail.item_req_qy
                    , to_char(req.item_req_de, 'YYYY-MM-DD') as item_req_de
                    , req.emp_no
                    , emp.emp_nm
                FROM
                    tb_item_req_detail detail
                JOIN
                    tb_item_list item
                ON
                    item.item_code = detail.item_code
                JOIN
                    tb_item_req req
                ON
                    detail.item_req_no = req.item_req_no
                JOIN
                    tb_employee emp
                ON
                    req.emp_no = emp.emp_no
                WHERE
                    detail.item_confirm_ysno = '0'
                ORDER BY
                    req.item_req_de DESC
            </select>
            
            <!-- select 약품신청목록에 있는 거래처 -->
            <select id="getMediCompanyName" resultType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.getMediCompanyName */
                SELECT item.medi_item_makr
                FROM
                    tb_medi_item_list item
                JOIN
                    tb_medi_item_req_detail detail
                ON
                    detail.medi_item_code = item.medi_item_code
                JOIN
                    tb_medi_item_request req
                ON
                    detail.medi_item_req_no = req.medi_item_req_no
                JOIN
                    tb_employee emp
                ON
                    req.emp_no = emp.emp_no
                WHERE
                    detail.medi_item_confirm_ysno = '0'
                GROUP BY
                    item.medi_item_makr
            </select>
            
            <!-- select 비품신청목록에 있는 거래처 -->
            <select id="getItemCompanyName" resultType="itemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.getItemCompanyName */
                SELECT item.item_makr
                FROM
                    tb_item_list item
                JOIN
                    tb_item_req_detail detail
                ON
                    detail.item_code = item.item_code
                JOIN
                    tb_item_req req
                ON
                    detail.item_req_no = req.item_req_no
                JOIN
                    tb_employee emp
                ON
                    req.emp_no = emp.emp_no
                WHERE
                    detail.item_confirm_ysno = '0'
                GROUP BY
                    item.item_makr
            </select>
                
            <!-- select 거래처별 약품리스트 (발주모달) -->
            <select id="mediItemByCompany" parameterType="String" resultType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.mediItemByCompany */
            SELECT
                req.medi_item_req_no
                , detail.medi_item_code
                , item.medi_item_name
                , item.medi_item_makr
                , item.medi_item_price
                , detail.medi_item_req_qy
                , detail.medi_item_req_total
                , to_char(req.medi_item_req_de, 'YYYY-MM-DD') AS mediItemReqDe
                , req.emp_no, emp.emp_nm
            FROM
                tb_medi_item_req_detail detail
            JOIN
                tb_medi_item_list item
            ON
                detail.medi_item_code = item.medi_item_code
            JOIN
                tb_medi_item_request req
            ON
                detail.medi_item_req_no = req.medi_item_req_no
            JOIN
                tb_employee emp
            ON
                req.emp_no = emp.emp_no
            WHERE
                item.medi_item_makr = #{mediItemMakr}
            AND
                detail.medi_item_confirm_ysno = '0'
            </select>
            
            <!-- select 거래처별 비품리스트 (발주모달) -->
            <select id="equipItemByCompany" parameterType="String" resultType="itemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.equipItemByCompany */
            SELECT
                req.item_req_no
                , detail.item_code
                , item.item_name
                , item.item_makr
                , item.item_price
                , detail.item_req_qy
                , detail.item_req_total
                , to_char(req.item_req_de, 'YYYY-MM-DD') AS itemReqDe
                , req.emp_no, emp.emp_nm
            FROM
                tb_item_req_detail detail
            JOIN
                tb_item_list item
            ON
                detail.item_code = item.item_code
            JOIN
                tb_item_req req
            ON
                detail.item_req_no = req.item_req_no
            JOIN
                tb_employee emp
            ON
                req.emp_no = emp.emp_no
            WHERE
                item.item_makr = #{itemMakr}
            AND
                detail.item_confirm_ysno = '0'
            </select>
            
            <!-- select 다음에 들어갈 약품 발주번호 -->
            <select id="getMediOrderNum" resultType="String">
            /* kr.or.item.mapper.ItemOrderMapper.getItemOrderNum */
            SELECT
                TO_CHAR(SYSDATE, 'YYMM')
                || '12'
                || TRIM(TO_CHAR
                    (NVL
                        (
                            (SELECT MAX(TO_NUMBER(SUBSTR(medi_item_order_no,-3)))
                            FROM tb_medi_item_order
                            WHERE medi_item_order_no LIKE TO_CHAR(sysdate,'YYMM') || '%')
                        , 0) + 1
                    , '000')
                )
            FROM DUAL
            </select>
            
            <!-- select 다음에 들어갈 비품 발주번호 -->
            <select id="getEquipOrderNum" resultType="String">
            /* kr.or.item.mapper.ItemOrderMapper.getEquipOrderNum */
            SELECT
                TO_CHAR(SYSDATE, 'YYMM')
                || '12'
                || TRIM(TO_CHAR
                    (NVL
                        (
                            (SELECT MAX(TO_NUMBER(SUBSTR(item_order_no,-3)))
                            FROM tb_item_order
                            WHERE item_order_no LIKE TO_CHAR(sysdate,'YYMM') || '%')
                        , 0) + 1
                    , '000')
                )
            FROM DUAL
            </select>
            
            <!-- update 약품 승인 -->
            <update id="approveMedi" parameterType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.approveMedi */
            UPDATE
                tb_medi_item_req_detail
            SET
                medi_item_confirm_ysno = '1'
                , medi_item_order_date = sysdate
                , medi_item_order_no = #{mediItemOrderNo}
            WHERE
                medi_item_req_no = #{mediItemReqNo}
            AND
                medi_item_code = #{mediItemCode}
            </update>
            
            <!-- update 약품 재고 늘리기 -->
            <update id="addMediInventory" parameterType="mediItemReqDetailVO">
            UPDATE
                tb_medi_item_inventory
            SET
                medi_item_invr_qty = medi_item_invr_qty + (
                    SELECT
                        SUM(detail.medi_item_req_qy) AS mediItemreqqy
                    FROM
                        tb_medi_item_order odr
                    JOIN
                        tb_medi_item_req_detail detail
                    ON
                        odr.medi_item_order_no = detail.medi_item_order_no
                    JOIN
                        tb_medi_item_list item
                    ON
                        detail.medi_item_code = item.medi_item_code
                    WHERE
                        odr.medi_item_order_no = #{mediItemOrderNo}
                    AND
                        item.medi_item_code = #{mediItemCode}
                )
            WHERE
                medi_item_code = #{mediItemCode}
            </update>
            
            <!-- update 비품 승인 -->
            <update id="approveEquip" parameterType="itemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.approveEquip */
            UPDATE
                tb_item_req_detail
            SET
                item_confirm_ysno = '1'
                , item_order_date = sysdate
                , item_order_no = #{itemOrderNo}
            WHERE
                item_req_no = #{itemReqNo}
            AND
                item_code = #{itemCode}
            </update>
            
            <!-- update 비품 재고 늘리기 -->
            <update id="addEquipInventory" parameterType="itemReqDetailVO">
            UPDATE
                tb_item_inventory
            SET
                item_invr_qty = item_invr_qty + (
                    SELECT
                        SUM(detail.item_req_qy) AS itemreqqy
                    FROM
                        tb_item_order odr
                    JOIN
                        tb_item_req_detail detail
                    ON
                        odr.item_order_no = detail.item_order_no
                    JOIN
                        tb_item_list item
                    ON
                        detail.item_code = item.item_code
                    WHERE
                        odr.item_order_no = #{itemOrderNo}
                    AND
                        item.item_code = #{itemCode}
                )
            WHERE
                item_code = #{itemCode}
            </update>
            
            <!-- insert 약품 발주 정보 -->
            <insert id="insertMediOrder" parameterType="mediItemOrderVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.insertMediOrder */
            INSERT INTO tb_medi_item_order (
                medi_item_order_no
                , emp_no
            )
            VALUES (
                #{mediItemOrderNo}
                , #{empNo}
            )
            </insert>
            
            <!-- insert 비품 발주 정보 -->
            <insert id="insertEquipOrder" parameterType="itemOrderVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.insertEquipOrder */
            INSERT INTO tb_item_order (
                item_order_no
                , emp_no
            )
            VALUES (
                #{itemOrderNo}
                , #{empNo}
            )
            </insert>
            
            <!-- select 약품 반려 리스트 -->
            <select id="rejectMediList" parameterType="mediItemReqDetailVO" resultType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.rejectMediList.rejectMediList */
            SELECT
                detail.medi_item_req_no
                , detail.medi_item_code
                , item.medi_item_name
                , item.medi_item_price
                , detail.medi_item_req_qy
                , detail.medi_item_req_total
                , req.emp_no
                , emp.emp_nm AS empNm
                , to_char(req.medi_item_req_de, 'YYYY-MM-DD') AS mediItemReqDe
                , item.medi_item_makr
            FROM
                tb_medi_item_req_detail detail
            JOIN
                tb_medi_item_list item
            ON
                detail.medi_item_code = item.medi_item_code
            JOIN
                tb_medi_item_request req
            ON
                detail.medi_item_req_no = req.medi_item_req_no
            JOIN
                tb_employee emp	
            ON
                req.emp_no = emp.emp_no
            WHERE
                detail.medi_item_req_no = #{mediItemReqNo}
            AND
                detail.medi_item_code = #{mediItemCode}
            </select>
            
            <!-- select 비품 반려 리스트 -->
            <select id="rejectEquipList" parameterType="itemReqDetailVO" resultType="itemReqDetailVO">
            /* kr.or.ddit.item.mapper.rejectMediList.rejectEquipList */
            SELECT
                detail.item_req_no
                , detail.item_code
                , item.item_name
                , item.item_price
                , detail.item_req_qy
                , detail.item_req_total
                , req.emp_no
                , emp.emp_nm AS empNm
                , to_char(req.item_req_de, 'YYYY-MM-DD') AS itemReqDe
                , item.item_makr
            FROM
                tb_item_req_detail detail
            JOIN
                tb_item_list item
            ON
                detail.item_code = item.item_code
            JOIN
                tb_item_req req
            ON
                detail.item_req_no = req.item_req_no
            JOIN
                tb_employee emp
            ON
                req.emp_no = emp.emp_no
            WHERE
                detail.item_req_no = #{itemReqNo}
            AND
                detail.item_code = #{itemCode}
            </select>

            <!-- update 반려사유인 약품만 -->
            <update id="rejectReasonMedi" parameterType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.rejectReasonMedi */
            UPDATE
                tb_medi_item_req_detail
            SET
                medi_item_return_why = '반려'
            WHERE
                medi_item_req_no = #{mediItemReqNo}
            AND
                medi_item_code = #{mediItemCode}
            </update>
            
            <!-- update 약품 반려 -->
            <update id="rejectMedi" parameterType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.rejectMedi */
            UPDATE
                tb_medi_item_req_detail detail
            SET
                medi_item_confirm_ysno = '2'
            WHERE
                medi_item_req_no = #{mediItemReqNo}
            </update>
            
            <!-- update 반려사유인 비품만 -->
            <update id="rejectReasonEquip" parameterType="mediItemReqDetailVO">
            /* kr.or.ddit.item.mapper.ItemOrderMapper.rejectReasonEquip */
            UPDATE
                tb_item_req_detail
            SET
                item_return_why = '반려'
            WHERE
                item_req_no = #{itemReqNo}
            AND
                item_code = #{itemCode}
            </update>
            
            <!-- update 비품 반려 -->
            <update id="rejectEquip" parameterType="itemReqDetailVO">
            /* kr.or.ddit.item.mapper.itemOrderMapper.rejectEquip */
            UPDATE
                tb_item_req_detail detail
            SET
                item_confirm_ysno = '2'
            WHERE
                item_req_no = #{itemReqNo}
            </update>
            
            <resultMap type="mediItemOrderVO" id="mediItemOrderMap">
                <id property="mediItemOrderNo" column="MEDI_ITEM_ORDER_NO" />
                <result property="empNo" column="EMP_NO" />
                <result property="empNm" column="empNm" />
                <result property="mediItemOrderDate" column="mediItemOrderDate" />
                <collection property="mediItemList" resultMap="mediItemListMap" />
            </resultMap>
            
            <resultMap type="mediItemListVO" id="mediItemListMap">
                <result property="mediItemCode" column="MEDI_ITEM_CODE" />
                <result property="mediItemName" column="MEDI_ITEM_NAME" />
                <result property="mediItemMakr" column="MEDI_ITEM_MAKR" />
                <result property="mediItemUnit" column="MEDI_ITEM_UNIT" />
                <result property="mediItemUsage" column="MEDI_ITEM_USAGE" />
                <result property="narcoticYn" column="NARCOTIC_YN" />
                <result property="mediItemPrice" column="MEDI_ITEM_PRICE" />
                <result property="mediItemReqQy" column="mediItemReqQy" />
                <result property="mediItemReqTotal" column="mediItemReqTotal" />
                <result property="mediItemReqNo" column="mediItemReqNo" />
            </resultMap>
            
            <!-- select 약품 발주리스트 -->
            <select id="getMediOrderList" parameterType="hashMap" resultMap="mediItemOrderMap">
            /* kr.or.ddit.item.mapper.itemOrderMapper.getMediOrderList */
            SELECT
                odr.medi_item_order_no
                , odr.emp_no
                , emp.emp_nm AS empNm
                , TO_CHAR(detail.medi_item_order_date, 'YYYY-MM-DD') AS
            mediItemOrderDate
                , item.medi_item_code
                , item.medi_item_name
                , item.medi_item_makr
                , item.medi_item_unit
                , item.medi_item_price
                , SUM(detail.medi_item_req_qy) AS mediItemReqQy
                , SUM(detail.medi_item_req_total) AS mediItemReqTotal
            FROM
                tb_medi_item_order odr
            JOIN
                tb_medi_item_req_detail detail
            ON
                odr.medi_item_order_no = detail.medi_item_order_no
            JOIN
                tb_medi_item_list item
            ON
                detail.medi_item_code = item.medi_item_code
            JOIN
                tb_employee emp
            ON
                emp.emp_no = odr.emp_no
            GROUP BY
                odr.medi_item_order_no,
                odr.emp_no,
                emp.emp_nm,
            TO_CHAR(detail.medi_item_order_date, 'YYYY-MM-DD'),
                item.medi_item_code
                , item.medi_item_name
                , item.medi_item_makr
                , item.medi_item_unit
                , item.medi_item_price
            ORDER BY
                odr.medi_item_order_no DESC

            </select>
            
            <!-- select 약품 발주 상세보기 -->
            <select id="getMediOrderDetail" parameterType="String" resultMap="mediItemOrderMap">
            /* kr.or.ddit.mapper.ItemOrderMapper.getMediOrderDetail */
            SELECT
                odr.medi_item_order_no
                , odr.emp_no
                , emp.emp_nm AS empNm
                , TO_CHAR(detail.medi_item_order_date, 'YYYY-MM-DD') AS
            mediItemOrderDate
                , item.medi_item_code
                , item.medi_item_name
                , item.medi_item_makr
                , item.medi_item_unit
                , item.medi_item_price
                , SUM(detail.medi_item_req_qy) AS mediItemReqQy
                , SUM(detail.medi_item_req_total) AS mediItemReqTotal
            FROM
                tb_medi_item_order odr
            JOIN
                tb_medi_item_req_detail detail
            ON
                odr.medi_item_order_no = detail.medi_item_order_no
            JOIN
                tb_medi_item_list item
            ON
                detail.medi_item_code = item.medi_item_code
            JOIN
                tb_employee emp
            ON
                emp.emp_no = odr.emp_no
            WHERE
                odr.medi_item_order_no = #{mediItemOrderNo}
            GROUP BY
                odr.medi_item_order_no,
                odr.emp_no,
                emp.emp_nm,
            TO_CHAR(detail.medi_item_order_date, 'YYYY-MM-DD'),
                item.medi_item_code
                , item.medi_item_name
                , item.medi_item_makr
                , item.medi_item_unit
                , item.medi_item_price
            ORDER BY
                odr.medi_item_order_no DESC
            </select>
            
            
            
            <resultMap type="itemOrderVO" id="itemOrderMap">
                <id property="itemOrderNo" column="ITEM_ORDER_NO" />
                <result property="empNo" column="EMP_NO" />
                <result property="empNm" column="empNm" />
                <result property="itemOrderDate" column="itemOrderDate" />
                <collection property="itemList" resultMap="itemListMap" />
            </resultMap>
            
            <resultMap type="itemListVO" id="itemListMap">
                <result property="itemCode" column="ITEM_CODE" />
                <result property="itemName" column="ITEM_NAME" />
                <result property="itemMakr" column="ITEM_MAKR" />
                <result property="itemUsage" column="ITEM_USAGE" />
                <result property="itemPrice" column="ITEM_PRICE" />
                <result property="itemReqNo" column="itemReqNo" />
                <result property="itemReqQy" column="itemReqQy" />
                <result property="itemReqTotal" column="itemReqTotal" />
            </resultMap>
            
            <!-- select 비품 발주리스트 -->
            <select id="getEquipOrderList" parameterType="hashMap" resultMap="itemOrderMap">
            /* kr.or.ddit.item.mapper.itemOrderMapper.getEquipOrderList */
            SELECT
                odr.item_order_no
                , odr.emp_no
                , emp.emp_nm AS empNm
                , TO_CHAR(detail.item_order_date, 'YYYY-MM-DD') AS itemOrderDate
                , item.item_code
                , item.item_name
                , item.item_makr
                , item.item_price
                , SUM(detail.item_req_qy) AS itemReqQy
                , SUM(detail.item_req_total) AS itemReqTotal
            FROM
                tb_item_order odr
            JOIN
                tb_item_req_detail detail
            ON
                odr.item_order_no = detail.item_order_no
            JOIN
                tb_item_list item
            ON
                detail.item_code = item.item_code
            JOIN
                tb_employee emp
            ON
                emp.emp_no = odr.emp_no
            GROUP BY
                odr.item_order_no,
                odr.emp_no,
                emp.emp_nm,
            TO_CHAR(detail.item_order_date, 'YYYY-MM-DD'),
                item.item_code
                , item.item_name
                , item.item_makr
                , item.item_price
            ORDER BY
                odr.item_order_no DESC
            </select>
            
            <!-- select 비품 발주 상세 -->
            <select id="getEquipOrderDetail" parameterType="String" resultMap="itemOrderMap">
            /* kr.or.ddit.item.mapper.itemOrderMapper.getEquipOrderDetail */
            SELECT
                odr.item_order_no
                , odr.emp_no
                , emp.emp_nm AS empNm
                , TO_CHAR(detail.item_order_date, 'YYYY-MM-DD') AS itemOrderDate
                , item.item_code
                , item.item_name
                , item.item_makr
                , item.item_price
                , SUM(detail.item_req_qy) AS itemReqQy
                , SUM(detail.item_req_total) AS itemReqTotal
            FROM
                tb_item_order odr
            JOIN
                tb_item_req_detail detail
            ON
                odr.item_order_no = detail.item_order_no
            JOIN
                tb_item_list item
            ON
                detail.item_code = item.item_code
            JOIN
                tb_employee emp
            ON
                emp.emp_no = odr.emp_no
            WHERE
                odr.item_order_no = #{itemOrderNo}
            GROUP BY
                odr.item_order_no,
                odr.emp_no,
                emp.emp_nm,
            TO_CHAR(detail.item_order_date, 'YYYY-MM-DD'),
                item.item_code
                , item.item_name
                , item.item_makr
                , item.item_price
            ORDER BY
                odr.item_order_no DESC
            </select>
            
        </mapper>
    </details>

    `🖥️ script`
    <details>
        <summary>mediItem.jsp, equipItem.jsp</summary>

        // 주요 코드 위주로 첨부하였습니다!

        $(function(){
            getMediItemList(function() {
                // mediItemTable 전체선택, 전체해제 이벤트
                $("#selectAll").on('click',function() {
                    if($("#selectAll").is(":checked")) $("input[name='chkArr[]']").prop("checked", true);
                    else $("input[name='chkArr[]']").prop("checked", false);
                });
                // mediItemTable에서 하나라도 체크 해제 시 전체해제 되게
                $("input[name='chkArr[]']").on('click', function() {
                    var total = $("input[name='chkArr[]']").length;
                    var checked = $("input[name='chkArr[]']:checked").length;
                
                    if(total != checked) $("#selectAll").prop("checked", false);
                    else $("#selectAll").prop("checked", true); 
                });
            });
            
        });

        // 약품 신청 조회 리스트 뿌리기
        const getMediItemList = (callback) => {
        // 	console.log("여기는 getMediItemList");
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/order/mediList", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
        // 			console.log("받아온 약품 신청 조회 리스트", result);
                    
                    $('#orderHeader p').text("🔔 총 " + result.length + "개의 약품신청내역이 있습니다.");
                    
                    let tblStr = `<table class="table table-hover" id="mediItemTable">
                                <thead>
                                    <tr>
                                        <th><input class="form-check-input" type="checkbox" id="selectAll"></th>
                                        <th>약품코드</th>
                                        <th>약품명</th>
                                        <th>거래처</th>
                                        <th>단가</th>
                                        <th>신청수량</th>
                                        <th>총액</th>
                                        <th>신청일자</th>
                                        <th>신청인</th> 
                                    </tr>
                                </thead>
                                <tbody>`;
                    if (result.length == 0 || result == null) {
                        tblStr += `<tr>
                                        <td colspan="9" style="text-align:center;">
                                            <br><br><br><br><br><br><br><br><br><br>
                                            조회할 약품 신청 내역이 없습니다
                                            <br><br><br><br><br><br><br><br><br><br><br>
                                        </td>
                                    </tr>`;
                    } else {
                        for(let i=0; i<result.length; i++) {
                            tblStr += `<tr>`;
                            tblStr += `<td><input class="form-check-input" type="checkbox" name="chkArr[]" id="defaultCheck3">
                                            <input type="hidden" id="reqNo" value="\${result[i].mediItemReqNo}">
                                        </td>`;
                            tblStr += `<td>\${result[i].mediItemCode}</td>`;
                            tblStr += `<td>\${result[i].mediItemName}</td>`;
                            tblStr += `<td>\${result[i].mediItemMakr}</td>`;
                            tblStr += `<td>\${result[i].mediItemPrice}</td>`;
                            tblStr += `<td>\${result[i].mediItemReqQy}</td>`;
                            tblStr += `<td>\${result[i].mediItemReqTotal}</td>`;
                            tblStr += `<td>\${result[i].mediItemReqDe}</td>`;
                            tblStr += `<td>\${result[i].empNm}</td>`;
                            tblStr += `</tr>`;
                        }
                    }
                    tblStr += `</tbody></table>`;
                    
        // 			console.log("tblStr" + tblStr);
                    $('#orderListTable').html(tblStr);
                    
                    callback();
                } 
            }
            xhr.send();
        }

        // 발주 승인 모달 - select box의 option에 약품 신청 리스트에 있는 거래처명 append
        const getSelectCompany = () => {
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/order/mediCompanyList", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
        // 			console.log("약품목록에 있는 거래처명: ", result);
                    
                    // 기존의 option 요소 모두 제거
                    $("#selectCompany").empty();
                    
                    // 기본 선택 옵션 추가
                    $("#selectCompany").append('<option value="" selected disabled>선택</option>');

                    for(let i=0; i<result.length; i++) {
        // 				console.log(i + "번째 mediItemMakr: " + result[i].mediItemMakr);
                        $("#selectCompany").append(`<option value="\${result[i].mediItemMakr}">\${result[i].mediItemMakr}</option>`);
                    }
                }
            }
            xhr.send();
        }

        // 발주 승인 모달 - 거래처 선택 시 해당하는 약품 리스트 출력
        $('#selectCompany').on('change', function() {
            let companyName = this.value;
        // 	console.log("선택한 회사명: " + companyName);
            let url = "/order/mediListByCompany/" + companyName;
            let xhr = new XMLHttpRequest();
            xhr.open("get", url, true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status) {
                    let result = JSON.parse(xhr.responseText);
        // 			console.log("거래처에 따른 리스트: ", result);
                    
                    // tbody를 선택하여 변수로 저장
                    let tbody = $('#tableByCompany tbody');
                    // 모든 행 선택
                    let rows = tbody.find('tr');
                    
                    for(let i=0; i<result.length; i++) {
                        let row;
                        
                        // 기존테이블의 tr보다 result 개수가 더 많으면 tr을 추가
                        if (i >= rows.length) {
                            // 새로운 행 추가
                            tbody.append('<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
                            row = tbody.find('tr').eq(i);
                        } else {
                            // 기존 행 업데이트
                            row = rows.eq(i);
                        }
                        
                        row.find('td:eq(0)').text(result[i].mediItemReqNo);
                        row.find('td:eq(1)').text(result[i].mediItemCode);
                        row.find('td:eq(2)').text(result[i].mediItemName);
                        row.find('td:eq(3)').text(result[i].mediItemPrice);
                        row.find('td:eq(4)').text(result[i].mediItemReqQy);
                        row.find('td:eq(5)').text(result[i].mediItemReqTotal);
                        row.find('td:eq(6)').text(result[i].empNm);
                        row.find('td:eq(7)').text(result[i].mediItemReqDe);
                    }
                    
                    // 남은 기존 행 초기화 (이전의 결과 행보다 새로운 결과 행이 더 적은 경우)
                    for (let i=result.length; i<rows.length; i++) {
                        let row = rows.eq(i);
                        row.find('td').text("");
                    }
                }
            }
            xhr.send();
        });

        // 발주 승인 처리
        $('#orderBtn').on('click', function() {
        // 	console.log("발주 승인버튼 클릭");
            let mediArray = [];
            let selectValue = $('#selectCompany').val();
            if(selectValue == null) {
                // 발주할 약품이 없는 경우
                Swal.fire({
                    icon: 'error',
                    title: '발주할 약품이 없습니다.',
                    text: '발주할 약품을 선택 후 다시 시도해주세요.'
                });
            } else {
                Swal.fire({
                    title: '약품 발주를 승인하시겠습니까?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '확인',
                    cancelButtonText: '취소'
                }).then((result) => {
                    $('#tableByCompany tbody tr').each(function(index, element) {
                        // 값이 있을 때만 vo에 저장
                        if(element.children[0].innerHTML.trim() != "") {
                            let reqNo = $(element).find('td:eq(0)').text();
                            let mediCode = $(element).find('td:eq(1)').text();
                            
                            let mediItemReqDetailVO = {
                                    "mediItemReqNo" : reqNo,
                                    "mediItemCode" : mediCode
                            }
        // 				    console.log("승인할 mediItemReqDetailVO: " + JSON.stringify(mediItemReqDetailVO));
                            mediArray.push(mediItemReqDetailVO);
                        }
                    });
                    
                    let xhr = new XMLHttpRequest();
                    xhr.open("put", "/order/approveMedi", true);
                    xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
                    xhr.onreadystatechange = function() {
                        if(xhr.readyState == 4 && xhr.status == 200) {
                            let result = xhr.responseText;
        // 					console.log("승인 결과: " + result);
            
                            Swal.fire({
                                icon: 'success',
                                title: '신청건이 정상적으로 승인되었습니다.'
                            }).then((result) => { // 확인버튼 클릭 시 화면 이동
                                if (result.isConfirmed) {
                                    // 모달 숨기기
                                    $('.orderModal-wrap').hide();
                                    $('.orderModal-bg').hide();
                                    location.href = "/order/mediItem";
                                }
                            });
                        }
                    }
                    xhr.send(JSON.stringify(mediArray));
                });
            }
        });

        // 약품 반려 모달, 반려 테이블 체크박스 실행 함수
        const showRejectModal = () => {
            putChkArr(function() {
                // rejectItemTable 전체선택, 전체해제 이벤트
                $("#rejectSelectAll").on('click',function() {
                    if($("#rejectSelectAll").is(":checked")) $("input[name='rejectChkArr[]']").prop("checked", true);
                    else $("input[name='rejectChkArr[]']").prop("checked", false);
                });
                // mediItemTable에서 하나라도 체크 해제 시 전체해제 되게
                $("input[name='rejectChkArr[]']").on('click', function() {
                    let total = $("input[name='rejectChkArr[]']").length;
                    let checked = $("input[name='rejectChkArr[]']:checked").length;
                
                    if(total != checked) $("#rejectSelectAll").prop("checked", false);
                    else $("#rejectSelectAll").prop("checked", true); 
                });
            });
        };

        // 약품 반려 모달 처리
        const putChkArr = (callback) => {
            let selectChkBoxes= $("#mediItemTable input[name='chkArr[]']:checked");
            
            // 약품코드가 저장될 배열
            let mediArray = [];
            selectChkBoxes.each(function() {
                let reqNo = $(this).closest('tr').find('td:eq(0) input[type="hidden"]').val(); // 0번째 td인 신청번호 push
                let mediCode = $(this).closest('tr').find('td:eq(1)').text(); // 1번째 td인 약품코드 push
                let vo = {
                        "mediItemReqNo": reqNo,
                        "mediItemCode": mediCode
                }
                mediArray.push(vo);
        //         console.log("push하고 난 mediArray", mediArray);
            });
            
            // 선택한 약품이 없는 경우
            if(mediArray.length == 0 || mediArray == null) {
                Swal.fire({
                    icon: 'error',
                    title: '반려할 약품이 없습니다.',
                    text: '반려할 약품을 선택 후 다시 시도해주세요.'
                });
            // 선택한 약품이 있는 경우
            } else {
        //     	alert(JSON.stringify(mediArray)); // 체크

                let xhr = new XMLHttpRequest();
                xhr.open("post", "/order/rejectMediList", true);
                xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
                xhr.onreadystatechange = function() {
                    if(xhr.readyState == 4 && xhr.status == 200) {
                        let result = JSON.parse(xhr.responseText);
        // 				console.log("반려 약품리스트: ", result);
                        
                        $('.rejectModal-wrap').show();
                        $('.rejectModal-bg').show();
                        
                        // tbody를 선택하여 변수로 저장
                        let tbody = $('#rejectTable tbody');
                        // 모든 행 선택
                        let rows = tbody.find('tr');
                        
                        for(let i=0; i<result.length; i++) {
                            let row;
                            
                            // 기존테이블의 tr보다 result 개수가 더 많으면 tr을 추가
                            if (i >= rows.length) {
                                // 새로운 행 추가
                                tbody.append('<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>');
                                row = tbody.find('tr').eq(i);
                            } else {
                                // 기존 행 업데이트
                                row = rows.eq(i);
                            }
                            
                            row.find('td:eq(0)').html(`<input class="form-check-input" type="checkbox" name="rejectChkArr[]" id="defaultCheck3" checked>`);
                            row.find('td:eq(1)').text(result[i].mediItemReqNo);
                            row.find('td:eq(2)').text(result[i].mediItemCode);
                            row.find('td:eq(3)').text(result[i].mediItemName);
                            row.find('td:eq(4)').text(result[i].mediItemMakr);
                            row.find('td:eq(5)').text(result[i].mediItemPrice);
                            row.find('td:eq(6)').text(result[i].mediItemReqQy);
                            row.find('td:eq(7)').text(result[i].mediItemReqTotal);
                            row.find('td:eq(8)').text(result[i].empNm);
                            row.find('td:eq(9)').text(result[i].mediItemReqDe);
                        }
                        
                        // 남은 기존 행 초기화 (이전의 결과 행보다 새로운 결과 행이 더 적은 경우)
                        for (let i=result.length; i<rows.length; i++) {
                            let row = rows.eq(i);
                            row.find('td').text("");
                        }
                        
                        callback();
                    }
                    
                }
                xhr.send(JSON.stringify(mediArray));
            }
        };

        // 약품 반려 처리
        $('#rejectBtn').on('click', function() {
        // 	console.log("약품 반려 버튼 클릭");
            let selectChkBoxes= $("#rejectTable input[name='rejectChkArr[]']:checked");

            // 약품코드가 저장될 배열
            let mediArray = [];
            selectChkBoxes.each(function() {
                let reqNo = $(this).closest('tr').find('td:eq(1)').text(); // 1번째 td인 신청번호 push
                let mediCode = $(this).closest('tr').find('td:eq(2)').text(); // 2번째 td인 약품코드 push
                let vo = {
                    "mediItemReqNo": reqNo,
                    "mediItemCode": mediCode
                }
                mediArray.push(vo);
        // 			console.log("push하고 난 mediArray", JSON.stringify(mediArray));
                });
            
            // 선택한 약품이 없는 경우
            if(mediArray.length == 0 || mediArray == null) {
                Swal.fire({
                    icon: 'error',
                    title: '반려할 약품이 없습니다.',
                    text: '반려할 약품을 선택 후 다시 시도해주세요.'
                });
            // 선택한 약품이 있는 경우
            } else {
                Swal.fire({
                    title: '약품 신청을 반려하시겠습니까?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '확인',
                    cancelButtonText: '취소'
                }).then((result) => {
                    let xhr = new XMLHttpRequest();
                    xhr.open("put", "/order/rejectMedi", true);
                    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
                    xhr.onreadystatechange = function() {
                        let result = xhr.responseText;
            // 			console.log("반려 결과: " + result);
                        
                        Swal.fire({
                            icon: 'success',
                            title: '신청건이 정상적으로 반려되었습니다.'
                        }).then((result) => { // 확인버튼 클릭 시 화면 이동
                            if (result.isConfirmed) {
                                // 모달 숨기기
                                $('.rejectModal-wrap').hide();
                                $('.rejectModal-bg').hide();
                                location.href = "/order/mediItem";
                            }
                        });
                    }
                    xhr.send(JSON.stringify(mediArray));
                });
            }
        });
    </details>

    `🖥️ view`
    <details>
        <summary>발주 신청내역 조회</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/f193eda0-5f11-448c-b110-bb4d0e1d1f15">
    </details>
    
    <details>
        <summary>발주신청 반려처리</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/5251973b-864a-4398-9291-fac5671abfe7">
    </details>

    <details>
        <summary>발주신청 승인처리</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/f9541bf2-2900-409d-8403-70d589a2cc75">
    </details>

    <details>
        <summary>발주내역 조회</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/2ba79fc0-d59a-4459-b11b-041beea0c5b8">
    </details>

### ☑️ 캘린더
* **구현 기능** : 병원일정 조회 / 병원일정 등록 / 병원일정 수정 / 병원일정 삭제 / 의사일정 조회
* mobiscroll API 사용
* JSON key값을 이용하여 일정 카테고리별 색상 구분
* 권한이 있는 경우(직원의 부서에 따라 구분)에만 일정 등록/수정/삭제 가능
* **CODE**
  
    `🖥️ controller`
    <details>
        <summary>ScheduleController.java</summary>

        @Slf4j
        @RequestMapping("/calendar")
        @Controller
        public class ScheduleController {

            @Autowired
            public HosScheduleService hosScheduleService;
            @Autowired
            public ClinicScheduleService clinicScheduleService;
            @Autowired
            public NotificationService notificationService;

            // go to view
            // /calendar/schedule
            // /calendar/schedule?ntcnId=12
            @GetMapping("/schedule")
            public String getSchedule(HttpSession session, Principal principal,
                    @RequestParam(value="ntcnId",required=false) String ntcnId) {
                log.debug("세션", session.getMaxInactiveInterval());
                
                String empNo = principal.getName();
                log.info("ntcnId : " + ntcnId + ", empNo : " + empNo);
                
                // nicnId가 null이면 TB_NOTI_CHECK 테이블에 변화 없음
                NotiCheckVO notiCheckVO = new NotiCheckVO();
                if(ntcnId!=null) {
                    notiCheckVO.setNtcnId(Integer.parseInt(ntcnId));
                    notiCheckVO.setEmpNo(empNo);
                    
                    //nicnId가 있으면 TB_NOTI_CHECK 테이블에 insert (알림 읽음 처리)
                    this.notificationService.insertNotiCheck(notiCheckVO);		
                }
                return "calendar/schedule";
            }
            
            // 병원일정 select list
            @ResponseBody
            @GetMapping(value="/hosSchedules", produces="application/json; charset=utf-8")
            public List<HosScheduleVO> listHosSch() {
                List<HosScheduleVO> hosSchList = hosScheduleService.listHosSch();
                log.debug("여기는 병원일정 list : " + hosSchList);
                return hosSchList;
            }

            // 병원일정 insert
            @ResponseBody
            @PostMapping(value="/hosSchedule", produces="application/json; charset=utf-8")
            public int postHosSch(@RequestBody HosScheduleVO hosScheduleVO) {
                log.debug("여기는 병원일정 post: " + hosScheduleVO);
                
                return hosScheduleService.insertHosSch(hosScheduleVO);
            }
            
            // 병원일정 update
            @ResponseBody
            @PutMapping(value="/hosSchedule", produces="application/json; charset=utf-8")
            public int putHosSch(@RequestBody HosScheduleVO hosScheduleVO) {
                log.debug("여기는 병원일정 put: " + hosScheduleVO);
                return hosScheduleService.updateHosSch(hosScheduleVO);
            }
            
            // 병원일정 delete
            @ResponseBody
            @DeleteMapping(value="/hosSchedule/{hosSchNo}", produces="applicaytion/json; charset=utf-8")
            public int deleteHosSch(@PathVariable int hosSchNo) {
                HosScheduleVO hosScheduleVO = new HosScheduleVO();
                hosScheduleVO.setHosSchNo(hosSchNo);
                log.debug("여기는 병원일정 delete : " + hosScheduleVO);
                return hosScheduleService.deleteHosSch(hosScheduleVO);
            }
            
            // 의사일정 select list
            @ResponseBody
            @GetMapping(value="/clinicSchedules")
            public List<ClinicschFacilityEmpVO> listClinicSch() {
                List<ClinicschFacilityEmpVO> clinicSchList = clinicScheduleService.listHosSch();
                log.debug("여기는 의사일정 list: " + clinicSchList);
                return clinicSchList;
            }

            // 일정 업데이트 시 알림내역 목록
            @ResponseBody
            @PostMapping("/selectNoti")
            public List<NotificationVO> selectNoti(String empNo){
                log.info("empNo : " + empNo);
                
                List<NotificationVO> notificationVOList = this.notificationService.selectNoti(empNo);
                log.info("notificationVOList : " + notificationVOList);
                
                return notificationVOList;
            }
            
            // 일정 내역 전체삭제버튼
            @ResponseBody
            @GetMapping("/deleteNotiList")
            public int deleteNotiList(@RequestParam String empNo) {
                log.info("empNo : " + empNo);
                
                int res = this.notificationService.deleteNotiList(empNo);
                
                return res;
            }
        }
    </details>

    `🖥️ serviceImpl`
    <details>
        <summary>HosScheduleServiceImpl</summary>

        @Slf4j
        @Service
        public class HosScheduleServiceImpl implements HosScheduleService {

            @Autowired
            HosScheduleMapper hosScheduleMapper;

            @Autowired
            NotificationMapper notificationMapper;
            
            @Autowired 

            @Override
            public List<HosScheduleVO> listHosSch() {
                return hosScheduleMapper.listHosSch();
            }

            @Override
            public HosScheduleVO oneHosSch(HosScheduleVO hosScheduleVO) {
                return hosScheduleMapper.oneHosSch(hosScheduleVO);
            }

            @Override
            public int updateHosSch(HosScheduleVO hosScheduleVO) {
                return hosScheduleMapper.updateHosSch(hosScheduleVO);
            }

            @Override
            public int deleteHosSch(HosScheduleVO hosScheduleVO) {
                return hosScheduleMapper.deleteHosSch(hosScheduleVO);
            }

            @Transactional
            @Override
            public int insertHosSch(HosScheduleVO hosScheduleVO) {

                NotificationVO notiVO = new NotificationVO();

                notiVO.setNtcnTitle(hosScheduleVO.getHosSchTitle()); // 일정 제목(=알림제목)
                log.debug("hosScheduleVO.getHosSchTitle()" + hosScheduleVO.getHosSchTitle());
                
                notiVO.setNtcnContent("새로운 병원일정(" + hosScheduleVO.getHosSchTitle() + ")이 등록되었습니다.");
                notiVO.setNtcnGubun("일정");

                log.debug("notiVO" + notiVO);

                int result = hosScheduleMapper.insertHosSch(hosScheduleVO);
                result += notificationMapper.insertNoti(notiVO);

                log.debug("result : " + result);

                return result;
            }
        }
    </details>

    `🖥️ mapper`
    <details>
        <summary>HosSchedule-Mapper.xml</summary>
        
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
        <mapper namespace="kr.or.ddit.schedule.mapper.HosScheduleMapper">
            
            <select id="listHosSch" resultType="hosScheduleVO">
            /* kr.or.ddit.schedule.mapper.HosScheduleMapper.listHosSch */
            SELECT * FROM tb_hos_schedule
            </select>
            
            <select id="oneHosSch" resultType="hosScheduleVO">
            /* kr.or.ddit.schedule.mapper.HosScheduleMapper.hosSchDetail */
            SELECT * FROM tb_hos_schedule
            WHERE hos_sch_no = #{hosSchNo}	
            </select>
            
            <insert id="insertHosSch" parameterType="hosScheduleVO">
            /* kr.or.ddit.schedule.mapper.HosScheduleMapper.insertHosSch */
            INSERT INTO tb_hos_schedule(
                    hos_sch_no
                    , hos_sch_start
                    , hos_sch_end
                    , hos_sch_title
                    , hos_sch_cont
                    , hos_sch_url
                    , hos_sch_allday
                    , hos_sch_color
                )
            VALUES (
                seq_hos_schedule.nextval
                    , #{hosSchStart}
                    , #{hosSchEnd}
                    , #{hosSchTitle}
                    , #{hosSchCont}
                    , #{hosSchUrl}
                    , #{hosSchAllDay}
                    , #{hosSchColor}
                )
            </insert>
            
            <update id="updateHosSch" parameterType="hosScheduleVO">
            /* kr.or.ddit.schedule.mapper.HosScheduleMapper.updateHosSch */
            UPDATE tb_hos_schedule
            SET
                hos_sch_start=#{hosSchStart}
                , hos_sch_end=#{hosSchEnd}
                , hos_sch_title=#{hosSchTitle}
                , hos_sch_cont=#{hosSchCont}
                , hos_sch_url=#{hosSchUrl}
                , hos_sch_allday=#{hosSchAllDay}
                , hos_sch_color=#{hosSchColor}
            WHERE hos_sch_no=#{hosSchNo}
            </update>
            
            <delete id="deleteHosSch" parameterType="hosScheduleVO">
            /* kr.or.ddit.schedule.mapper.HosScheduleMapper.deleteHosSch */
            DELETE FROM tb_hos_schedule
            WHERE hos_sch_no = #{hosSchNo}
            </delete>
            
        </mapper>
    </details>

    `🖥️ script`
    <details>
        <summary>schedule.jsp</summary>

        // CRUD 코드 위주로 첨부하였습니다!

        // 병원일정 뿌리기(list)
        const hosEventList = function() {
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/calendar/hosSchedules", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log("병원일정 출력 시작");
                    // json 문자열을 json객체로
                    let result = JSON.parse(xhr.responseText);
                    let myData = [];

                    for (let i = 0; i < result.length; i++) {
                        let item = result[i];
                        let dataItem = {
                            no : item.hosSchNo,
                            title : item.hosSchTitle,
                            description : item.hosSchCont,
                            start : item.hosSchStart,
                            end : item.hosSchEnd,
                            allday : item.hosSchAllDay,
                            color : item.hosSchColor
                        }
                        myData.push(dataItem);
                    }
                    console.log("전체병원일정(myData): ", myData);

                    calendar.addEvent(myData);
                }
            }
            xhr.send();
        };

        // 병원일정 insert
        const insertEvent = function(event) {
            console.log("insertEvent로 넘어온 event", event);
            // 넘길 데이터
            let hosScheduleVO = {
                hosSchTitle : event.title,
                hosSchCont : event.description,
                hosSchStart : event.start,
                hosSchEnd : event.end,
                //    			hosSchUrl: ,
                hosSchColor : event.color,
                hosSchAllDay : event.allDay
            }
            console.log("insertEvent에서 저장된 VO ", hosScheduleVO);

            let xhr = new XMLHttpRequest();
            xhr.open('post', "/calendar/hosSchedule", true);
            xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log("일정 등록 체크: ", xhr.responseText);

                    let msg = {
                        to : "all",
                        from : "예린",
                        cmd : "alarm",
                        data : "새로운 병원 일정이 등록되었습니다."
                    }
                    webSocket.send(JSON.stringify(msg));

                    // 일정 업데이트 시 알림내역 목록
                    let empNo = "${empVO.empNo}";
                    console.log("로그인 한 empNo : " + empNo);

                    // 가상 폼
                    let formData = new FormData();
                    formData.append("empNo", empNo);

                    $
                            .ajax({
                                url : "/calendar/selectNoti",
                                processData : false,
                                contentType : false,
                                data : formData,
                                type : "post",
                                dataType : "json",
                                success : function(result) {
                                    console
                                            .log("result :"
                                                    + JSON.stringify(result));
                                    //result : List<NotificationVO>
                                    let str = "";
                                    let cnt = 0;
                                    $
                                            .each(
                                                    result,
                                                    function(index, notificationVO) {
                                                        str += "<li><a class='dropdown-item' href='/calendar/schedule?ntcnId="
                                                                + notificationVO.ntcnId
                                                                + "'>";
                                                        str += "<i class='fa fa-bell me-2'></i> <span class='align-middle'>"
                                                                + notificationVO.ntcnContent
                                                                + "</span></a>";
                                                        str += "</li><li><div class='dropdown-divider'></div></li>";
                                                        cnt++;
                                                    });
                                    $("#ulNoti").html(str);
                                    $("#circle").html(cnt);
                                },
                                error : function(xhr, status, error) {
                                    console.log("code: " + xhr.status);
                                    console.log("message: " + xhr.responseText);
                                    console.log("error: " + error);
                                }
                            });
                }
            }
            xhr.send(JSON.stringify(hosScheduleVO)); // json으로 변경 후 전송
        }

        // 병원일정 update
        const updateEvent = function(event) {
            // 넘길 데이터
            let hosScheduleVO = {
                hosSchNo : event.no,
                hosSchTitle : event.title,
                hosSchCont : event.description,
                hosSchStart : event.start,
                hosSchEnd : event.end,
                //    			hosSchUrl: ,
                hosSchColor : event.color,
                hosSchAllDay : event.allDay
            }
            console.log("updateEvent에서 저장된 VO ", hosScheduleVO);

            let xhr = new XMLHttpRequest();
            xhr.open("put", "/calendar/hosSchedule", true)
            xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log("일정수정 체크", xhr.responseText); // update 된 행의 수
                }
            }
            xhr.send(JSON.stringify(hosScheduleVO));
        }

        // 병원일정 delete
        const delEvent = function(event) {
            let xhr = new XMLHttpRequest();
            let url = "/calendar/hosSchedule/" + event.no;
            console.log("url : " + url);
            //     	console.log("delEvent에 넘어온 event.no", event.no);
            xhr.open("delete", url, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log("일정삭제체크", xhr.responseText); // delete 된 행의 개수
                    hosEventList();
                }
            }
            xhr.send();
        }
    </details>

    `🖥️ view`
    <details>
        <summary>일정 조회</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/0a6fbe3c-5158-4a2d-b11c-dde67d9859a2">
    </details>
    
    <details>
        <summary>일정 등록</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/0fdadd1c-33b8-482c-824d-e1a19d3d355c">
    </details>

    <details>
        <summary>일정 수정/삭제 (권한 있는 경우)</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/7cb8f6c0-5877-4257-9456-611e7c431664">
    </details>

### ☑️ 통계
* **구현 기능** : 환자 성별 통계 / 환자 연령대별 통계 / 내원 사유별 통계 / 내원 경로별 통계 / 최근 12개월 병원 매출 통계
* chart.js API를 사용하여 구현
* UNION ALL을 사용하여 쿼리 작성
* **CODE**
  
    `🖥️ controller`
    <details>
        <summary>ChartController.java</summary>

        @Slf4j
        @Controller
        @RequestMapping("/chart")
        public class ChartController {

            @Autowired
            private ChartService service;
            
            @GetMapping
            public String getChart() {
                log.debug("<<< 여기는 getChart >>>");
                
                return "statistics/chart";
            }
            
            @ResponseBody
            @GetMapping(value="/gender", produces="application/json; charset=utf-8")
            public List<ChartVO> getGenderData() {
                log.debug("<<< 여기는 getGenderData >>>");
                
                List<ChartVO> genderData = service.patCntByGender();
                log.info("genderData" + genderData);
                
                return genderData;
            }
            
            @ResponseBody
            @GetMapping(value="/age", produces="application/json; charset=utf-8")
            public List<ChartVO> getAgeData() {
                log.debug("<<< 여기는 getAgeData >>>");
                
                List<ChartVO> ageData = service.patCntByAge();
                log.info("ageData" + ageData);
                
                return ageData;
            }
            
            @ResponseBody
            @GetMapping(value="/reason", produces="application/json; charset=utf-8")
            public List<ChartVO> getVisitReason() {
                log.debug("<<< 여기는 getVisitReason >>>");
                
                List<ChartVO> reasonData = service.visitReasonCnt();
                log.info("reasonData" + reasonData);
                
                return reasonData;
            }
            
            @ResponseBody
            @GetMapping(value="/path", produces="application/json; charset=utf-8")
            public List<ChartVO> getVisitPath() {
                log.debug("<<< 여기는 getVisitPath >>>");
                
                List<ChartVO> pathData = service.visitPathCnt();
                log.info("pathData" + pathData);
                
                return pathData;
            }
            
            @ResponseBody
            @GetMapping(value="/sales", produces="application/json; charset=utf-8")
            public List<ChartVO> getSalesByMonth() {
                log.debug("<<< 여기는 getSalesByMonth >>>");
                
                List<ChartVO> salesData = service.salesByMonth();
                log.info("salesData" + salesData);
                
                return salesData;
            }
            
            @ResponseBody
            @GetMapping(value="/physio", produces="application/json; charset=utf-8")
            public List<ChartVO> getPhysioList() {
                log.debug("<<< 여기는 getPhysioList >>>");
                
                List<ChartVO> physioData = service.physioList();
                
                return physioData;
            }
        }
    </details>

    `🖥️ mapper`
    <details>
        <summary>Chart-Mapper.xml</summary>
        
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
        <mapper namespace="kr.or.ddit.statistics.mapper.ChartMapper">
            
            <select id="patCntByGender" resultType="chartVO">
            /* kr.or.ddit.board.mapper.ChartMapper.patCntByGender */
            SELECT
                'Female' AS dataLabel
                , COUNT(*) AS dataVal
            FROM
                TB_PATIENT
            WHERE
                PAT_GEN_CODE = 'F'
            UNION ALL
            SELECT
                'Male' AS dataLabel
                , COUNT(*) AS dataVal
            FROM
                TB_PATIENT
            WHERE
                PAT_GEN_CODE = 'M'
            </select>
            
            <select id="patCntByAge" resultType="chartVO">
            /* kr.or.ddit.board.mapper.ChartMapper.patCntByAge */
            SELECT
                '10대 미만' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) BETWEEN 0 AND 9
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM
                TB_PATIENT
            UNION ALL
            SELECT
                '10대' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) BETWEEN 10 AND 19
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM
                TB_PATIENT
            UNION ALL
            SELECT
                '20대' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) BETWEEN 20 AND 29
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM
                TB_PATIENT
            UNION ALL
            SELECT
                '30대' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) BETWEEN 30 AND 39
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM
                TB_PATIENT
            UNION ALL
            SELECT
                '40대' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) BETWEEN 40 AND 49
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM TB_PATIENT
            UNION ALL
            SELECT
                '50대' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) BETWEEN 50 AND 59
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM
                TB_PATIENT
            UNION ALL
            SELECT
                '60대' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) BETWEEN 60 AND 69
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM
                TB_PATIENT
            UNION ALL
            SELECT
                '60대 이상' AS dataLabel
                , SUM(
                    CASE WHEN TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE(PAT_BRTHDY, 'YYYYMMDD')) / 12) >= 70
                            THEN 1
                            ELSE 0
                    END) AS dataVal
            FROM
                TB_PATIENT
            </select>
            
            <select id="visitPathCnt" resultType="chartVO">
            /* kr.or.ddit.board.mapper.ChartMapper.visitPathCnt */
            SELECT
                '지역거주자' AS dataLabel
                , SUM(CASE WHEN RCEPT_PATH_CODE = '1' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_RECEIPT
            UNION ALL
            SELECT '지인소개' AS dataLabel
                , SUM(CASE WHEN RCEPT_PATH_CODE = '2' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_RECEIPT
            UNION ALL
            SELECT '제휴업체' AS dataLabel
                , SUM(CASE WHEN RCEPT_PATH_CODE = '3' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_RECEIPT
            UNION ALL
            SELECT '검색' AS dataLabel
                , SUM(CASE WHEN RCEPT_PATH_CODE = '4' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_RECEIPT
            UNION ALL
            SELECT '광고매체' AS dataLabel
                , SUM(CASE WHEN RCEPT_PATH_CODE = '5' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_RECEIPT
            UNION ALL
            SELECT '기타' AS dataLabel
                , SUM(CASE WHEN RCEPT_PATH_CODE = '6' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_RECEIPT
            </select>
            
            <select id="visitReasonCnt" resultType="chartVO">
            /* kr.or.ddit.board.mapper.ChartMapper.visitReasonCnt */
            SELECT
                '머리' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 0 AND 9 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '목' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 10 AND 19 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '흉곽' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 20 AND 29 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '복부, 요추, 골반' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 30 AND 39 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '어깨, 팔 상완' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 40 AND 49 THEN 1
                    ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '팔꿈치, 팔 하완' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 50 AND 59 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '손, 손목' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 60 AND 69 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '둔부, 대퇴' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 70 AND 79 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '무릎, 다리 하완부' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 80 AND 89 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            UNION ALL
            SELECT
                '발, 발목' AS dataLabel
                , SUM(CASE WHEN SUBSTR(DISS_CODE_NO, -2) BETWEEN 90 AND 99 THEN 1
                        ELSE 0 END) AS dataVal
            FROM
                TB_CHART_DETAIL
            </select>
            
            <select id="salesByMonth" resultType="chartVO">
            SELECT dataLabel, dataVal
            FROM (
                SELECT
                    SUBSTR(RCIV_DE, 1, 7) AS dataLabel,
                    SUM(RCIV_PAYMENT) AS dataVal
                FROM
                    TB_RECEIPTION
                GROUP BY
                    SUBSTR(RCIV_DE, 1, 7)
                ORDER BY
                    SUBSTR(RCIV_DE, 1, 7) DESC
            )
            WHERE <![CDATA[ROWNUM <= 12]]>
            ORDER BY dataLabel ASC
            </select>

            <select id="physioList" resultType="chartVO">
            SELECT
                '열치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS001' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '음압치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS002' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '냉각치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS003' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '레이저치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS004' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '파라핀치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS005' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '견인치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS006' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '이온치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS007' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '초음파치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS008' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '저주파치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS009' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            UNION ALL
            SELECT
                '아쿠아치료' AS dataLabel
                , SUM(CASE WHEN PHYSIO_CODE = 'PHYS010' THEN 1 ELSE 0 END) AS dataVal
            FROM
                TB_PHYSIOTHERAPY_LIST
            </select>
        </mapper>
    </details>

    `🖥️ jsp`
    <details>
        <summary>chart.jsp</summary>

        <%@ page language="java" contentType="text/html; charset=UTF-8"%>
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        </head>
        <body>
            <div id="div1">
                <div class="card long" id="patientChartDiv">
                    <div class="card-header">
                        <h4>환자 통계</h4>
                    </div>
                    <div class="card-body">
                        <div class="total-div">
                            <h1 class="total-count"></h1>
                            <h5 class="total-text">Total</h5>
                        </div>
                        <div class="genderChartDiv">
                            <canvas id="genderChart"></canvas>
                        </div>
                        <div class="ageChartDiv">
                            <canvas id="ageChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="card long" style="width:37vw;margin-left:3vw;">
                    <div class="card-header" style="display:flex;">
                        <h4>병원 매출</h4>
        <!-- 					<input class="form-control" type="month" id="currentDate"> -->
                    </div>
                    <div class="card-body">
                        <div class="salesChartDiv">
                            <canvas id="salesChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            
            <div id="div2">
                <div class="card short" id="salesChartDiv">
                    <div class="card-header">
                        <h4>내원 사유</h4>
                    </div>
                    <div class="card-body">
                        <div class="reasonChartDiv">
                            <canvas id="reasonChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="card short" id="treatChartDiv" style="margin-left:3vw;">
                    <div class="card-header">
                        <h4>내원 경로</h4>
                    </div>
                    <div class="card-body">
                        <div class="pathChartDiv">
                            <canvas id="pathChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="card short" id="" style="margin-left:3vw;">
                    <div class="card-header">
                        <h4>물리치료 통계</h4>
                    </div>
                    <div class="card-body">
                        <div class="physioChartDiv">
                            <canvas id="physioChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
        //-------------------- 웹소켓 ----------------------
        function fMessage() { // 받는 쪽에 작성
            let serverMsg = JSON.parse(event.data);

            if(serverMsg.cmd == "alarm") {
                getNotiList();
            }
        }
        //-------------------- /웹소켓 ----------------------

        $(function() {
            const genderChart = document.querySelector('#genderChart');
            const ageChart = document.querySelector('#ageChart');
            const salesChart = document.querySelector('#salesChart');
            const reasonChart = document.querySelector('#reasonChart');
            const pathChart = document.querySelector('#pathChart');
            const physioChart = document.querySelector('#physioChart');	
            const colors = ['#FFCC88', '#F7A894', '#E0F3DB', '#CCEBC5', '#A8DDB5'
                            , '#4EB3D3', '#4EB3D3', '#2B8CBE', '#0868AC', '#084081'];

            getGenderData(function() {
                // 데이터 가져온 후 성별 차트 출력
                new Chart(genderChart, {
                    type: 'pie',
                    data: {
                        labels: genderLabels,
                        datasets: [{
                            label: "누적 환자 수",
                            data: genderValues,
                            backgroundColor: colors
                        }]
                    },
                    options: {
                        plugins: {
                            title: { // default: display false
                                display: true,
                                text: '성별'
                            },
                            legend: {
                                position: 'right'
                            }
                        },
                        scales: {
                            x: {
                                beginAtZero: true,
                                display: false
                            },
                            y: {
                                beginAtZero: true,
                                display: false
                            }
                        }
                    }	
                });
            });
            
            getAgeData(function() {
                // 데이터 가져온 후 연령대별 차트 출력
                new Chart(ageChart, {
                    type: 'pie',
                    data: {
                        labels: ageLabels,
                        datasets: [{
                            label: '누적 환자 수',
                            data: ageValues,
                            backgroundColor: colors
                        }]
                    },
                    options: {
                        plugins: {
                            title: {
                                display: true,
                                text: '연령대별'
                            },
                            legend: {
                                position: 'right'
                            }
                        },
                        scales: {
                            x: {
                                beginAtZero: true,
                                display: false
                            },
                            y: {
                                beginAtZero: true,
                                display: false
                            }
                        }
                    }
                });
            });
            
            getVisitPath(function() {
                // 데이터 가져온 후 내원경로 출력
                new Chart(pathChart, {
                    type: 'radar',
                    data: {
                        labels: pathLabels,
                        datasets: [{
                            label: '환자 수',
                            data: pathValues,
                            backgroundColor: colors
                        }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            r: {
                                min: 0,
        // 			            max: 10,
                                beginAtZero: true,
                                angleLines: {
                                    display: false
                                }
                            },
                        }
                    }
                });
            });
            
            getVisitReason(function() {
                // 데이터 가져온 후 내원사유 출력
                new Chart(reasonChart, {
                    type: 'pie',
                    data: {
                        labels: reasonLabels,
                        datasets: [{
                            label: '환자 수',
                            data: reasonValues,
                            backgroundColor: colors
                        }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                position: 'right'
                            }
                        },
                        scales: {
                            x: {
                                beginAtZero: true,
                                display: false
                            },
                            y: {
                                beginAtZero: true,
                                display: false
                            }
                        }
                    }
                });
            });
            
            getSalesByMonth(function() {
                // 데이터 가져온 후 월별 매출 출력
                new Chart(salesChart, {
                    type: 'bar',
                    data: {
                        labels: salesLabels,
                        datasets: [{
                            label: '총 매출',
                            data: salesValues,
                            backgroundColor: colors
                        }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            x: {
                                beginAtZero: true
                            },
                            y: {
                                beginAtZero: true,
                            }
                        }
                    }
                });
            });
            
            getPhysioList(function() {
                // 데이터 가져온 후 물리치료 통계 출력
                new Chart(physioChart, {
                    type: 'pie',
                    data: {
                        labels: physioLabels,
                        datasets: [{
                            label: '횟수',
                            data: physioValues,
                            backgroundColor: colors
                        }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                position: 'right'
                            }
                        },
                        scales: {
                            x: {
                                beginAtZero: true,
                                display: false
                            },
                            y: {
                                beginAtZero: true,
                                display: false
                            }
                        }
                    }
                });
            });
            
        });

        // 성별 데이터 가져오기
        const getGenderData = (callback) => {
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/chart/gender", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
                    console.log("가져온 성별 데이터", result);
                    
                    // 성별 데이터를 저장할 배열 변수
                    genderLabels = []; // 남, 여
                    genderValues = []; // 1, 4
                    let genderTotal = 0;
                    
                    for(let i=0; i<result.length; i++) {
                        genderLabels.push(result[i].dataLabel);
                        genderValues.push(result[i].dataVal);
                        genderTotal += Number(result[i].dataVal);
        // 				console.log("genderTotal: " + genderTotal);
                    }
        // 			console.log("최종 genderLabel", genderLabels);
        // 			console.log("최종 genderValues", genderValues);
                    
                    $('#patientChartDiv h1').text(genderTotal); // 전체 환자 수
                    
                    callback();
                }
            }
            xhr.send();
        }

        // 연령대별 데이터 가져오기
        const getAgeData = (callback) => {
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/chart/age", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
                    console.log("가져온 연령대 데이터", result);
                    
                    // 연령대 데이터를 저장할 배열 변수
                    ageLabels = [];
                    ageValues = [];
                    
                    for(let i=0; i<result.length; i++) {
                        ageLabels.push(result[i].dataLabel);
                        ageValues.push(result[i].dataVal);
                    }
                    callback();
                }
            }
            xhr.send();
        }

        // 내원경로 데이터 가져오기
        const getVisitPath = (callback) => {
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/chart/path", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
                    console.log("가져온 내원경로: ", result);
                    
                    // 내원경로 데이터를 저장할 배열함수
                    pathLabels = [];
                    pathValues = [];
                    
                    for(let i=0; i<result.length; i++) {
                        pathLabels.push(result[i].dataLabel);
                        pathValues.push(result[i].dataVal);
                    }
                    callback();
                }
            }
            xhr.send();
        }

        // 내원사유 데이터 가져오기
        const getVisitReason = (callback) => {
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/chart/reason", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
                    console.log("가져온 내원사유: ", result);
                    
                    // 내원사유 데이터를 저장할 배열 함수
                    reasonLabels = [];
                    reasonValues = [];
                    
                    for(let i=0; i<result.length; i++) {
                        reasonLabels.push(result[i].dataLabel);
                        reasonValues.push(result[i].dataVal);
                    }
                    callback();
                }
            }
            xhr.send();
        }

        // 월별 매출 데이터 가져오기
        const getSalesByMonth = (callback) => {

        // 	let currentDate = $('#currentDate').val().replace("-", "");
        // 	console.log("오늘날짜는?", currentDate);
            
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/chart/sales", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
                    console.log("가져온 월별 매출데이터: ", result);
                    
                    // 월별 매출 데이터를 저장할 배열 함수
                    salesLabels = [];
                    salesValues = [];
                    
                    for(let i=0; i<result.length; i++) {
                        salesLabels.push(result[i].dataLabel);
                        salesValues.push(result[i].dataVal);
                    }
                    callback();
                    
                }
            }
            xhr.send();
        }

        // 물리치료 통계 데이터 가져오기
        const getPhysioList = (callback) => {
            let xhr = new XMLHttpRequest();
            xhr.open("get", "/chart/physio", true);
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    let result = JSON.parse(xhr.responseText);
                    console.log("가져온 물리치료 통계데이터: ", result);
                    
                    // 물리치료 통계데이터를 저장할 배열 함수
                    physioLabels = [];
                    physioValues = [];
                    
                    for(let i=0; i<result.length; i++) {
                        physioLabels.push(result[i].dataLabel);
                        physioValues.push(result[i].dataVal);
                    }
                    callback();
                }
            }
            xhr.send();
        }
        </script>
        </html>
    </details>

    `🖥️ view`
    <details>
        <summary>통계 조회</summary>
        <img src="https://github.com/kimyerini/ddit_finalProject/assets/142777918/e96c9cbd-9c25-42dd-9b18-eeda6202c8f6">
    </details>
  
