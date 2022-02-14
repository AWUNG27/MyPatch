package com.mypatch.www.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardControllerkjw {

	@RequestMapping(value = "testkjw", method = RequestMethod.GET)
	public void testkjw() {
		log.info("테스트용 jsp 페이지");
	}
}
