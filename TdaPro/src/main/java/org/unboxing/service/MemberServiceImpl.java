package org.unboxing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.unboxing.domain.AuthVO;
import org.unboxing.domain.MemberVO;
import org.unboxing.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BCryptPasswordEncoder pwEncoder;
	
	@Override
	public void register(MemberVO vo) {
		
		String userpw = pwEncoder.encode(vo.getUserpw());
		vo.setUserpw(userpw);	
		
		mapper.register(vo);
	}

	@Override
	public void registerAuth(AuthVO vo) {
		String auth = "ROLE_USER";
		vo.setAuth(auth);
		mapper.registerAuth(vo);
	}
	
	

}
