package com.smartchoice.app.controller;
import java.util.List;
import java.util.Set;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.runners.Parameterized.Parameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smartchoice.app.domain.CardDiscountDto;
import com.smartchoice.app.domain.CardDto;
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
	
	//관리자 카드정보등록 : 카드사, 대분류 적용 컨트롤러
	@RequestMapping(value="/manager_cardRegister", method=RequestMethod.GET)
	public String managerCardRegisterGET(HttpServletResponse resp, Model model) throws Exception{
		model.addAttribute("companies", service.getCardComp());
		model.addAttribute("bigcategories", service.getBigCategoryList());
		model.addAttribute("code", service.getCard_num());
		return "/manager/manager_cardRegister";
	}
	
	//관리자 카드정보등록 : 대분류 선택시, 소분류 자동변환 컨트롤러
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

	//관리자 카드정보등록 : DB전송 컨트롤러-카드할인정보
	@RequestMapping(value="/manager_cardRegisterList", method=RequestMethod.POST)
	public @ResponseBody String managerCardRegisterLIST(@RequestBody List<CardDiscountDto> disDto) throws Exception{
		logger.info("disDto:"+disDto);
		service.registerCardDiscount(disDto);
		return "success";
	}
	
	//관리자 카드정보등록 : DB전송 컨트롤러-카드기본정보
	@RequestMapping(value="/manager_cardRegisterDto", method=RequestMethod.POST)
	public @ResponseBody String managerCardRegisterDTO(@RequestBody CardDto dto, HttpServletRequest req) throws Exception{
		
		logger.info("DTO:" + dto);
		service.registerCard(dto);
		return "success";
	}
	//관리자 카드정보등록 : DB전송 컨트롤러-카드이미지 업데이트
	@RequestMapping(value="/manager_cardRegisterDto2", method=RequestMethod.POST)
	public String managerCardRegisterDTO2(HttpServletRequest request, CardDto dto) throws Exception{
		request.setCharacterEncoding("utf-8");
		ServletContext ctx = request.getServletContext();
		String path = ctx.getRealPath("/resources/images");

		int maxSize = 50 * 1024 * 1024;
		String filename = "";
		MultipartRequest multiReq = 
				new MultipartRequest(request, 
						path, 
						maxSize, 
						"utf-8", 
						new DefaultFileRenamePolicy());
		Enumeration enumer = multiReq.getFileNames();
		String card_code = multiReq.getParameter("hidden_card_code");
		logger.info("cardcode 데이터 값 :" + card_code);
		while(enumer.hasMoreElements()){
			String name= (String)enumer.nextElement();
			filename = multiReq.getFilesystemName(name);
		}

		//logger.info("파라미터 코드값 : " + card_code);
		dto.setCard_img(filename);
		dto.setCard_code(card_code);
		logger.info("SET 이후 DTO는 " + dto);
		service.updateCardImage(dto);

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
