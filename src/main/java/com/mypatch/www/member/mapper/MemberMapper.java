package com.mypatch.www.member.mapper;


import java.util.List;

import com.mypatch.www.board.domain.BoardDTO;

import com.mypatch.www.member.domain.MemberDTO;
import java.util.Map;

public interface MemberMapper {
	public MemberDTO selectUser(String member_id);
	public String chkEmail(String member_id);
	public String chkNick(String member_nick);
	public int insertMember(MemberDTO mDto);
	public int insertMemberAuth(String member_id);
	
	public List<BoardDTO> profileread(String member_id);

  public void follow(Map<String, String> paramMap);
	public void unfollow(Map<String, String> paramMap);
}
