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
		log.info("목록");
		return mapper.getList();
	}

	@Override
	public void register(ReviewVO board) {
		log.info("등록 ---> "+board);
		mapper.insertSelectKey(board);
	}

	@Override
	public ReviewVO get(Long bno) {
		log.info("조회 ---> "+bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(ReviewVO board) {
		log.info("수정 ---> "+board);
		return mapper.update(board) == 1; //정상적 수정완료시 1값반환 == 연산자를 이용해 t/f 처리
	}

	@Override
	public boolean remove(Long bno) {
		log.info("삭제 ---> "+bno);
		return mapper.delete(bno) == 1;
	}

}
