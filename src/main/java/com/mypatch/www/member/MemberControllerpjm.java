package com.mypatch.www.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
		
	}
}
