package org.unboxing.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

//페이징처리를 위한 기준 클래스 , 검색처리 포함

@Data
public class Criteria {

	private int pageNum; // 페이지 번호
	private int amount;  // 한 페이지당 몇개의 데이터
	
	private String type; // 검색 타입
	private String keyword; // 검색 키워드
	
	public Criteria() { // 페이지 기본값
		this(1,10);
	}
	
	public Criteria(int pageNum,int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//검색조건 T , W , C 한번에 처리하기 위함
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	// 리다이렉트시 코드길이를 줄이기위한 UriComponentsBuilder 사용
	// UriComponentsBuilder은 파라미터들을 URL 형태로 만들어주는 기능
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
}
