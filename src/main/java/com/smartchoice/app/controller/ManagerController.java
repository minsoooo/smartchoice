package com.smartchoice.app.controller;

import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.runners.Parameterized.Parameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartchoice.app.domain.SmallCategoryDto;
import com.smartchoice.app.service.CardService;

@Controller
@RequestMapping("/manager/")
public class ManagerController {
	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Inject
	private CardService service;
	
	//관리자 메인페이지
	@RequestMapping("/manager_main")
	public void managerMainGET() throws Exception{
		//return "/manager/manager_main";
	}
	
	//관리자 회원정보리스트 페이지
	@RequestMapping("/manager_memberList")
	public void managerMemberListGET() throws Exception{
		//return "/manager/manager_main";
	}
	
	//관리자 회원정보수정 페이지
	@RequestMapping("/manager_memberCor")
	public void managerMemberCorGET() throws Exception{
		//return "/manager/manager_main";
	}
	
	//관리자 회원정보수정 전송
	@RequestMapping(value="/manager_memberCor", method=RequestMethod.POST)
	public String managerMemberCorPOST() throws Exception{
		return "redirect:/manager/manager_memberList";
	}
	
	//관리자 카드정보리스트 페이지
	@RequestMapping("/manager_cardList")
	public void managerCardListGET() throws Exception{
		//return "/manager/manager_cardRegister";
	}
	
	//관리자 카드정보등록 페이지 : 카드사, 대분류 적용
	@RequestMapping(value="/manager_cardRegister", method=RequestMethod.GET)
	public String managerCardRegisterGET(HttpServletResponse resp, Model model) throws Exception{
		model.addAttribute("companies", service.getCardComp());
		model.addAttribute("bigcategories", service.getBigCategoryList());
	
		return "/manager/manager_cardRegister";
	}
	
	//관리자 카드정보등록 페이지 : 대분류 선택시, 소분류 자동변환 컨트롤러
	@RequestMapping(value="/manager_cardRegister_small", method=RequestMethod.GET)
	public @ResponseBody HashMap<Integer, Object> managerCardRegisterSmall(@RequestParam(value="big_num", defaultValue="1") String big_num){
		HashMap<Integer, Object> hashmap = new HashMap<Integer, Object>();
		List<SmallCategoryDto> list = service.getSmallCategoryList(Integer.parseInt(big_num));
		for(int i=0; i<list.size(); i++){
			SmallCategoryDto dto = list.get(i);
			hashmap.put(i, dto);
		}
		return hashmap;
	}
	
	//관리자 카드정보등록 전송 페이지
	@RequestMapping(value="/manager_cardRegister", method=RequestMethod.POST)
	public String managerCardRegisterPOST() throws Exception{
		return "redirect:/manager/manager_cardList";
	}

	//관리자 카드정보수정 페이지
	@RequestMapping("/manager_cardCor")
	public void managerCardCorGET() throws Exception{
		//return "/manager/manager_main";
	}
	
	//관리자 카드정보수정 전송 페이지 
	@RequestMapping(value="/manager_cardCor", method=RequestMethod.POST)
	public String managerCardCorPOST() throws Exception{
		return "redirect:/manager/manager_cardList";
	}
	
	//관리자 데이터정보리스트 페이지 
	@RequestMapping("/manager_dataList")
	public void managerDataListGET() throws Exception{
		//return "/manager/manager_main";
	}
}
