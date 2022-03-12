package com.mypatch.www.chat.service;

import java.util.List;

import com.mypatch.www.chat.domain.ChatMessageDTO;
import com.mypatch.www.chat.domain.ChatRoomDTO;
import com.mypatch.www.member.domain.MemberDTO;

public interface IChatService {
	public List<ChatMessageDTO> chatList(String member_id);
	public List<ChatMessageDTO> messageList(int chatRoom_num,String member_id);
	public int sendMessage(ChatMessageDTO cmDTO);
	public ChatMessageDTO lastMessage(String message_sender);
	public List<MemberDTO> searchMemberList(String searchKeyword);
	public String findExistChatRoom(ChatRoomDTO crDTO);
	public int newChatRoom(ChatRoomDTO crDTO);
}
