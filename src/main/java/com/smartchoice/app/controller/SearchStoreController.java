/*
 * 	매장찾기 MapSearchController
		
	작성일 : 2016-07-21
	수정일 : 2016-07-21
	작성자 : 이재승
 */
package com.smartchoice.app.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;

import com.smartchoice.app.domain.BigCategoryDto;
import com.smartchoice.app.domain.CardDto;
import com.smartchoice.app.domain.CategoryDto;
import com.smartchoice.app.domain.DiscountDto;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.service.BigCategoryService;
import com.smartchoice.app.service.CardService;
import com.smartchoice.app.service.CategoryService;
import com.smartchoice.app.service.DiscountService;


@Controller
public class SearchStoreController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private BigCategoryService bigCategoryService;
	
	@Inject
	private CategoryService categoryService;
	
	@Inject
	private CardService cardService;
	
	@Inject
	private DiscountService discountService;
	
	// 매장찾기 페이지로 이동
	@RequestMapping("/searchStore/showMap")
	public void searchShopGET(HttpServletRequest req, Model model) throws Exception {
		HttpSession session = req.getSession();
		MemberDto memberDto = (MemberDto)session.getAttribute("MEM_KEY");
		
		if(memberDto != null){
			String cardCode = memberDto.getMem_cardcode();
			CardDto cardDto = cardService.getCardName(cardCode);
			List<DiscountDto> discountDto = discountService.getDiscountName(cardCode);
			
			model.addAttribute("cardCode", cardDto.getCard_name());
			model.addAttribute("discount", discountDto);
			model.addAttribute("DcBigCategory", discountService.getDcBigCategory(cardCode));
		}
		
		List list = bigCategoryService.getBigCategory();
		BigCategoryDto dto = (BigCategoryDto) list.get(0);
		
		model.addAttribute("bigDtoList" , bigCategoryService.getBigCategory());
		model.addAttribute("smallCateList", categoryService.getSmallCategory(dto.getBig_num()));
		
	}
	
	@RequestMapping("/map/getSmallCategory")
	public void getSmallCategory(int big_num, HttpServletResponse resp) throws Exception {
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/xml");

		List<CategoryDto> categoryList = new ArrayList<CategoryDto>();
		categoryList = categoryService.getSmallCategory(big_num);

		CategoryDto dto = null;
		PrintWriter out = null;

		try {
			out = resp.getWriter();
			out.println("<response>");
			for (int i = 0; i < categoryList.size(); i++) {
				dto = (CategoryDto) categoryList.get(i);
				out.println("<category>");
				out.println("<big_num>" + dto.getBig_num() + "</big_num>");
				out.println("<big_name><![CDATA[" + dto.getBig_name() + "]]></big_name>");
				out.println("<small_num>" + dto.getSmall_num() + "</small_num>");
				out.println("<small_name><![CDATA[" + dto.getSmall_name() + "]]></small_name>");
				out.println("</category>");
			}
			out.println("</response>");
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}
	
	@RequestMapping("/map/getDcSmallCategory")
	public void getDcSmallCategory(int small_bignum, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HttpSession session = req.getSession();
		MemberDto memberDto = (MemberDto)session.getAttribute("MEM_KEY");
		
		if(memberDto != null){
			String cardCode = memberDto.getMem_cardcode();
			
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/xml");

			List<DiscountDto> discountList = new ArrayList<DiscountDto>();
			discountList = discountService.getDcSmallCategory(cardCode, small_bignum);

			DiscountDto dto = null;
			PrintWriter out = null;

			try {
				out = resp.getWriter();
				out.println("<response>");
				for (int i = 0; i < discountList.size(); i++) {
					dto = discountList.get(i);
					out.println("<category>");
					out.println("<small_bignum>" + dto.getSmall_bignum() + "</small_bignum>");
					out.println("<big_name><![CDATA[" + dto.getBig_name() + "]]></big_name>");
					out.println("<small_num>" + dto.getSmall_num() + "</small_num>");
					out.println("<small_name><![CDATA[" + dto.getSmall_name() + "]]></small_name>");
					out.println("</category>");
				}
				out.println("</response>");
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				out.close();
			}
		}
	}
}
