package com.mypatch.www.board.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardDTO {
	
	private Integer board_num;
	private String member_id;
	private String board_content;
	private Date board_date;
	
	private List<BoardAttachDTO> bList;
}
