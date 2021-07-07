package org.unboxing.mapper;

import java.util.List;

import org.unboxing.domain.CompletionAttachVO;

public interface CompletionAttachMapper {

	public void insert(CompletionAttachVO vo); //첨부파일 등록
	
	public void delete(String uuid); //첨부파일 삭제
	
	public List<CompletionAttachVO> findByBno(Long bno); // 등록과 삭제를 하기위한 특정 게시물 번호 찾기
	
	public void deleteAll(Long bno); //게시물 삭제시 첨부파일 전체삭제
	
	public List<CompletionAttachVO> getOldFiles(); // task 스케쥴러를사용해 잘못업로드된 파일을 제거하기위함
}
