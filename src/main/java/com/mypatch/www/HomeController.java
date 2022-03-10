package com.mypatch.www;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mypatch.www.board.domain.LikeDTO;
import com.mypatch.www.board.domain.MainDTO;
import com.mypatch.www.board.domain.ReplyDTO;
import com.mypatch.www.board.mapper.BoardMapper;
import com.mypatch.www.util.DeduplicationUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@GetMapping("/")
	public String mainPage(Principal principal, Model model) throws ParseException {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		int cnt = 0;
		Integer count = 0;
		log.info("Welcome JOINUS...");
		List<MainDTO> mList = new ArrayList<>();
		if (principal != null) {
			String member_id = principal.getName();
			log.info(member_id);
			mList = boardMapper.mainread(member_id, 6*(0+cnt)+1, 6*(1+cnt));
			count = boardMapper.maincount(member_id);
		}
		mList.forEach(mDto -> {
			mDto.setBdate(simpleDateFormat.format(mDto.getBoard_date()));
			if (mDto.getReply_date() != null) {
				mDto.setRdate(simpleDateFormat.format(mDto.getReply_date()));
			}
			mDto.setBoardattach_path(mDto.getBoardattach_path().replaceAll("\\\\", "/"));
		});
		mList = DeduplicationUtils.deduplication(mList, MainDTO::getBoard_num);
		DeduplicationUtils.syso(mList);
		model.addAttribute("mList", mList);
		model.addAttribute("count", count);
		return "/main/index";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mainscroll", method = RequestMethod.GET)
	public Map<String, Object> mainscroll(String member_id, Model model, String cnt){
		log.info("member_id: " + member_id + ", cnt: " + cnt);
		Map<String, Object> fwdata = new HashMap<>();
		List<MainDTO> mscroll = new ArrayList<>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		mscroll = boardMapper.mainread(member_id, 6*(0+Integer.parseInt(cnt))+1, 6*(1+Integer.parseInt(cnt)));
		mscroll.forEach(mDto -> {
			mDto.setBdate(simpleDateFormat.format(mDto.getBoard_date()));
			if (mDto.getReply_date() != null) {
				mDto.setRdate(simpleDateFormat.format(mDto.getReply_date()));
			}
			mDto.setBoardattach_path(mDto.getBoardattach_path().replaceAll("\\\\", "/"));
		});
		mscroll = DeduplicationUtils.deduplication(mscroll, MainDTO::getBoard_num);
		DeduplicationUtils.syso(mscroll);
		
		fwdata.put("mscroll", mscroll);
		return fwdata;
	}
	
	@ResponseBody
	@RequestMapping(value = "/mylike", method = RequestMethod.GET)
	public void mylike(LikeDTO likeDTO) {
		log.info("좋아요 누르기");
		log.info("likeDTO: " + likeDTO);
		String like_cnt = boardMapper.searchlike(likeDTO);
		log.info("좋아요 있는지 확인: " + like_cnt);
		if ("N".equals(like_cnt)) {
			log.info(boardMapper.mydislike(likeDTO));
		} else if ("".equals(like_cnt) || like_cnt == null) {
			log.info(boardMapper.insertlike(likeDTO));
		}
	}
	@ResponseBody
	@RequestMapping(value = "/mydislike", method = RequestMethod.GET)
	public void mydislike(LikeDTO likeDTO) {
		log.info("좋아요 없애기");
		log.info("likeDTO: " + likeDTO);
		log.info(boardMapper.mylike(likeDTO));
	}
	
	@ResponseBody
	@RequestMapping(value = "/mainreply", method = RequestMethod.GET)
	public Map<String, Object> mainreply(ReplyDTO replyDTO) {
		Map<String, Object> mainreply = new HashMap<>();
		log.info("replyDTO" + replyDTO);
		Integer result = boardMapper.mainreply(replyDTO);
		log.info(result);
		mainreply.put("result", result);
		return mainreply;
	}
	
}
