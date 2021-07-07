package org.unboxing.mapper;

import org.unboxing.domain.AuthVO;
import org.unboxing.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public void register(MemberVO vo);
	
	public void registerAuth(AuthVO vo);
}
