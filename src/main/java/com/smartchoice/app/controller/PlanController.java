/*
 * 	카드추천 controller
	작성일 : 2016-07-18
	수정일 : 2016-07-18
	작성자 : 김상덕
 */
package com.smartchoice.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PlanController {
	private static final Logger logger = LoggerFactory.getLogger(PlanController.class);

	//카드추천 intro 페이지로 이동
	@RequestMapping("/planCard/planIntro")
	public void registerGET() {}
}
