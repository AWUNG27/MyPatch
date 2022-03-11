package com.mypatch.www.chat.domain;

import com.mypatch.www.member.domain.MemberDTO;

import lombok.Data;

@Data
public class ChatMessageDTO {
	private int message_num;
	private int chatRoom_num;
	private String message_sender;
	private	String message_receiver;
	private String message_content;
	private String message_sendTime;
	private char message_read;
	private MemberDTO member;
	private ChatAttachDTO attachFile;
}
