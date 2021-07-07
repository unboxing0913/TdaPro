package org.unboxing.service;

import java.util.List;

import org.unboxing.domain.Criteria;
import org.unboxing.domain.NoticeAttachVO;
import org.unboxing.domain.NoticeVO;

public interface NoticeService {
	
	//public List<NoticeVO> getList(); //목록조회
	
	public List<NoticeVO> getList(Criteria cri); // 목록조회(페이징처리)
	
	public void register(NoticeVO board); //create
	
	public NoticeVO get(Long bno); //read
			
	public boolean modify(NoticeVO board); // update

	public boolean remove(Long bno); //delete
	
	public int getTotal(Criteria cri); // 전체데이터 개수 처리
	
	public List<NoticeAttachVO> getAttachList(Long bno);  //첨부파일 게시글번호를 가져옴
	
}
