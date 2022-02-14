package com.mypatch.www.member;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.member.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberControllerkjw {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	@RequestMapping(value = "/login")
	public void login() {
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signup() {
	}
  
	//내 프로필 페이지 이동
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public void profile(String member_id) {
		List<BoardDTO> bList = new ArrayList<BoardDTO>();
		log.info("My page..");
		log.info("내 아이디: " + member_id);
		bList = memberMapper.profileread(member_id);
		for (BoardDTO bDto : bList) {
			log.info(bDto);
		}
	}
	
}
