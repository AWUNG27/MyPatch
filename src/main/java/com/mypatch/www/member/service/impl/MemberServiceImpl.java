package com.mypatch.www.member.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;
import com.mypatch.www.member.mapper.MemberMapper;
import com.mypatch.www.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
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

	@Override
	public List<MemberDTO> following(String member_id) {
		
		List<ProfileDTO> pDto = mapper.followingProfile(member_id);
		List<MemberDTO> mDto = mapper.followingInfo(member_id);
		
		for (MemberDTO memberDTO : mDto) {
			for (ProfileDTO profileDTO : pDto) {
				if (memberDTO.getMember_id().equals(profileDTO.getMember_id())) {
					
					memberDTO.setProfile(profileDTO);
				}
			}
		}
		
		return mDto;
	}

	@Override
	public List<MemberDTO> follower(String member_nick) {
		
		List<ProfileDTO> pDto = mapper.followerProfile(member_nick);
		List<MemberDTO> mDto = mapper.followerInfo(member_nick);
		
		for (MemberDTO memberDTO : mDto) {
			for (ProfileDTO profileDTO : pDto) {
				if (memberDTO.getMember_id().equals(profileDTO.getMember_id())) {
					
					memberDTO.setProfile(profileDTO);
				}
			}
		}

		return mDto;
	}
}
