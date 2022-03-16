<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
video{
width: 612px;
}
</style>
    <section id="main_container">
        <div class="inner">
        	<!-- 본인 팔로워의 게시글 div -->
	            <div class="contents_box">
	            	<input type="hidden" value="${count}" id="allcnt">
            		<c:choose>
            			<c:when test="${empty mList}">
							<article class="contents">
			                    <header class="top">
			                        <div class="user_container">
			                            <div class="profile_img">
			                                <img src="/resources/image/profile.png" alt="프로필사진">
			                            </div>
			                            <div class="user_name">
			                                <div class="nick_name m_text">글닉네임</div>
			                            </div>
			
			                        </div>
			
			                        <div class="sprite_more_icon" data-name="more">
			                            <ul class="toggle_box">
			                               <li><input type="submit" class="follow" value="팔로우" data-name="follow"></li>
			                                <li>수정</li>
			                                <li>삭제</li>
			                            </ul>
			                        </div>
			                    </header>
			
			                    <div class="img_section">
			                        <div class="trans_inner">
			                            <div><img src="/resources/image/main_default.jpg" alt="메인이미지"></div>
			                        </div>
			                    </div>
			
			                    <div class="bottom_icons">
			                        <div class="left_icons">
			                            <div class="heart_btn">
			                                <div class="sprite_heart_icon_outline" name="39" data-name="heartbeat"></div>
			                            </div>
			                            <div class="sprite_bubble_icon"></div>
			                            <div class="sprite_share_icon" data-name="share"></div>
			                        </div>
			                    </div>
			
			                    <div class="likes m_text">
			                        좋아요
			                        <span id="like-count-39">1,234</span>
			                        개
			                    </div>
			
			                    <div class="comment_container">
			                        <div class="comment" id="comment-list-ajax-post37">
			                            <div class="comment-detail">
			                                <div class="nick_name m_text">댓글닉네임</div>
			                                <div>댓글 예시</div>
			                            </div>
			                        </div>
			                    </div>
			
			                    <div class="timer">2022-03-01</div>
			
			                    <div class="comment_field" id="add-comment-post37">
			                        <input type="text" placeholder="댓글달기...">
			                        <div class="upload_btn m_text" data-name="comment">게시</div>
			                    </div>
			                </article>
            			</c:when>
            			<c:otherwise>
				        	<c:forEach var="mList" items="${mList}">
				                <article class="contents">
				                    <header class="top">
				                        <div class="user_container">
				                            <div class="profile_img">
				                            	<c:choose>
				                            		<c:when test="${empty mList.profile_fileName}">
				                            			<img src="/resources/image/profile.png" alt="프로필사진">
				                            		</c:when>
				                            		<c:otherwise>
						                                <img src="resources/fileUpload/profile/${mList.profile_uuid}_${mList.profile_fileName}">
				                            		</c:otherwise>
				                            	</c:choose>
				                            </div>
				                            <div class="user_name">
				                                <div class="nick_name m_text">${mList.member_nick}</div>
				                            </div>
				                        </div>
										<div class="sprite_more_icon" data-name="more">
				                            <ul class="toggle_box">
				                               <li><input type="submit" class="follow" value="팔로우" data-name="follow"></li>
				                                <li>수정</li>
				                                <li>삭제</li>
				                            </ul>
			                        	</div>
				                    </header>
				                    <div class="img_section">
				                        <div class="trans_inner">
				                        	<div>
					                        	<c:choose>
								            		<c:when test="${mList.boardattach_type eq 'V'}">
									                    <video src="/resources/fileUpload/board/${mList.boardattach_path}/${mList.boardattach_uuid}_${mList.boardattach_filename}" controls="controls"></video>
								            		</c:when>
								            		<c:when test="${mList.boardattach_type eq 'I'}">
														<img src="/resources/fileUpload/board/${mList.boardattach_path}/${mList.boardattach_uuid}_${mList.boardattach_filename}"/>
								            		</c:when>
							            		</c:choose>
						            		</div>
				                        </div>
				                    </div>
									<div class="bottom_icons">
				                        <div class="left_icons">
				                            <div class="heart_btn">
				                            	<c:choose>
				                            		<c:when test="${mList.like_cnt eq 'Y'}">
				                            			<div class="sprite_redheart_icon_outline" name="39" data-name="heartbeat">
				                            				<input type="hidden" value="${mList.board_num}" id="board_num">
				                            				<input type="hidden" value="${mList.cnt}" id="like_count">
				                            			</div>
				                            		</c:when>
				                            		<c:otherwise>
						                                <div class="sprite_heart_icon_outline" name="39" data-name="heartbeat">
				                            				<input type="hidden" value="${mList.board_num}" id="board_num">
				                            				<input type="hidden" value="${mList.cnt}" id="like_count">
						                                </div>
				                            		</c:otherwise>
				                            	</c:choose>
				                            </div>
				                            <div class="sprite_bubble_icon"></div>
				                            <div class="sprite_share_icon" data-name="share"></div>
				                        </div>
				                    </div>
				                    <div class="likes m_text">
				                    	좋아요
				                    	<span id="like-count-39">
				                    	<c:choose>
				                    		<c:when test="${empty mList.cnt}">0</c:when>
				                    		<c:otherwise>${mList.cnt}</c:otherwise>
				                    	</c:choose>
				                    	</span>
				                    	<span id="bookmark-count-39"></span>
				                    	개
				                    </div>
				                    <div class="comment_container">
				                        <div class="comment" id="comment-list-ajax-post37">
				                            <div class="comment-detail">
				                                <div class="nick_name m_text">${mList.reply_nick}</div>
				                                <div>${mList.reply_content}</div>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="timer">${mList.bdate}</div>
				                    <div class="comment_field" id="add-comment-post37">
				                        <input type="text" placeholder="댓글달기..." name="reply_content" maxlength="200">
				                        <div class="upload_btn m_text" data-name="comment">게시</div>
				                    </div>
				                </article>
				        	</c:forEach>
            			</c:otherwise>
            		</c:choose>
	            </div>
            
            <!-- 팔로우 목록 div -->
            <div class="side_box">
				<!-- 본인 프로필 사진 정보 -->
                <div class="user_profile">
                    <div class="profile_thumb">
                        <img src="/resources/image/profile.png" alt="프로필사진">
                    </div>
                    <div class="detail">
                        <div class="id m_text">내닉네임</div>
                        <div class="ko_name">내이름</div>
                    </div>
                </div>
                
				<!-- 추천 팔로우 목록 -->
                <article class="recommend">
                    <header class="reco_header">
                        <div>회원님을 위한 추천</div>
                        <div class="more">모두 보기</div>
                    </header>

                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="/resources/image/profile.png" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">추천 팔로우 닉네임</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="/resources/image/profile.png" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">추천 팔로우 닉네임</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="/resources/image/profile.png" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">추천 팔로우 닉네임</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="/resources/image/profile.png" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">추천 팔로우 닉네임</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="/resources/image/profile.png" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">추천 팔로우 닉네임</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                </article>
            </div>
            
        </div>
    </section>


