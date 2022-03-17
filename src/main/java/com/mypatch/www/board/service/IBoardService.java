package com.mypatch.www.board.service;

import com.mypatch.www.board.domain.BoardDTO;

public interface IBoardService {
	
	public void register(BoardDTO bDto) throws Exception;
	public BoardDTO boardRead(int board_num);
}
