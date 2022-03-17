package com.mypatch.www.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.domain.ProfileDTO;
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
	
	//회원정보 수정 페이지 이동
	@GetMapping("/modifyProfile")
	public void modifyProfile(String member_id, Model model) {
		log.info("modify member page..");
		MemberDTO mDto = service.selectMe(member_id);
		model.addAttribute("memberDTO", mDto);
		model.addAttribute("profileDTO", mDto.getProfileDTO());
		log.info(mDto.toString());
	}
	
	//회원정보 수정
	@PostMapping("/modifyProfile")
	public String modifyProfileSubmit(MemberDTO mDto, 
			@RequestParam(value="alarmConfirm" , required = false)boolean alarm,
			@RequestParam("profile_uuid")String uuid,
			@RequestParam("profile_fileName")String filename, 
			RedirectAttributes rttr) {
		log.info("profile change submit..");
		
		if (alarm) {
			mDto.setMember_alarm('Y');
		} else mDto.setMember_alarm('N');
		
		if (!uuid.equals("") && !filename.equals("")) {
			ProfileDTO pDto = new ProfileDTO();
			pDto.setProfile_uuid(uuid);
			pDto.setProfile_fileName(filename);
			pDto.setMember_id(mDto.getMember_id());
			mDto.setProfileDTO(pDto);
		}
		int result = service.modifyMember(mDto);
		
		if (result < 1) {
			rttr.addFlashAttribute("message","System error!!");
		} else {
			rttr.addFlashAttribute("message","회원정보가 수정되었습니다.");			
		}
		
		return "redirect:/member/profile?member_id="+mDto.getMember_id();
	}
	
	@PostMapping("/removeProfile")
	public ResponseEntity<String> removeProfile(ProfileDTO pDto) {
		log.info("remove profile..");
		String msg = "";
		int result = service.removeProfile(pDto);
		if (result > 0) {
			msg = "프로필 사진이 삭제되었습니다.";
		} else {
			msg = "error";
			return new ResponseEntity<String>(msg, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<String>(msg, HttpStatus.OK);
	}
	
	@PostMapping("/pwdModify")
	public ResponseEntity<Integer> pwdModify(MemberDTO newDto , String origin) {
		log.info("modify password..");
		MemberDTO member = new MemberDTO();
		member = service.selectMe(newDto.getMember_id());
		int result;
		if (!encoder.matches(origin, member.getMember_pwd())) {
			result = 0;
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} else {
			member.setMember_pwd(encoder.encode(newDto.getMember_pwd()));
			service.updatePwd(member);
			result = 1;
		}
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@PostMapping("/exitMember")
	public ResponseEntity<Integer> exitMember(MemberDTO mDto){
		log.info("exit joinus..");
		int result;
		MemberDTO member = new MemberDTO();
		member = service.selectMe(mDto.getMember_id());
		if (!encoder.matches(mDto.getMember_pwd(), member.getMember_pwd())) {
			result = 0;
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
		} else {
			result = service.deleteMember(mDto.getMember_id());
			SecurityContextHolder.clearContext();
		}
		
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
}
