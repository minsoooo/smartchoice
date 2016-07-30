package com.smartchoice.app.service;

import java.util.List;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.SearchCriteria;

public interface BoardService {
	public void register(NoticeBoardDto dto) throws Exception;

	public NoticeBoardDto read(Integer num) throws Exception;

	public void modify(NoticeBoardDto dto) throws Exception;

	public void remove(Integer num) throws Exception;	
	
	public void register_reply(NoticeBoardReplyDto replydto) throws Exception;
	
	public void remove_reply(NoticeBoardReplyDto replydto) throws Exception;
	
	public List<NoticeBoardReplyDto> read_reply(Integer num) throws Exception;

	public List<NoticeBoardDto> listSearch(SearchCriteria cri)throws Exception;
	  
	public int listSearchCount(SearchCriteria cri)throws Exception;


}
