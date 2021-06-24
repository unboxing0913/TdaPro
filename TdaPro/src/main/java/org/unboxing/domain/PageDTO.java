package org.unboxing.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage; // 시작
	private int endPage; // 끝
	private boolean prev , next; // 이전 , 다음
	
	private int total; //전체 데이터
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0 )) * 10 ; //끝번호 계산
		
		this.startPage = this.endPage - 9 ;  //마지막번호 계산
		
		
		//total을 통한 마지막번호 재 계산
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount())); 
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		
		this.prev = this.startPage > 1 ; // 이전 계산
		
		this.next = this.endPage < realEnd; // 다음 계산
	}
}
