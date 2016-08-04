package com.smartchoice.app.domain;

import java.util.Date;

public class EventBoardReplyDto {
	private Integer ereply_num;		
	private String ereply_content;
	private Date ereply_regdate;	
	private Integer ereply_memnum;		
	private Integer ereply_eboardnum;
	private String ereply_memid;
	
	public Integer getEreply_num() {
		return ereply_num;
	}
	public void setEreply_num(Integer ereply_num) {
		this.ereply_num = ereply_num;
	}
	public String getEreply_content() {
		return ereply_content;
	}
	public void setEreply_content(String ereply_content) {
		this.ereply_content = ereply_content;
	}
	public Date getEreply_regdate() {
		return ereply_regdate;
	}
	public void setEreply_regdate(Date ereply_regdate) {
		this.ereply_regdate = ereply_regdate;
	}
	public Integer getEreply_memnum() {
		return ereply_memnum;
	}
	public void setEreply_memnum(Integer ereply_memnum) {
		this.ereply_memnum = ereply_memnum;
	}
	public Integer getEreply_eboardnum() {
		return ereply_eboardnum;
	}
	public void setEreply_eboardnum(Integer ereply_eboardnum) {
		this.ereply_eboardnum = ereply_eboardnum;
	}
	public String getEreply_memid() {
		return ereply_memid;
	}
	public void setEreply_memid(String ereply_memid) {
		this.ereply_memid = ereply_memid;
	}
}
