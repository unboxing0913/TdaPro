package org.unboxing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.unboxing.domain.AuthVO;
import org.unboxing.domain.MemberVO;
import org.unboxing.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@Setter(onMethod_=@Autowired)
	MemberService service;
	
	@Setter(onMethod_=@Autowired)
	BCryptPasswordEncoder pwdEncoder;
	
	
	//접근제한 매핑
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth,Model model) {
		log.info("access Denied:"+auth);
		model.addAttribute("msg","Access Denied");
	}
	
	
	//로그인페이지로의 매핑
	@GetMapping("/customLogin")
	public void loginInput(String error,String logout,Model model) {
		log.info("error:"+error);
		log.info("logout:"+logout);
		
		if(error != null) {
			model.addAttribute("error","아이디 또는 비밀번호가 잘못되었습니다");
		}
		if(logout != null) {
			model.addAttribute("logout","로그아웃 하셨습니다");
		}
	}
	
	//로그아웃 매핑
	@GetMapping("/customLogout")
	public void logoutGET() {
		log.info("custom logout");
	}
	
	//회원가입 페이지 매핑
	@GetMapping("/customSignUp")
	public void customSignUp() {
		log.info("회원가입");
	}
	
	//
	@PreAuthorize("isAnonymous()")
	@PostMapping("/customSignUp")
	public String register(MemberVO vo,AuthVO avo) {

		service.register(vo);
		service.registerAuth(avo);
		
		return "redirect:/";
	}
	
	@GetMapping("/maps")
	public void maps() {
		
	}
	
}
