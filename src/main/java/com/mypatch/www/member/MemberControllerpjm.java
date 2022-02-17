package com.mypatch.www.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;
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
		
		log.info("follow............");
		
		service.follow(member_id, member_nick);
	}
	
	// 언팔로우(팔로우 취소)
	@GetMapping("/unfollow")
	public void unfollow(String member_id, String member_nick) {
		
		log.info("unfollow............");
		
		service.unfollow(member_nick, member_id);
	}
	
	// 팔로잉 목록
	@GetMapping("/following")
	public void following(String member_id, Model model) {
		
		log.info("following............");
		log.info(member_id);
		
		List<MemberDTO> mDto = service.following(member_id);
		
	}
	
	// 팔로워 목록
	@GetMapping("/follower")
	public void follower(String member_nick) {
		
		log.info("following............");
		
		List<MemberDTO> mDto = service.follower(member_nick);
	
	}
}
