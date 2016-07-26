package com.smartchoice.app.persistence;

import java.util.List;

import com.smartchoice.app.domain.Criteria;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;

public interface BoardDAO {
	public void register(NoticeBoardDto dto) throws Exception;

	public NoticeBoardDto read(Integer num) throws Exception;

	public void modify(NoticeBoardDto dto) throws Exception;

	public void remove(Integer num) throws Exception;

	public List<NoticeBoardDto> listAll() throws Exception;
	
	public List<NoticeBoardDto> listSearch(String keyWord,String keyField) throws Exception;
	
	public void register_reply(NoticeBoardReplyDto replydto) throws Exception;
	
	public List<NoticeBoardReplyDto> read_reply(Integer num) throws Exception;
	
	public List<NoticeBoardDto> listCriteria(Criteria cri) throws Exception;
	
	public int countPaging(Criteria cri) throws Exception;
	
}
