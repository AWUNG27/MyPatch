package com.mypatch.www.board.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

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
	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
		
	}
	
	@GetMapping("/read")
	public String board_read() {
		return null;
	}
	
	@GetMapping("/like")
	public String like() {
		return null;
	}
	
	// 페이지 특성상 ajax비동기 통신으로 첨부파일 처리하기로 함
	@PostMapping(value = "/fileUpload", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public void uploadFile(MultipartFile[] uploadFile) {
		
		log.info("fileUpload ajax POST--------------------");
		
		String uploadFolder = "/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload/board";
		
		// 첨부파일 폴더생성
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("BoardController upload path : " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// 업로드 폴더 형식은 yyyy/MM/dd(년/월/일)
		
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------------");
			
			log.info("Upload FIle Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
			log.info("only file name : " + uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			log.info("BoardController uploadFile uuid + uploadFileName : " + uploadFileName); // 확인용이라 나중에 지워도 상관없음
			
			// File saveFile = new File(uploadFolder, uploadFileName); 테스트용 업로드 폴더
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				
				multipartFile.transferTo(saveFile);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
		}
	}
	
	
	
}
