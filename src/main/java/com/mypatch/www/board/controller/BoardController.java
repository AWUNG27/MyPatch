package com.mypatch.www.board.controller;

import java.io.File;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
public class BoardController {
	
	private String uploadPath = "/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload";
	
	@GetMapping("/read")
	public String board_read() {
		return null;
	}
	
	@GetMapping("/like")
	public String like() {
		return null;
	}
	
	
	@PostMapping(value = "/fileUpload", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public void uploadFile(MultipartFile[] uploadFile) {
		
		log.info("fileUpload ajax POST--------------------");
		
		String uploadFolder = "/Users/ung/Documents/test";
		
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------------");
			
			log.info("Upload FIle Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
			log.info("only file name : " + uploadFileName);
			
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				
				multipartFile.transferTo(saveFile);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
		}
	}
	
	
	
}
