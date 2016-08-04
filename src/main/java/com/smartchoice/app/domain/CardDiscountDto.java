package com.smartchoice.app.domain;

public class CardDiscountDto {

	private int dc_num;
	private int dc_min;
	private int dc_max;
	private int dc_value;
	private int dc_classify;
	private String dc_etc;
	private int dc_smallnum;
	private String dc_cardcode;
	
	private int big_num;
	private String big_name;
	private int small_num;
	private String small_name;
	

	public int getDc_num() {
		return dc_num;
	}
	public void setDc_num(int dc_num) {
		this.dc_num = dc_num;
	}
	public String getDc_cardcode() {
		return dc_cardcode;
	}
	public void setDc_cardcode(String dc_cardcode) {
		this.dc_cardcode = dc_cardcode;
	}
	public int getDc_min() {
		return dc_min;
	}
	public void setDc_min(int dc_min) {
		this.dc_min = dc_min;
	}
	public int getDc_max() {
		return dc_max;
	}
	public void setDc_max(int dc_max) {
		this.dc_max = dc_max;
	}
	public int getDc_value() {
		return dc_value;
	}
	public void setDc_value(int dc_value) {
		this.dc_value = dc_value;
	}
	public int getDc_classify() {
		return dc_classify;
	}
	public void setDc_classify(int dc_classify) {
		this.dc_classify = dc_classify;
	}
	public String getDc_etc() {
		return dc_etc;
	}
	public void setDc_etc(String dc_etc) {
		this.dc_etc = dc_etc;
	}

	public int getDc_smallnum() {
		return dc_smallnum;
	}
	public void setDc_smallnum(int dc_smallnum) {
		this.dc_smallnum = dc_smallnum;
	}
	
	
	public int getBig_num() {
		return big_num;
	}
	public void setBig_num(int big_num) {
		this.big_num = big_num;
	}
	public String getBig_name() {
		return big_name;
	}
	public void setBig_name(String big_name) {
		this.big_name = big_name;
	}
	public int getSmall_num() {
		return small_num;
	}
	public void setSmall_num(int small_num) {
		this.small_num = small_num;
	}
	public String getSmall_name() {
		return small_name;
	}
	public void setSmall_name(String small_name) {
		this.small_name = small_name;
	}
	@Override
	public String toString() {
		return "CardDiscountDto [dc_num=" + dc_num + ", dc_min=" + dc_min + ", dc_max=" + dc_max + ", dc_value="
				+ dc_value + ", dc_classify=" + dc_classify + ", dc_etc=" + dc_etc + ", dc_smallnum=" + dc_smallnum
				+ ", dc_cardcode=" + dc_cardcode + ", big_num=" + big_num + ", big_name=" + big_name + ", small_num="
				+ small_num + ", small_name=" + small_name + "]";
	}



}
