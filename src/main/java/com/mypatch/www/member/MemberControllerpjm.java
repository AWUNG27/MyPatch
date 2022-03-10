package com.mypatch.www.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberControllerpjm {

	@Autowired
	private IMemberService service;

	// 팔로우
	@GetMapping("/follow")
	public void follow(String member_id, String member_nick) {
		
		log.info("follow..");
		log.info("follow member_id : " + member_id);
		log.info("follow member_nick : " + member_nick);
		
		service.follow(member_id, member_nick);
	}
	
	// 언팔로우(팔로우 취소)
	@GetMapping("/unfollow")
	public void unfollow(String member_id, String member_nick) {
		
		log.info("unfollow..");
		log.info("unfollow member_id : " + member_id);
		
		service.unfollow(member_nick, member_id);
	}
	
	// 팔로잉 목록
	@GetMapping("/following")
	@ResponseBody
	public List<MemberDTO> following(String member_id) {	
		
		log.info("following..");
		log.info("following member_id : " + member_id);
		
//		Map<String, Object> following = new HashMap();

		List<MemberDTO> mDto = service.following(member_id);
	
		for (MemberDTO memberDTO : mDto) {
			
			log.info("memberDTO : " + memberDTO);
		}

//		following.put("following", mDto);
		
//		log.info(following.toString());
		
		return mDto;
	}
	
	// 팔로워 목록
	@GetMapping("/follower")
	@ResponseBody
	public Map<String, Object> follower(String member_nick) {
				
		log.info("follower..");
		log.info("follower member_nick : " + member_nick);
		
		Map<String, Object> follower = new HashMap();

		List<MemberDTO> mDto = service.follower(member_nick);
	
		follower.put("follower", mDto);
		
		return follower;
	}
}
