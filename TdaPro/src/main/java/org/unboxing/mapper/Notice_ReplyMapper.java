package org.unboxing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.Notice_ReplyVO;

public interface Notice_ReplyMapper {

	public int insert(Notice_ReplyVO vo);  //등록
	
	public Notice_ReplyVO read(Long bno); // 조회 (게시물 번호)
	 
	public int delete (Long rno); //삭제 (댓글의 번호)
	
	public int update(Notice_ReplyVO reply); // 수정
	
	public List<Notice_ReplyVO> getListWithPaging( // 댓글 목록 처리
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	
	public int getCountByBno(Long bno); // 해당 게시글 댓글전체숫자 파악
}
