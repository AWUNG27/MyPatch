package com.mypatch.www.member.mapper;

import com.mypatch.www.member.domain.MemberDTO;

public interface MemberMapper {
	public MemberDTO selectUser(String member_id);
	public String chkEmail(String member_id);
	public String chkNick(String member_nick);
	public int insertMember(MemberDTO mDto);
	public int insertMemberAuth(String member_id);
}
