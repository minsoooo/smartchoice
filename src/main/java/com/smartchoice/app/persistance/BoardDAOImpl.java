package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.smartchoice.app.domain.EventBoardDto;
import com.smartchoice.app.domain.EventBoardReplyDto;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.smartchoice.mappers.boardMapper";

	// NoticeBoard_DAO_Impl
	
	@Override
	public void register(NoticeBoardDto dto) throws Exception {		
		sqlSession.insert(NAMESPACE + ".notice_register" , dto);
	}

	@Override
	public NoticeBoardDto read(Integer num) throws Exception {		
		return sqlSession.selectOne(NAMESPACE + ".notice_read" , num);
	}	

	@Override
	public void viewcnt(Integer num) throws Exception {
		sqlSession.selectOne(NAMESPACE + ".notice_viewcnt" , num);
	}
	
	@Override
	public void modify(NoticeBoardDto dto) throws Exception {	
		sqlSession.update(NAMESPACE + ".notice_modify" , dto);
	}

	@Override
	public void remove(Integer num) throws Exception {		
		sqlSession.delete(NAMESPACE + ".notice_remove" , num);
	}	
	
	@Override
	public void register_reply(NoticeBoardReplyDto replydto) throws Exception {		
		sqlSession.insert(NAMESPACE + ".notice_register_reply" , replydto);
	}	
	
	@Override
	public void remove_reply(NoticeBoardReplyDto replydto) throws Exception {
		sqlSession.delete(NAMESPACE + ".notice_remove_reply" , replydto);		
	}

	@Override
	public List<NoticeBoardReplyDto> read_reply(Integer num) throws Exception {			
		return sqlSession.selectList(NAMESPACE + ".read_reply" , num);
	}
	
	@Override
	public List<NoticeBoardDto> listSearch(SearchCriteria cri) throws Exception {		
		return sqlSession.selectList(NAMESPACE + ".notice_listSearch",cri);
	}
	
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		  return sqlSession.selectOne(NAMESPACE + ".notice_listSearchCount", cri);
	}
	
	// EventBoard_DAO_Impl
	
	@Override
	public void event_register(EventBoardDto dto) throws Exception {
		sqlSession.insert(NAMESPACE + ".event_register" , dto);
	}

	@Override
	public EventBoardDto event_read(Integer num) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".event_read" , num);
	}
	
	@Override
	public void event_viewcnt(Integer num) throws Exception {
		sqlSession.selectOne(NAMESPACE + ".event_viewcnt" , num);
	}
	
	@Override
	public void event_modify(EventBoardDto dto) throws Exception {
		sqlSession.update(NAMESPACE + ".event_modify" , dto);
	}

	@Override
	public void event_remove(Integer num) throws Exception {
		sqlSession.delete(NAMESPACE + ".event_remove" , num);
	}

	@Override
	public void event_register_reply(EventBoardReplyDto replydto) throws Exception {			
		sqlSession.insert(NAMESPACE + ".event_register_reply" , replydto);
	}

	@Override
	public void event_remove_reply(EventBoardReplyDto replydto) throws Exception {
		sqlSession.delete(NAMESPACE + ".event_remove_reply" , replydto);		
	}

	@Override
	public List<EventBoardReplyDto> event_read_reply(Integer num) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".event_read_reply" , num);
	}
	
	@Override
	public List<EventBoardDto> event_listAll(String eboard_start,String eboard_end) throws Exception {
		Map map = new HashMap();
		map.put("eboard_start", eboard_start);
		map.put("eboard_end", eboard_end);
		
		return sqlSession.selectList(NAMESPACE + ".event_listAll",map);
	}

	@Override
	public List<EventBoardDto> event_listSearch(SearchCriteria cri) throws Exception {		
		return sqlSession.selectList(NAMESPACE + ".event_listSearch",cri);
	}

	@Override
	public int event_listSearchCount(SearchCriteria cri) throws Exception {		
		return sqlSession.selectOne(NAMESPACE + ".event_listSearchCount", cri);
	}
}
