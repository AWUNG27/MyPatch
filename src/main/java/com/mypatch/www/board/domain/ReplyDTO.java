package com.mypatch.www.board.domain;

import java.util.List;

import com.mypatch.www.member.domain.MemberDTO;

import lombok.Data;

@Data
public class ReplyDTO {
	private Integer reply_num;
	private Integer board_num;
	private String member_id;
	private String reply_content;
	private String reply_date;
	private MemberDTO member;
	private List<ReReplyDTO> rereplyList;
}
