package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.EventBoardDto;
import com.smartchoice.app.domain.EventBoardReplyDto;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.SearchCriteria;

public interface BoardService {
	
	// NoticeBoard_Service
	
	public void register(NoticeBoardDto dto) throws Exception;

	public NoticeBoardDto read(Integer num) throws Exception;

	public void modify(NoticeBoardDto dto) throws Exception;

	public void remove(Integer num) throws Exception;	
	
	public void register_reply(NoticeBoardReplyDto replydto) throws Exception;
	
	public void remove_reply(NoticeBoardReplyDto replydto) throws Exception;
	
	public List<NoticeBoardReplyDto> read_reply(Integer num) throws Exception;

	public List<NoticeBoardDto> listSearch(SearchCriteria cri)throws Exception;
	  
	public int listSearchCount(SearchCriteria cri)throws Exception;
	
	// EventBoard_Service
	
	public void event_register(EventBoardDto dto) throws Exception;

	public NoticeBoardDto event_read(Integer num) throws Exception;

	public void event_modify(EventBoardDto dto) throws Exception;

	public void event_remove(Integer num) throws Exception;	
	
	public void event_register_reply(EventBoardReplyDto replydto) throws Exception;
	
	public void event_remove_reply(EventBoardReplyDto replydto) throws Exception;
	
	public List<EventBoardReplyDto> event_read_reply(Integer num) throws Exception;
	
	public List<EventBoardDto> event_listAll(String eboard_start,String eboard_end)throws Exception;
		
}
