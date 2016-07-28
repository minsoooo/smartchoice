package com.smartchoice.app.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smartchoice.app.domain.Criteria;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.PageMaker;
import com.smartchoice.app.domain.SearchCriteria;
import com.smartchoice.app.service.BoardService;

@Controller
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject // Service 연결
	private BoardService service;

	@RequestMapping(value = "/board/notice_board/notice_register") // 공지사항 글쓰기로
																	// 가기
	public void registerGET() {
	}

	@RequestMapping(value = "/board/notice_board/notice_register", method = RequestMethod.POST) // 공지사항 글쓰기를 POST로 받아서 전달한다.
																							
	public String registerPOST(NoticeBoardDto board, RedirectAttributes rttr) throws Exception {		
		System.out.println("registerPOST 에서 받은 editor_cotent : " + board.getNboard_content());
		
		service.register(board);
		rttr.addFlashAttribute("msg", "SUCCESS"); // 성공 후 메세지 출력하게 전달한다.
		return "redirect:/board/notice_board/notice_listPage"; // 리다이렉트로, 여러번 새로고침 되지않게 게시글 위치로 이동한다.
	}

	@RequestMapping(value = "/board/notice_board/notice_listPage", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {		
		
		if (cri.getSearchType() == null) {
			cri.setSearchType("notice_title_listSearch");
		}
		if (cri.getKeyword() == null) {
			cri.setKeyword("");
		}

		model.addAttribute("list", service.listSearch(cri));				

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		pageMaker.setTotalCount(service.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value = "/board/notice_board/notice_listPage", method = RequestMethod.POST)
	public void listSearchPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {		
		
		if (cri.getSearchType() == null) {
			cri.setSearchType("notice_title_listSearch");
		}
		if (cri.getKeyword() == null) {
			cri.setKeyword("");
		}

		model.addAttribute("list", service.listSearch(cri));		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		pageMaker.setTotalCount(service.listSearchCount(cri));

		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping("/board/notice_board/notice_readPage")
	public void read(@RequestParam int num, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {		
		model.addAttribute("boardDto", service.read(num));
		List<NoticeBoardReplyDto> list = service.read_reply(num);

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
	}

	@RequestMapping("/board/notice_board/notice_modifyPage") // readPage에서 수정하기 버튼을 눌렀을 때 GET방식이면 수정하는 페이지로 이동한다.															
	public void modify(@RequestParam int num, Model model) throws Exception {		
		model.addAttribute("boardDto", service.read(num));
	}

	@RequestMapping(value = "/board/notice_board/notice_modifyPage", method = RequestMethod.POST) // modify에서 폼(POST)으로 받아서 내용을 변경한다.																								
	public String modify(NoticeBoardDto board, RedirectAttributes rttr) throws Exception {		
		service.modify(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/notice_board/notice_readPage?num=" + board.getNboard_num();
	}

	@RequestMapping("/board/notice_board/notice_remove") // readPage에서 삭제하기 버튼을 눌렀을 때 명령어를 받아 삭제하고 게시판 목록으로 돌아간다.															
	public String remove(@RequestParam int num, RedirectAttributes rttr) throws Exception {
		service.remove(num);
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/board/notice_board/notice_listPage";
	}

	@RequestMapping(value = "/board/notice_board/notice_reply", method = RequestMethod.POST) // 글 내부에서 쓴 댓글을 POST로 전달받는다.
	public String replyPOST(NoticeBoardReplyDto replydto, RedirectAttributes rttr) throws Exception {
		System.out.println("전달받은 댓글이름,내용 : " + replydto.getNreply_memid() + "," + replydto.getNreply_content());
		service.register_reply(replydto);
		return "redirect:/board/notice_board/notice_read?num=" + replydto.getNreply_nboardnum();
		// 리다이렉트로, 여러번 새로고침 되지않게 게시글 위치로 이동한다.
	}
}
