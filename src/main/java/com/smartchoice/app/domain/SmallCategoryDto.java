/*
 * 	2016.07.29
 * 	소분류 Dto 작성
 */
package com.smartchoice.app.domain;

public class SmallCategoryDto {
	private int small_num;
	private String small_name;
	
	
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
		return "SmallCategoryDto [small_num=" + small_num + ", small_name=" + small_name + "]";
	}
	
	
	
}
