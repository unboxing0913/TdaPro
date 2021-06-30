package org.unboxing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.ReviewVO;

public interface ReviewMapper {

	//@Select("select * from review_board where bno > 0 ")
	public List<ReviewVO> getList();
	
	//Criteria 타입을 피라미터로 사용하는 메서드 (페이징처리)
	public List<ReviewVO> getListWithPaging(Criteria cri);
	
	//전체 데이터개수를 구하기위한 메서드
	public int getTotalCount(Criteria cri);
	
	//Test코드실행시 Lombok의 toString()으로만든 bno변수가 null값으로 비어있음
	public void insert(ReviewVO board);
	
	//MyBatis 의 SelectKey 어노테이션을통해 bno값을 만들어놓은뒤 sql문적용
	public void insertSelectKey(ReviewVO board);

	//데이터 조회 작업은 PK를 이용해서 처리 ReviewVO클래스의 bno를 파라미터로 받음
	public ReviewVO read(Long bno);
	
	//데이터 삭제 작업도 PK를 이용해서 처리 (정삭적으로 삭제시 1반환 , 해당게시물이 없을시 0반환)
	public int delete(Long bno);
	
	//데이터 수정도 마찬가지로 몇개의 데이터를 수정했는지 처리하기위해 int 타입(최종수정시간 : 현재시간)
	public int update(ReviewVO board);
	
	//현재 게시글의 총 댓글수를 구하기위함
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
}
