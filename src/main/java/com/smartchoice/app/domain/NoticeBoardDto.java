package com.smartchoice.app.domain;

import java.util.Date;

public class NoticeBoardDto {	

	private Integer nboard_num;
	private String nboard_writer;
	private String nboard_title;
	private String nboard_content;
	private Date nboard_regdate;	
	private String nboard_filename;	
	private int nboard_viewcnt;
	
	public Integer getNboard_num() {
		return nboard_num;
	}
	public void setNboard_num(Integer nboard_num) {
		this.nboard_num = nboard_num;
	}
	public String getNboard_writer() {
		return nboard_writer;
	}
	public void setNboard_writer(String nboard_writer) {
		this.nboard_writer = nboard_writer;
	}
	public String getNboard_title() {
		return nboard_title;
	}
	public void setNboard_title(String nboard_title) {
		this.nboard_title = nboard_title;
	}
	public String getNboard_content() {
		return nboard_content;
	}
	public void setNboard_content(String nboard_content) {
		this.nboard_content = nboard_content;
	}
	public Date getNboard_regdate() {
		return nboard_regdate;
	}
	public void setNboard_regdate(Date nboard_regdate) {
		this.nboard_regdate = nboard_regdate;
	}	
	public String getNboard_filename() {
		return nboard_filename;
	}
	public void setNboard_filename(String nboard_filename) {
		this.nboard_filename = nboard_filename;
	}
	public int getNboard_viewcnt() {
		return nboard_viewcnt;
	}
	public void setNboard_viewcnt(int nboard_viewcnt) {
		this.nboard_viewcnt = nboard_viewcnt;
	}
}
