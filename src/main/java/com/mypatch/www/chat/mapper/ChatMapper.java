package com.mypatch.www.chat.mapper;

import java.util.List;

import com.mypatch.www.chat.domain.ChatAttachDTO;
import com.mypatch.www.chat.domain.ChatMessageDTO;
import com.mypatch.www.chat.domain.ChatRoomDTO;

public interface ChatMapper {
	public List<ChatMessageDTO> chatList(String member_id);
	public List<ChatMessageDTO> messageList(int chatRoom_num);
	public ChatRoomDTO chatUserList(int chatRoom_num);
	public int chatInsert(ChatMessageDTO cmDTO);
	public int maxMessageNum(String message_sender);
	public void insertAttach(ChatAttachDTO caDTO);
	public ChatMessageDTO lastMessage(String message_sender);
}
