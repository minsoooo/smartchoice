package com.smartchoice.app.controller;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.smartchoice.app.domain.EventBoardDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.SearchCriteria;
import com.smartchoice.app.service.BoardService;
import com.smartchoice.app.service.MemberService;

import net.sf.json.JSONArray;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private MemberService service_mem;
	
	@Inject
	private BoardService service_board;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {		
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	//총 회원수 구하는 AJAX 코드
	@RequestMapping("/home/memberCount")
	public void getMemberCount(HttpServletResponse resp){
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/plain");
		PrintWriter out = null;
		List<MemberDto> memList = service_mem.getMemberList();
		int memCount = memList.size();
		try{
			out = resp.getWriter();
			out.println(memCount);
		}catch(Exception err){
			err.printStackTrace();
		}finally{
			out.close();
		}
	}
	
	//공지사항 2개 뽑아오기 
	@RequestMapping("/home/getNotice")
	public void getNotice(@ModelAttribute("cri") SearchCriteria cri, HttpServletResponse resp) throws Exception{
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/json");
		PrintWriter out = null;
		Map<String,Object> jsonMap = null;
		List<Map<String,Object>> jsonList = new ArrayList<Map<String,Object>>();
		JSONArray json;
		
		if (cri.getSearchType() == null) {
			cri.setSearchType("notice_title_listSearch");
		}
		if (cri.getKeyword() == null) {
			cri.setKeyword("");
		}
		
		List<NoticeBoardDto> boardList = service_board.listSearch(cri);
		jsonMap = new HashMap<String, Object>();
		jsonMap.put("title", boardList.get(0).getNboard_title());
		jsonMap.put("num", boardList.get(0).getNboard_num());
		jsonList.add(jsonMap);
		
		jsonMap = new HashMap<String, Object>();
		jsonMap.put("title", boardList.get(1).getNboard_title());
		jsonMap.put("num", boardList.get(1).getNboard_num());
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
	/*
	//이벤트 2개 뽑아오기 
	@RequestMapping("/home/getEvent")
	public void getEvent(@ModelAttribute("cri") SearchCriteria cri, HttpServletResponse resp) throws Exception{
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/json");
		PrintWriter out = null;
		Map<String,Object> jsonMap = null;
		List<Map<String,Object>> jsonList = new ArrayList<Map<String,Object>>();
		JSONArray json;
		
		if (cri.getSearchType() == null) {
			cri.setSearchType("notice_title_listSearch");
		}
		if (cri.getKeyword() == null) {
			cri.setKeyword("");
		}
		
		List<EventBoardDto> boardList = service_board.event_listSearch(cri);
		jsonMap = new HashMap<String, Object>();
		jsonMap.put("title", boardList.get(0).getEboard_title());
		jsonMap.put("num", boardList.get(0).getEboard_num());
		jsonList.add(jsonMap);
		
		jsonMap = new HashMap<String, Object>();
		jsonMap.put("title", boardList.get(1).getEboard_title());
		jsonMap.put("num", boardList.get(1).getEboard_num());
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
	
	*/
}