</body>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
$(function() {
var anonymous = $("#anonymous").val();
var member_id = $("#auth").val();
	$(document).on('click','.upload_btn',function(){
		var reply_content = $(this).parent().children().val();
		var board_num = $(this).parents("article").find("input[id=board_num]").val();
		if (reply_content == "" || reply_content == null) {
			alert("댓글 내용을 입력해주세요.");
			$(this).parent().children().focus();
		} else {
			$(this).parent().children().val("");
			$.ajax({
				type : 'get',
				url : '/mainreply',
				datatype : 'json',
				data : {
					"reply_content" : reply_content,
					"member_id" : member_id,
					"board_num" : board_num
				},
				success : function(data) {
					if (data.result == "1") {
						alert("댓글 작성에 성공했습니다");
					}
				}
			});
		}
	});
});

$(function() {
	var anonymous = $("#anonymous").val();
	var member_id = $("#auth").val();
	$(document).on('mouseenter','video',function(){
		$(this).get(0).play();
	});
	$(document).on('mouseleave','video',function(){
		$(this).get(0).pause();
	});
	if (member_id != "" && member_id != null) {
		$(document).on("click", ".sprite_heart_icon_outline", function() {
			var board_num = $(this).find("input[id=board_num]").val();
			var like_count = $(this).parents("article").find("span[id=like-count-39]").html();
			like_count = Number(like_count) + 1;
			$(this).parents("article").find("span[id=like-count-39]").html(like_count);
			$(this).attr("class", "sprite_redheart_icon_outline");
	 		$.ajax({
				type : 'get',
				url : '/mylike',
				datatype : 'json',
				data : {
					"board_num" : board_num,
					"member_id" : member_id
				},
				success : function () {
				}
			});
		});
		$(document).on("click", ".sprite_redheart_icon_outline", function() {
			var board_num = $(this).find("input[id=board_num]").val();
			var like_count = $(this).parents("article").find("span[id=like-count-39]").html();
			like_count = Number(like_count) - 1;
			$(this).parents("article").find("span[id=like-count-39]").html(like_count);
			$(this).attr("class", "sprite_heart_icon_outline");
	 		$.ajax({
				type : 'get',
				url : '/mydislike',
				datatype : 'json',
				data : {
					"board_num" : board_num,
					"member_id" : member_id
				},
				success : function () {
				}
			});
		});
	}
});

