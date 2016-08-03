package com.smartchoice.app.controller;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.inject.Inject;
import javax.security.auth.login.AccountNotFoundException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.smartchoice.app.domain.AccountBookDto;
import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.ManagerDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.SmallCategoryDto;
import com.smartchoice.app.service.AccountBookService;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CardService;
import com.smartchoice.app.service.CategoryService;
import com.smartchoice.app.service.ManagerService;
import com.smartchoice.app.service.MemberService;
import com.smartchoice.app.util.Cipher;
import com.smartchoice.app.util.Paging;
import net.sf.json.JSONArray;

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
	
	@Inject
	private AccountBookService service_account;
	
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
	    paging.setPageSize(5);//페이지 사이즈 셋팅
	    paging.setTotalCount(list.size());//토탈카운트 셋팅
	   
	    if((page_num)*5 >= list.size()){
	    	  for(int i =(page_num-1)*5  ; i<list.size();i++ ){
	  	    	managerList.add(list.get(i));	    	
	  	    }
	    }else{
	    	 for(int i =(page_num-1)*5 ; i<(page_num-1)*5+5;i++ ){
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
	    paging.setPageSize(10);//페이지 사이즈 셋팅
	    paging.setTotalCount(setList.size());//토탈카운트 셋팅
	    
	    if((page_num)*10 >= list.size()){
	    	  for(int i = (page_num-1)*10  ; i < setList.size(); i++ ){
	  	    	memberList.add(setList.get(i));	    	
	  	    }
	    }else{
	    	 for(int i = (page_num-1)*10 ; i < (page_num-1)*10+10; i++ ){
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
	    paging.setPageSize(5);//페이지 사이즈 셋팅
	    paging.setTotalCount(setList.size());//토탈카운트 셋팅
	    
	    if((page_num)*5 >= list.size()){
	    	  for(int i = (page_num-1)*5  ; i < setList.size(); i++ ){
	  	    	memberList.add(setList.get(i));	    	
	  	    }
	    }else{
	    	 for(int i = (page_num-1)*5 ; i < (page_num-1)*5+5; i++ ){
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

	//관리자 통계페이지로 이동 by Minsoo
	@RequestMapping("/manager_stats")
	public void statsGET(){

	}
	//관리자 통계/대분류별 회원수 불러오기 ajax 코드 
	@RequestMapping("/manager_getStats1")
	public void getStats1(HttpServletResponse resp){
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/json");
		PrintWriter out = null;
		Map<String,String> jsonMap = null;
		List<BigCategoryDto> cateList = new ArrayList<BigCategoryDto>();
		List<Map<String,String>> jsonList = new ArrayList<Map<String,String>>();
		JSONArray json;
		cateList = service_cate.getBigCategory();
		
		for(int i = 0 ; i < cateList.size(); i++){
			jsonMap = new HashMap<String, String>();
			jsonMap.put("big_name", cateList.get(i).getBig_name());
			jsonMap.put("value",Integer.toString(service_mem.getMemberCount(Integer.toString(cateList.get(i).getBig_num()))));
			jsonList.add(jsonMap);
		}
			json = JSONArray.fromObject(jsonList);	
		try{
			out = resp.getWriter();
			out.println(json);
		}catch(Exception err){
			err.printStackTrace();
		}finally{
			out.close();
		}
	}
	//관리자 통계불러오기/ 연령별 가입자수 불러오기
	@RequestMapping("/manager_getStats2")
	public void getStats2(HttpServletResponse resp){
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/json");
		
		Calendar cal = Calendar.getInstance();
		int thisYear = cal.get(Calendar.YEAR);
		int memYear =0;
		//세대별 인원수를 저장할 변수 초기화
		int g1=0; int g2=0; int g3=0;int g4=0; int g5=0; int g6=0;
		
		PrintWriter out = null;
		Map<String,String> jsonMap = null;
		List<MemberDto> memList = new ArrayList<MemberDto>();
		List<Map<String,String>> jsonList = new ArrayList<Map<String,String>>();
		JSONArray json;
		memList = service_mem.getMemberList();
		for(int i = 0; i < memList.size(); i++){
			
			memYear = Integer.parseInt(memList.get(i).getMem_birthdate().split("/")[0]);
			int disYear = thisYear - memYear;
			
			if( disYear<20){
				g1 += 1;
			}else if(disYear>=20 && disYear <30){
				g2 +=1;
			}else if(disYear>=30 && disYear <40){
				g3 +=1;
			}else if(disYear>=40 && disYear <50){
				g4 +=1;
			}else if(disYear>=50 && disYear <60){
				g5 +=1;
			}else if(disYear>=60){
				g6 +=1;
			}
			
		}
		jsonMap = new HashMap<String, String>();
		jsonMap.put("generation", "10대");
		jsonMap.put("value",Integer.toString(g1));
		jsonList.add(jsonMap);
		
		jsonMap = new HashMap<String, String>();
		jsonMap.put("generation", "20대");
		jsonMap.put("value",Integer.toString(g2));
		jsonList.add(jsonMap);
		
		jsonMap = new HashMap<String, String>();
		jsonMap.put("generation", "30대");
		jsonMap.put("value",Integer.toString(g3));
		jsonList.add(jsonMap);
		
		jsonMap = new HashMap<String, String>();
		jsonMap.put("generation", "40대");
		jsonMap.put("value",Integer.toString(g4));
		jsonList.add(jsonMap);
		
		jsonMap = new HashMap<String, String>();
		jsonMap.put("generation", "50대");
		jsonMap.put("value",Integer.toString(g5));
		jsonList.add(jsonMap);
		
		jsonMap = new HashMap<String, String>();
		jsonMap.put("generation", "60대이상");
		jsonMap.put("value",Integer.toString(g6));
		jsonList.add(jsonMap);
		
			json = JSONArray.fromObject(jsonList);	
		try{
			out = resp.getWriter();
			out.println(json);
		}catch(Exception err){
			err.printStackTrace();
		}finally{
			out.close();
		}
	}
	
	//관리자 통계/대분류별/연령별 회원수 불러오기 ajax 코드 
	
	@RequestMapping("/manager_getStats3")
	public void getStats3(HttpServletResponse resp){
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/json");
		PrintWriter out = null;
		Map<String,Object> jsonMap = null;
		List<MemberDto> memList =null;
		
		Calendar cal = Calendar.getInstance();
		int thisYear = cal.get(Calendar.YEAR);
		int memYear =0;
		//세대별 인원수를 저장할 변수 초기화
		int g1=0; int g2=0; int g3=0;int g4=0; int g5=0; int g6=0;
		
		List<BigCategoryDto> cateList = new ArrayList<BigCategoryDto>();
		List<Map<String,Object>> jsonList = new ArrayList<Map<String,Object>>();
		String[] values = null;
		JSONArray json;
		cateList = service_cate.getBigCategory();
		
		for(int i = 0 ; i < cateList.size(); i++){
			jsonMap = new HashMap<String, Object>();
			jsonMap.put("big_name", cateList.get(i).getBig_name());
			memList = service_mem.getViewListMember("mem_fav", Integer.toString(cateList.get(i).getBig_num()));
			for(int j = 0; j < memList.size(); j++){	
				memYear = Integer.parseInt(memList.get(j).getMem_birthdate().split("/")[0]);
				int disYear = thisYear - memYear;	
				if( disYear<20){
					g1 += 1;
				}else if(disYear>=20 && disYear <30){
					g2 +=1;
				}else if(disYear>=30 && disYear <40){
					g3 +=1;
				}else if(disYear>=40 && disYear <50){
					g4 +=1;
				}else if(disYear>=50 && disYear <60){
					g5 +=1;
				}else if(disYear>=60){
					g6 +=1;
				}
				
			}
			values = new String[6];
			values[0]  =Integer.toString(g1);
			values[1]  =Integer.toString(g2);
			values[2]  =Integer.toString(g3);
			values[3]  =Integer.toString(g4);
			values[4]  =Integer.toString(g5);
			values[5]  =Integer.toString(g6);
			
			jsonMap.put("value",values);
			jsonList.add(jsonMap);
			g1=0;g2=0;g3=0;g4=0;g5=0;g6=0;
		}
			json = JSONArray.fromObject(jsonList);	
		try{
			out = resp.getWriter();
			out.println(json);
		}catch(Exception err){
			err.printStackTrace();
		}finally{
			out.close();
		}
	}
	
	//관리자 카드사별 통계페이지 이동 by Minsoo
	@RequestMapping("/manager_statsComp")
	public void statsCompGET(){
		
	}
	
	//관리자 카드사별 지출내역 불러오기 AJAX 코드
	@RequestMapping("/manager_getStatsComp")
	public void getStatsComp(HttpServletResponse resp){
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/json");
		
		Map<String,Object> jsonMap = null;
		List<Map<String,Object>> jsonList = new ArrayList<Map<String,Object>>();
		JSONArray json;
		
		Calendar cal = Calendar.getInstance();
		String thisYear = Integer.toString(cal.get(Calendar.YEAR));
		String thisMonth = Integer.toString(cal.get(Calendar.MONTH));
		String workMonth ="";
		if(thisMonth.length()<2){
			workMonth = thisYear +"-0"+thisMonth;
		}else{
			workMonth = thisYear +"-"+thisMonth;
		}
		PrintWriter out = null;
		List<AccountBookDto> accountList = new ArrayList<AccountBookDto>();
		List<AccountBookDto> workMonthList = new ArrayList<AccountBookDto>();
		List<CardDto> compList = new ArrayList<CardDto>();
		List<BigCategoryDto> cateList = new ArrayList<BigCategoryDto>();
		List<AccountBookDto> accountCompList =null;
		//전체 카테고리 리스트 받아오기
		cateList = service_cate.getBigCategory();
		// 카테 리스트 크기만큼의 스트링 배열 만들기 
		int[] cates = null;
		//전체 카드사 내역 가져오기 
		compList = service.getCardComp();
		//전체 지출정보 가져오기
		accountList = service_account.getAccountBookList();
		//직전 달 정보 가져오기 // 전체 지출 리스트중 직전달 리스트만 새로운 리스트에 추가
		for(int i = 0 ; i < accountList.size() ; i ++){
			if(accountList.get(i).getRegi_month().equals(workMonth)){
				workMonthList.add(accountList.get(i));
			}
		}
		
		//카드사별로 리스트를 만들어 담기 
		for(int k = 0; k< compList.size(); k++){
			jsonMap = new HashMap<String, Object>();
			accountCompList = new ArrayList<AccountBookDto>();
			cates = new int[cateList.size()];
			jsonMap.put("comp_name", compList.get(k).getComp_name());
			for(int j = 0; j < workMonthList.size(); j ++){
				if(compList.get(k).getComp_name().equals(workMonthList.get(j).getComp_name())){
					accountCompList.add(workMonthList.get(j));
				}
			}
			
			
			for(int t = 0; t < cateList.size() ; t ++){
				for(int y = 0 ; y < accountCompList.size() ; y++){
					if(accountCompList.get(y).getAbook_bignum() == cateList.get(t).getBig_num()){
						cates[t] += accountCompList.get(y).getAbook_money();
					}
				}
			}
			jsonMap.put("value", cates);
			jsonList.add(jsonMap);	
		}
		json = JSONArray.fromObject(jsonList);	
		System.out.println(json);
		try{
			out = resp.getWriter();
			out.println(json);
		}catch(Exception err){
			err.printStackTrace();
		}finally{
			out.close();
		}		
	}
	
	//관리자 통계/대분류 이름 가져오기 ajax 코드 
		@RequestMapping("/manager_getStatsCate")
		public void getStatsCate(HttpServletResponse resp){
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/json");
			PrintWriter out = null;
			Map<String,String> jsonMap = null;
			List<BigCategoryDto> cateList = new ArrayList<BigCategoryDto>();
			List<Map<String,String>> jsonList = new ArrayList<Map<String,String>>();
			JSONArray json;
			cateList = service_cate.getBigCategory();
			
			for(int i = 0 ; i < cateList.size(); i++){
				jsonMap = new HashMap<String, String>();
				jsonMap.put("big_name", cateList.get(i).getBig_name());
				jsonList.add(jsonMap);
			}
				json = JSONArray.fromObject(jsonList);
				System.out.println(json);
			try{
				out = resp.getWriter();
				out.println(json);
			}catch(Exception err){
				err.printStackTrace();
			}finally{
				out.close();
			}
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
