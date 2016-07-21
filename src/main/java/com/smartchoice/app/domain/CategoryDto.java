/*
 * 	대분류 소분류 DTO
		
	작성일 : 2016-07-21
	수정일 : 2016-07-21
	작성자 : 김상덕
 */
package com.smartchoice.app.domain;

public class CategoryDto {
	
	private int big_num;
	private String big_name;
	private int small_num;
	private String small_name;
	
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
	
}
