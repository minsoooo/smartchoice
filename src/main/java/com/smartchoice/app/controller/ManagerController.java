package com.smartchoice.app.controller;

import java.util.List;
import java.util.Map;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smartchoice.app.domain.CardDiscountDto;
import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.ManagerDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.SmallCategoryDto;
import com.smartchoice.app.service.CardService;
import com.smartchoice.app.service.ManagerService;
import com.smartchoice.app.util.Cipher;

@Controller
@RequestMapping("/manager/")
public class ManagerController {
	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Inject
	private CardService service;
	
	@Inject
	private ManagerService service_mng;
	
	//관리자 아이디 중복체크 AJAX코드 
	@RequestMapping("/manager_idCheck")
	public void managerCheckId(String mng_id, HttpServletResponse resp){
		String result = "true";
		if(service_mng.getMngWithId(mng_id) != null){
			result ="false";
		}
			PrintWriter out = null;
		try {
			 out = resp.getWriter();
			out.print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}
	//관리자 로그인 페이지이동  by minsoo	
	@RequestMapping("/manager_login")
	public void managerLogin(){
		
	}
	
	//관리자 로그인완료   by minsoo
	@RequestMapping(value ="/manager_login" , method=RequestMethod.POST)
	public String managerLogin(@ModelAttribute ManagerDto manager, HttpServletRequest req){
		
		try {
			Cipher cipher = new Cipher();
			String MD5Pw = cipher.getMD5(manager.getMng_pw());
			ManagerDto dto = service_mng.getMngWithIdAndPw(manager.getMng_id(), MD5Pw);
			logger.info(dto.toString());
			WebUtils.setSessionAttribute(req, "MNG_KEY", dto);
			req.setAttribute("check", "success");
		} catch (Exception e) {
			req.setAttribute("check", "fail");
			return"/manager/manager_login";
		}

		return "/manager/manager_login";
	}
	// 관리자 로그아웃  by minsoo
	@RequestMapping("/manager_logout")
	public String managerLogout(HttpServletRequest req){
		req.getSession().invalidate();
		return "redirect:/";
	}
	
	//직원관리설정페이지 이동 by minsoo
	@RequestMapping("/manager_chooseAdmin")
	public void chooseAdmin(){
		
	}
	//직원등록페이지 이동 by minsoo
	@RequestMapping("/manager_regiAdmin")
	public void regiAdminGET(){
		
	}
	
	//직원등록 DB연동
	@RequestMapping(value ="/manager_regiAdmin", method=RequestMethod.POST)
	public String regiAdminPOST(@ModelAttribute ManagerDto dto, HttpServletRequest req, RedirectAttributes rttr){
		Cipher cipher = new Cipher();
		String mng_pnum = req.getParameter("phone1")+"-"+req.getParameter("phone2")+"-"+req.getParameter("phone3");
		dto.setMng_pnum(mng_pnum);
		dto.setMng_pw(cipher.getMD5(dto.getMng_pw()));
	 
		logger.info(dto.toString());
		service_mng.regiManager(dto);
		rttr.addAttribute("success", "success");
		return "redirect:/manager/manager_listAdmin";
	}
	//직원리스트 페이지로 이동 by Minsoo
	@RequestMapping("/manager_listAdmin")
	public void managerList(Model model){
		List<ManagerDto> managerList = new ArrayList<ManagerDto>();
		managerList = service_mng.getManager();
		model.addAttribute("managerList", managerList);
	}
	
	//직원수정페이지로 이동 by Minsoo
	@RequestMapping("/manager_updateAdmin")
	public void updateAdminGET(HttpServletRequest req){
		String mng_id = req.getParameter("mng_id");
		ManagerDto dto = service_mng.getMngWithId(mng_id);
		req.setAttribute("manager", dto);
	}
	//직원수정DB연동 by Minsoo
	@RequestMapping(value ="/manager_updateAdmin", method=RequestMethod.POST)
	public String updateAdminPOST(@ModelAttribute ManagerDto dto ,HttpServletRequest req, RedirectAttributes rttr){
		String mng_pnum = req.getParameter("phone1")+"-"+req.getParameter("phone2")+"-"+req.getParameter("phone3");
		dto.setMng_pnum(mng_pnum);
		service_mng.updateManager(dto);
		rttr.addAttribute("success", "success");
		return"redirect:/manager/manager_listAdmin";
	}
	//직원삭제 DB연동 by Minsoo
	@RequestMapping("/manager_delAdmin")
	public String delAdmin(HttpServletRequest req){
		String mng_id = req.getParameter("mng_id");
		logger.info("mng_id" + mng_id);
		service_mng.delManager(mng_id);
		return "redirect:/manager/manager_listAdmin";
	}
	//관리자 메인페이지
	@RequestMapping("/manager_main")
	public void managerMainGET() throws Exception{
	}

	//관리자 카드관리 페이지 : 카드관리 컨트롤러
	@RequestMapping("/manager_cardManage")
	public void managerCardManageGET() throws Exception{
	}
	//관리자 카드삭제 페이지 : 삭제 컨트롤러
	@RequestMapping("/manager_deleteCard")
	public String deleteCard(HttpServletRequest req){
		String card_code = req.getParameter("card_code");
		service.deleteCard(card_code);
		return "redirect:/manager/manager_cardList";
	}
	//관리자 카드기본정보수정 : GET 페이지
	@RequestMapping(value="/manager_cardCor", method=RequestMethod.GET)
	public void cardCorGET(HttpServletRequest req, Model model) throws Exception{
		String card_code = req.getParameter("card_code");
		CardDto dto = service.getCard_info(card_code);
		logger.info("dto:" + dto);
		req.setAttribute("card_info", dto);
		model.addAttribute("companies", service.getCardComp());
	}
	
	//관리자 카드기본정보수정 : DB전송 컨트롤러-기본정보DTO
	@RequestMapping(value="/manager_cardCor", method=RequestMethod.POST)
	public @ResponseBody String cardCorPOST(@RequestBody CardDto dto, HttpServletRequest req) throws Exception{
		
		logger.info("기본정보 수정에 필요한 DTO : " + dto);
		service.updateCard(dto);
		return "success";
	}
	//관리자 카드기본정보수정 : DB전송 컨트롤러-카드이미지 업데이트
	@RequestMapping(value="/manager_cardCorImg", method=RequestMethod.POST)
	public String managerCardCorImg(HttpServletRequest request, CardDto dto, RedirectAttributes rttr) throws Exception{
		request.setCharacterEncoding("utf-8");
		ServletContext ctx = request.getServletContext();
		String path = ctx.getRealPath("/resources/images/card");
		
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
		dto.setCard_img(filename);
		dto.setCard_code(card_code);
		logger.info("SET 이후 DTO는 " + dto);
		service.updateCardImage(dto);
		
		FlashMap fm = RequestContextUtils.getOutputFlashMap(request);
		fm.put("card_code", card_code);
		
		return "redirect:/manager/manager_cardDisCor";
	}

	//관리자 카드할인수정 : GET 컨트롤러, 대분류 포함
	@RequestMapping(value="/manager_cardDisCor", method=RequestMethod.GET)
	public void managerCardDisCorGET(HttpServletRequest req, Model model){
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(req);
		String card_code = (String) flashMap.get("card_code");
		logger.info("card_code : "+card_code);
		List<CardDiscountDto> disdto = service.getDisCard_info(card_code);
		logger.info("가져온 할인정보리스트 : " + disdto );
		model.addAttribute("bigcategories", service.getBigCategoryList());
		req.setAttribute("discard", disdto);
	}
	//관리자 카드할인수정 : 대분류 선택시, 소분류 자동변환 컨트롤러
	@RequestMapping(value="/manager_cardDisCor_small", method=RequestMethod.GET)
	public @ResponseBody HashMap<Integer, Object> managerCardDisCor_small(@RequestParam(value="big_num", defaultValue="1") String big_num){
		HashMap<Integer, Object> hashmap = new HashMap<Integer, Object>();
		List<SmallCategoryDto> list = service.getSmallCategoryList(Integer.parseInt(big_num));
		for(int i=0; i<list.size(); i++){
			SmallCategoryDto dto = list.get(i);
			hashmap.put(i, dto);
		}
		return hashmap;
	}
	//관리자 카드할인수정 : 삭제 컨트롤러
	@RequestMapping(value="/manager_deleteDisCard", method=RequestMethod.POST)
	public @ResponseBody String deleteDisCard(@RequestBody List<CardDiscountDto> disDto){
		logger.info("디스카운트삭제 DTO : " + disDto);
		service.deleteDisCard(disDto);
		return "success";
	}
	//관리자 카드할인정보 수정 : DB전송 컨트롤러-카드할인정보
	@RequestMapping(value="/manager_updateDisCard", method=RequestMethod.POST)
	public @ResponseBody String updateDisCard(@RequestBody List<CardDiscountDto> disDto) throws Exception{
		logger.info("disDto:"+disDto);
		service.updateDisCard(disDto);
		return "success";
	}
	//관리자 카드할인정보 추가 : DB전송 컨트롤러-카드할인정보
		@RequestMapping(value="/manager_addDisCard", method=RequestMethod.POST)
		public @ResponseBody String addDisCard(@RequestBody List<CardDiscountDto> disDto){
			logger.info("ADD disDto:"+disDto);
			try{
				service.registerCardDiscount(disDto);				
				return "success";
			}catch(Exception e){
				System.out.println(e);
				return "failed";
			}
		}
	
	//관리자 카드정보리스트 : 카드리스트 컨트롤러
	@RequestMapping("/manager_cardList")
	public void managerCardListGET(Model model) throws Exception{
		List<CardDto> cardList = new ArrayList<CardDto>();
		cardList = service.CardList();
		model.addAttribute("cardList", cardList);
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
		String path = ctx.getRealPath("/resources/images/card");

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
	
}