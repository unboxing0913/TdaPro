package org.unboxing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.Review_ReplyVO;

public interface Review_ReplyMapper {

	public int insert(Review_ReplyVO vo);  //등록
	
	public Review_ReplyVO read(Long bno); // 조회 (게시물 번호)
	 
	public int delete (Long rno); //삭제 (댓글의 번호)
	
	public int update(Review_ReplyVO reply); // 수정
	
	public List<Review_ReplyVO> getListWithPaging( // 댓글 목록 처리
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	
	public int getCountByBno(Long bno); // 해당 게시글 댓글전체숫자 파악
}
