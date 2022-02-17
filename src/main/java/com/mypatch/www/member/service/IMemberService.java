package com.mypatch.www.member.service;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;

public interface IMemberService {
	public String chkEmail(String email);
	public String chkNick(String nickname);
	public int signup(MemberDTO mDto);
	public MemberDTO selectMe(String member_id);
	public int modifyMember(MemberDTO mDto);
	public int removeProfile(ProfileDTO pDto);
	public void updatePwd(MemberDTO mDto);
}
