package com.smartchoice.app.domain;

import java.util.Date;

public class EventBoardDto {	

	private Integer eboard_num;
	private String eboard_writer;
	private String eboard_title;
	private String eboard_content;
	private Date eboard_regdate;
	private Date eboard_start;
	private Date eboard_end;
	private String eboard_filename;	
	private int eboard_viewcnt;
	
	public Integer getEboard_num() {
		return eboard_num;
	}
	public void setEboard_num(Integer eboard_num) {
		this.eboard_num = eboard_num;
	}
	public String getEboard_writer() {
		return eboard_writer;
	}
	public void setEboard_writer(String eboard_writer) {
		this.eboard_writer = eboard_writer;
	}
	public String getEboard_title() {
		return eboard_title;
	}
	public void setEboard_title(String eboard_title) {
		this.eboard_title = eboard_title;
	}
	public String getEboard_content() {
		return eboard_content;
	}
	public void setEboard_content(String eboard_content) {
		this.eboard_content = eboard_content;
	}
	public Date getEboard_regdate() {
		return eboard_regdate;
	}
	public void setEboard_regdate(Date eboard_regdate) {
		this.eboard_regdate = eboard_regdate;
	}
	public Date getEboard_start() {
		return eboard_start;
	}
	public void setEboard_start(Date eboard_start) {
		this.eboard_start = eboard_start;
	}
	public Date getEboard_end() {
		return eboard_end;
	}
	public void setEboard_end(Date eboard_end) {
		this.eboard_end = eboard_end;
	}
	public String getEboard_filename() {
		return eboard_filename;
	}
	public void setEboard_filename(String eboard_filename) {
		this.eboard_filename = eboard_filename;
	}
	public int getEboard_viewcnt() {
		return eboard_viewcnt;
	}
	public void setEboard_viewcnt(int eboard_viewcnt) {
		this.eboard_viewcnt = eboard_viewcnt;
	}	
}
