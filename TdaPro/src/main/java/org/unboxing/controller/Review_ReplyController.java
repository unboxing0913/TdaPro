package org.unboxing.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType; //MeadiaType
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.Review_ReplyPageDTO;
import org.unboxing.domain.Review_ReplyVO;
import org.unboxing.service.Review_ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/review/replies/")
@RestController  // 컨트롤러가 REST방식으로 처리하기위한것임을 명시함
@Log4j
@AllArgsConstructor
public class Review_ReplyController {

	
	private Review_ReplyService service;

// @RequestBody : 데이터 자체를 전달하기 위한 용도 
// ResponseEntity<> 타입 : REST방식 호출의 경우 화면자체가아닌 데이터 자체를 전송하는 방식으로 처리한다. 때문에 정상적인 데이터인지 구분할수있도록 HTTP헤더 상태의 메세지 등을 같이 전달하는 용도
// @PathVariable("") : URL 경로에 있는 값을 파라미터로 추출하려고 할때 사용 
	
	
	
	@PreAuthorize("isAuthenticated()") //로그인한 사용자만 작성할수있게
	//댓글 등록처리
	@PostMapping(value="/new",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody Review_ReplyVO vo){
		
		log.info("Review_ReplyVO : " + vo );
		int insertCount = service.register(vo);
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success" , HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
	
	}
	/*
	//특정 게시글 댓글목록 처리
	@GetMapping(value="/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_XML_VALUE , MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<Review_ReplyVO>> getList(
			@PathVariable("page") int page, 
			@PathVariable("bno") Long bno){
		
		log.info("댓글 목록보기 실행");
		Criteria cri = new Criteria(page,10); // 주소에 입력한 page 피라미터의 값
		log.info(cri);		
		
		return new ResponseEntity<>(service.getList(cri, bno),HttpStatus.OK);
	
	}
	*/
	
	//특정 게시글 댓글목록 처리 (페이징처리)
	@GetMapping(value="/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_XML_VALUE , MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Review_ReplyPageDTO> getList(@PathVariable("page") int page , @PathVariable("bno") Long bno){
		Criteria cri = new Criteria(page,10);
		log.info("get Reply List bno ----> " +bno);
		log.info("cri : " + cri);
		return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK);
	}
	
	
	//댓글 조회
	@GetMapping(value="/{rno}",
			produces = {MediaType.APPLICATION_XML_VALUE , MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Review_ReplyVO> get(@PathVariable("rno") Long rno){
		
		log.info("get : " + rno);
		
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	
	}
	
	
	//댓글 삭제
	@DeleteMapping(value="/{rno}",produces= {MediaType.TEXT_PLAIN_VALUE })
	@PreAuthorize("principal.username == #vo.replyer") // replyer이름이 같을경우에 삭제허용
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno,@RequestBody Review_ReplyVO vo){
		
		log.info("remove : "+rno);
		
		log.info("replyer : "+vo.getReplyer());
		
		return service.remove(rno) == 1 ? new ResponseEntity<>("success",HttpStatus.OK) 
				                        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글수정
	@RequestMapping(method= {RequestMethod.PUT,RequestMethod.PATCH},
			    value="/{rno}",
			    consumes="application/json",
			    produces= {MediaType.TEXT_PLAIN_VALUE }) 
	@PreAuthorize("principal.username == #vo.replyer")  //replyer이름이 같을경우에 삭제허용
	public ResponseEntity<String> modify(
			@RequestBody Review_ReplyVO vo,
			@PathVariable("rno") Long rno){
		
		vo.setRno(rno);
		
		log.info("rno : "+rno);
		log.info("modify : "+vo);
		
		return service.modify(vo) == 1 ? new ResponseEntity<>("success",HttpStatus.OK)
				                       : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
    }
	
	
}
