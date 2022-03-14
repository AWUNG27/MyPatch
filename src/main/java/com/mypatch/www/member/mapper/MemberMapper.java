package com.mypatch.www.member.mapper;


import java.util.List;
import java.util.Map;

import com.mypatch.www.board.domain.BoardAttachDTO;
import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;

import org.apache.ibatis.annotations.Param;

public interface MemberMapper {
	public MemberDTO selectUser(String member_id);
	public MemberDTO selectMe(String member_id);
	public String chkEmail(String member_id);
	public String chkNick(String member_nick);
	public int insertMember(MemberDTO mDto);
	public int insertMemberAuth(String member_id);
	public int deleteMember(String member_id);
	public void deleteAuth(String member_id);
	public List<MemberDTO> searchMemberList(String searchKeyword);


	public int deleteProfile(String member_id);
	public void insertProfile(ProfileDTO pDto);
	public int updateMember(MemberDTO mDto);
	public void updatePwd(MemberDTO mDto);
	public List<BoardDTO> profileread(String member_id);

	public List<BoardAttachDTO> profileimg(@Param("member_id") String member_id,@Param("cnt") String cnt);
	public List<BoardDTO> profileboard(@Param("member_id") String member_id,@Param("cnt") String cnt);
	public Integer profilecnt(String member_id);
	public int follow(Map<String, String> paramMap);
	public int unfollow(Map<String, String> paramMap);

	public int followingCnt(String member_id);
	public int followerCnt(String member_nick);
	
	public List<ProfileDTO> followingProfile(String member_id);
	public List<MemberDTO> followingInfo(String member_id);
	
	public List<ProfileDTO> followerProfile(String member_nick);
	public List<MemberDTO> followerInfo(String member_nick);

}