$(function() {
	var anonymous = $("#anonymous").val();
	var cnt = 0;
	var member_id = $("#auth").val();
	$(window).scroll(function(event) {
        var scrolltop = parseInt ($(window).scrollTop());
        if( scrolltop >= $(document).height() - $(window).height() - 5 ){
        	cnt++;
			var pageall = Number(cnt*6 + 6);
			var allcnt = Number($("#allcnt").val());
			if (Number(pageall) > Number(allcnt) + 6) {
		    	event.preventDefault();
		    	event.stopPropagation();
		    	return false;
			} else if (anonymous == "anonymous") {
		    	event.preventDefault();
		    	event.stopPropagation();
		    	return false;
			} else {
	        	$.ajax({
	        		type : 'get',
	        		url : '/mainscroll',
	        		dataType : 'json',
	        		data : {
	        			"cnt" : cnt,
	        			"member_id" : member_id
	        		},
	        		success : function(data) {
						var result = "";
						console.log(data);
						if (data != "") {
							$(data.mscroll).each(function() {
								var str  = "";
								var str_1 = "";
								var str_2 = "";
								var str_3 = "";
								var str1 = "";
								var str2 = "";
								var str3 = "";
								var str3_1 = "";
								var str3_2 = "";
								var str3_3 = "";
								var str4 = "";
								var str5 = "";
								var str6 = "";
								var str6_1 = "";
								var str6_2 = "";
								var str6_3 = "";
								str  +=	"<article class='contents'>"
									 +	"<header class='top'>"
									 +	"<div class='user_container'>"
									 +	"<div class='profile_img'>";
								if (this.profile_fileName == "" || this.profile_fileName == null) {
									str_1 += "<img src='/resources/image/profile.png'>";
								} else {
									str_2 += "<img src='/resources/fileUpload/profile/" + this.profile_uuid + "_" + this.profile_fileName + "'>";
								}
								str_3+=	"</div>"
									 +	"<div class='user_name'>"
									 +	"<div class='nick_name m_text'>" + this.member_nick + "</div>"
									 +	"</div>"
									 +	"</div>"
									 +	"<div class='sprite_more_icon' data-name='more'>"
									 +	"<ul class='toggle_box'>"
									 +	"<li><input type='submit' class='follow' value='팔로우' data-name='follow'>" + "</li>"
									 +	"<li>수정</li>"
									 +	"<li>삭제</li>"
									 +	"</ul>"
									 +	"</div>"
									 +	"</header>"
									 +	"<div class='img_section'>"
									 +	"<div class='trans_inner'>"
									 +	"<div>";
								if (this.boardattach_type == "V") {
									str1 +=	"<video src='/resources/fileUpload/board/" + this.boardattach_path + "/"
										 +	this.boardattach_uuid + "_" + this.boardattach_filename + "'" + "controls='controls'/>";
								} else if (this.boardattach_type == "I") {
									str2 +=	"<img src='/resources/fileUpload/board/" + this.boardattach_path + "/"
										 +	this.boardattach_uuid + "_" + this.boardattach_filename + "'/>";
								}
								str3 +=	"</div>"
									 +	"</div>"
									 +	"</div>"
									 +	"<div class='bottom_icons'>"
									 +	"<div class='left_icons'>"
									 +	"<div class='heart_btn'>";
								if (this.like_cnt == "Y") {
									str3_1 += "<div class='sprite_redheart_icon_outline' name='39' data-name='heartbeat'>"
										   +  "<input type='hidden' value='" + this.board_num + "' id='board_num'>"
										   +  "</div>";
								} else {
									str3_2 += "<div class='sprite_heart_icon_outline' name='39' data-name='heartbeat'>"
										   +  "<input type='hidden' value='" + this.board_num + "' id='board_num'>"
										   + "</div>";
								}
								str3_3 += "</div>"
									 +	"<div class='sprite_bubble_icon'>" + "</div>"
									 +	"<div class='sprite_share_icon' data-name='share'>" + "</div>"
									 +	"</div>"
									 +	"</div>"
									 +	"<div class='likes m_text'>"
									 +	"좋아요"
									 +	"<span id='like-count-39'>";
								if (this.cnt == "" || this.cnt == null) {
									str4 +=	"0";
								} else {
									str5 +=	this.cnt;
								}
								str6 +=	"</span>"
									 +	"<span id='bookmark-count-39'>" + "</span>"
									 +	"개"
									 +	"</div>"
									 +	"<div class='comment_container'>"
									 +	"<div class='comment' id='comment-list-ajax-post37'>"
									 +	"<div class='comment-detail'>";
								if (this.reply_nick == "" || this.reply_nick == null) {
									str6_1 += "<div class='nick_name m_text'>" + "</div>"
										   +  "<div>" + "</div>";
								} else {
									str6_2 += "<div class='nick_name m_text'>" + this.reply_nick + "</div>"
										   +  "<div>" + this.reply_content + "</div>";
								}
								str6_3+="</div>"
									 +	"</div>"
									 +	"</div>"
									 +	"<div class='timer'>" + this.bdate + "</div>"
									 +	"<div class='comment_field' id='add-comment-post37'>"
									 +	"<input type='text' placeholder='댓글달기...'>"
									 +	"<div class='upload_btn m_text' data-name='comment'>" + "게시" + "</div>"
									 +	"</div>"
									 +	"</article>"
									 +	"</div>";
									 result += str + str_1 + str_2 + str_3 + str1 + str2 + str3 + str3_1 + str3_2 + str3_3 + str4 + str5 + str6 + str6_1 + str6_2 + str6_3;
							});
							$(".contents_box").append(result);
							console.log("result: " + result);
						}
					}
	        	});
	        	return true;
			}
        }
	});
});
</script>
</html>