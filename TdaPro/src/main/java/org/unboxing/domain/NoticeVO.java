package org.unboxing.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt; //현재 게시글의 총 댓글수
	
	private List<NoticeAttachVO> attachList; //첨부파일 
	
}
