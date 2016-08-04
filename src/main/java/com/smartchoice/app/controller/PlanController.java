/*
 * 	카드추천 PlanController
		
	작성일 : 2016-07-18
	수정일 : 2016-08-04
	작성자 : 김상덕
	cardPlan Snapshot 2.0 by.santori
 */
package com.smartchoice.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.CategoryDto;

import com.smartchoice.app.domain.DiscountDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.cardResultDto;

import com.smartchoice.app.service.BigCategoryService;

import com.smartchoice.app.service.CardService;
import com.smartchoice.app.service.CategoryService;
import com.smartchoice.app.service.DiscountService;
import com.smartchoice.app.util.ValueComparator;


import net.sf.json.JSONArray;


@Controller
public class PlanController {
	private static final Logger logger = LoggerFactory.getLogger(PlanController.class);
		
	@Inject
	private BigCategoryService bigCategoryService;
	
	@Inject
	private CategoryService categoryService;
	
	@Inject
	private DiscountService discountService;
	
	@Inject
	private CardService cardService;

	//카드추천 Intro 페이지로 이동
	@RequestMapping("/planCard/planIntro")
	public void planintroGET() {}
	
	//카드추천 Intro 페이지로 이동
	@RequestMapping(value="/planCard/planPattern", method = RequestMethod.POST)
	public void planlistPost(HttpServletRequest req, Model model) {
		String cardtypeflag = req.getParameter("card_classify");
		String usemonthmoney = req.getParameter("cuns");
		model.addAttribute("cardtypeflag", cardtypeflag);
		model.addAttribute("usemonthmoney", usemonthmoney);
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
				 out.println("<big_name><![CDATA["+dto.getBig_name()+"]]></big_name>");
				 out.println("<small_num>"+dto.getSmall_num()+"</small_num>");
				 out.println("<small_name><![CDATA["+dto.getSmall_name()+"]]></small_name>");
				 out.println("<small_img><![CDATA["+dto.getSmall_img()+"]]></small_img>");
				 out.println("</category>");
			 }
			 out.println("</response>");
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			out.close();
		}
	}
	
	@SuppressWarnings({"unchecked"})
	@RequestMapping(value="/planCard/planResult", method = RequestMethod.POST)
	public @ResponseBody List<Object> planResultPost(HttpServletRequest req, HttpServletResponse resp, @RequestBody String paramData) throws UnsupportedEncodingException {
		// json string 값을 @RequestBody를 이용해 받아옴
		PrintWriter out =null;
		List<Map<String, Object>> accountList = new ArrayList<Map<String, Object>>();
		List<DiscountDto> discountList = new ArrayList<DiscountDto>();
		accountList = JSONArray.fromObject(paramData);		// json배열을 map형식으로 arraylist에 담음
		
		
		ArrayList totalMoneylist = null;
		ArrayList plansmallCardlist = new ArrayList();
		
		Map totalmap = new HashMap();
		Map smallCardlist = new HashMap();
		
		int plan_usemonthmoney = Integer.parseInt(accountList.get(0).get("plan_usemonthmoney").toString()); //월 예상 사용금액
		int plan_useEtcMoney = Integer.parseInt(accountList.get(0).get("plan_useEtcMoney").toString()); //월 예상 사용금액
		int cardtypeflag;
		String plan_name;
		int plan_num;
		int plan_money;
		
		if(accountList.get(0).get("plan_cardtypeflag").equals("신용")){// 카드종류 
			cardtypeflag = 0;
		}else{
			cardtypeflag = 1;
		}
		
		for(int i=0 ; i<accountList.size() ; i++){ //종목별로 돌린다
			logger.info(i+"번째 종목************************");
			
			plan_name = (String) accountList.get(i).get("plan_name");
			plan_num = Integer.parseInt((String)accountList.get(i).get("plan_num"));
			plan_money = Integer.parseInt((String)accountList.get(i).get("plan_money"));
			
			discountList = discountService.getSmallSelect(plan_num, cardtypeflag);
			DiscountDto dDto = null;
			
			
			for(int j=0 ; j<discountList.size(); j++){ // 종목으로 선택된 카드별로 돌린다
				cardResultDto resultDto = null;
				cardResultDto resultDtoSub = null;
				logger.info(plan_name+"부분---------------------------");
				dDto = discountList.get(j);
				if(plan_money > dDto.getDc_min()){	//사용금액이 최소사용금액보다 큰경우 
					if(dDto.getDc_classify() == 0){ //% 할인 경우
						dDto.setDc_discountMoney(plan_money * dDto.getDc_value()/100); //할인액 저장
					}else if(dDto.getDc_classify() == 1){ // 원 할인 경우
						dDto.setDc_discountMoney(plan_money - dDto.getDc_value());
						//주유일 경우 L당 계산 추가 해야됨****** 휘발유는 1L에 1400원으로해 
					}
					
					if(dDto.getDc_discountMoney() > dDto.getDc_max()){//할인된 금액이 최대 할인액 보다 큰경우
						dDto.setDc_discountMoney(dDto.getDc_max());
					}
				}
				else{
					dDto.setDc_discountMoney(0);
				}
				if(i == 0){//첫 소분류에서는 맵에 다 넣는다.
					totalmap.put(dDto.getDc_cardcode(), dDto.getDc_discountMoney());
					
					//resultView에서 쓸수 잇게 가공
					resultDto = new cardResultDto();
					resultDto.setCardCode(dDto.getDc_cardcode());
					resultDto.setSmallNum(dDto.getDc_smallnum());
					resultDto.setSmallMoney(dDto.getDc_discountMoney());
					resultDto.setSmallName(plan_name);
					resultDto.setPlanMoney(plan_money);
					resultDto.setUsemonthMoney(plan_usemonthmoney);
					resultDto.setUseetcMoney(plan_useEtcMoney);
					plansmallCardlist.add(resultDto);//cardResult Dto를 리스트에 넣어요 
					
				}
				else{//두번째 소분류 부터는 카드 명이 같으면 합치고 같은게 없으면 넣는다,
					if(totalmap.get(dDto.getDc_cardcode()) == null){ //코드 중복이 없으면 값은 넣는다.
						totalmap.put(dDto.getDc_cardcode(), dDto.getDc_discountMoney());
						//resultView에서 쓸수 잇게 가공
						resultDto = new cardResultDto();
						resultDto.setCardCode(dDto.getDc_cardcode());
						resultDto.setSmallNum(dDto.getDc_smallnum());
						resultDto.setSmallMoney(dDto.getDc_discountMoney());
						resultDto.setSmallName(plan_name);
						resultDto.setPlanMoney(plan_money);
						resultDto.setUsemonthMoney(plan_usemonthmoney);
						resultDto.setUseetcMoney(plan_useEtcMoney);
						plansmallCardlist.add(resultDto);//cardResult Dto를 리스트에 넣어요 
					}
					else{//중복 된게 있으면 합한다.
						int saveTotalMoney = (Integer) totalmap.get(dDto.getDc_cardcode()); //값을 빼서 저장
						totalmap.remove(dDto.getDc_cardcode());
						totalmap.put(dDto.getDc_cardcode(), (dDto.getDc_discountMoney()+saveTotalMoney));
						//resultView에서 쓸수 잇게 가공
						for(int k=0 ; k<plansmallCardlist.size() ; k++){
							resultDtoSub = (cardResultDto) plansmallCardlist.get(k);
							if(resultDtoSub.getCardCode().equals(dDto.getDc_cardcode())){
								resultDtoSub.setSmallNum(dDto.getDc_smallnum());
								resultDtoSub.setSmallMoney(dDto.getDc_discountMoney());
								resultDtoSub.setSmallName(plan_name);
								resultDtoSub.setPlanMoney(plan_money);
								resultDtoSub.setUsemonthMoney(plan_usemonthmoney);
								resultDtoSub.setUseetcMoney(plan_useEtcMoney);
								
							}
						}
					}
				}
			}
		}
		
		Map<String,Object> sortedMap = new TreeMap(new ValueComparator(totalmap)); //map value 기준 정렬
		sortedMap.putAll(totalmap);//map value 기준 정렬
		
		totalMoneylist = new ArrayList(sortedMap.values()); //이걸로 value를 배열로 받을수 있엉
			
		req.getSession().invalidate();
		WebUtils.setSessionAttribute(req, "plansmallCardlist", plansmallCardlist);
		
		return totalMoneylist;
	}
	
	
	//결과 페이지로 이동
	@RequestMapping(value="/planCard/planResultView")
	public void planResultViewPost(HttpServletRequest req, Model model) {
		HttpSession session= req.getSession();
		List plansmallCardlist = (List) session.getAttribute("plansmallCardlist");
		List SortplansmallCardlist = new ArrayList();
		
		//카드 이름과 이미지를 가져와야되요
		for(int i=0; i<plansmallCardlist.size() ; i++){
			cardResultDto resultDto1 = (cardResultDto) plansmallCardlist.get(i);
			CardDto cardDto =  cardService.getCard(resultDto1.getCardCode());
			resultDto1.setCardName(cardDto.getCard_name());
			resultDto1.setCardImg(cardDto.getCard_img());
			resultDto1.setCardAnnualfee(cardDto.getCard_annualfee());
		}
		//각 카드별 할인정보를 가져와야 되요
		for(int i=0; i<plansmallCardlist.size() ; i++){
			cardResultDto resultDto1 = (cardResultDto) plansmallCardlist.get(i);
			List<DiscountDto> discountDtoList = new ArrayList<DiscountDto>();
			discountDtoList = discountService.getDiscountDetail(resultDto1.getCardCode());
			DiscountDto discountDto = null;
			String EtcContent = null;
			String classify = null;
			String etc = null;
			for(int j=0; j<discountDtoList.size() ; j++){
				discountDto = discountDtoList.get(j);
				resultDto1.setEtcName(discountDto.getSmall_name());
				if(discountDto.getDc_classify() == 0){
					classify = "% 할인";
				}else{
					classify = "원 할인";
				}
				if(discountDto.getDc_etc() != null){
					etc = "["+discountDto.getDc_etc()+"]  ";
				}else{
					etc =" ";
				}
				
				EtcContent = etc+ Integer.toString(discountDto.getDc_value()) + classify ;
				resultDto1.setEtcContent(EtcContent);
			}
		}
	
		
		//정렬
		cardResultDto sortDto[] =  new cardResultDto[plansmallCardlist.size()];
		for(int i=0; i<sortDto.length ; i++){
			sortDto[i] = (cardResultDto) plansmallCardlist.get(i);
		}
		cardResultDto tmp;
		for(int i=0; i<plansmallCardlist.size() ; i++){
			for(int j=0; j<plansmallCardlist.size()-1 ; j++){
				if(sortDto[j].getTotalMoney() < sortDto[j+1].getTotalMoney() ){
					tmp = sortDto[j];
					sortDto[j] = sortDto[j+1];
					sortDto[j+1] = tmp;
				}
			}
		}
		//다시 리스트에 넣음
		for(int i=0; i<sortDto.length ; i++){
			SortplansmallCardlist.add(sortDto[i]);
		}
		//정렬 끝
		model.addAttribute("SortplansmallCardlist", SortplansmallCardlist);
		
	}
	

}

