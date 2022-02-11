package com.mypatch.www.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {
	
	private String uploadPath = "/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload";
	
	public String board_read() {
		return null;
	}
	
	@GetMapping("/like")
	public String like() {
		return null;
	}
}
