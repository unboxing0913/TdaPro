package org.unboxing.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.unboxing.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MemberMapperTests {

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	
	//admin 의 대한 정보 조회 테스트
	@Test
	public void testRead() {
		MemberVO vo = mapper.read("admin");
		log.info(vo);
		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
}
