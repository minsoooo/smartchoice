
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.ManagerDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.SmallCategoryDto;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CardService;
import com.smartchoice.app.service.CategoryService;
import com.smartchoice.app.service.ManagerService;
import com.smartchoice.app.service.MemberService;
import com.smartchoice.app.util.Cipher;
import com.smartchoice.app.util.Paging;

@Controller
@RequestMapping("/manager/")
public class ManagerController {
	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Inject
	private CardService service;
	
	@Inject
	private ManagerService service_mng;
	
	@Inject
	private MemberService service_mem;
	
	@Inject
	private BigCategoryService service_cate;
	
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
	//직원리스트 페이지로 이동 by Minsoo// 페이징처리까지
	@RequestMapping("/manager_listAdmin")
	public void managerList(Model model, int page_num){
		List<ManagerDto> managerList = new ArrayList<ManagerDto>();
		List<ManagerDto> list = new ArrayList<ManagerDto>();
		list = service_mng.getManager(); 	
		
		Paging paging = new Paging();
		paging.setPageNo(page_num);//페이지번호셋팅
	    paging.setPageSize(2);//페이지 사이즈 셋팅
	    paging.setTotalCount(list.size());//토탈카운트 셋팅
	   
	    if((page_num)*2 >= list.size()){
	    	  for(int i =(page_num-1)*2  ; i<list.size();i++ ){
	  	    	managerList.add(list.get(i));	    	
	  	    }
	    }else{
	    	 for(int i =(page_num-1)*2 ; i<(page_num-1)*2+2;i++ ){
	 	    	managerList.add(list.get(i));	    	
	 	    }
	    }
	   
		model.addAttribute("paging",paging);
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

	//관리자 회원 리스트 페이지 이동  by minsoo
	@RequestMapping("/manager_listMember")
	public void listMemberGET(Model model, int page_num) throws Exception{
		
		List<MemberDto> list = new ArrayList<MemberDto>();
		List<MemberDto>	setList = new ArrayList<MemberDto>();
		List<MemberDto> memberList = new ArrayList<MemberDto>();
		List<BigCategoryDto> cateList = new ArrayList<BigCategoryDto>();
		List<CardDto> compList = new ArrayList<CardDto>();
		
		MemberDto memDto =null;
		BigCategoryDto cateDto = null;
		
		list = service_mem.getMemberList();
		cateList = service_cate.getBigCategory();
		compList = service.getCardComp();
		
		for(int j = 0 ; j < list.size(); j++){
			memDto = (MemberDto)list.get(j);
			cateDto = service_cate.getBigCateWithNum(Integer.parseInt(memDto.getMem_fav1()));
			memDto.setFav1_name(cateDto.getBig_name());
			cateDto = service_cate.getBigCateWithNum(Integer.parseInt(memDto.getMem_fav2()));
			memDto.setFav2_name(cateDto.getBig_name());
			cateDto = service_cate.getBigCateWithNum(Integer.parseInt(memDto.getMem_fav3()));
			memDto.setFav3_name(cateDto.getBig_name());
			setList.add(memDto);
		}
		
		Paging paging = new Paging();
		paging.setPageNo(page_num);//페이지번호셋팅
	    paging.setPageSize(2);//페이지 사이즈 셋팅
	    paging.setTotalCount(setList.size());//토탈카운트 셋팅
	    
	    if((page_num)*2 >= list.size()){
	    	  for(int i = (page_num-1)*2  ; i < setList.size(); i++ ){
	  	    	memberList.add(setList.get(i));	    	
	  	    }
	    }else{
	    	 for(int i = (page_num-1)*2 ; i < (page_num-1)*2+2; i++ ){
	 	    	memberList.add(setList.get(i));	    	
	 	    }
	    }
	    model.addAttribute("compList",compList);
	    model.addAttribute("cateList",cateList);
		model.addAttribute("paging",paging);
		model.addAttribute("memberList", memberList);
	    
	}

	//관리자 회원 분류별 보기 by Minsoo
	@RequestMapping("/manager_viewListMember")
	public void viewListMember(Model model, int page_num, String keyword, String value){
		List<MemberDto> list = new ArrayList<MemberDto>();
		List<MemberDto>	setList = new ArrayList<MemberDto>();
		List<MemberDto> memberList = new ArrayList<MemberDto>();
		List<BigCategoryDto> cateList = new ArrayList<BigCategoryDto>();
		List<CardDto> compList = new ArrayList<CardDto>();
		
		MemberDto memDto =null;
		BigCategoryDto cateDto = null;
		
		list = service_mem.getViewListMember(keyword, value);
		cateList = service_cate.getBigCategory();
		compList = service.getCardComp();
		
		for(int j = 0 ; j < list.size(); j++){
			memDto = (MemberDto)list.get(j);
			cateDto = service_cate.getBigCateWithNum(Integer.parseInt(memDto.getMem_fav1()));
			memDto.setFav1_name(cateDto.getBig_name());
			cateDto = service_cate.getBigCateWithNum(Integer.parseInt(memDto.getMem_fav2()));
			memDto.setFav2_name(cateDto.getBig_name());
			cateDto = service_cate.getBigCateWithNum(Integer.parseInt(memDto.getMem_fav3()));
			memDto.setFav3_name(cateDto.getBig_name());
			setList.add(memDto);
		}
		
		Paging paging = new Paging();
		paging.setPageNo(page_num);//페이지번호셋팅
	    paging.setPageSize(2);//페이지 사이즈 셋팅
	    paging.setTotalCount(setList.size());//토탈카운트 셋팅
	    
	    if((page_num)*2 >= list.size()){
	    	  for(int i = (page_num-1)*2  ; i < setList.size(); i++ ){
	  	    	memberList.add(setList.get(i));	    	
	  	    }
	    }else{
	    	 for(int i = (page_num-1)*2 ; i < (page_num-1)*2+2; i++ ){
	 	    	memberList.add(setList.get(i));	    	
	 	    }
	    }
	    model.addAttribute("keyword",keyword);
	    model.addAttribute("value",value);
	    model.addAttribute("compList",compList);
	    model.addAttribute("cateList",cateList);
		model.addAttribute("paging",paging);
		model.addAttribute("memberList", memberList);
		
	}
	//관리자 회원 탈퇴처리 by Minsoo
	@RequestMapping("/manager_delMember")
	public String delMember(String mem_id){
		service_mem.deleteMember(mem_id);
		return "redirect:/manager/manager_listMember?page_num=1";
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
		for(int i = 0; i < list.size(); i++){
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
