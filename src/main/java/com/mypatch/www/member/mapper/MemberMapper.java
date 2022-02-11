package com.mypatch.www.member.mapper;

import com.mypatch.www.member.domain.MemberDTO;

public interface MemberMapper {
	public MemberDTO selectUser(String member_id);
}
