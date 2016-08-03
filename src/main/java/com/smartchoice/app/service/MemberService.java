package com.smartchoice.app.service;

import java.util.List;

import com.smartchoice.app.domain.MemberDto;

public interface MemberService {
	
	public void regiMember(MemberDto dto);
	public List getMemberList();
	public MemberDto getMember(String mem_id, String mem_pw);
	public MemberDto getMemberWithId(String mem_id);
	public void updateMember(MemberDto dto);
	public void deleteMember(String mem_id);
	public String searchId(String mem_email);
	public String searchPw(String mem_id, String mem_email);
	public void updatePw(String mem_id, String mem_pw);
	public List<MemberDto> getViewListMember(String keyword, String value);
	public int getMemberCount();
	public int getMemberCount(String mem_fav);
}
