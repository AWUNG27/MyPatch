package com.mypatch.www.member.service;

import com.mypatch.www.member.domain.MemberDTO;

public interface IMemberService {
	public String chkEmail(String email);
	public String chkNick(String nickname);
	public int signup(MemberDTO mDto);
}
