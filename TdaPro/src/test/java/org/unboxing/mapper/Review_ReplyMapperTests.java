package org.unboxing.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.Review_ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class Review_ReplyMapperTests {

	@Setter(onMethod_=@Autowired)
	private Review_ReplyMapper mapper;
	
	//테스트하기 위한 게시물번호 (존재하는)
	private Long[] bnoArr = {903L,902L,901L,900L,899L};
	
	
	//정상동작하는지 테스트
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	//댓글 등록 테스트
	@Test
	public void testCreate() {
		
		//10개의 댓글 추가 테스트
		IntStream.rangeClosed(1,10).forEach(i->{			
			Review_ReplyVO vo = new Review_ReplyVO();
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글 테스트"+i);
			vo.setReplyer("replyer"+i);
			
			mapper.insert(vo);
		});			
	}
	
	//조회 테스트
	@Test
	public void testRead() {
		Long testRno = 5L;
		Review_ReplyVO vo = mapper.read(testRno);
		log.info(vo);
	}
	
	//수정테스트 (최종 수정 시간도 수정 )
	@Test
	public void testUpdate() {
		Long testRno = 10L;
		Review_ReplyVO vo = mapper.read(testRno);
		vo.setReply("Update Reply");
		int count = mapper.update(vo);
		log.info("UPDATE COUNT:"+count);
	}
	
	
	//목록 테스트
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<Review_ReplyVO> replies = mapper.getListWithPaging(cri , bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}
}
