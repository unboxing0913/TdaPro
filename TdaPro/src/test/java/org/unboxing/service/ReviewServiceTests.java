package org.unboxing.service;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.ReviewVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReviewServiceTests {

	@Setter(onMethod_=@Autowired)
	private ReviewService service;
	
	//정상적으로 주입되는지 테스트
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	//등록 테스트
	@Test
	public void testRegister() {
		ReviewVO board = new ReviewVO();
		board.setTitle("서비스 등록 테스트 제목");
		board.setContent("서비스 등록 테스트 내용");
		board.setWriter("user00");
		service.register(board);
		
		log.info("생성된 게시물의 번호 --> "+board.getBno());
	}
	
	//목록 테스트
	@Test
	public void testGetList() {
		//service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(2,10)).forEach(board -> log.info(board));
	}
	
	// 1번글 조회 테스트
	@Test
	public void testGet() {
		log.info(service.get(1L));
	}
	
	// 2번글 삭제 테스트
	@Test
	public void testDelete() {
		log.info("삭제 결과 : "+service.remove(2L));		
	}
	
	// 1번글 수정 테스트
	@Test
	public void testUpdate() {
		ReviewVO board = service.get(1L);
		if(board == null) {
			return;
		}
		board.setTitle("수정된 제목");
		log.info("수정 결과 : "+service.modify(board));
	}
}
