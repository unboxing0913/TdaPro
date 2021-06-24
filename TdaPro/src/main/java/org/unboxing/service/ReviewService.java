package org.unboxing.service;

import java.util.List;

import org.unboxing.domain.Criteria;
import org.unboxing.domain.ReviewVO;

public interface ReviewService {
	
	//public List<ReviewVO> getList(); //목록조회
	
	public List<ReviewVO> getList(Criteria cri); // 목록조회(페이징처리)
	
	public void register(ReviewVO board); //create
	
	public ReviewVO get(Long bno); //read
			
	public boolean modify(ReviewVO board); // update

	public boolean remove(Long bno); //delete
	
	public int getTotal(Criteria cri); // 전체데이터 개수 처리
	
}
