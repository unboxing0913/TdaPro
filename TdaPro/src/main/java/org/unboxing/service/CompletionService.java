package org.unboxing.service;

import java.util.List;

import org.unboxing.domain.Criteria;
import org.unboxing.domain.CompletionAttachVO;
import org.unboxing.domain.CompletionVO;

public interface CompletionService {
	
	//public List<CompletionVO> getList(); //목록조회
	
	public List<CompletionVO> getList(Criteria cri); // 목록조회(페이징처리)
	
	public void register(CompletionVO board); //create
	
	public CompletionVO get(Long bno); //read
			
	public boolean modify(CompletionVO board); // update

	public boolean remove(Long bno); //delete
	
	public int getTotal(Criteria cri); // 전체데이터 개수 처리
	
	public List<CompletionAttachVO> getAttachList(Long bno);  //첨부파일 게시글번호를 가져옴
	
}
