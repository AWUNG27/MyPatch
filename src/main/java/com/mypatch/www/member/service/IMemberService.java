package com.mypatch.www.member.service;

import java.util.List;

import com.mypatch.www.member.domain.FollowDTO;
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

	public int follow(String member_id, String member_nick);
	public int unfollow(String member_nick, String member_id);
	public int deleteMember(String member_id);
	
	public int followingCnt(String member_id);
	public int followerCnt(String member_nick);

	public List<MemberDTO> following(String member_id);
	public List<MemberDTO> follower(String member_nick);
	
	public int followChk(FollowDTO fDto);
}
