package com.mypatch.www.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mypatch.www.board.domain.BoardAttachDTO;
import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.board.service.IBoardService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	private String uploadPath = "/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload/";
	
	@Autowired
	private IBoardService boardService;
	
	// FileSystem 업로드 폴더 생성 메소드
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
		
	}
	
	//게시물 상세 보기
	@PostMapping("/read")
	public ResponseEntity<BoardDTO> board_read(int board_num) {
		log.info("board read...");
		log.info("BoardController board_read board_num : " + board_num);
		
		BoardDTO bDto = boardService.boardRead(board_num);

		if (bDto == null) {
			return new ResponseEntity<BoardDTO>(bDto,HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return new ResponseEntity<BoardDTO>(bDto,HttpStatus.OK);
	}
	
	@GetMapping("/like")
	public String like() {
		return null;
	}
	
	@PostMapping("/regist")
	public String regist(BoardDTO bDto, RedirectAttributes rttr) throws Exception{
		log.info("BoardController regist 접근확인---------------------");
		log.info("BoardDTO bDto : " + bDto.toString());
		
		if(bDto.getBList() != null) {
			
			bDto.getBList().forEach(attach -> log.info(attach));
			
		}
		
		boardService.register(bDto);
		
		return "/";
	}
	
	// 페이지 특성상 ajax비동기 통신으로 첨부파일 처리하기로 함
	@PostMapping(value = "/fileUpload", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> uploadFile(MultipartFile[] uploadFile) {
		
		List<BoardAttachDTO> list = new ArrayList<BoardAttachDTO>();
		log.info("fileUpload ajax POST--------------------");
		log.info("BoardController fileUpload uploadFile : " + uploadFile);
		
		String uploadFolder = "/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload/board";
		
		String uploadFolderPath = getFolder();
		
		// 첨부파일 폴더생성
		File uploadPath = new File(uploadFolder, getFolder());
		
		log.info("BoardController upload path : " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
			
		}
		// 업로드 폴더 형식은 yyyy/MM/dd(년/월/일)
		
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------------");
			
			BoardAttachDTO boardAttachDTO = new BoardAttachDTO();
			
			log.info("Upload FIle Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
			log.info("only file name : " + uploadFileName);
			boardAttachDTO.setBoardattach_filename(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			log.info("BoardController uploadFile uuid + uploadFileName : " + uploadFileName); // 확인용이라 나중에 지워도 상관없음
			
			// File saveFile = new File(uploadFolder, uploadFileName); 테스트용 업로드 폴더
			
			try {
				
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				boardAttachDTO.setBoardattach_uuid(uuid.toString());
				boardAttachDTO.setBoardattach_path(uploadFolderPath);
				log.info("boardAttachDTO setBoardattach_path : " + boardAttachDTO.getBoardattach_path());
				
				if (attachFileTypeCheck(saveFile)) {
					
					boardAttachDTO.setImageORvideo(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 400, 400);
					
					thumbnail.close();
				}
				
				// 리스트 추가
				list.add(boardAttachDTO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/cropFileUpload", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> uploadCropFile(MultipartFile[] uploadFile) throws Exception{
		
		List<BoardAttachDTO> list = new ArrayList<BoardAttachDTO>();
		log.info("cropFileUpload ajax POST--------------------");
		
		log.info("BoardController cropFileUpload uploadFile : " + uploadFile);
		
		String uploadFolder = "/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload/board";
		
		String uploadFolderPath = getFolder();
		
		// 첨부파일 폴더생성
		File uploadPath = new File(uploadFolder, getFolder());
		
		log.info("BoardController cropFile upload path : " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
			
		}
		// 업로드 폴더 형식은 yyyy/MM/dd(년/월/일)
		
		log.info("BoardController uploadFile : " + uploadFile);
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------------");
			
			log.info("BoardController uploadFile MultiPartFile : " + uploadFile.toString());
			
			BoardAttachDTO boardAttachDTO = new BoardAttachDTO();
			
			log.info("Upload CropFile Name : " + multipartFile.getOriginalFilename());
			log.info("Upload CropFile Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/") + 1);
			log.info("only cropFile name : " + uploadFileName);
			boardAttachDTO.setBoardattach_filename(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			log.info("BoardController uploadCropFile uuid + uploadFileName : " + uploadFileName); // 확인용이라 나중에 지워도 상관없음
			
			// File saveFile = new File(uploadFolder, uploadFileName); 테스트용 업로드 폴더
			
			try {
				
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				boardAttachDTO.setBoardattach_uuid(uuid.toString());
				boardAttachDTO.setBoardattach_path(uploadFolderPath);
				log.info("boardAttachDTO setBoardattach_path by Cropped : " + boardAttachDTO.getBoardattach_path());
				
//				if (attachCropFileTypeCheck(saveFile)) {
//					
//				}
				boardAttachDTO.setImageORvideo(true);
				boardAttachDTO.setBoardattach_type("I");
				
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 400, 400);
				
				thumbnail.close();
				
				// 리스트 추가
				list.add(boardAttachDTO);
				log.info("BoardController list : " + list);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		log.info("BoardController getFile fileName : " + fileName);
		
		File file = new File("/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload/board" + "/" + fileName);
		
		log.info("BoardController getFile file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		return result;
	}
	
	@GetMapping("/cropDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> getCropFile(String fileName) {
		
		log.info("BoardController getFile fileName : " + fileName);
		
		File file = new File("/Users/ung/IDE/workspace/mypatch/src/main/webapp/resources/fileUpload/board" + "/" + fileName);
		
		log.info("BoardController getFile file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		return result;
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html;charset=UTF-8");
		
		File file;
		
		try {
			file = new File(uploadPath + "/" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			if (type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName : " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", headers, HttpStatus.OK);
	}
	
	private boolean attachFileTypeCheck(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());
			log.info("FileTypeCheck : " + contentType);
			return contentType.startsWith("image");
					
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	
}
