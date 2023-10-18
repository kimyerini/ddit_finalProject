package kr.or.ddit.util;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.slf4j.Slf4j;

// 스프링에게 예외를 처리하는 핸들러 클래스임을 알려줌
// ControllerAdvice: Controller와 동일한 역할 수행. 예외 발생 시 예외만 처리(예외처리에 특화된 컨트롤러임)
// ControllerAdvice("특정패키지"): 특정패키지 이하에서 catch 되지 않은 Exception 발생 시 이 클래스가 동작
// Controller에서 Exceiption이 발생한 것을 DispatcherServlet -> JVM으로 가기 전에 먼저 예외를 잡음
@Slf4j
@ControllerAdvice
public class CommonExceptionHandler {

	// 예외에 대한 내용을 Model객체를 이용해서 에러객체를 뷰(View, jsp)로 전달
	// 사용자가 설정한 예외타입이 해당되는 예외가 발생시 handle()메소드에서 처리함

/*
	@ExceptionHandler(Exception.class) // RequestMapping과 동일한 역할을 수행
	public String handle(Exception e, Model model) {
		log.error(e.toString());
		
		model.addAttribute("exception", e);
		
		// forwarding
		return "error/errorCommon";
	}
*/

//	@ExceptionHandler(NoHandlerFoundException.class)
//	@ResponseStatus(HttpStatus.NOT_FOUND)
//	public String handle(Exception e, Model model) {
//		log.error("handle의 e: " + e.toString());
//		
//		model.addAttribute("exception", e);
//		
//		// forwarding
//		return "error/errorCommon";
//	}
}
