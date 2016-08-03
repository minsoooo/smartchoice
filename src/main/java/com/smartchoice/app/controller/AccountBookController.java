package com.smartchoice.app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

import com.smartchoice.app.domain.AccountBookDto;
import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.CategoryDto;
import com.smartchoice.app.domain.DiscountDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.StatsDto;
import com.smartchoice.app.service.AccountBookService;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CardService;
import com.smartchoice.app.service.CategoryService;
import com.smartchoice.app.service.DiscountService;
import com.smartchoice.app.service.MemberService;
import com.smartchoice.app.service.StatsService;
import com.smartchoice.app.util.CalendarUtil;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/accountbook/")
public class AccountBookController {	
	@Inject
	private BigCategoryService bigService;
	@Inject
	private CategoryService smallService;
	@Inject
	private AccountBookService abookService;
	@Inject
	private StatsService statsService;
	@Inject
	private MemberService memService;	

	@Inject
	private DiscountService dcService;
	@Inject
	private CardService cardService;

	
	private static final Logger logger = LoggerFactory.getLogger(AccountBookController.class);
	private CalendarUtil cal = new CalendarUtil();
	
	// 지출관리 페이지로 이동
	@RequestMapping("/index")
	public String accountBookGET(String now_year, String now_month, Model model, HttpServletRequest req){
		CalendarUtil cal  = new CalendarUtil();
				
		List<String> list = null;
		HttpSession session = req.getSession();
		MemberDto dto = new MemberDto();
		dto= (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = dto.getMem_num();
		
		int cal_year = cal.getNowYear(now_year);
		int cal_month = cal.getNowMonth(now_month);		// calendar객체를 통해 년,월을 받아옴
		
		String regi_month = "";		// 받아온 년,월을 2016-07 의 형태로 합치기 위함
		
		if(cal_month < 10){
			regi_month = cal_year + "-0" + cal_month;
		}
		else{
			regi_month = cal_year + "-" + cal_month;
		}

		list = abookService.selectRegiDay(regi_month, regi_memnum);	// 해당 '월' 중 등록된 '일'의 값을 리스트 형태로 가져옴
		String regi_days = "";
				
		for(int i = 0; i < list.size(); i++){
			regi_days += list.get(i) + ",";
		}

		model.addAttribute("now_year", cal_year);
		model.addAttribute("now_month", cal_month);
		model.addAttribute("regi_days", regi_days);
		return "/accountbook/accountbook_index";
	}
	
	// 선택한 날짜의 지출목록을 불러옴
	@RequestMapping("/getAccountBook")
	public void getAccountBook(HttpServletResponse resp, HttpServletRequest req, String regi_month, String regi_day){
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/xml");
		PrintWriter out =null;
		
		HttpSession session = req.getSession();
		MemberDto memDto = new MemberDto();
		memDto = (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = memDto.getMem_num();
		
		int abook_reginum = abookService.selectRegiNum(regi_month, regi_day, regi_memnum);	// 선택한 날짜의 regi_num을 가져옴
		
		List<AccountBookDto> accountbook = abookService.getAccountBook(abook_reginum);		// regi_num에 해당하는 지출목록을 가져옴
		AccountBookDto abookDto = null;
		CategoryDto categoryDto = null;
		
		try {
			out = resp.getWriter();
			
			out.println("<response>");
				
			for(int i = 0; i < accountbook.size(); i++){
				abookDto = (AccountBookDto)accountbook.get(i);
				categoryDto = smallService.getCategoryName(abookDto.getAbook_smallnum());
				// small_num을 통해 대분류와 소분류 정보를 꺼내옴
				
				out.println("<accountbook>");
				out.println("<money>" + abookDto.getAbook_money() + "</money>");
				out.println("<bignum>" + categoryDto.getBig_num() + "</bignum>");				
				out.println("<smallnum>" + categoryDto.getSmall_num() + "</smallnum>");
				out.println("<bigname>" + categoryDto.getBig_name() + "</bigname>");				
				out.println("<smallname>" + categoryDto.getSmall_name() + "</smallname>");	
				out.println("</accountbook>");
			}
			
			out.println("</response>");
		} catch (IOException e) {
			logger.info("AccountBookController getAccountBook : " + e);
		} finally{
			out.close();
		}
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

	// '저장하기'버튼을 클릭한 경우
	@SuppressWarnings({"unchecked"})
	@RequestMapping(value="/insertList", method=RequestMethod.POST)
	public void insertAccountBook(HttpServletRequest req, HttpServletResponse resp, @RequestBody String paramData 
															) throws UnsupportedEncodingException{
		// json string 값을 @RequestBody를 이용해 받아옴

		PrintWriter out =null;
		
		HttpSession session = req.getSession();
		
		MemberDto dto = new MemberDto();
		List<Map<String, Object>> accountList = new ArrayList<Map<String, Object>>();
		accountList = JSONArray.fromObject(paramData);		// json배열을 map형식으로 arraylist에 담음
		
		String regi_month = (String) accountList.get(0).get("regi_month");		// 선택한 년,월 (예 2016-07)
		String regi_day = (String) accountList.get(0).get("regi_day");			// 선택한 일
		dto= (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = dto.getMem_num();
		int regi_num = 0;

		
		if(accountList.get(0).size() == 2){	
			// 날짜만 받아온 경우임. 즉, 지출목록을 모두 지우고 저장하는 경우			
			abookService.deleteRegiAbook(regi_month, regi_day, regi_memnum);	// regi_abook테이블의 해당 날짜를 삭제
		}
		else{
			try{			
				if(abookService.selectRegiNum(regi_month, regi_day, regi_memnum) > 0){	// 이미 지출을 등록한 날짜인 경우
					regi_num = abookService.selectRegiNum(regi_month, regi_day, regi_memnum);
					abookService.deleteAccountBook(regi_num);	// 기존의 지출목록 데이터를 삭제
				}// 지출을 등록하지 않은 날짜라면 NullPointer에러 발생 -> catch문에서 처리		
			}
			catch(Exception e){	// 지출을 등록하지 않은 날짜라면
				abookService.insertRegiAbook(regi_month, regi_day, regi_memnum);		// regi_abook 테이블에 날짜 추가
			}
			finally{
				regi_num = abookService.selectRegiNum(regi_month, regi_day, regi_memnum);
				// 추가된 후 regi_num을 가져옴
			}
			
			for(Map<String, Object> map : accountList){
				map.put("abook_reginum", regi_num);
				abookService.insertAccountBook(map);
				// accountbook 테이블에 regi_num과 지출목록을 추가
			}	
			
		}

	}

	// 통계보기 페이지로 이동, 해당 달에 할인받은 금액을 표시
	@RequestMapping("/stats")
	public String statsGET(String regi_month, String now_year, String now_month, HttpServletRequest req, Model model){
		model.addAttribute("regi_month", regi_month);
		model.addAttribute("now_year", now_year);
		model.addAttribute("now_month", now_month);
		return "accountbook/accountbook_stats";
	}
	
	// 가장 많이 이용한 소분류를 통계냄
	@RequestMapping(value="/stats", method=RequestMethod.POST)
	public void getStatsResult(String regi_month, HttpServletRequest req, HttpServletResponse resp){
		PrintWriter out =null;
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/json");
		
		HttpSession session = req.getSession();
		MemberDto dto = new MemberDto();
		dto= (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = dto.getMem_num();
		
		List smallnums = statsService.getSmallNums(regi_month, regi_memnum);	// 한 달 동안 사용한 소분류들을 가져옴
		JSONArray json;
		
		if(smallnums.size() != 0){	// 이번 달 지출내역이 존재하는 경우
			
			int[][] sumArray = {{0,0},{0,0},{0,0}};		// 소분류 별 사용합계를 저장하기 위한 공간 (small_num, sum)
			
			if(smallnums.size() > 3){	// 사용한 소분류가 3가지가 넘었을 경우
				sumArray = new int[smallnums.size()][2];		
			}
			
			// 사용한 소분류 별 합계를 구함
			
			for(int i = 0; i < smallnums.size(); i++){		
				int small_num = (Integer) smallnums.get(i);
				
				List moneyList = statsService.getMoneyList(regi_month, regi_memnum, small_num);	
				// 해당 소분류에 사용한 금액을 모두 가져옴
				
				int sum = 0;
				
				// 합계를 구하여 배열에 담음
				for(int j = 0; j < moneyList.size(); j++){
					sum += (Integer)moneyList.get(j);
				}                                   
	
				sumArray[i][0] = small_num;
				sumArray[i][1] = sum;
			}
			
			
			// 선택정렬(내림차순)
			for(int m = 0; m < sumArray.length - 1; m++){
				for(int n = m+1; n < sumArray.length; n++){
					if(sumArray[m][1] < sumArray[n][1]){		// 합계를 비교
						int[] temp = sumArray[m];
						sumArray[m] = sumArray[n];				// 조건을 만족한다면 해당 small_num과 sum의 자리를 바꿈
						sumArray[n] = temp;
					} 
				}
			}		
			
			StatsDto result1, result2, result3;
			
			if(smallnums.size() == 1){	// 하나의 소분류만 사용한 경우
				result1 = statsService.getStatsResult(sumArray[0][0]);		
				result1.setSum(sumArray[0][1]);
		
				
				result2 = new StatsDto();
				result3 = new StatsDto();	// 생성자를 통해 기본값으로 저장(0 or "")
			}
			else if(smallnums.size() == 2){	// 두개의 소분류만 사용한 경우
				result1 = statsService.getStatsResult(sumArray[0][0]);		
				result1.setSum(sumArray[0][1]);	
				
				result2 = statsService.getStatsResult(sumArray[1][0]);	
				result2.setSum(sumArray[1][1]);
				
				result3 = new StatsDto();
			}
			else{	// 세개 이상의 소분류를 사용한 경우
				result1 = statsService.getStatsResult(sumArray[0][0]);		// 1번 결과를 dto에 담음
				result1.setSum(sumArray[0][1]);	
				
				result2 = statsService.getStatsResult(sumArray[1][0]);		// 2번 결과를 dto에 담음
				result2.setSum(sumArray[1][1]);
				
				result3 = statsService.getStatsResult(sumArray[2][0]);		// 3번 결과를 dto에 담음
				result3.setSum(sumArray[2][1]);
			}
			
			
			List<StatsDto> statslist = new ArrayList<StatsDto>();		// json으로 파싱하기 위해 dto들을 리스트에 담음
			statslist.add(result1);
			statslist.add(result2);
			statslist.add(result3);

			json = JSONArray.fromObject(statslist);		// json 파싱
		}
		else{	// 이번 달 지출내역이 존재하지 않는 경우
			json = JSONArray.fromObject(null);
		}

		try {
			out = resp.getWriter();	
			out.println(json);
		} catch (Exception e) {
			logger.info("AccountBookController getStatsResult : " + e);
		} finally{
			out.close();
		}
	}

	// 이번 달 할인내역
	@RequestMapping("/discountInfo")
	public void getDiscountInfo(Integer small_num1, Integer small_num2, Integer small_num3, 
								Integer sum1, Integer sum2, Integer sum3, HttpServletRequest req, HttpServletResponse resp){
		
		PrintWriter out =null;
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/json");
		
		HttpSession session = req.getSession();
		MemberDto memDto = new MemberDto();
		memDto = (MemberDto)session.getAttribute("MEM_KEY");
		String mem_id = memDto.getMem_id();		
		String card_code = memDto.getMem_cardcode();
		
		int[] small_num = {small_num1, small_num2, small_num3};	
		int[] sum = {sum1, sum2, sum3};
		
		DiscountDto dcInfoDto = null;
		List<DiscountDto> dcInfoList = new ArrayList<DiscountDto>();	// 내가 할인받은 정보들을 담을 공간
		
		JSONArray json = null;
		
		for(int i = 0; i < 3; i++){
			try{
				dcInfoDto = dcService.getCardDCInfo(card_code, small_num[i]);	
				// 등록한 카드에서 해당 소분류의 할인정보를 dto에 담음
				int dc_value = dcInfoDto.getDc_value();
				
				// '%'으로 할인되는 경우
				if(dcInfoDto.getDc_classify() == 0){			
					int dc_money = sum[i] / 100 * dc_value;
					
					if(dc_money > dcInfoDto.getDc_max()){	// 계산한 결과가 할인받을 수 있는 최대 금액을 넘었을 경우
						dc_money = dcInfoDto.getDc_max();
					}
					
					dcInfoDto.setDc_discountMoney(dc_money);	// 계산한 결과를 dto에 넣음
				}
				else{	// '원'로 할인되는 경우
					int dc_money = dc_value;
					dcInfoDto.setDc_discountMoney(dc_money);
				}
				
				dcInfoDto.setComp_name(memDto.getComp_name());
				dcInfoDto.setCard_name(memDto.getCard_name());
				dcInfoList.add(dcInfoDto);	// dto를 arraylist에 추가
			}
			catch(Exception e){}
		}
	
		try{
			out = resp.getWriter();
			json = JSONArray.fromObject(dcInfoList);
			out.println(json);
		}
		catch(Exception e){
			logger.info("AccountController getDiscountInfo : " + e);
		}
		finally{
			out.close();
		}
		
	}

	// '카드추천' 버튼을 클릭한 경우 
	// 현재 사용하는 카드보다 더 많은 할인을 받을 수 있는 카드가 존재하는지 검사, 그 카드의 모든 할인정보를 담음
	@RequestMapping("/recommendCard")
	public void recommendCard(Integer max_small_num, Integer small_num1, Integer small_num2, Integer small_num3,
			Integer money, String regi_month, HttpServletRequest req, HttpServletResponse resp){
		
		PrintWriter out =null;
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/json");
		JSONArray json = null;
		
		HttpSession session = req.getSession();
		MemberDto memDto = new MemberDto();
		memDto = (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = memDto.getMem_num();	
		String card_code = memDto.getMem_cardcode();
		
		List moneyList = statsService.getMoneyList(regi_month, regi_memnum, max_small_num);	
		// 해당 소분류(가장 많은 할인을 받은 소분류)에 사용한 금액을 가져옴
	
		int sum = 0;
		// 합계를 구함
		for(int j = 0; j < moneyList.size(); j++){
			sum += (Integer)moneyList.get(j);
		}

		
		List<DiscountDto> infoList = dcService.getAllCardDCInfo(max_small_num);	
		// 해당 소분류를 할인해주는 카드들의 정보를 가져옴
		
		DiscountDto dcInfoDto = null;

		for(int i = 0; i < infoList.size(); i++){
			try{
				dcInfoDto = infoList.get(i);	
				
				int dc_value = dcInfoDto.getDc_value();
				
				// '%'으로 할인되는 경우
				if(dcInfoDto.getDc_classify() == 0){			
					int dc_money = sum / 100 * dc_value;
					
					if(dc_money > dcInfoDto.getDc_max()){	// 계산한 결과가 할인받을 수 있는 최대 금액을 넘었을 경우
						dc_money = dcInfoDto.getDc_max();
					}
					
					infoList.get(i).setDc_discountMoney(dc_money);	
				}
				else{	// '원'로 할인되는 경우
					int dc_money = dc_value;
					infoList.get(i).setDc_discountMoney(dc_money);
				}
			}
			catch(Exception e){}
		}
		
		int max_dc_money = money;		// 현재 할인받은 금액을 초기값으로 설정
		CardDto cardDto = null;
		
		for(int j = 0; j < infoList.size(); j++){
			if(max_dc_money < infoList.get(j).getDc_discountMoney()){	// 더 많이 할인받을 수 있는 카드가 있다면
				max_dc_money = infoList.get(j).getDc_discountMoney();
				dcInfoDto = infoList.get(j);	// 그 카드의 정보를 dto에 담음
			}
			else{	
				dcInfoDto = dcService.getCardDCInfo(card_code, max_small_num);	// 현재 카드의 정보를 dto에 담음
				dcInfoDto.setDc_discountMoney(money);
			}
		}
		
		List<DiscountDto> AllDcList = dcService.getAllCardDCInfo(dcInfoDto.getDc_cardcode());
		// 추천카드의 모든 할인정보를 가져옴
		
		List<DiscountDto> dcList = new ArrayList<DiscountDto>();	// 나의 소분류 Top3에 해당하는 할인정보만 담을 공간
		
		for(int k = 0; k < AllDcList.size(); k++){
			int dc_smallnum = AllDcList.get(k).getDc_smallnum();
			if(dc_smallnum == small_num1 || dc_smallnum == small_num2 || dc_smallnum == small_num3){
				dcList.add(AllDcList.get(k));
			}
		}
		
		cardDto = cardService.getCardName(dcInfoDto.getDc_cardcode());	// 추천카드의 정보를 가져옴(카드명, 카드이미지)
		
		// 뷰에서 카드이미지와 카드이름을 출력하기 위해 첫번째(get(0))에만 설정해줌
		String card_img = cardDto.getCard_img();
		dcList.get(0).setCard_img(card_img);
		
		String card_name = cardDto.getCard_name();
		dcList.get(0).setCard_name(card_name);
		
		String comp_name = cardService.getCompName(dcInfoDto.getDc_cardcode());
		dcList.get(0).setComp_name(comp_name);
		
		
		try{
			out = resp.getWriter();
			json = JSONArray.fromObject(dcList);
			out.println(json);
		}
		catch(Exception e){
			logger.info("AccountController recommendCard : " + e);
		}
		finally{
			out.close();
		}
	}
	
	// 이번 달 총 사용금액
	@RequestMapping("/totalMoney")
	public void getTotalMoney(String regi_month, HttpServletRequest req, HttpServletResponse resp){
		resp.setContentType("text/plain");
		
		PrintWriter out = null;
		HttpSession session = req.getSession();
		MemberDto memDto = new MemberDto();
		memDto = (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = memDto.getMem_num();
		
		List<Integer> moneylist = abookService.getTotalMoney(regi_memnum, regi_month);
		int total = 0;
		
		for(int i = 0; i < moneylist.size(); i++){
			total += moneylist.get(i);
		}
		
		try{
			out = resp.getWriter();
			out.println(total);
		}
		catch(Exception e){
			logger.info("AccountBookController getTotalMoney : " + e);
		}
		finally{
			out.close();
		}
	}
}
