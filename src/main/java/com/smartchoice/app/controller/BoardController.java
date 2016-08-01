package com.smartchoice.app.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.PageMaker;
import com.smartchoice.app.domain.PhotoDto;
import com.smartchoice.app.domain.SearchCriteria;
import com.smartchoice.app.service.AccountBookService;
import com.smartchoice.app.service.BoardService;
import com.smartchoice.app.service.CalendarService;

@Controller
public class BoardController {	

	@Inject // Service 연결
	private BoardService service;
	
	@Inject
	private CalendarService calService;
	
	@Inject
	private AccountBookService abookService;
	
	
	////////////////////////////// NoticeBoard //////////////////////////////

	@RequestMapping(value = "/board/notice_board/notice_register") // 공지사항 글쓰기로 가기																	
	public void registerGET() {
	}

	@RequestMapping(value = "/board/notice_board/notice_register", method = RequestMethod.POST) // 공지사항 글쓰기를 POST로 받아서 전달한다.
																							
	public String registerPOST(NoticeBoardDto board, RedirectAttributes rttr) throws Exception {			
		
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
		return "redirect:/board/notice_board/notice_readPage?num=" + replydto.getNreply_nboardnum();
		// 리다이렉트로, 여러번 새로고침 되지않게 게시글 위치로 이동한다.
	}
	
	@RequestMapping("/board/notice_board/notice_reply_remove") // 글 내부에서 댓글 삭제하기 버튼을 눌렀을 때 명령어를 받아 삭제하고 댓글달았던 글로 돌아간다.															
	public String replyRemove(NoticeBoardReplyDto replydto, RedirectAttributes rttr) throws Exception {			
		service.remove_reply(replydto);
		return "redirect:/board/notice_board/notice_readPage?num=" + replydto.getNreply_nboardnum();
	}
	
	//다중파일업로드
	@RequestMapping("/multiplePhotoUpload")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response){
		
	    try {
	         //파일정보
	         String sFileInfo = "";
	         //파일명을 받는다 - 일반 원본파일명
	         String filename = request.getHeader("file-name");
	         //파일 확장자
	         String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
	         //확장자를소문자로 변경
	         filename_ext = filename_ext.toLowerCase();	        
	         //파일 기본경로
	         String dftFilePath = request.getSession().getServletContext().getRealPath("/");
	         //파일 기본경로 _ 상세경로
	         String filePath = dftFilePath + "resources" + File.separator + "photo_upload" + File.separator;
	         File file = new File(filePath);
	         if(!file.exists()) {
	            file.mkdirs();
	         }
	         String realFileNm = "";
	         SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	         String today= formatter.format(new java.util.Date());
	         
	         // 파일 이름을 랜덤으로 바꿔준다.
	         
	         realFileNm = today+UUID.randomUUID().toString() + "." + filename_ext;
	         String rlFileNm = filePath + realFileNm;
	         ///////////////// 서버에 파일쓰기 ///////////////// 
	         InputStream  is = request.getInputStream();
	         OutputStream os=new FileOutputStream(rlFileNm);
	         int numRead;
	         byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
	         while((numRead = is.read(b,0,b.length)) != -1){
	            os.write(b,0,numRead);
	         }
	         if(is != null) {
	            is.close();
	         }
	         os.flush();
	         os.close();
	         ///////////////// 서버에 파일쓰기 /////////////////
	         // 정보 출력
	         sFileInfo += "&bNewLine=true";
	         // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
	         sFileInfo += "&sFileName="+ filename;;
	         sFileInfo += "&sFileURL="+"/resources/photo_upload/"+realFileNm;
	         PrintWriter print = response.getWriter();
	         print.print(sFileInfo);
	         print.flush();
	         print.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	
	///////////////////////// Event Board ///////////////////////////////
	
	@RequestMapping("/board/event_board/event_listPage")
	public String eventlistPage(String now_year, String now_month, @ModelAttribute("cri") SearchCriteria cri, Model model, HttpServletRequest req) throws Exception{
		List<String> list = null;
		HttpSession session = req.getSession();
		MemberDto dto = new MemberDto();
		dto= (MemberDto)session.getAttribute("MEM_KEY");
		int regi_memnum = dto.getMem_num();
		
		int cal_year = calService.getNowYear(now_year);
		int cal_month = calService.getNowMonth(now_month);		// calendar객체를 통해 년,월을 받아옴
		
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
		
		
		return "/board/event_board/event_listPage";
	}
	
	
}
