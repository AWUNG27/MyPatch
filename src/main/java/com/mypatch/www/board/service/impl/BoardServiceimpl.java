package com.mypatch.www.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.board.domain.ReReplyDTO;
import com.mypatch.www.board.domain.ReplyDTO;
import com.mypatch.www.board.mapper.BoardAttachMapper;
import com.mypatch.www.board.mapper.BoardMapper;
import com.mypatch.www.board.service.IBoardService;
import com.mypatch.www.member.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BoardServiceimpl implements IBoardService {
	
	@Autowired
	private BoardMapper boardMapper;
	
	@Autowired MemberMapper memberMapper;
	
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

	@Override
	public BoardDTO boardRead(int board_num) {
		BoardDTO bDto = boardMapper.boardRead(board_num); // 게시글 상세 정보
		bDto.setMember(memberMapper.selectMe(bDto.getMember_id())); // 게시글 작성자 정보
		
		List<ReplyDTO> replyList = boardMapper.getReplyList(board_num);
		if (!replyList.equals(null)) {
			for (ReplyDTO replyDTO : replyList) { //게시글에 대한 댓글 리스트와 댓글 작성자 정보를 set
				replyDTO.setMember(memberMapper.selectMe(replyDTO.getMember_id()));
				List<ReReplyDTO> rereplyList = boardMapper.getRereplyList(replyDTO.getReply_num());
				log.info("---------------------");
				log.info(rereplyList.toString());
				if (!rereplyList.toString().equals("[null]")) {
					for (ReReplyDTO reReplyDTO : rereplyList) { //대댓글 리스트와 대댓글 작성자 정보를 set
						log.info(replyDTO.getMember_id());
						reReplyDTO.setMember(memberMapper.selectMe(reReplyDTO.getMember_id()));
					}
					replyDTO.setRereplyList(rereplyList);
				}
			}
			bDto.setReplyList(replyList);
		}
		return bDto;
	}
}
