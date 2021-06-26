package org.unboxing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.Review_ReplyVO;
import org.unboxing.mapper.Review_ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
// @AllArgsConstructor : Setter로 대신처리
public class Review_ReplyServiceImpl implements Review_ReplyService{

	@Setter(onMethod_=@Autowired)
	private Review_ReplyMapper mapper;
	@Override
	public int register(Review_ReplyVO vo) {
		log.info("등록처리 ---> " + vo);
		return mapper.insert(vo);
	}

	@Override
	public Review_ReplyVO get(Long rno) {
		log.info("조회처리 ---> " + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(Review_ReplyVO vo) {
		log.info("수정처리 ---> " + vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long rno) {
		log.info("삭제처리 ---> " + rno);
		return mapper.delete(rno);
	}

	@Override
	public List<Review_ReplyVO> getList(Criteria cri, Long bno) {
		log.info("댓글 목록 처리 ---> " + bno);
		return mapper.getListWithPaging(cri, bno);
	}

}
