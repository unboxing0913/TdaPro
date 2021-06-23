package org.unboxing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.unboxing.domain.ReviewVO;
import org.unboxing.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/review/*")
@Log4j
@AllArgsConstructor
public class ReviewController {
	
	private ReviewService service;
	
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list page");
		model.addAttribute("list",service.getList());
	}
	
	
	//화면에서 확인하기위해 get방식 매핑 적용	
	@GetMapping("/register")
	public void register() {
		
	}
	
	
	@PostMapping("/register")
	public String register(ReviewVO board, RedirectAttributes rttr) {
		//RedirectAttributes의 addFlashAttribute경우 일회성데이터를 전달하기때문에 중복처리하기 좋음
		log.info("register : "+board);
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno()); 
		
		//등록 작업이후 다시 목록화면으로 이동
		return "redirect:/review/list";
	}
	
	
	//화면에서 확인하기위해 get방식 매핑적용 modify는 조회페이지(get)과 같기때문
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno,Model model) {
		log.info("get page , modify page");
		model.addAttribute("board",service.get(bno));
	}
	
	
	@PostMapping("/modify")
	public String modify(ReviewVO board,RedirectAttributes rttr) {
		log.info("modify : "+board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
		//수정 작업이후 다시 목록화면으로 이동
		return "redirect:/review/list";
	}
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,RedirectAttributes rttr) {
		log.info("remove Bno : " +bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		
		//삭제 작업이후 다시 목록화면으로 이동
		return "redirect:/review/list";
	}

}
