package org.unboxing.controller;

import org.junit.Before; //Junit Before 이용
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml","file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@WebAppConfiguration // ServletContext 이용하기위함 Spring에서는 WebApplicationContext
public class ReviewControllerTests {

	@Setter(onMethod_=@Autowired)
	private WebApplicationContext ctx;
	
	// Fake mvc (테스트용)
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	
	//list(page 처리) 테스트
	@Test
	public void testListPaging() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/review/list")
				.param("pageNum", "2")
				.param("amount", "50"))
				.andReturn().getModelAndView().getModelMap());
	}
	
	
	//list 테스트
	@Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/review/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap()
				);
	}
	
	
	//register 테스트
	@Test
	public void testRegister() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/review/register")
				.param("title", "테스트 새글 제목")
				.param("content", "테스트 새글 내용")
				.param("writer","user00")
				)
				.andReturn()
				.getModelAndView()
				.getViewName();
		
		log.info(resultPage);
	}
	
	
	//get 테스트
	@Test
	public void testGet() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/review/get")
				.param("bno", "5")) //5번글
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	
	//modify 테스트
	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/review/modify")
				.param("bno","1")
				.param("title","수정된 테스트 새글 제목")
				.param("content","수정된 테스트 새글 내용")
				.param("writer","user00"))
				.andReturn()
				.getModelAndView()
				.getViewName();
		
		log.info(resultPage);
	}
	
	
	//remove 테스트
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/review/remove")
				.param("bno","8")) //8번글
				.andReturn()
				.getModelAndView()
				.getViewName();
		
		log.info(resultPage);
	}
	
}
