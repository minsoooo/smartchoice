package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.MemberDto;

public interface MemberDAO {
	
	public void regiMember();
	public List getMemberList();
	public MemberDto getMember(String mem_email, String mem_pw);
	public void updateMember(Integer mem_num);
	public void deleteMember(Integer mem_num);
}
