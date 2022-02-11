package com.mypatch.www.member.dto;


import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class MemberDTO {

	private String member_id;
	private String member_name;
	private String member_pwd;
	private Date member_birth;
	private char member_alarm;
	private String member_nick;
	private List<AuthDTO> authList;
}
