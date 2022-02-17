package com.mypatch.www.member.mapper;


import java.util.List;
import java.util.Map;

import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;

public interface MemberMapper {
	public MemberDTO selectUser(String member_id);
	public String chkEmail(String member_id);
	public String chkNick(String member_nick);
	public int insertMember(MemberDTO mDto);
	public int insertMemberAuth(String member_id);
	
	public List<BoardDTO> profileread(String member_id);

	public void follow(Map<String, String> paramMap);
	public void unfollow(Map<String, String> paramMap);

	public int followingCnt(String member_id);
	public int followerCnt(String member_nick);
	
	public List<ProfileDTO> followingProfile(String member_id);
	public List<MemberDTO> followingInfo(String member_id);
	
	public List<ProfileDTO> followerProfile(String member_nick);
	public List<MemberDTO> followerInfo(String member_nick);

}
