package com.mypatch.www.member.service.impl;

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
	public MemberDTO selectMe(String member_id) {
		return mapper.selectMe(member_id);
	}
	
	@Transactional
	@Override
	public int modifyMember(MemberDTO mDto) {
		int result = mapper.updateMember(mDto);
		if (mDto.getProfileDTO() != null) {
			mapper.deleteProfile(mDto.getMember_id());
			mapper.insertProfile(mDto.getProfileDTO());			
		}
		return result;
	}

	@Override
	public int removeProfile(ProfileDTO pDto) {
		return mapper.deleteProfile(pDto.getMember_id());
	}

	@Override
	public void updatePwd(MemberDTO mDto) {
		mapper.updatePwd(mDto);
	}
	
	@Override
	public int follow(String member_id, String member_nick) {
				
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_id", member_id);		
		paramMap.put("member_nick", member_nick);		
		
		int result = mapper.follow(paramMap);
		
		return result;
	}
	
	@Override
	public int unfollow(String member_nick, String member_id) {
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("member_nick", member_nick);
		paramMap.put("member_id", member_id);
		
		int result = mapper.unfollow(paramMap);
		
		return result;
	}

	@Override
	public int followingCnt(String member_id) {
		
		return mapper.followingCnt(member_id);
	}

	@Override
	public int followerCnt(String member_nick) {
		
		return mapper.followerCnt(member_nick);
	}
	
	@Override
	public List<MemberDTO> following(String member_id) {
		
		List<ProfileDTO> pDto = mapper.followingProfile(member_id);
		List<MemberDTO> mDto = mapper.followingInfo(member_id);
		
		for (MemberDTO memberDTO : mDto) {
			for (ProfileDTO profileDTO : pDto) {
				if (memberDTO.getMember_id().equals(profileDTO.getMember_id())) {
					
					memberDTO.setProfileDTO(profileDTO);
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
					
					memberDTO.setProfileDTO(profileDTO);
				}
			}
		}

		return mDto;
	}

}
