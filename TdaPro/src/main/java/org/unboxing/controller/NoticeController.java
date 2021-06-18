package org.unboxing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice/*")
@Log4j
public class NoticeController {

	@GetMapping("/list")
	public String list() {
		log.info("list");
		return "/notice/list";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping({"/get","/modify"})
	public void get() {
		log.info("/get or modify");
	}
	
	
}
