package org.unboxing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.unboxing.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService{

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	@Override
	public void register(String userid, String userpw, String username) {
		mapper.register(userid, username, userpw);
	}

	@Override
	public void registerAuth(String userid, String auth) {
		mapper.registerAuth(userid, auth);
	}
	
	

}
