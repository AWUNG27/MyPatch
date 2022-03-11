package com.mypatch.www.chat.service;

import java.util.List;

import com.mypatch.www.chat.domain.ChatMessageDTO;

public interface IChatService {
	public List<ChatMessageDTO> chatList(String member_id);
	public List<ChatMessageDTO> messageList(int chatRoom_num);
	public int sendMessage(ChatMessageDTO cmDTO);
	public ChatMessageDTO lastMessage(String message_sender);
}
