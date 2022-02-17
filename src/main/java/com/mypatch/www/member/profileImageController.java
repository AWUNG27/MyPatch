package com.mypatch.www.member;

import java.io.File;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.mypatch.www.member.domain.ProfileDTO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class profileImageController {

	private static final String UPLOAD_PATH = "C:\\Users\\82104\\git\\MyPatch\\src\\main\\webapp\\resources\\fileUpload\\profile";

	@PostMapping(value = "/uploadProfile", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<ProfileDTO> upload(MultipartFile profile) {
		log.info("file upload--------------");
		
		File uploadFolder = new File(UPLOAD_PATH);
		
		String uploadFileName = profile.getOriginalFilename();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		
		ProfileDTO fileDTO = new ProfileDTO();
		fileDTO.setProfile_fileName(uploadFileName);
		UUID uuid = UUID.randomUUID();

		uploadFileName = uuid.toString() + "_" + uploadFileName;

		try {
			File saveFile = new File(uploadFolder, uploadFileName);
			profile.transferTo(saveFile);
			fileDTO.setProfile_uuid(uuid.toString());
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}
		return new ResponseEntity<ProfileDTO>(fileDTO, HttpStatus.OK);
	}
}
