//package kr.or.ddit.common.exception;
//
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.NoHandlerFoundException;
//
//import lombok.extern.slf4j.Slf4j;
////에러 페이지로 이동하려면 return에 "myError"; (뷰 리졸버) 를 써주고 ResponseBody를 주석처리
//@Slf4j
//@ControllerAdvice	//일일이 컨트롤러에 등록하지 않고 예외처리 공통 사용
//public class CommonExceptionHandler {
//   // NullPointerException
//   @ExceptionHandler(NullPointerException.class)
//   //@ResponseBody
//   public String nullHandle(NullPointerException e, Model model) {
//	  log.info("에렁" + e.getMessage());
//	  model.addAttribute("exception","예외: "+ e.getMessage());
//      return "/error/myError";
//   }
//   
//   // NoHandlerFoundException 핸들링
//   @ExceptionHandler(NoHandlerFoundException.class)
//   @ResponseBody
//   public String notFoundHandle(NoHandlerFoundException e, Model model) {
//	   model.addAttribute("exception","예외: "+ e.getMessage());
//	   return "error/myError";
//   }
//   
//   
//   // 기타 예외처리
//   @ExceptionHandler(Exception.class)
//   @ResponseBody
//   public String exception(Exception e, Model model) {
//	   model.addAttribute("exception","예외: "+ e.getMessage());
//	   return "error/myError";
//   }
//
//   
//}
////