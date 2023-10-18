package kr.or.ddit.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.service.SmsHistoryService;
import kr.or.ddit.common.service.SmsService;
import kr.or.ddit.common.vo.SmsHistoryVO;
import kr.or.ddit.common.vo.SmsVO;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/sms")
@Slf4j
public class SmsController {
	@Autowired
	SmsService smsService;
	
	@Autowired
	SmsHistoryService smsHisService;
	
	
	@GetMapping("/main")
	public String smsMain() {
		return "sms/sms";
	}
	
	@ResponseBody
	@PostMapping("/send")
	public int sendSms(@RequestBody List<SmsHistoryVO> smsHisVOList) {
		  log.info("리스트왔니!"+smsHisVOList.toString());
		  return smsHisService.insertSMSHis(smsHisVOList);
	}
	
	@ResponseBody
	@GetMapping("/list")
	public List<SmsVO> getSmsList(){
		List<SmsVO> list = new ArrayList<SmsVO>();
		list = smsService.getSmsList();
		return list;
	}
	
	@ResponseBody
	@GetMapping("/getSms/{smsNm}")
	public SmsVO getSms(@PathVariable(value="smsNm") String smsNm) {
		SmsVO smsVO = new SmsVO();
		smsVO.setSmsNm(smsNm);
		smsVO = smsService.getSms(smsVO);
		return smsVO;
	}
	
	@ResponseBody
	@PostMapping("/modSms")
	public int modSms(@RequestBody SmsVO smsVO) {
		log.info(smsVO.toString());
		int cnt = smsService.updateSms(smsVO);
		return cnt;
	}
	
	@ResponseBody
	@PostMapping("/insSms")
	public int insSms(@RequestBody SmsVO smsVO) {
		log.info(smsVO.toString());
		int cnt = smsService.insertSms(smsVO);
		return cnt;
	}
	
	@ResponseBody
	@GetMapping("/delSms/{smsNm}")
	public int delSms(@PathVariable(value="smsNm",required=false) String smsNm) {
		SmsVO smsVO = new SmsVO();
		smsVO.setSmsNm(smsNm);
		int cnt = smsService.deleteSms(smsVO);
		return cnt;
	}
	
	@ResponseBody
	@GetMapping("/getSmsHis")
	public List<SmsHistoryVO> getSmsHis(){
		List<SmsHistoryVO> list = new ArrayList<SmsHistoryVO>();
		list = smsHisService.getSMSHisList();
		log.info("리스트"+list.toString());
		return list;
	}
}
