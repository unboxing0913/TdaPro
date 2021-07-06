package org.unboxing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.unboxing.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	@Setter(onMethod_=@Autowired)
	MemberService service;
	
	@Setter(onMethod_=@Autowired)
	BCryptPasswordEncoder pwdEncoder;
	
	
	
	@GetMapping("/register")
	public void getRegister() {
		
	}
	
	@PostMapping("/register")
	public String register(String userid,String userpw,String username) {
		
		String auth = "ROLE_USER";
		
		service.register(userid,userpw,username);
		service.registerAuth(userid, auth);
		return "redirect:/";
	}
}
