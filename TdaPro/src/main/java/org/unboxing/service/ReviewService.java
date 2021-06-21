package org.unboxing.service;

import java.util.List;

import org.unboxing.domain.ReviewVO;

public interface ReviewService {
	
	public List<ReviewVO> getList(); //목록조회
	
	public void register(ReviewVO board); //create
	
	public ReviewVO get(Long bno); //read
			
	public boolean modify(ReviewVO board); // update

	public boolean remove(Long bno); //delete
	
	
}
