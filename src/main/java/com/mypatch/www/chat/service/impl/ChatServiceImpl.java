package com.mypatch.www.chat.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mypatch.www.chat.domain.ChatAttachDTO;
import com.mypatch.www.chat.domain.ChatMessageDTO;
import com.mypatch.www.chat.domain.ChatRoomDTO;
import com.mypatch.www.chat.mapper.ChatMapper;
import com.mypatch.www.chat.service.IChatService;
import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.mapper.MemberMapper;

@Service
public class ChatServiceImpl implements IChatService{
	
	@Autowired
	private ChatMapper mapper;
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public List<ChatMessageDTO> chatList(String member_id) {
		return mapper.chatList(member_id);
	}
	
	@Transactional
	@Override
	public List<ChatMessageDTO> messageList(int chatRoom_num, String member_id) {
		//메세지를 받은사람이 확인하면 read 여부를 y로 변경
		Map<String, Object> updateMap = new HashMap<String, Object>();
		updateMap.put("member_id", member_id);
		updateMap.put("chatRoom_num", chatRoom_num);
		mapper.messageRead(updateMap);
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

	@Override
	public List<MemberDTO> searchMemberList(String searchKeyword) {
		return memberMapper.searchMemberList(searchKeyword);
	}

	@Override
	public String findExistChatRoom(ChatRoomDTO crDTO) {
		return mapper.findExistChatRoom(crDTO);
	}

	@Override
	public int newChatRoom(ChatRoomDTO crDTO) {
		return mapper.newChatRoom(crDTO);
	}

}
