package org.unboxing.service;

import java.util.List;

import org.unboxing.domain.Criteria;
import org.unboxing.domain.Completion_ReplyPageDTO;
import org.unboxing.domain.Completion_ReplyVO;

public interface Completion_ReplyService {

	public int register(Completion_ReplyVO vo);
	
	public Completion_ReplyVO get(Long rno);
	
	public int modify(Completion_ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<Completion_ReplyVO> getList(Criteria cri , Long bno);
	
	public Completion_ReplyPageDTO getListPage(Criteria cri , Long bno);
	
}
