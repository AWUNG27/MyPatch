package com.mypatch.www.board.mapper;

import com.mypatch.www.board.domain.BoardDTO;

public interface BoardMapper {
	
	public void register(BoardDTO bDto) throws Exception;
	
}
