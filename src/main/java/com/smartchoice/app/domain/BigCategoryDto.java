/*
 *
 * 	2016.07.21
 * 	대분류 Dto 작성
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD

=======
>>>>>>> refs/remotes/origin/master
=======
>>>>>>> refs/remotes/origin/master
>>>>>>> refs/remotes/Minsoo/cardPlan_Snapshot_2.0
 */
package com.smartchoice.app.domain;

public class BigCategoryDto {
	private int big_num;
	private String big_name;
	
	
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

	
	@Override
	public String toString() {
		return "BigCategoryDto [big_num=" + big_num + ", big_name=" + big_name + "]";
	}
}
