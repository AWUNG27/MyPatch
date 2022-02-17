package com.mypatch.www.member.mapper;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;

public interface MemberMapper {
	public MemberDTO selectUser(String member_id);
	public MemberDTO selectMe(String member_id);
	public String chkEmail(String member_id);
	public String chkNick(String member_nick);
	public int insertMember(MemberDTO mDto);
	public int insertMemberAuth(String member_id);
	public int deleteProfile(String member_id);
	public void insertProfile(ProfileDTO pDto);
	public int updateMember(MemberDTO mDto);
	public void updatePwd(MemberDTO mDto);
}
