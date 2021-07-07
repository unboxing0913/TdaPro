package org.unboxing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.Completion_ReplyPageDTO;
import org.unboxing.domain.Completion_ReplyVO;
import org.unboxing.mapper.CompletionMapper;
import org.unboxing.mapper.Completion_ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
// @AllArgsConstructor : Setter로 대신처리
public class Completion_ReplyServiceImpl implements Completion_ReplyService{

	@Setter(onMethod_=@Autowired)
	private Completion_ReplyMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private CompletionMapper rv_mapper; //트랜잭션처리를 위함
	
	@Transactional
	@Override
	public int register(Completion_ReplyVO vo) {
		log.info("등록처리 ---> " + vo);
		
		//전달받은 vo 객체 내의 게시물번호로 댓글추가
		rv_mapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.insert(vo);
	}

	@Override
	public Completion_ReplyVO get(Long rno) {
		log.info("조회처리 ---> " + rno);
		return mapper.read(rno);
	}

	@Override
	public int modify(Completion_ReplyVO vo) {
		log.info("수정처리 ---> " + vo);
		return mapper.update(vo);
	}

	@Transactional //트랜잭션 처리
	@Override
	public int remove(Long rno) {
		log.info("삭제처리 ---> " + rno);
	
		//피라미터로 전달받은 게시물 번호로 게시물정보를 알아낸뒤 현재게시글 총 댓글수 구함
		Completion_ReplyVO vo = mapper.read(rno);
		rv_mapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	@Override
	public List<Completion_ReplyVO> getList(Criteria cri, Long bno) {
		log.info("댓글 목록 처리 ---> " + bno);
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public Completion_ReplyPageDTO getListPage(Criteria cri, Long bno) {
		log.info("댓글 목록 페이징처리");
		return new Completion_ReplyPageDTO(mapper.getCountByBno(bno),mapper.getListWithPaging(cri, bno));
	}
	

}
