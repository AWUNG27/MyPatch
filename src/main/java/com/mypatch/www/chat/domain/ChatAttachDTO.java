package com.mypatch.www.chat.domain;

import lombok.Data;

@Data
public class ChatAttachDTO {
	private String chatAttach_uuid;
	private int chatAttach_roomNum;
	private int chatAttach_msgNum;
	private String chatAttach_fileName;
	private String chatAttach_path;
	private String chatAttach_fileType;
}
