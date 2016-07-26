package com.smartchoice.app.domain;

import java.util.Date;

public class NoticeBoardReplyDto {
	private Integer nreply_num;		
	private String nreply_content;
	private Date nreply_regdate;	
	private Integer nreply_memnum;		
	private Integer nreply_nboardnum;
	private String nreply_memid;
		
	public String getNreply_memid() {
		return nreply_memid;
	}
	public void setNreply_memid(String nreply_memid) {
		this.nreply_memid = nreply_memid;
	}
	public Integer getNreply_num() {
		return nreply_num;
	}
	public void setNreply_num(Integer nreply_num) {
		this.nreply_num = nreply_num;
	}
	public String getNreply_content() {
		return nreply_content;
	}
	public void setNreply_content(String nreply_content) {
		this.nreply_content = nreply_content;
	}
	public Date getNreply_regdate() {
		return nreply_regdate;
	}
	public void setNreply_regdate(Date nreply_regdate) {
		this.nreply_regdate = nreply_regdate;
	}
	public Integer getNreply_memnum() {
		return nreply_memnum;
	}
	public void setNreply_memnum(Integer nreply_memnum) {
		this.nreply_memnum = nreply_memnum;
	}
	public Integer getNreply_nboardnum() {
		return nreply_nboardnum;
	}
	public void setNreply_nboardnum(Integer nreply_nboardnum) {
		this.nreply_nboardnum = nreply_nboardnum;
	}	
}
