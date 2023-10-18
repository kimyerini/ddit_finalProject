package kr.or.ddit.exception;

import java.io.IOException;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class KmExceptionHandler {

	
	@ExceptionHandler(NoHandlerFoundException.class)
	public String handle404(NoHandlerFoundException e){
		return "error/error2/myError";
	}
	
	
    @ExceptionHandler(IOException.class)
    public String ioException(IOException ex) {
        return "error/error2/myError"; 
    }

	
    @ExceptionHandler(Exception.class)
    public String allException(Exception ex) {
        return "error/error2/myError"; 
    }
}
