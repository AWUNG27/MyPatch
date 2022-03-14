package com.mypatch.www.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
	public ResponseEntity<String> follow(String member_id, String member_nick) {
		
		log.info("follow..");
		log.info("follow member_id : " + member_id);
		log.info("follow member_nick : " + member_nick);
		
		int result = service.follow(member_id, member_nick);
		log.info("follow result..." + result);
		
		if (result <= 0) {
			return new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	// 언팔로우(팔로우 취소)
	@GetMapping("/unfollow")
	public ResponseEntity<String> unfollow(String member_id, String member_nick) {
		
		log.info("unfollow..");
		log.info("unfollow member_id : " + member_id);
		log.info("unfollow member_nick : " + member_nick);
		
		int result = service.unfollow(member_nick, member_id);
		log.info("unfollow result..." + result);

		if (result <= 0) {
			return new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	// 팔로잉 목록
	@GetMapping("/following")
	@ResponseBody
	public List<MemberDTO> following(String member_id) {	
		
		log.info("following..");
		log.info("following member_id : " + member_id);

		List<MemberDTO> followingMemDto = service.following(member_id);
	
		for (MemberDTO memberDTO : followingMemDto) {
			
			log.info("팔로잉 리스트 memberDTO : " + memberDTO);
		}
		
		return followingMemDto;
	}
	
	// 팔로워 목록
	@GetMapping("/follower")
	@ResponseBody
	public List<MemberDTO> follower(String member_nick) {
				
		log.info("follower..");
		log.info("follower member_nick : " + member_nick);

		List<MemberDTO> followerMemDto = service.follower(member_nick);
	
		for (MemberDTO memberDTO : followerMemDto) {
			
			log.info("팔로워 리스트 memberDTO : " + memberDTO);
		}
		
		return followerMemDto;
	}
}
