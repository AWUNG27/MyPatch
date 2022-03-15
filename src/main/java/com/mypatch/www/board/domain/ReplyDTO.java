package com.mypatch.www.board.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {
	private Integer reply_num;
	private Integer board_num;
	private String member_id;
	private String reply_content;
	private Date reply_date;
}
