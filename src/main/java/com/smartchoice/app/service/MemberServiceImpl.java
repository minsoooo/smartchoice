package com.smartchoice.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.smartchoice.app.domain.MemberDto;
import com.smartchoice.app.persistance.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Inject
	private MemberDAO dao;
	
	@Override
	public void regiMember(MemberDto dto) {
		dao.regiMember(dto);

	}

	@Override
	public MemberDto getMemberWithId(String mem_id) {
		return dao.getMemberWithId(mem_id);
	}

	@Override
	public List getMemberList() {
		
		return dao.getMemberList();
	}

	@Override
	public MemberDto getMember(String mem_id, String mem_pw) {
		return dao.getMember(mem_id,mem_pw);
	}

	@Override
	public void updateMember(MemberDto dto) {
		dao.updateMember(dto);

	}

	@Override
	public void deleteMember(int mem_num) {
		dao.deleteMember(mem_num);

	}

	@Override
	public String searchId(String mem_email) {
		
		return dao.searchId(mem_email);
	}

	@Override
	public String searchPw(String mem_id, String mem_email) {
		return dao.searchPw(mem_id, mem_email);
	}

	@Override
	public void updatePw(String mem_id, String mem_pw) {
			dao.updatePw(mem_id, mem_pw);
		
	}

}
