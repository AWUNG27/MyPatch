package com.mypatch.www.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.mapper.MemberMapper;
import com.mypatch.www.member.service.IMemberService;

@Service
public class MemberServiceImpl implements IMemberService{
	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public String chkEmail(String email) {
		return mapper.chkEmail(email);
	}

	@Override
	public String chkNick(String nickname) {
		return mapper.chkNick(nickname);
	}
	
	@Transactional
	@Override
	public int signup(MemberDTO mDto) {
		int memberResult = mapper.insertMember(mDto);
		int authResult = mapper.insertMemberAuth(mDto.getMember_id());
		int result = memberResult+authResult;
		return result;
	}
}
