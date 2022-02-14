package com.mypatch.www.member.service.impl;

import java.util.HashMap;
import java.util.Map;

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
	
	@Override
	public void follow(String member_id, String member_nick) {
				
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_id", member_id);		
		paramMap.put("member_nick", member_nick);		
		mapper.follow(paramMap);
	}
	
	@Override
	public void unfollow(String member_nick, String member_id) {
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_nick", member_nick);
		paramMap.put("member_id", member_id);
		mapper.unfollow(paramMap);
	}
}
