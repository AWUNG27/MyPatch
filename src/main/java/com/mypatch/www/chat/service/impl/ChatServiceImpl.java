package com.mypatch.www.chat.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mypatch.www.chat.domain.ChatAttachDTO;
import com.mypatch.www.chat.domain.ChatMessageDTO;
import com.mypatch.www.chat.domain.ChatRoomDTO;
import com.mypatch.www.chat.mapper.ChatMapper;
import com.mypatch.www.chat.service.IChatService;

@Service
public class ChatServiceImpl implements IChatService{
	
	@Autowired
	private ChatMapper mapper;
	
	@Override
	public List<ChatMessageDTO> chatList(String member_id) {
		return mapper.chatList(member_id);
	}

	@Override
	public List<ChatMessageDTO> messageList(int chatRoom_num) {
		return mapper.messageList(chatRoom_num);
	}
	
	@Transactional
	@Override
	public int sendMessage(ChatMessageDTO cmDTO) {
		//message를 DB에 insert
		int result = mapper.chatInsert(cmDTO);
		//발급된 message num값을 select..
		int maxMessageNum = mapper.maxMessageNum(cmDTO.getMessage_sender());
		//메세지 유형이 첨부파일일때
		if (cmDTO.getAttachFile() != null) {
			ChatAttachDTO attachDTO = cmDTO.getAttachFile();
			attachDTO.setChatAttach_roomNum(cmDTO.getChatRoom_num());
			attachDTO.setChatAttach_msgNum(maxMessageNum);
			mapper.insertAttach(attachDTO);
		}
		return result;
	}

	@Override
	public ChatMessageDTO lastMessage(String message_sender) {
		return mapper.lastMessage(message_sender);
	}

}
