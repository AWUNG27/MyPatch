package com.mypatch.www;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	@GetMapping("/")
	public String mainPage() {
		log.info("Welcome JOINUS...");
		return "/main/index";
	}
	
}
