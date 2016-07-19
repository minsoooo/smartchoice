package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.MemberDto;

public interface MemberDAO {
	
	public void regiMember(MemberDto dto);
	public List getMemberList();
	public MemberDto getMember(String mem_id, String mem_pw);
	public void updateMember(MemberDto dto);
	public void deleteMember(int mem_num);
}
