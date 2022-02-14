package com.mypatch.www.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberControllerjsh {
	
	@Autowired
	private IMemberService service;
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	//이메일 중복검사
	@PostMapping("/emailChk")
	public ResponseEntity<String> emailChk(String email){
		log.info("check overlap email..");
		String result = service.chkEmail(email);
		return new ResponseEntity<String>(result,HttpStatus.OK);
	}
	
	//닉네임 중복검사
	@PostMapping("/nickChk")
	public ResponseEntity<String> nickChk(String nickname){
		log.info("check overlap nickname..");
		String result = service.chkNick(nickname);
		return new ResponseEntity<String>(result,HttpStatus.OK);
	}
	
	//회원가입 submit
	@PostMapping("/signupSubmit")
	public ResponseEntity<String> signupSubmit(MemberDTO mDto) {
		log.info("signup request..");
		
		String pw = mDto.getMember_pwd();
		mDto.setMember_pwd(encoder.encode(pw));
		int result = service.signup(mDto);
		if (result < 2) {
			return new ResponseEntity<String>("system error!!!",HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}
	
	//내 프로필 페이지 이동
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public void profile(String member_id) {
		log.info("My page..");
	}
}
