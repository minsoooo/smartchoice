package com.smartchoice.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.domain.CategoryDto;
import com.smartchoice.app.domain.SmallCategoryDto;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CalendarService;
import com.smartchoice.app.service.CategoryService;

@Controller
@RequestMapping("/accountbook/")
public class AccountBookController {
	@Inject
	private CalendarService calService;
	@Inject
	private BigCategoryService bigService;
	@Inject
	private CategoryService smallService;
	
	private static final Logger logger = LoggerFactory.getLogger(AccountBookController.class);
	
	// 지출관리 페이지로 이동
	@RequestMapping("/index")
	public String accountBookGET(String now_year, String now_month, Model model){
		model.addAttribute("now_year", calService.getNowYear(now_year));
		model.addAttribute("now_month", calService.getNowMonth(now_month));
		
		return "/accountbook/accountbook_index";
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
}
