package org.unboxing.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.unboxing.domain.ReviewVO;
import org.unboxing.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReviewServiceImpl implements ReviewService{
	
	//@Setter(onMethod_=@Autowired)  AllArgsConstructor로 사용
	private ReviewMapper mapper;
	
	@Override
	public List<ReviewVO> getList() {
		return null;
	}

	@Override
	public void register(ReviewVO board) {
		log.info("등록 ---> "+board);
		mapper.insertSelectKey(board);
	}

	@Override
	public ReviewVO get(Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(ReviewVO board) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

}
