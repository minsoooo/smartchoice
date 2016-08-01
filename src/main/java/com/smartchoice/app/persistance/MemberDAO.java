package com.smartchoice.app.persistance;

import java.util.List;

import com.smartchoice.app.domain.MemberDto;

public interface MemberDAO {
	
	public void regiMember(MemberDto dto);
	public List<MemberDto> getMemberList();
	public MemberDto getMember(String mem_id, String mem_pw);
	public MemberDto getMemberWithId(String mem_id);
	public void updateMember(MemberDto dto);
	public void deleteMember(String mem_id);
	public String searchId(String mem_email);
	public String searchPw(String mem_id, String mem_email);
	public void updatePw(String mem_id, String mem_pw);
	public List<MemberDto> getMemberWithCompNum(int comp_num);
	public List<MemberDto> getMemberWithFav(String mem_fav);

}
