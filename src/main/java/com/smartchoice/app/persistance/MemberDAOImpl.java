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
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void regiMember(@ModelAttribute MemberDto dto) {
		sqlSession.insert("regiMember", dto);	
	}

	@Override
	public List getMemberList() {
		return sqlSession.selectList("getMemberList");
	}

	
	@Override
	public MemberDto getMemberWithId(String mem_id) {
		return sqlSession.selectOne("getMemberWithId", mem_id);
	}

	@Override
	public MemberDto getMember(String mem_id, String mem_pw) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("mem_id", mem_id);
		paramMap.put("mem_pw", mem_pw);
		
		return sqlSession.selectOne("getMember",paramMap);
	}

	
	@Override
	public void updateMember(@ModelAttribute MemberDto dto) {
		sqlSession.update("updateMember",dto);

	}

	
	@Override
	public void deleteMember(int mem_num) {
		sqlSession.delete("deleteMember",mem_num);

	}

}
