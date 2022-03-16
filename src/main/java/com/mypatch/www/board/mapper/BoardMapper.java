package com.mypatch.www.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.board.domain.LikeDTO;
import com.mypatch.www.board.domain.MainDTO;
import com.mypatch.www.board.domain.ReReplyDTO;
import com.mypatch.www.board.domain.ReplyDTO;

public interface BoardMapper {
	public List<MainDTO> mainread(@Param("member_id")String member_id, @Param("a")int a, @Param("b")int b);
	public Integer maincount(String member_id);
	public Integer mylike(LikeDTO likeDTO);
	public Integer mydislike(LikeDTO likeDTO);
	public String searchlike(LikeDTO likeDTO);
	public Integer insertlike(LikeDTO likeDTO);
	public Integer mainreply(ReplyDTO replyDTO);
	public void register(BoardDTO bDto) throws Exception;
	public BoardDTO boardRead(int board_num);
	public List<ReplyDTO> getReplyList(int board_num);
	public List<ReReplyDTO> getRereplyList(int reply_num);

}
