package com.mypatch.www.board.domain;

import com.mypatch.www.member.domain.MemberDTO;

import lombok.Data;

@Data
public class ReReplyDTO {
	
	private int rereply_num;
	private int reply_num;
	private String member_id;
	private String rereply_content;
	private String rereply_date;
	private MemberDTO member;
}
