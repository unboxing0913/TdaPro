package org.unboxing.mapper;

import java.util.List;

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
public class ReviewMapperTests {

	@Setter(onMethod_=@Autowired)
	private ReviewMapper mapper;
	
	@Test
	public void TestGetList() {
		mapper.getList().forEach(review -> log.info(review));
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		
		//3페이지 test
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<ReviewVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
	
	//검색테스트
	@Test
	public void testSerach() {
		Criteria cri = new Criteria();
		cri.setKeyword("ddd");
		cri.setType("TC");
		
		List<ReviewVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));		
	}
	
	
	@Test
	public void testInsert() {
		ReviewVO board = new ReviewVO();
		board.setTitle("insert() 테스트제목");
		board.setContent("insert() 테스트내용");
		board.setWriter("insert() 테스트작성자");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		ReviewVO board = new ReviewVO();
		board.setTitle("insertSelectKey() 테스트제목");
		board.setContent("insertSelectKey() 테스트내용");
		board.setWriter("insertSelectKey() 테스트작성자");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		ReviewVO board = mapper.read(5L);
		log.info(board);
	}
	
	@Test
	public void testDelete() {
		log.info("TEST Delete count --> "+mapper.delete(3L));
	}
	
	@Test
	public void testUpdate() {
		ReviewVO board = new ReviewVO();
		board.setBno(1L);
		board.setTitle("Testupdate() 제목");
		board.setContent("Testupdate() 내용");
		board.setWriter("Testupdate() 작성자");
		
		int count = mapper.update(board);
		log.info("TEST Update count -->"+count);
	}
}
