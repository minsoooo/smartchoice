package com.smartchoice.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smartchoice.app.domain.AccountBookDto;
import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.domain.CategoryDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.service.AccountBookService;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CalendarService;
import com.smartchoice.app.service.CategoryService;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/accountbook/")
public class AccountBookController {
	@Inject
	private CalendarService calService;
	@Inject
	private BigCategoryService bigService;
	@Inject
	private CategoryService smallService;
	@Inject
	private AccountBookService abookService;
	
	private static final Logger logger = LoggerFactory.getLogger(AccountBookController.class);
	
	// 지출관리 페이지로 이동
	@RequestMapping("/index")
	public String accountBookGET(String now_year, String now_month, Model model, HttpServletRequest req){
		List<String> list = null;
		HttpSession session = req.getSession();
		MemberDto dto = new MemberDto();
		dto= (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = dto.getMem_num();
		
		int cal_year = calService.getNowYear(now_year);
		int cal_month = calService.getNowMonth(now_month);		// calendar객체를 통해 년,월을 받아옴
		
		String regi_month = "";		// 받아온 년,월을 2016-07 의 형태로 합치기 위함
		
		if(cal_month < 10){
			regi_month = cal_year + "-0" + cal_month;
		}
		else{
			regi_month = cal_year + "-" + cal_month;
		}

		list = abookService.selectRegiDay(regi_month, regi_memnum);	// 해당 '월' 중 등록된 '일'의 값을 리스트 형태로 가져옴
		String regi_days = "";
				
		for(int i = 0; i < list.size(); i++){
			regi_days += list.get(i) + ",";
		}

		model.addAttribute("now_year", cal_year);
		model.addAttribute("now_month", cal_month);
		model.addAttribute("regi_days", regi_days);
		return "/accountbook/accountbook_index";
	}
	
	// 선택한 날짜의 지출목록을 불러옴
	@RequestMapping("/getAccountBook")
	public void getAccountBook(HttpServletResponse resp, HttpServletRequest req, String regi_month, String regi_day){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/xml");
		PrintWriter out =null;
		
		HttpSession session = req.getSession();
		MemberDto memDto = new MemberDto();
		memDto = (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = memDto.getMem_num();
		
		int abook_reginum = abookService.selectRegiNum(regi_month, regi_day, regi_memnum);	// 선택한 날짜의 regi_num을 가져옴
		
		List<AccountBookDto> accountbook = abookService.getAccountBook(abook_reginum);		// regi_num에 해당하는 지출목록을 가져옴
		AccountBookDto abookDto = null;
		CategoryDto categoryDto = null;
		
		try {
			out = resp.getWriter();
			
			out.println("<response>");
				
			for(int i = 0; i < accountbook.size(); i++){
				abookDto = (AccountBookDto)accountbook.get(i);
				categoryDto = abookService.getCategoryName(abookDto.getAbook_smallnum());
				// small_num을 통해 대분류와 소분류 정보를 꺼내옴
				
				out.println("<accountbook>");
				out.println("<money>" + abookDto.getAbook_money() + "</money>");
				out.println("<bignum>" + categoryDto.getBig_num() + "</bignum>");				
				out.println("<smallnum>" + categoryDto.getSmall_num() + "</smallnum>");
				out.println("<bigname>" + categoryDto.getBig_name() + "</bigname>");				
				out.println("<smallname>" + categoryDto.getSmall_name() + "</smallname>");	
				out.println("</accountbook>");
			}
			
			out.println("</response>");
		} catch (IOException e) {
			logger.info("AccountBookController getAccountBook : " + e);
		} finally{
			out.close();
		}
	}
	
	// 대분류 목록을 보냄
	@RequestMapping("/bigCategory")
	public void getBigCategory(HttpServletResponse resp){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/xml");
		
		List bigList = new ArrayList();
		bigList = bigService.getBigCategory();
		BigCategoryDto dto = null;		// 대분류 목록을 담을 공간
		PrintWriter out =null;
		
		try {
			out = resp.getWriter();
			
			out.println("<response>");
				
			for(int i = 0; i < bigList.size(); i++){
				dto = (BigCategoryDto)bigList.get(i);					
				
				out.println("<big>");
				out.println("<bignum>" + dto.getBig_num() + "</bignum>");				
				out.println("<bigname><![CDATA[" + dto.getBig_name() + "]]></bigname>");	// 특수문자(&)를 가져오기 위함
				out.println("</big>");
			}
			
			out.println("</response>");
		} catch (IOException e) {
			logger.info("AccountBookController getBigCategory : " + e);
		} finally{
			out.close();
		}
	}
	
	// 소분류 목록을 보냄
	@RequestMapping("/smallCategory")
	public void getSmallCategory(Integer big_num, HttpServletResponse resp){
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/xml");
			
			List smallList = new ArrayList();
			CategoryDto dto = null;		// 선택된 대분류의 소분류를 담을 공간
			PrintWriter out =null;
			
			try {
				smallList = smallService.getSmallCategory(big_num);		// 소분류를 가져옴
				out = resp.getWriter();
				
				out.println("<response>");
				
				for(int i = 0; i < smallList.size(); i++){
					dto = (CategoryDto)smallList.get(i);										
					out.println("<small>");
					out.println("<smallnum>" + dto.getSmall_num() + "</smallnum>");	
					out.println("<smallname><![CDATA[" + dto.getSmall_name() + "]]></smallname>");	
					out.println("</small>");
				}
				
				out.println("</response>");
			} catch (Exception e) {
				logger.info("AccountBookController getSmallCategory : " + e);
			} finally{
				out.close();
			}
			
			
		}

	
	// '저장하기'버튼을 클릭한 경우
	@SuppressWarnings({"unchecked"})
	@RequestMapping(value="/insertList", method=RequestMethod.POST)
	public void insertAccountBook(HttpServletRequest req, HttpServletResponse resp, @RequestBody String paramData 
															) throws UnsupportedEncodingException{
		// json string 값을 @RequestBody를 이용해 받아옴

		PrintWriter out =null;
		
		HttpSession session = req.getSession();
		
		MemberDto dto = new MemberDto();
		List<Map<String, Object>> accountList = new ArrayList<Map<String, Object>>();
		accountList = JSONArray.fromObject(paramData);		// json배열을 map형식으로 arraylist에 담음
		
		String regi_month = (String) accountList.get(0).get("regi_month");		// 선택한 년,월 (예 2016-07)
		String regi_day = (String) accountList.get(0).get("regi_day");			// 선택한 일
		dto= (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = dto.getMem_num();
		int regi_num = 0;

		
		if(accountList.get(0).size() == 2){	
			// 날짜만 받아온 경우임. 즉, 지출목록을 모두 지우고 저장하는 경우			
			abookService.deleteRegiAbook(regi_month, regi_day, regi_memnum);	// regi_abook테이블의 해당 날짜를 삭제
		}
		else{
			try{			
				if(abookService.selectRegiNum(regi_month, regi_day, regi_memnum) > 0){	// 이미 지출을 등록한 날짜인 경우
					regi_num = abookService.selectRegiNum(regi_month, regi_day, regi_memnum);
					abookService.deleteAccountBook(regi_num);	// 기존의 지출목록 데이터를 삭제
				}// 지출을 등록하지 않은 날짜라면 NullPointer에러 발생 -> catch문에서 처리		
			}
			catch(Exception e){	// 지출을 등록하지 않은 날짜라면
				abookService.insertRegiAbook(regi_month, regi_day, regi_memnum);		// regi_abook 테이블에 날짜 추가
			}
			finally{
				regi_num = abookService.selectRegiNum(regi_month, regi_day, regi_memnum);
				// 추가된 후 regi_num을 가져옴
			}
			
			for(Map<String, Object> map : accountList){
				map.put("abook_reginum", regi_num);
				abookService.insertAccountBook(map);
				// accountbook 테이블에 regi_num과 지출목록을 추가
			}	
			
		}

	}
}
