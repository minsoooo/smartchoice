package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.persistence.BoardDAO;
import com.smartchoice.app.domain.Criteria;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.SearchCriteria;

@Service	// 서비스 연결하기
public class BoardServiceImpl implements BoardService {
	
	@Inject	// BoardDAO연결하기
	private BoardDAO dao;

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
	
	@Override	// List 전체를 불러오기위해 DAO로 넘긴다
	public List<NoticeBoardDto> listAll() throws Exception {		
		return dao.listAll();		
	}

	@Override	// List 전체를 불러오기위해 DAO로 넘긴다
	public List<NoticeBoardDto> listSearch(String keyWord,String keyField) throws Exception {		
		return dao.listSearch(keyWord, keyField);	
	}

	@Override
	public void register_reply(NoticeBoardReplyDto replydto) throws Exception {
		dao.register_reply(replydto);
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

}
