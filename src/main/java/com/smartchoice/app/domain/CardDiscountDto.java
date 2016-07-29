package com.smartchoice.app.domain;

public class CardDiscountDto {

	private int dc_min;
	private int dc_max;
	private int dc_value;
	private int dc_classify;
	private String dc_etc;
	private int dc_smallnum;
	private String dc_cardcode;
	 

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
	@Override
	public String toString() {
		return "CardDiscountDto [dc_min=" + dc_min + ", dc_max=" + dc_max + ", dc_value=" + dc_value + ", dc_classify="
				+ dc_classify + ", dc_etc=" + dc_etc + ", dc_smallnum=" + dc_smallnum + ", dc_cardcode=" + dc_cardcode
				+ "]";
	}


}
