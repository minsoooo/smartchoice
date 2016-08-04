package com.smartchoice.app.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smartchoice.app.domain.EventBoardDto;
import com.smartchoice.app.domain.EventBoardReplyDto;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.PageMaker;
import com.smartchoice.app.domain.SearchCriteria;
import com.smartchoice.app.service.BoardService;
import com.smartchoice.app.util.CalendarUtil;

import net.sf.json.JSONArray;

@Controller
public class BoardController {	

	@Inject // Service 연결
	private BoardService service;
	
	CalendarUtil cal = new CalendarUtil();
	
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
		service.register_reply(replydto);
		return "redirect:/board/notice_board/notice_readPage?num=" + replydto.getNreply_nboardnum();
		// 리다이렉트로, 여러번 새로고침 되지않게 게시글 위치로 이동한다.
	}
	
	@RequestMapping("/board/notice_board/notice_reply_remove") // 글 내부에서 댓글 삭제하기 버튼을 눌렀을 때 명령어를 받아 삭제하고 댓글달았던 글로 돌아간다.															
	public String replyRemove(NoticeBoardReplyDto replydto, RedirectAttributes rttr) throws Exception {			
		service.remove_reply(replydto);
		return "redirect:/board/notice_board/notice_readPage?num=" + replydto.getNreply_nboardnum();
	}
	
	///////////////////////// 파일 업로드 시작 ///////////////////////////////
	
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
	         System.out.println("dftPath : " + dftFilePath);
	         String filePath = dftFilePath + "resources" + File.separator + "photo_upload" + File.separator;
	         System.out.println("파일 path : " + filePath);
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
	         System.out.println("입력 경로 : " + sFileInfo);
	         PrintWriter print = response.getWriter();
	         print.print(sFileInfo);
	         print.flush();
	         print.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}	
	///////////////////////// 파일 업로드 종료 ///////////////////////////////
	
	
	
	///////////////////////// Event Board ///////////////////////////////
	
	@RequestMapping("/board/event_board/event_listPage")
	public String eventlistPage(String now_year, String now_month, EventBoardDto dto, Model model, HttpServletRequest req) throws Exception{
		JSONArray json = null;
		
		int cal_year = cal.getNowYear(now_year);
		int cal_month = cal.getNowMonth(now_month);		// calendar객체를 통해 년,월을 받아옴
		
		Calendar cal2 = Calendar.getInstance();
		int cal_lastdays = cal2.getActualMaximum(Calendar.DATE);		
		
		String eboard_start = cal_year + "/" + cal_month + "/" + 1;
		String eboard_end = cal_year + "/" + cal_month + "/" + cal_lastdays;
		
		System.out.println("DB에 넣을 시작일  : " + eboard_start);
		System.out.println("DB에 넣을 종료일  : " + eboard_end);			
			
		// DB를 호출해서 DB상에 있는 모든 게시판 글을 가져온다.
		
		List<EventBoardDto> list = service.event_listAll(eboard_start,eboard_end);
				
		
		// DB 안의 Eboard_start의 값 (EX:2016/7/5)과 Eboard_end의 값 (EX:2016/7/31)을 split("/")으로 배열에 잘라서 담고, 하나의 String으로 연결해서 보낸다.		
		// EX) 2016/7/1 -> 201671 
		
		model.addAttribute("now_year", cal_year);
		model.addAttribute("now_month", cal_month);
		model.addAttribute("list", list);	
		
		return "/board/event_board/event_listPage";		
	}	
	
	@RequestMapping("/board/event_board/event_select")
	public void getEventSelect(String year, String month, String date, HttpServletRequest req, HttpServletResponse resp) throws Exception{
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/json");
		
		JSONArray json = null;
		PrintWriter out = null;
		
		Calendar cal = Calendar.getInstance();
		int cal_lastdays = cal.getActualMaximum(Calendar.DATE);	
				
		String eboard_start = year + "/" + month + "/" + 1;
		String eboard_end = year + "/" + month + "/" + cal_lastdays;
		
		List list = (List)service.event_listAll(eboard_start, eboard_end);		
		List resultList = new ArrayList();
		
		String[] split_startDate = null;	// 스플릿 하기위한 변수
		String[] split_endDate = null;
		int trans_startDate = 0;		// 나눈 스플릿3개의 마지막 일자(2016,7,1)중에서 1을 담을 변수  -> EX) 201671 / 1 
		int trans_endDate = 0;
		EventBoardDto edto = null;
		
		for(int i=0; i<list.size(); i++){
			edto = (EventBoardDto) list.get(i);						
					
			split_startDate = edto.getEboard_start().split("/");
			split_endDate = edto.getEboard_end().split("/");
			
			trans_startDate = Integer.parseInt(split_startDate[2]);
			trans_endDate = Integer.parseInt(split_endDate[2]);
			System.out.println(trans_startDate + ", " + trans_endDate);
			
			int num = Integer.parseInt(date);
			
			
			if(trans_startDate <= num && num <= trans_endDate){
				resultList.add(edto);
			}	
		}
		
		
		try{
			out = resp.getWriter();
			json = JSONArray.fromObject(resultList);
			out.println(json);
		}
		catch(Exception e){
			
		}
		finally{
			out.close();
		}
		
	}

	// 여기서부터는 이벤트 게시판에 관리자 모드로 들어갔을 때 사용할 페이지 
	
		@RequestMapping(value = "/board/event_board/event_register") // 이벤트게시판 글쓰기로 가기																	
		public void event_registerGET() {
		}
		
		@RequestMapping(value = "/board/event_board/event_register", method = RequestMethod.POST) // 이벤트게시판 글쓰기를 POST로 받아서 전달한다.																							
		public String event_registerPOST(HttpServletRequest req, EventBoardDto board, RedirectAttributes rttr) throws Exception {
			
			// 게시판에서 시작일과 종료일을 select문으로 보내면 받아서 EventBoardDto에 시작일,종료일에 각각 넣는다.
			String event_startdate = req.getParameter("start_year")+"/"+req.getParameter("start_month")+"/"+req.getParameter("start_day");
			String event_enddate = req.getParameter("end_year")+"/"+req.getParameter("end_month")+"/"+req.getParameter("end_day");
			
			board.setEboard_start(event_startdate);
			board.setEboard_end(event_enddate);
			
			service.event_register(board);
			
			rttr.addFlashAttribute("msg", "SUCCESS"); // 성공 후 메세지 출력하게 전달한다.
			return "redirect:/board/event_board/event_mgr_listPage"; // 리다이렉트로, 여러번 새로고침 되지않게 게시글 위치로 이동한다.
		}
		
		@RequestMapping(value = "/board/event_board/event_mgr_listPage", method = RequestMethod.GET)
		public void event_listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {		
			
			if (cri.getSearchType() == null) {
				cri.setSearchType("event_title_listSearch");
			}
			if (cri.getKeyword() == null) {
				cri.setKeyword("");
			}

			model.addAttribute("list", service.event_listSearch(cri));				

			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);

			pageMaker.setTotalCount(service.event_listSearchCount(cri));

			model.addAttribute("pageMaker", pageMaker);
		}
		
		@RequestMapping(value = "/board/event_board/event_mgr_listPage", method = RequestMethod.POST)
		public void event_listSearchPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {		
			
			if (cri.getSearchType() == null) {
				cri.setSearchType("event_title_listSearch");
			}
			if (cri.getKeyword() == null) {
				cri.setKeyword("");
			}

			model.addAttribute("list", service.event_listSearch(cri));		
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);

			pageMaker.setTotalCount(service.event_listSearchCount(cri));

			model.addAttribute("pageMaker", pageMaker);
		}

		@RequestMapping("/board/event_board/event_readPage")
		public String event_read(@RequestParam int num, @RequestParam String check,  @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {		
					
			model.addAttribute("boardDto", service.event_read(num));
			List<EventBoardReplyDto> list = service.event_read_reply(num);

			model.addAttribute("list", list);
			model.addAttribute("cri", cri);
			
			if(check.equals("mng")){
				return "/board/event_board/event_readPage";
			}
			else{
				return "/board/event_board/event_user_readPage";
			}
		}

		@RequestMapping("/board/event_board/event_modifyPage") // readPage에서 수정하기 버튼을 눌렀을 때 GET방식이면 수정하는 페이지로 이동한다.															
		public void event_modify(@RequestParam int num, Model model) throws Exception {		
			model.addAttribute("boardDto", service.event_read(num));
		}

		@RequestMapping(value = "/board/event_board/event_modifyPage", method = RequestMethod.POST) // modify에서 폼(POST)으로 받아서 내용을 변경한다.																								
		public String event_modify(EventBoardDto board, RedirectAttributes rttr) throws Exception {		
			service.event_modify(board);
			rttr.addFlashAttribute("msg", "SUCCESS");
			return "redirect:/board/event_board/event_readPage?num=" + board.getEboard_num();
		}

		@RequestMapping("/board/event_board/event_remove") // readPage에서 삭제하기 버튼을 눌렀을 때 명령어를 받아 삭제하고 게시판 목록으로 돌아간다.															
		public String event_remove(@RequestParam int num, RedirectAttributes rttr) throws Exception {
			service.event_remove(num);
			rttr.addFlashAttribute("msg", "SUCCESS");
			return "redirect:/board/event_board/event_mgr_listPage";
		}

		@RequestMapping(value = "/board/event_board/event_reply", method = RequestMethod.POST) // 글 내부에서 쓴 댓글을 POST로 전달받는다.
		public String event_replyPOST(EventBoardReplyDto replydto, RedirectAttributes rttr) throws Exception {	
			System.out.println("댓글 입력하고 여기 도착했냐");
			service.event_register_reply(replydto);
			return "redirect:/board/event_board/event_readPage?num=" + replydto.getEreply_eboardnum();
			// 리다이렉트로, 여러번 새로고침 되지않게 게시글 위치로 이동한다.
		}
		
		@RequestMapping("/board/event_board/event_reply_remove") // 글 내부에서 댓글 삭제하기 버튼을 눌렀을 때 명령어를 받아 삭제하고 댓글달았던 글로 돌아간다.															
		public String event_replyRemove(EventBoardReplyDto replydto, RedirectAttributes rttr) throws Exception {			
			service.event_remove_reply(replydto);
			return "redirect:/board/event_board/event_readPage?num=" + replydto.getEreply_eboardnum();
		}
	
}

