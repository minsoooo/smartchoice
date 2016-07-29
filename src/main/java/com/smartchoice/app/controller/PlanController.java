/*
 * 	카드추천 PlanController
		
	작성일 : 2016-07-18
	수정일 : 2016-07-19
	작성자 : 김상덕
 */
package com.smartchoice.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.CategoryDto;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CategoryService;



@Controller
public class PlanController {
	private static final Logger logger = LoggerFactory.getLogger(PlanController.class);
	
	@Inject
	private BigCategoryService bigCategoryService;
	
	@Inject
	private CategoryService categoryService;
	
	//카드추천 Intro 페이지로 이동
	@RequestMapping("/planCard/planIntro")
	public void planintroGET() {}
	
	//카드추천 Intro 페이지로 이동
	@RequestMapping(value="/planCard/planPattern", method = RequestMethod.POST)
	public void planlistPost(HttpServletRequest req, Model model) {
		model.addAttribute("bigDtoList" ,bigCategoryService.getBigCategory());
	}
	
	//카드추천 smallclass 페이지 
	@RequestMapping(value="/planCard/getSmallclass")
	public void smallclassPost(int blgclass_num, HttpServletResponse resp) throws Exception {
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/xml");
						
		List<CategoryDto> categoryList = new ArrayList<CategoryDto>();
		categoryList = categoryService.getSmallCategory(blgclass_num);
		
		CategoryDto dto = null;
		PrintWriter out = null;
		
		try {
			 out = resp.getWriter();
			 out.println("<response>");
			 for(int i =0; i<categoryList.size();i++){
				 dto = (CategoryDto)categoryList.get(i);
				 out.println("<category>");
				 out.println("<big_num>"+dto.getBig_num()+"</big_num>");
				 out.println("<big_name>"+dto.getBig_name()+"</big_name>");
				 out.println("<small_num>"+dto.getSmall_num()+"</small_num>");
				 out.println("<small_name>"+dto.getSmall_name()+"</small_name>");
				 out.println("</category>");
			 }
			 out.println("</response>");
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}

}
