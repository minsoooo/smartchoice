/*
 * 	ī����õ controller
	�ۼ��� : 2016-07-18
	������ : 2016-07-18
	�ۼ��� : ����
 */
package com.smartchoice.app.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PlanController {
	private static final Logger logger = LoggerFactory.getLogger(PlanController.class);

	//ī����õ intro �������� �̵�
	@RequestMapping("/planCard/planIntro")
	public void registerGET() {}
}
