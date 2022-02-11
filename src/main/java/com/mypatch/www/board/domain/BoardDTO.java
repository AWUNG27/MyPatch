package com.mypatch.www.board.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {
	private int board_num;
	private String member_id;
	private String board_content;
	private Date board_date;
	
	
}
