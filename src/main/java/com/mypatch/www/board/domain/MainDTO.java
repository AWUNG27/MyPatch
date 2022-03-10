package com.mypatch.www.board.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MainDTO {
	private Integer board_num;
	private String member_id;
	private String member_nick;
	private String board_content;
	private Date board_date;
	private String boardattach_uuid;
	private String boardattach_filename;
	private String boardattach_path;
	private String boardattach_type;
	private Integer cnt;
	private String profile_uuid;
	private String profile_fileName;
	private Integer reply_num;
	private String reply_id;
	private String reply_nick;
	private String reply_content;
	private Date reply_date;
	private String like_cnt;
	
	private String bdate;
	private String rdate;
	
}
