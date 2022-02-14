<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

    <section id="main_container">
        <div class="inner">
        	<!-- 본인 팔로워의 게시글 div -->
            <div class="contents_box">
                <article class="contents">
                    <header class="top">
                        <div class="user_container">
                            <div class="profile_img">
                                <img src="imgs/thumb.jpeg" alt="프로필이미지">
                            </div>
                            <div class="user_name">
                                <div class="nick_name m_text">KindTiger</div>
                            </div>
                        </div>
                    </header>
                    <div class="img_section">
                        <div class="trans_inner">
                            <div><img src="imgs/img_section/img01.jpg" alt="visual01"></div>
                        </div>
                    </div>
                    <div class="likes m_text">좋아요<span id="like-count-39">2,346</span>개</div>
                    <div class="comment_container">
                        <div class="comment" id="comment-list-ajax-post37">
                            <div class="comment-detail">
                                <div class="nick_name m_text">dongdong2</div>
                                <div>강아지가 너무 귀여워요~!</div>
                            </div>
                        </div>
                    </div>
                    <div class="timer">1시간 전</div>
                    <div class="comment_field" id="add-comment-post37">
                        <input type="text" placeholder="댓글달기...">
                        <div class="upload_btn m_text" data-name="comment">게시</div>
                    </div>
                </article>
            </div>
            
            <!-- 팔로우 목록 div -->
            <div class="side_box">
				<!-- 본인 프로필 사진 정보 -->
                <div class="user_profile">
                    <div class="profile_thumb">
                        <img src="imgs/thumb.jpeg" alt="프로필사진">
                    </div>
                    <div class="detail">
                        <div class="id m_text">KindTiger</div>
                        <div class="ko_name">심선범</div>
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
                            <img src="imgs/thumb02.jpg" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">kind_tigerrrr</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="imgs/thumb02.jpg" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">kind_tigerrrr</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="imgs/thumb02.jpg" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">kind_tigerrrr</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="imgs/thumb02.jpg" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">kind_tigerrrr</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                    <div class="thumb_user">
                        <div class="profile_thumb">
                            <img src="imgs/thumb02.jpg" alt="프로필사진">
                        </div>
                        <div class="detail">
                            <div class="id">kind_tigerrrr</div>
                            <div class="time">1시간 전</div>
                        </div>
                    </div>
                </article>
            </div>
            
        </div>
    </section>



</section>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>