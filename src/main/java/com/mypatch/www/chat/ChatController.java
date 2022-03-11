package com.mypatch.www.chat;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mypatch.www.chat.domain.ChatMessageDTO;
import com.mypatch.www.chat.service.IChatService;
import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Controller 
@RequestMapping("/chat")
@Log4j
public class ChatController {
	
	@Autowired
	private IChatService service;
	@Autowired
	private IMemberService memberService;
	
	//DM 첫화면 이동..
	@GetMapping("/chat")
	public void chatMain(String member_id, Model model) {
		log.info("Direct message..");
		List<ChatMessageDTO> CMList = new ArrayList<ChatMessageDTO>();
		CMList = service.chatList(member_id);
		
		for (ChatMessageDTO chatMessageDTO : CMList) {
			//상대방의 아이디 확인..
			String yourID = chatMessageDTO.getMessage_receiver().equals(member_id) ? 
							chatMessageDTO.getMessage_sender() : 
							chatMessageDTO.getMessage_receiver();
			//상대회원 프로필을 set
			MemberDTO mDto = memberService.selectMe(yourID);
			chatMessageDTO.setMember(mDto);
			
			//장문 메세지 길이 조절 set
			if (chatMessageDTO.getMessage_content().length() > 20) {
				String splitContent = chatMessageDTO.getMessage_content().substring(0, 20);
				String newMessage = splitContent+"...";
				chatMessageDTO.setMessage_content(newMessage);
			}
			//마지막 메세지가 첨부파일일 때 미리보기 내용 변경
			if (chatMessageDTO.getMessage_content().equals("첨부파일")) {
				chatMessageDTO.setMessage_content("새로운 메세지가 있습니다.");
			}
			//마지막 메세지가 내가 보낸 메세지일때 읽지 않음 표시 없애기
			if (chatMessageDTO.getMessage_sender().equals(member_id)) {
				chatMessageDTO.setMessage_read('y');
			}
		}
		model.addAttribute("chatList",CMList);
	}
	@PostMapping("/chat")
	public @ResponseBody List<ChatMessageDTO> newList(String member_id) {
		List<ChatMessageDTO> CMList = new ArrayList<ChatMessageDTO>();
		CMList = service.chatList(member_id);
		
		for (ChatMessageDTO chatMessageDTO : CMList) {
			//상대방의 아이디 확인..
			String yourID = chatMessageDTO.getMessage_receiver().equals(member_id) ? 
					chatMessageDTO.getMessage_sender() : 
						chatMessageDTO.getMessage_receiver();
			//상대회원 프로필을 set
			MemberDTO mDto = memberService.selectMe(yourID);
			chatMessageDTO.setMember(mDto);
			
			//장문 메세지 길이 조절 set
			if (chatMessageDTO.getMessage_content().length() > 20) {
				String splitContent = chatMessageDTO.getMessage_content().substring(0, 20);
				String newMessage = splitContent+"...";
				chatMessageDTO.setMessage_content(newMessage);
			}
			//마지막 메세지가 첨부파일일 때 미리보기 내용 변경
			if (chatMessageDTO.getMessage_content().equals("첨부파일")) {
				chatMessageDTO.setMessage_content("새로운 메세지가 있습니다.");
			}
			//마지막 메세지가 내가 보낸 메세지일때 읽지 않음 표시 없애기
			if (chatMessageDTO.getMessage_sender().equals(member_id)) {
				chatMessageDTO.setMessage_read('y');
			}
		}
		return CMList;
	}
	
	//채팅방 상세 보기 Ajax..
	@PostMapping("/messageList")
	public ResponseEntity<List<ChatMessageDTO>> messageList(String member_id, int chatRoom_num, Model model){
		log.info("message history..");
		List<ChatMessageDTO> messageList = service.messageList(chatRoom_num);
		for (ChatMessageDTO chatMessageDTO : messageList) {
			//상대방의 아이디 확인..
			String yourID = chatMessageDTO.getMessage_receiver().equals(member_id) ? 
							chatMessageDTO.getMessage_sender() : 
							chatMessageDTO.getMessage_receiver();
			//상대회원 프로필을 set
			MemberDTO mDto = memberService.selectMe(yourID);
			chatMessageDTO.setMember(mDto);
			
		}
		return new ResponseEntity<List<ChatMessageDTO>>(messageList,HttpStatus.OK);
	}
}
