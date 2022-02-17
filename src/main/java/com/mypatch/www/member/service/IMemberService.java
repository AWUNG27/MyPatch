package com.mypatch.www.member.service;

import java.util.List;

import com.mypatch.www.member.domain.MemberDTO;

public interface IMemberService {
	public String chkEmail(String email);
	public String chkNick(String nickname);
	public int signup(MemberDTO mDto);
	
	public void follow(String member_id, String member_nick);
	public void unfollow(String member_nick, String member_id);
	
	public List<MemberDTO> following(String member_id);
	public List<MemberDTO> follower(String member_nick);
}
