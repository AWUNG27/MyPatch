package com.mypatch.www.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberControllerkjw {

	@RequestMapping(value = "/login")
	public void login() {
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signup() {
	}
  
	//내 프로필 페이지 이동
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public void profile(String member_id) {
		log.info("My page..");
		
	}
	
}
