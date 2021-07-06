package org.unboxing.mapper;

import org.unboxing.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public void register(String userid,String username,String userpw);
	
	public void registerAuth(String userid,String Auth);
}
