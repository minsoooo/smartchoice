/*
 * 	카드추천 PlanController
		
	작성일 : 2016-07-18
	수정일 : 2016-07-19
	작성자 : 김상덕
 */
package com.smartchoice.app.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.smartchoice.app.service.BigCategoryService;



@Controller
public class PlanController {
	private static final Logger logger = LoggerFactory.getLogger(PlanController.class);
	
	@Inject
	private BigCategoryService service;
	
	//카드추천 Intro 페이지로 이동
	@RequestMapping("/planCard/planIntro")
	public void planintroGET() {}
	
	//카드추천 Intro 페이지로 이동
	@RequestMapping(value="/planCard/planPattern", method = RequestMethod.POST)
	public void planlistPost(HttpServletRequest req, Model model) {
		model.addAttribute("bigDtoList" ,service.getBigCategory());
	}
}
