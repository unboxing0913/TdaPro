package org.unboxing.service;

import java.util.List;

import org.unboxing.domain.Criteria;
import org.unboxing.domain.Notice_ReplyPageDTO;
import org.unboxing.domain.Notice_ReplyVO;

public interface Notice_ReplyService {

	public int register(Notice_ReplyVO vo);
	
	public Notice_ReplyVO get(Long rno);
	
	public int modify(Notice_ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<Notice_ReplyVO> getList(Criteria cri , Long bno);
	
	public Notice_ReplyPageDTO getListPage(Criteria cri , Long bno);
	
}
