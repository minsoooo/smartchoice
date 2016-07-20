package com.smartchoice.app.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
/*
 * 	 �ۼ��� : �ڹμ�
 * 	 �ۼ��� : 2016-07-18
 * 	 ���� : ȸ������ controller
 * 
 */
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.smartchoice.app.util.Cipher;
import com.smartchoice.app.util.MailSend;
import com.smartchoice.app.util.MemberValidation;
import com.smartchoice.app.controller.MemberController;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;
	
	@Inject 
	private BigCategoryService service_cate;
	
	@RequestMapping("/check")
	public void checkId(String mem_id, HttpServletResponse resp){
		String result = "true";
		if(service.getMemberWithId(mem_id) != null){
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

	@RequestMapping("/code")
	public void sendCode(HttpServletRequest req, HttpServletResponse resp){
		MailSend send = new MailSend();
		Cipher cipher = new Cipher();
		String recipient = req.getParameter("email1")+"@"+req.getParameter("email2");
		String title = "이메일 인증 코드입니다.";
		String newCode = cipher.getNewCode();
		String content ="이메일 인증 코드입니다.. : " + newCode + "  정확히 입력해 주세요";
		send.setProperty("smtp.naver.com", 465, "altntaos@naver.com", "als136512403!");
		send.sendMail(recipient, title, content);
		
		PrintWriter out = null;
		try {
			 out = resp.getWriter();
			 out.print(newCode);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}
	
	
	
	@RequestMapping("/member")
	public void member(){
		
	}
	
	@RequestMapping(value ="/member",method=RequestMethod.POST)
	public String regiMember(HttpServletRequest req, @ModelAttribute MemberDto dto, RedirectAttributes rttr){
		String mem_email = req.getParameter("email1")+"@"+req.getParameter("email2");
		String mem_level = "1";
		dto.setMem_email(mem_email);
		dto.setMem_level(mem_level);
		rttr.addFlashAttribute("MemberDto", dto);
		return "redirect:/member/memberStep2";
	}
	
	@RequestMapping("/memberStep2")
	public void regiStep2(@ModelAttribute(value="MemberDto") MemberDto dto,HttpServletRequest req){
		List CateList = new ArrayList();
		CateList = service_cate.getBigCategory();
		req.setAttribute("CateList", CateList );			
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
			req.setAttribute("check", "success");
		} catch (Exception e) {
			result.reject("login");
			return"/member/login";
		}

		return "/member/login";	
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
