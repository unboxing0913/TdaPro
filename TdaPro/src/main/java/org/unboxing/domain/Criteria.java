package org.unboxing.domain;

import lombok.Data;

//페이징처리를 위한 기준 클래스

@Data
public class Criteria {

	private int pageNum; // 페이지 번호
	private int amount;  // 한 페이지당 몇개의 데이터
	
	public Criteria() { // 페이지 기본값
		this(1,10);
	}
	
	public Criteria(int pageNum,int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
