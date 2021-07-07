package org.unboxing.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;


//회원 객체

@Data
public class MemberVO {

	private String userid;
	private String userpw;
	private String username;
	private boolean enabled;
	
	private Date regDate;
	private Date updateDate;
	
	private List<AuthVO> authList;
}
