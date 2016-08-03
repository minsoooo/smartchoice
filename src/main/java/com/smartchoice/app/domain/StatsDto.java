package com.smartchoice.app.domain;

public class StatsDto {
	private int big_num;
	private String big_name;
	private int small_num;
	private String small_name;
	private String small_img;
	private int sum;

	public StatsDto() {
		this.big_num = 0;
		this.big_name = "";
		this.small_num = 0;
		this.small_name = "";
		this.small_img = "";
		this.sum = 0;
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

	public String getSmall_img() {
		return small_img;
	}

	public void setSmall_img(String small_img) {
		this.small_img = small_img;
	}

	public int getSum() {
		return sum;
	}

	public void setSum(int sum) {
		this.sum = sum;
	}

}
