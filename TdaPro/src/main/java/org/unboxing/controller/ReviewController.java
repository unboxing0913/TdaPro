package org.unboxing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review/*")
@Log4j
public class ReviewController {

	@GetMapping("/list")
	public String list() {
		log.info("list");
		return "/review/list";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping({"/get","/modify"})
	public void get() {
		log.info("/get or modify");
	}

	@GetMapping("/test2")
	public void test2(){
		//?šŒ?›ê°??… ?„?‹œ
	}
	
	@GetMapping("/test")
	public void test(){
		//ë¡œê·¸?¸ ?„?‹œ
	}
}
