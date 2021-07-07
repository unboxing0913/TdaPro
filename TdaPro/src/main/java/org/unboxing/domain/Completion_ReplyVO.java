package org.unboxing.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Completion_ReplyVO {

	private Long rno;
	private Long bno;
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}
