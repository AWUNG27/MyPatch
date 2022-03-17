package com.mypatch.www.board.domain;

import java.util.Date;
import java.util.List;

import com.mypatch.www.member.domain.MemberDTO;

import lombok.Data;

@Data
public class BoardDTO {
	
	private Integer board_num;
	private String member_id;
	private String board_content;
	private Date board_date;
	private MemberDTO member;
	
	//날짜 포맷 담기위해
	private String date;
	//글의 파일들 list
	private List<BoardAttachDTO> bList;
	private List<ReplyDTO> replyList;
}
