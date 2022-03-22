package com.mypatch.www.member;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mypatch.www.board.domain.BoardAttachDTO;
import com.mypatch.www.board.domain.BoardDTO;
import com.mypatch.www.member.domain.MemberDTO;
import com.mypatch.www.member.mapper.MemberMapper;
import com.mypatch.www.util.DeduplicationUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberControllerkjw {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	
	
	@RequestMapping(value = "/login")
	public void login() {
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signup() {
	}
  
	//프로필 페이지 이동
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public void profile(String member_id, Model model, String cnt) {

		if ("".equals(cnt) || cnt == null) {
			cnt = "0";
		}
		log.info("cnt: " + cnt);
		List<BoardDTO> bList = new ArrayList<BoardDTO>();
		List<BoardAttachDTO> bimgList = new ArrayList<BoardAttachDTO>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		log.info("My page..");
		bList = memberMapper.profileboard(member_id, cnt);
		bimgList = memberMapper.profileimg(member_id, cnt);
		MemberDTO mDto = memberMapper.selectMe(member_id);
		Integer bcnt = memberMapper.profilecnt(member_id);
		int followingCnt = memberMapper.followingCnt(member_id);
		int followerCnt = memberMapper.followerCnt(mDto.getMember_nick());
		bimgList = DeduplicationUtils.deduplication(bimgList, BoardAttachDTO::getBoard_num);

		//날짜 변환
		for (BoardDTO bDto : bList) {
			bDto.setDate(simpleDateFormat.format(bDto.getBoard_date()));
		}
		
		//경로 변환
		for (BoardAttachDTO bAttachDTO : bimgList) {
			String path = bAttachDTO.getBoardattach_path();
			bAttachDTO.setBoardattach_path(path.replaceAll("\\\\", "/"));
		}
		
		//BoardDTO의 bList에 BoardAttachDTO 값을 담기
		for (BoardDTO bDto : bList) {
			List<BoardAttachDTO> query = new ArrayList<BoardAttachDTO>();
			for (BoardAttachDTO bAttachDTO : bimgList) {
				if (bDto.getBoard_num() == bAttachDTO.getBoard_num()) {
					query.add(bAttachDTO);
				}
			}
			bDto.setBList(query);
		}
		for (BoardDTO allList : bList) {
			log.info(allList);
		}
		log.info(bimgList.toString());
		model.addAttribute("bList", bList);
		model.addAttribute("bimgList", bimgList);
		model.addAttribute("bcnt", bcnt);
		model.addAttribute("mDto", mDto);
		model.addAttribute("followingCnt", followingCnt);
		model.addAttribute("followerCnt", followerCnt);
	}
	//내 프로필 스크롤 이벤트
	@ResponseBody
	@RequestMapping(value = "/scroll", method = RequestMethod.GET)
	public Map<String, Object> scroll(String member_id, Model model, String cnt) {
		Map<String, Object> profiledata = new HashMap<>();
		if ("".equals(cnt) || cnt == null) {
			cnt = "0";
		}
		log.info("cnt: " + cnt);
		List<BoardDTO> bList = new ArrayList<BoardDTO>();
		List<BoardAttachDTO> bimgList = new ArrayList<BoardAttachDTO>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		bList = memberMapper.profileboard(member_id, cnt);
		bimgList = memberMapper.profileimg(member_id, cnt);
		bimgList = DeduplicationUtils.deduplication(bimgList, BoardAttachDTO::getBoard_num);
		//날짜 변환
		for (BoardDTO bDto : bList) {
			bDto.setDate(simpleDateFormat.format(bDto.getBoard_date()));
		}
		
		//경로 변환
		for (BoardAttachDTO bAttachDTO : bimgList) {
			String path = bAttachDTO.getBoardattach_path();
			bAttachDTO.setBoardattach_path(path.replaceAll("\\\\", "/"));
		}
		
		//BoardDTO의 bList에 BoardAttachDTO 값을 담기
		for (BoardDTO bDto : bList) {
			List<BoardAttachDTO> query = new ArrayList<BoardAttachDTO>();
			for (BoardAttachDTO bAttachDTO : bimgList) {
				if (bDto.getBoard_num() == bAttachDTO.getBoard_num()) {
					query.add(bAttachDTO);
				}
			}
			bDto.setBList(query);
		}
		profiledata.put("bList", bList);
		profiledata.put("bimgList", bimgList);
		
		return profiledata;
	}
	
}
