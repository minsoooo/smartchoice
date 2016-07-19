package com.smartchoice.app.controller;
/*
 * 	 작성자 : 박민수
 * 	 작성일 : 2016-07-18
 * 	 설명 : 회원관련 controller
 * 
 */
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

import com.smartchoice.app.util.MemberValidation;
import com.smartchoice.app.controller.MemberController;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;
	
	@RequestMapping("/member")
	public void member(){
		
	}
	
	@RequestMapping(value ="/member",method=RequestMethod.POST)
	public String regiMember(HttpServletRequest req, @ModelAttribute MemberDto dto){
		String mem_email = req.getParameter("email1")+"@"+req.getParameter("email2");
		String mem_level = "1";
		
		dto.setMem_email(mem_email);
		dto.setMem_level(mem_level);
		service.regiMember(dto);
		
		return "home";
	}
	
	@RequestMapping("/delete")
	public void deleteMember(int mem_num){
		service.deleteMember(mem_num);
	}
	
	@RequestMapping("/update")
	public void updateMember(){

	}
	
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public void updateMember(@ModelAttribute MemberDto dto){
		service.updateMember(dto);
	}
	
	@RequestMapping("/memberList")
	public List<MemberDto> getMemberList(){
		return service.getMemberList();
	}
	
	@RequestMapping("/login")
	public void login(){
		
	}
	
	@RequestMapping(value ="/login", method=RequestMethod.POST)
	public String loginComplete(@Valid MemberDto member, BindingResult result, HttpServletRequest req){
		logger.info(member.toString());
		
		if(result.hasErrors()){
			return"/member/login";
		}
		try {
			MemberDto dto = service.getMember(member.getMem_id(), member.getMem_pw());
			WebUtils.setSessionAttribute(req, "MEM_KEY", dto);
		} catch (Exception e) {
			result.reject("login");
			return"/member/login";
		}

		return "home";	
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req){
		req.getSession().invalidate();
		return "home";
	}
	
	
	@InitBinder
	private void initBinder(WebDataBinder binder){
		binder.setValidator(new MemberValidation());
	}
}
