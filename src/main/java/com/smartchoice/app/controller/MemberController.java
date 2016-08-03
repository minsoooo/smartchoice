
/*
 * 	 작성자 :박민수	
 * 	 작성일 : 2016-07-18
 * 	 설명 : Member 관련 Controller 처리 
 * 
 */
package com.smartchoice.app.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.session.SqlSession;
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
import com.smartchoice.app.controller.MemberController;
import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CardService;
import com.smartchoice.app.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	///Member처리 서비스
	@Inject
	private MemberService service_mem;
	///Category처리 서비스
	@Inject 
	private BigCategoryService service_cate;
	///Card처리 서비스
	@Inject
	private CardService service_card;
	
	//아이디 중복체크 코드 AJAX
	@RequestMapping("/check")
	public void checkId(String mem_id, HttpServletResponse resp){
		String result = "true";
		if(service_mem.getMemberWithId(mem_id) != null){
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
	//이메일 인증코드 발송 코드 AJAX 처리
	@RequestMapping("/code")
	public void sendCode(HttpServletRequest req, HttpServletResponse resp){
		MailSend send = new MailSend();
		Cipher cipher = new Cipher();
		String recipient = req.getParameter("email1")+"@"+req.getParameter("email2");
		String title = "이메일 인증 코드입니다.";
		String newCode = cipher.getNewCode();
		logger.info("인증코드 :" + newCode);
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
	
	//선택한 달의 끝날을 구해오는 코드/AJAX 처리
	@RequestMapping("/maxday")
	public void getMaxday(int selectMonth, HttpServletResponse resp){
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.MONTH, selectMonth-1);
		cal.set(Calendar.DATE, 1);
		int maxDay = cal.getActualMaximum(Calendar.DATE);
		logger.info("끝날가져오기"+Integer.toString(maxDay));
		PrintWriter out = null;
		try{
			out = resp.getWriter();
			out.println(maxDay);
		}catch(Exception err){
			err.printStackTrace();
		}finally{
			out.close();
		}
	}
	//회원가입창 이동
	@RequestMapping("/member")
	public void member(){
		
	}
	//회원기본정보 입력
	@RequestMapping(value ="/member",method=RequestMethod.POST)
	public String regiMember(HttpServletRequest req, @ModelAttribute MemberDto dto, RedirectAttributes rttr){
		String mem_email = req.getParameter("email1")+"@"+req.getParameter("email2");
		String mem_level = "1";
		String mem_birthdate = req.getParameter("year")+"/"+req.getParameter("month")+"/"+req.getParameter("day");
		dto.setMem_birthdate(mem_birthdate);
		dto.setMem_email(mem_email);
		dto.setMem_level(mem_level);
		logger.info("member 1단계 :" +dto.toString());
		rttr.addFlashAttribute("MemberDto", dto);
		return "redirect:/member/memberStep2";
	}
	//회원선호분야 입력 페이지로 이동
	@RequestMapping("/memberStep2")
	public void regiStep2(@ModelAttribute(value="MemberDto") MemberDto dto,HttpServletRequest req){
		List cateList = new ArrayList();
		cateList = service_cate.getBigCategory();
		req.setAttribute("MemberDto", dto);
		req.setAttribute("cateList", cateList );			
	}
	//회원선호분야 저장후 카드선택페이지로 이동
	@RequestMapping(value ="/memberStep2", method=RequestMethod.POST)
	public String regiStep3(@ModelAttribute MemberDto dto, HttpServletRequest req, RedirectAttributes rttr){
		String[] favs= req.getParameterValues("big_cate");
		String mem_fav1 = favs[0];
		String mem_fav2 = favs[1];
		String mem_fav3 = favs[2];
		
		dto.setMem_fav1(mem_fav1);
		dto.setMem_fav2(mem_fav2);
		dto.setMem_fav3(mem_fav3);
		logger.info("2단계 : " + dto.toString() );
		rttr.addFlashAttribute("MemberDto", dto);
		
		return "redirect:/member/memberStep3";
	}
	//회원카드선택페이지로이동
	@RequestMapping("/memberStep3")
	public void regiStep3(@ModelAttribute(value="MemberDto") MemberDto dto,HttpServletRequest req){
		List compList = new ArrayList();
		compList = service_card.getCardComp();
		req.setAttribute("compList", compList);
		req.setAttribute("MemberDto", dto);
	}
	// 회원가입 완료 단계  비밀번호/MD5화 해서 DB연결하기
	@RequestMapping(value ="/memberStep3", method=RequestMethod.POST)
	public String regiComplete(@ModelAttribute MemberDto dto, HttpServletRequest req){
		Cipher cipher = new Cipher();
		String MD5Pw = cipher.getMD5(dto.getMem_pw());
		dto.setMem_pw(MD5Pw);
		logger.info("3단계 : " + dto.toString());
		service_mem.regiMember(dto);
		req.setAttribute("regiCheck", "true");
		return "index";
		
	}
	//카드리스트 가져오는 AJAX 처리 코드
	@RequestMapping("/cardList")
	public void getCardList(int card_compnum,HttpServletResponse resp){
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/xml");
		List<CardDto> cardList = new ArrayList<CardDto>();
		cardList = service_card.getCardList(card_compnum);
		CardDto dto = null;
		PrintWriter out = null;
		try {
			 out = resp.getWriter();
			 out.println("<response>");
			 for(int i =0; i<cardList.size();i++){
				 dto = (CardDto)cardList.get(i);
				 out.println("<card>");
				 out.println("<card_code>"+dto.getCard_code()+"</card_code>");
				 out.println("<card_name><![CDATA["+dto.getCard_name()+"]]></card_name>");
				 out.println("<card_img>"+dto.getCard_img()+"</card_img>");
				 out.println("</card>");
			 }
			 out.println("</response>");
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
		
		

	}
	
	//회원 탈퇴하면 세션을 초기화후 index페이지로 이동
	@RequestMapping( value ="/delete")
	public String deleteMember(String mem_id,HttpServletRequest req){
		service_mem.deleteMember(mem_id);
		req.getSession().invalidate();
		return "index";
	}
	
	//회원정보수정 선택페이지로 이동
	@RequestMapping("/update")
	public void update(){
		
	}
	
	//회원기본정보 수정페이지 이동
	@RequestMapping("/update_basic")
	public void update_basic(){
	}
	
	//회원기본정보 DB연동
	@RequestMapping(value ="/update_basic", method=RequestMethod.POST)
	public String update_basic(@ModelAttribute MemberDto dto, HttpServletRequest req, RedirectAttributes rttr){
		Cipher cipher = new Cipher();
		String mem_email = req.getParameter("email1")+"@"+req.getParameter("email2");
		dto.setMem_email(mem_email);
		String mem_pw = req.getParameter("mem_pw");
		String MD5 = cipher.getMD5(mem_pw);
		dto.setMem_pw(MD5);
		service_mem.updateMember(dto);
		
		//세션에 저장된 값을 바꿔줘야함으로 제거후 다시생성한다.
		req.getSession().invalidate();
		dto = service_mem.getMember(dto.getMem_id(), dto.getMem_pw());
		WebUtils.setSessionAttribute(req, "mem_pw", mem_pw);
		WebUtils.setSessionAttribute(req, "MEM_KEY", dto);
		rttr.addFlashAttribute("check", "success");
		return "redirect:/member/update_basic";
	}
	//회원추가정보 수정페이지 이동/선호분류/카드정보 같이 보내기
	@RequestMapping("/update_add")
	public void update_add(HttpServletRequest req){
		MemberDto dto = new MemberDto();
		HttpSession session = req.getSession();
		dto = (MemberDto)session.getAttribute("MEM_KEY");
		int comp_num = dto.getComp_num();
		List cateList = new ArrayList();
		List compList = new ArrayList();
		List cardList = new ArrayList();
		
		cateList = service_cate.getBigCategory();
		compList = service_card.getCardComp();
		cardList = service_card.getCardList(comp_num);
		req.setAttribute("cateList", cateList );
		req.setAttribute("compList", compList );
		req.setAttribute("cardList", cardList );
	}
	
	//수정한 추가정보를 DB연동
	@RequestMapping(value="/update_add",method=RequestMethod.POST)
	public String update_add(@ModelAttribute MemberDto dto,HttpServletRequest req, RedirectAttributes rttr){
		
		String[] favs= req.getParameterValues("big_cate");
		String mem_fav1 = favs[0];
		String mem_fav2 = favs[1];
		String mem_fav3 = favs[2];
		dto.setMem_fav1(mem_fav1);
		dto.setMem_fav2(mem_fav2);
		dto.setMem_fav3(mem_fav3);
		service_mem.updateMember(dto);
		//세션에 저장된 값을 바꿔줘야함으로 제거후 다시생성한다.
		req.getSession().invalidate();
		dto = service_mem.getMember(dto.getMem_id(), dto.getMem_pw());
		WebUtils.setSessionAttribute(req, "MEM_KEY", dto);
		rttr.addFlashAttribute("check", "success");
		return "redirect:/member/update_add";
	}
	//전체 멤버 리스트 가져오기
	@RequestMapping("/memberList")
	public List<MemberDto> getMemberList(){
		return service_mem.getMemberList();
	}
	//로그인 페이지로 이동
	@RequestMapping("/login")
	public void login(){
		
	}
	//로그인 확인 페이지 /로그인되면 MEM_KEY로 세션 생성
	@RequestMapping(value ="/login", method=RequestMethod.POST)
	public String loginComplete(MemberDto member , HttpServletRequest req){
		logger.info("111");
		try {
			Cipher cipher = new Cipher();
			String MD5Pw = cipher.getMD5(member.getMem_pw());
			logger.info("2222");
			logger.info(member.getMem_id());
			logger.info(MD5Pw);
			MemberDto dto = service_mem.getMember(member.getMem_id(), MD5Pw);
			logger.info(dto.toString());
			WebUtils.setSessionAttribute(req, "mem_pw", member.getMem_pw());
			WebUtils.setSessionAttribute(req, "MEM_KEY", dto);
			req.setAttribute("check", "success");
		} catch (Exception e) {
			req.setAttribute("check", "fail");
			return"/member/login";
		}

		return "/member/login";	
	}
	//로그아웃하면 세션 지우기
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req){
		req.getSession().invalidate();
		return "index";
	}
	//아이디 검색페이지 이동
	@RequestMapping("/searchId")
	public void searchId(){
		
	}
	//아이디 검색 / 이메일로
	@RequestMapping(value="/searchId", method=RequestMethod.POST)
	public void searchId(HttpServletRequest req){
		String mem_email = req.getParameter("email1")+"@"+req.getParameter("email2");
		logger.info(mem_email);
			try{
				String mem_id = service_mem.searchId(mem_email);
				if(!mem_id.equals(null)){
					req.setAttribute("mem_id", mem_id);
					req.setAttribute("result", "success");
				}
			}catch(NullPointerException err){
				req.setAttribute("result", "fail");
			}

	}
	//비밀번호 찾기 페이지 이동
	@RequestMapping("/searchPw")
	public void searchPw(){
		
	}
	//비밀번호 찾기/아이디/이메일
	@RequestMapping(value="/searchPw", method=RequestMethod.POST)
	public void searchPw(HttpServletRequest req){
		
		Cipher cipher = new Cipher();
		String mem_email = req.getParameter("email1")+"@"+req.getParameter("email2");
		String mem_id = req.getParameter("mem_id");
		String mem_pw ="";
		try{
			mem_pw =service_mem.searchPw(mem_id, mem_email);
			if(!mem_pw.equals("")){
				mem_pw = cipher.getNewPass();
				req.setAttribute("result", "success");
				req.setAttribute("mem_pw", mem_pw);
				String MD5 = cipher.getMD5(mem_pw);
				service_mem.updatePw(mem_id, MD5);
			}
		}catch(Exception err){
			req.setAttribute("result", "fail");
		}
		
	}
}
