package com.smartchoice.app.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.smartchoice.app.domain.MemberDto;


@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final String NAMESPACE ="com.smartchoice.mappers.memberMapper";
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void regiMember(@ModelAttribute MemberDto dto) {
		sqlSession.insert(NAMESPACE +".regiMember", dto);	
	}

	@Override
	public List getMemberList() {
		return sqlSession.selectList(NAMESPACE+".getMemberList");
	}

	
	@Override
	public MemberDto getMemberWithId(String mem_id) {
		return sqlSession.selectOne(NAMESPACE+".getMemberWithId", mem_id);
	}

	@Override
	public MemberDto getMember(String mem_id, String mem_pw) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mem_id", mem_id);
		paramMap.put("mem_pw", mem_pw);
		
		return sqlSession.selectOne(NAMESPACE+".getMember",paramMap);
	}

	
	@Override
	public void updateMember(@ModelAttribute MemberDto dto) {
		sqlSession.update(NAMESPACE+".updateMember",dto);

	}

	
	@Override
	public void deleteMember(String mem_id) {
		sqlSession.delete(NAMESPACE+".deleteMember", mem_id);

	}

	@Override
	public String searchId(String mem_email) {
		return sqlSession.selectOne(NAMESPACE+".searchId",mem_email);
	}

	@Override
	public String searchPw(String mem_id, String mem_email) {
		Map<String, Object> params = new HashMap<String ,Object>();
		params.put("mem_id", mem_id);
		params.put("mem_email", mem_email);
		return sqlSession.selectOne(NAMESPACE+".searchPw",params);
	}

	@Override
	public void updatePw(String mem_id, String mem_pw) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mem_id", mem_id);
		params.put("mem_pw", mem_pw);
		sqlSession.update(NAMESPACE+".updatePw",params);
		
	}

	@Override
	public List<MemberDto> getMemberWithCompNum(int comp_num) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("comp_num", comp_num);
		return sqlSession.selectList(NAMESPACE+".getViewListMember", param);
	}

	@Override
	public List<MemberDto> getMemberWithFav(String mem_fav) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("mem_fav", mem_fav);
		return sqlSession.selectList(NAMESPACE+".getViewListMember", param);
	}

}
