package com.mypatch.www.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;
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
}
