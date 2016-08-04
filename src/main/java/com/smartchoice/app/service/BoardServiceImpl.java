package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.Criteria;
import com.smartchoice.app.domain.EventBoardDto;
import com.smartchoice.app.domain.EventBoardReplyDto;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.SearchCriteria;
import com.smartchoice.app.persistance.BoardDAO;

@Service	// 서비스 연결하기
public class BoardServiceImpl implements BoardService {
	
	@Inject	// BoardDAO연결하기
	private BoardDAO dao;
	
	// NoticeBoard_ServiceImpl

	@Override	// 글쓰기를 전송받아서 DAO로 넘긴다
	public void register(NoticeBoardDto dto) throws Exception {		
		dao.register(dto);
	}

	@Override	// 글번호를 전송받아서 DAO로 넘긴다
	public NoticeBoardDto read(Integer num) throws Exception {			
		return dao.read(num);
	}

	@Override	// 글번호를 전송받아서 DAO로 넘긴다
	public void modify(NoticeBoardDto dto) throws Exception {		
		dao.modify(dto);
	}

	@Override	// 글번호를 전송받아서 DAO로 넘긴다
	public void remove(Integer num) throws Exception {		
		dao.remove(num);
	}	

	@Override
	public void register_reply(NoticeBoardReplyDto replydto) throws Exception {
		dao.register_reply(replydto);
	}
	
	@Override
	public void remove_reply(NoticeBoardReplyDto replydto) throws Exception {
		dao.remove_reply(replydto);
	}

	@Override
	public List<NoticeBoardReplyDto> read_reply(Integer num) throws Exception{
		return dao.read_reply(num);
	}
	
	@Override
	public List<NoticeBoardDto> listSearch(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}
	
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {		
		return dao.listSearchCount(cri);
	}

	
	
	// EventBoard_ServiceImpl
	
	@Override
	public void event_register(EventBoardDto dto) throws Exception {
		dao.event_register(dto);
	}

	@Override
	public EventBoardDto event_read(Integer num) throws Exception {
		return dao.event_read(num);
	}

	@Override
	public void event_modify(EventBoardDto dto) throws Exception {
		dao.event_modify(dto);
	}

	@Override
	public void event_remove(Integer num) throws Exception {
		dao.event_remove(num);
	}	
	
	@Override
	public List<EventBoardDto> event_listAll(String eboard_start,String eboard_end) throws Exception {		
		return dao.event_listAll(eboard_start,eboard_end);
	}
	
	@Override
	public List<EventBoardReplyDto> event_read_reply(Integer num) throws Exception {		
		return dao.event_read_reply(num);
	}	

	@Override
	public void event_register_reply(EventBoardReplyDto replydto) throws Exception {
		dao.event_register_reply(replydto);
	}

	@Override
	public void event_remove_reply(EventBoardReplyDto replydto) throws Exception {
		dao.event_remove_reply(replydto);
	}

	@Override
	public List<EventBoardDto> event_listSearch(SearchCriteria cri) throws Exception {		
		return dao.event_listSearch(cri);
	}

	@Override
	public int event_listSearchCount(SearchCriteria cri) throws Exception {		
		return dao.event_listSearchCount(cri);
	}
}
