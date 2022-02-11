package com.mypatch.www.member.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MemberDTO {
	private String member_id;
	private String member_name;
	private String member_pwd;
	private String member_birth;
	private char member_alarm;
	private String member_nick;
	private List<AuthDTO> authList;
}
