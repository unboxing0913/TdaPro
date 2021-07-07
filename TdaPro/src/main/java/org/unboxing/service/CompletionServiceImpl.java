package org.unboxing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.unboxing.domain.Criteria;
import org.unboxing.domain.CompletionAttachVO;
import org.unboxing.domain.CompletionVO;
import org.unboxing.mapper.CompletionAttachMapper;
import org.unboxing.mapper.CompletionMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
//@AllArgsConstructor 두개이상의 매퍼주입이기떄문에 Setter사용
public class CompletionServiceImpl implements CompletionService{
	
	
	@Setter(onMethod_=@Autowired)  //1개의 매퍼일시 AllArgsConstructor로 대체가능
	private CompletionMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private CompletionAttachMapper attachMapper;
	
	
	/*
	@Override
	public List<CompletionVO> getList() {
		log.info("목록");
		return mapper.getList();
	}
	*/
	@Override
	public List<CompletionVO> getList(Criteria cri) {
		log.info("목록처리, 페이징 처리 : " +cri);
		return mapper.getListWithPaging(cri);
	}
	
	
	@Transactional    //게시글과 첨부파일 양쪽테이블 모두 insert가 진행되게하기위함
	@Override
	public void register(CompletionVO board) {
		log.info("등록 ---> "+board);
		mapper.insertSelectKey(board);
		
		//첨부파일이 존재하지않을때
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno()); //첨부파일 테이블에 현재게시글 번호를 넣어준다
			attachMapper.insert(attach);
		});
	}

	@Override
	public CompletionVO get(Long bno) {
		log.info("조회 ---> "+bno);
		return mapper.read(bno);
	}
	
	
	
	@Transactional
	@Override
	public boolean modify(CompletionVO board) {
		log.info("수정 ---> "+board);
		
		attachMapper.deleteAll(board.getBno()); //기존에 있던 첨부파일 삭제
		
		boolean modifyResult = mapper.update(board) == 1; //정상적 수정완료시 1값반환 == 연산자를 이용해 t/f 처리
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach); // 현재 첨부파일데이터를 다시추가
			});
		}
		
		return modifyResult;
		
	}
	
	
	@Transactional //게시글을 지울때 첨부파일도 전체 삭제할수있도록 트랜잭션처리
	@Override
	public boolean remove(Long bno) {
		log.info("삭제 ---> "+bno);
		
		attachMapper.deleteAll(bno); //첨부파일 전체삭제
		
		return mapper.delete(bno) == 1;
	}


	@Override
	public int getTotal(Criteria cri) {
		log.info("전체 데이터 수");
		return mapper.getTotalCount(cri);
	}


	@Override
	public List<CompletionAttachVO> getAttachList(Long bno) {
		log.info("첨부파일의 번호를 가져오기 ---> "+bno);
		return attachMapper.findByBno(bno); //게시글번호 조회하는 메서드 사용후 리턴
	}

	

}
