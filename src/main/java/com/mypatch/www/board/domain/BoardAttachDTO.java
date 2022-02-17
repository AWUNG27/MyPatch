package com.mypatch.www.board.domain;

import lombok.Data;

@Data
public class BoardAttachDTO {
	
	private String boardattach_uuid;
	private Integer board_num;
	private String boardattach_filename;
	private String boardattach_path;
	private String boardattach_type;
	private boolean imageORvideo;
}
