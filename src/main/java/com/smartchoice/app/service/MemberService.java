package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.MemberDto;

public interface MemberService {
	
	public void regiMember(MemberDto dto);
	public List getMemberList();
	public MemberDto getMember(String mem_id, String mem_pw);
	public void updateMember(MemberDto dto);
	public void deleteMember(int mem_num);
}
