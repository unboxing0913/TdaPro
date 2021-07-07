package org.unboxing.service;

import org.unboxing.domain.AuthVO;
import org.unboxing.domain.MemberVO;

public interface MemberService {
	
	public void register(MemberVO vo); 
	
	public void registerAuth(AuthVO vo);
	
}
