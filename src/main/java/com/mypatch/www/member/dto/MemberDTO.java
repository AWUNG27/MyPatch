package com.mypatch.www.member.dto;

import lombok.Data;

@Data
public class MemberDTO {

	private String member_id;
	private String member_name;
	private String member_pwd;
	private Integer member_birth;
	private String member_alarm;
	private String member_nick;
}
