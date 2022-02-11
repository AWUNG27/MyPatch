package com.mypatch.www.board.domain;

import lombok.Data;

@Data
public class LikeDTO {
	
	private Integer board_num;
	private String member_id;
	private char like_cnt;

}
