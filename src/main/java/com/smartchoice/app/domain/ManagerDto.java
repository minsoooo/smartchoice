package com.smartchoice.app.domain;

public class ManagerDto {
	private int mng_num;
	private String mng_id;
	private String mng_pw;
	private String mng_position;
	private String mng_name;
	private String mng_pnum;
	private String mng_regdate;
	private String mng_level;
	public int getMng_num() {
		return mng_num;
	}
	public void setMng_num(int mng_num) {
		this.mng_num = mng_num;
	}
	public String getMng_id() {
		return mng_id;
	}
	public void setMng_id(String mng_id) {
		this.mng_id = mng_id;
	}
	public String getMng_pw() {
		return mng_pw;
	}
	public void setMng_pw(String mng_pw) {
		this.mng_pw = mng_pw;
	}
	public String getMng_position() {
		return mng_position;
	}
	public void setMng_position(String mng_position) {
		this.mng_position = mng_position;
	}
	public String getMng_name() {
		return mng_name;
	}
	public void setMng_name(String mng_name) {
		this.mng_name = mng_name;
	}
	public String getMng_pnum() {
		return mng_pnum;
	}
	public void setMng_pnum(String mng_pnum) {
		this.mng_pnum = mng_pnum;
	}
	public String getMng_regdate() {
		return mng_regdate;
	}
	public void setMng_regdate(String mng_regdate) {
		this.mng_regdate = mng_regdate;
	}
	public String getMng_level() {
		return mng_level;
	}
	public void setMng_level(String mng_level) {
		this.mng_level = mng_level;
	}
	@Override
	public String toString() {
		return "MangerDto() =  mng_name : " + getMng_name() + " mng_id : "
				+ getMng_id() + " mng_pw : " +  getMng_pw() + " mng_pnum : "
				+ getMng_pnum() + " mng_position : " + getMng_position()+ 
				"mng_level : " + getMng_level() +" mng_regdate : " +getMng_regdate();
	}
	
	
	
}
