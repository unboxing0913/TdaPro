package org.unboxing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.Review_ReplyVO;

public interface Review_ReplyMapper {

	public int insert(Review_ReplyVO vo);  //등록
	
	public Review_ReplyVO read(Long bno); // 조회 (게시물 번호)
	 
	public int delete (int rno); //삭제 (댓글의 번호)
	
	public int update(Review_ReplyVO reply); // 수정
	
	public List<Review_ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
}
