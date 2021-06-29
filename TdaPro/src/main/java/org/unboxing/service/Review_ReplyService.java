package org.unboxing.service;

import java.util.List;

import org.unboxing.domain.Criteria;
import org.unboxing.domain.Review_ReplyPageDTO;
import org.unboxing.domain.Review_ReplyVO;

public interface Review_ReplyService {

	public int register(Review_ReplyVO vo);
	
	public Review_ReplyVO get(Long rno);
	
	public int modify(Review_ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<Review_ReplyVO> getList(Criteria cri , Long bno);
	
	public Review_ReplyPageDTO getListPage(Criteria cri , Long bno);
	
}
