package com.mypatch.www.websocket;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mypatch.www.chat.domain.ChatMessageDTO;
import com.mypatch.www.chat.service.IChatService;
import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.service.IMemberService;

public class TextChatHandler extends TextWebSocketHandler{
	
	@Autowired
	private IChatService service;
	@Autowired
	private IMemberService memberService;
	
	private Map<String, WebSocketSession> userSession = new HashMap<>();
	
	//클라이언트가 세션에 서버에 컨넥션 됐을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("connected");
		String userId = session.getPrincipal().getName();
		userSession.put(userId, session);
		//세션에 접속하는 user들을 map에 저장
	}
	
	//서버에 메세지를 보낼때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		//json string 메세지를 dto에 매핑
		ObjectMapper mapper = new ObjectMapper();
		ChatMessageDTO messageDTO = mapper.readValue(message.getPayload(), ChatMessageDTO.class);
		//첨부파일이 있는 메세지인지 분기
		String finalMsg = "";
		if (messageDTO.getMessage_content() == null || messageDTO.getMessage_content().length() == 0) {
			//화면 출력을 위해 profile을 매핑
			MemberDTO mDto = memberService.selectMe(messageDTO.getMessage_sender());
			//이미 저장된 첨부메세지를 DB에서 select해 매핑
			messageDTO = service.lastMessage(messageDTO.getMessage_sender());
			messageDTO.setMember(mDto);
			finalMsg = mapper.writeValueAsString(messageDTO);
		} else {
			//텍스트 메세지라면 DB저장
			service.sendMessage(messageDTO);
			MemberDTO mDto = memberService.selectMe(messageDTO.getMessage_sender());
			messageDTO.setMember(mDto);
			finalMsg = mapper.writeValueAsString(messageDTO);			
		}
		//메세지 전송
		//상대방이 접속중이라면 상대방에게도 메세지를 전송
		if (userSession.get(messageDTO.getMessage_receiver()) != null) {
			WebSocketSession yourSess = userSession.get(messageDTO.getMessage_receiver());
			yourSess.sendMessage(new TextMessage(finalMsg));
		}
		//화면단 처리를 위해 나에게도 발송
		session.sendMessage(new TextMessage(finalMsg));
		
 	}
	
	//컨넥션이 해제될때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception{
		userSession.remove(session.getPrincipal().getName());
		System.out.println("socket session disconnected");
	}
}
