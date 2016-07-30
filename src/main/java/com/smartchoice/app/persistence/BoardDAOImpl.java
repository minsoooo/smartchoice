package com.smartchoice.app.persistence;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.smartchoice.app.domain.NoticeBoardDto;
import com.smartchoice.app.domain.NoticeBoardReplyDto;
import com.smartchoice.app.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.smartchoice.mappers.boardMapper";

	@Override
	public void register(NoticeBoardDto dto) throws Exception {		
		sqlSession.insert(NAMESPACE + ".notice_register" , dto);
	}

	@Override
	public NoticeBoardDto read(Integer num) throws Exception {		
		return sqlSession.selectOne(NAMESPACE + ".notice_read" , num);
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
}
