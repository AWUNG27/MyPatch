package com.mypatch.www.chat;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mypatch.www.chat.domain.ChatAttachDTO;
import com.mypatch.www.chat.domain.ChatMessageDTO;
import com.mypatch.www.chat.service.IChatService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChatAttachController {
	
	private static final String CHAT_FILE_PATH = "C:\\Users\\82104\\git\\MyPatch\\src\\main\\webapp\\resources\\fileUpload\\chat";
	
	@Autowired
	private IChatService service;
	
	private String getFolder() { // 해당 날짜 파일경로 취득
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	@PostMapping(value = "/attachSend", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Integer> attachSend(ChatMessageDTO cmDTO, MultipartFile file) {
		log.info("Direct message attach file send");
		String uploadFolderPath = getFolder();
		File uploadFolder = new File(CHAT_FILE_PATH, getFolder());
		//날짜 경로의 이름인 폴더가 없을때 생성
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		//화면에서 넘어온 file을 DTO에 세팅 및 업로드
		ChatAttachDTO chatFile = new ChatAttachDTO();
		String uploadFileName = file.getOriginalFilename();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		chatFile.setChatAttach_fileName(uploadFileName);
		UUID uuid = UUID.randomUUID();
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		try {
			File saveFile = new File(uploadFolder, uploadFileName);
			file.transferTo(saveFile);
			chatFile.setChatAttach_uuid(uuid.toString());
			chatFile.setChatAttach_path(uploadFolderPath);
			//파일 타입 분기문
			if (file.getContentType().equals("video/mp4")) {
				chatFile.setChatAttach_fileType("v");
			} else chatFile.setChatAttach_fileType("i");
			//파일을 경로에 업로드 후에 DB에 insert
			cmDTO.setMessage_content("첨부파일");
			cmDTO.setAttachFile(chatFile);
			int result = service.sendMessage(cmDTO);
			return result > 0 ? 
				new ResponseEntity<Integer>(cmDTO.getChatRoom_num(),HttpStatus.OK) :
				new ResponseEntity<Integer>(result, HttpStatus.INTERNAL_SERVER_ERROR);
			
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
			return new ResponseEntity<Integer>(0,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
