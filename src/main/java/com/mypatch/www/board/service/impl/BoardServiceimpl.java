package com.mypatch.www.board.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.board.mapper.BoardAttachMapper;
import com.mypatch.www.board.mapper.BoardMapper;
import com.mypatch.www.board.service.IBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BoardServiceimpl implements IBoardService {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired
	private BoardAttachMapper boardAttachMapper;
	
	@Override
	public void register(BoardDTO bDto) throws Exception {
		log.info("BoardServiceImpl 접근확인-------------------------");
		log.info("BoardDTO bDto : " + bDto);
		
		boardMapper.register(bDto);
		
		if(bDto.getBList() == null || bDto.getBList().size() <= 0) {
			return;
		}
		
		bDto.getBList().forEach(attach -> {
			attach.setBoard_num(bDto.getBoard_num());
			boardAttachMapper.insertAttach(attach);
		});
		
	}
}
