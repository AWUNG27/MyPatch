<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/css/profile.css">
<style>
video{
width: 300px;
height: 300px;
}
.thumbnail img{
width: 300px;
width: 300px;
}
.glyphicon { margin-right:5px; }
.thumbnail
{
    margin-bottom: 20px;
    padding: 0px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
}

.item.list-group-item
{
    float: none;
    width: 100%;
    background-color: #fff;
    margin-bottom: 10px;
}
.item.list-group-item:nth-of-type(odd):hover,.item.list-group-item:hover
{
    background: #428bca;
}

.item.list-group-item .list-group-image
{
    margin-right: 10px;
}
.item.list-group-item .thumbnail
{
    margin-bottom: 0px;
}
.item.list-group-item .caption
{
    padding: 9px 9px 0px 9px;
}
.item.list-group-item:nth-of-type(odd)
{
    background: #eeeeee;
}

.item.list-group-item:before, .item.list-group-item:after
{
    display: table;
    content: " ";
}

.item.list-group-item img
{
    float: left;
}
.item.list-group-item:after
{
    clear: both;
}
.list-group-item-text
{
    margin: 0 0 11px;
}

.modal-title{
	font-size: 17px;
	text-align:left;
	font-weight: bold;
}
.modal_table{
	width:100%;
}
#modal_userImg{
	width:50px;
	height:50px;
	border-radius: 75%;
}
#modal_userId{
	width:200px;
	padding-bottom: 50px;
}
#modal_userFollow{
	margin:10px;
	text-align: right;
}
#modal_followingImg{
	width:20px;
	height:20px;
}
.modal-xl{
height: 650px;
}
.carousel-control-next-icon, .carousel-control-prev-icon{
background-color: black;
}
.modal-body{
padding: 0px;
}
.col{
padding: 0px;
}
#modal-contents{
margin-bottom: 0px;
width: 100%; 
}
</style>

    <div id="main_container">
        <section class="b_inner">
            <div class="hori_cont">
                <div class="profile_wrap">
                    <div class="profile_img" style="margin:0 auto; width:150px; height:150px; border-radius: 70%; overflow: hidden;">
                    	<c:choose>
	                    	<c:when test="${empty mDto.profileDTO}">
		                        <img src="/resources/image/profile.png" style="width: 100%; height: 100%; object-fit: cover;">
	                    	</c:when>
	                    	<c:otherwise>
		                        <img src="/resources/fileUpload/profile/${mDto.profileDTO.profile_uuid}_${mDto.profileDTO.profile_fileName}" style="width: 100%; height: 100%; object-fit: cover;">
	                    	</c:otherwise>
                    	</c:choose>
                    </div>
                </div>
                <div class="detail">
                    <div class="top">
                        <div class="user_name">${mDto.member_nick}</div>

                        <a href="/member/modifyProfile?member_id=${user.username}" class="profile_edit" style="font-size: 15px;">프로필편집</a>

                        <a href="#" class="logout">로그아웃</a>
                    </div>

                    <ul class="middle">

                        <li><span class="showModal">게시물</span>${bcnt}</li>
                        <li><div class="follower" data-toggle="modal" data-target="#followModal" style="cursor: pointer;"><span>팔로워</span>${followerCnt}</div></li>
                        <li><div class="following" data-toggle="modal" data-target="#followModal" style="cursor: pointer;"><span>팔로잉</span>${followingCnt}</div></li>

                    </ul>
					          	
					      <!-- Modal -->
							<div class="modal fade" id="followModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" role="dialog">
							  <div class="modal-dialog modal-dialog-scrollable">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							        <table class="modal_table">
							        	
					          		</table>
							      </div>
							    </div>
							  </div>
							</div>

						<!-- modal end -->
					    </div>
					</div>
          
			<div class="container">
				<input type="hidden" value="${bcnt}" id="allcnt">
				<div class="well well-sm">
			        <strong>Display</strong>
			        <div class="btn-group">
			            <a href="#" id="list" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-th-list">
			            </span>List</a> <a href="#" id="grid" class="btn btn-default btn-sm"><span
			                class="glyphicon glyphicon-th"></span>Grid</a>
			        </div>
				</div>
				<div id="products" class="row list-group flex-row">
						<c:if test="${empty bimgList}">
							<img src="/resources/image/profile_default.png">
						</c:if>
					<c:forEach items="${bimgList}" var="bimgList">
				        <div class="item col-xs-4 col-lg-6 col-xl-4">
				            <div class="thumbnail">
				            	<input type="hidden" id="board_num" value="${bimgList.board_num}">
				            	<c:choose>
				            		<c:when test="${bimgList.boardattach_type eq 'V'}">
					                    <video src="/resources/cropFileUpload/board/${bimgList.boardattach_path}/${bimgList.boardattach_uuid}_${bimgList.boardattach_filename}" controls="controls"></video>
				            		</c:when>
				            		<c:when test="${bimgList.boardattach_type eq 'I'}">
										<img class="group list-group-image" src="/resources/cropFileUpload/board/${bimgList.boardattach_path}/${bimgList.boardattach_uuid}_${bimgList.boardattach_filename}"/>
				            		</c:when>
				            	</c:choose>
				            </div>
						</div>
				    </c:forEach>
			    </div>
			</div>
        </section>
	</div>
	<!-- Button trigger modal -->
<button type="button" id="modalOpen" data-bs-toggle="modal" data-bs-target="#exampleModal" style="display: none;">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">글 상세페이지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container">
					<div class="row">
						<div class="col">
							<div id="carouselExampleControls" class="carousel slide sticky-top" data-bs-ride="carousel">
								<div class="carousel-inner">
									<div class="carousel-item active">
										<img src="/resources/fileUpload/board/2022/02/17/10_곰돌이4.jpg" class="d-block w-100" alt="...">
									</div>
									<div class="carousel-item">
										<img src="/resources/fileUpload/board/2022/02/17/11_곰돌이5.jpg" class="d-block w-100" alt="...">
									</div>
									<div class="carousel-item">
										<img src="/resources/fileUpload/board/2022/02/17/12_곰돌이6.jpg" class="d-block w-100" alt="...">
									</div>
								</div>
								<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
									<span class="carousel-control-prev-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Previous</span>
								</button>
								<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
									<span class="carousel-control-next-icon" aria-hidden="true"></span>
									<span class="visually-hidden">Next</span>
								</button>
							</div>
						</div>
						<div class="col">
							<article class="contents" id="modal-contents">
								<header class="top sticky-top">
			                        <div class="user_container">
			                            <div class="profile_img">
			                                <img src="/resources/image/profile.png" alt="프로필사진">
			                            </div>
			                            <div class="user_name">
			                                <div class="nick_name m_text">글닉네임</div>
			                            </div>
			                        </div>
			                    </header>
			                    <div style="overflow-y:auto; overflow-x:hidden; width:100%; height: 400px;">
									글 내용...
			                    </div>
			                    <div class="sticky-bottom">
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
			                    	<div class="comment_field" id="add-comment-post37">
				                        <input type="text" placeholder="댓글달기..." name="reply_content" maxlength="200">
				                        <div class="upload_btn m_text" data-name="comment">게시</div>
				                    </div>
			                    </div>
							</article>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script>


//게시물 클릭이벤트 감지
$(document).on("click",".thumbnail",function(){
	var boardNum = $(this).children("#board_num").val();
	//게시글 상세 및 댓글목록을 가져오기 위한 Ajax..
	$.ajax({
		type : 'post',
		url : '/board/read',
		data : {"board_num" : boardNum},
		success : function(data){
			console.log(data);
			console.log(data.blist);
		},error: function(){
			alert("System error..!!");
		}
		});
	//글 상세 목록이 세팅이 되면 modal open..
	$("#modalOpen").click();
});

$(document).ready(function() {

	//Ajax spring security header..
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
    $(document).ajaxSend(function(e, xhr, options){
    	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
    });
    
    $('#list').click(function(event){event.preventDefault();$('#products .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();$('#products .item').removeClass('list-group-item');$('#products .item').addClass('grid-group-item');});

	$(document).on('mouseenter','video',function(){
		$(this).get(0).play();
	});
	$(document).on('mouseleave','video',function(){
		$(this).get(0).pause();
	});
});

  $(function() {
    var cnt = 0;
    $(window).scroll(function(event) {
        var scrolltop = parseInt ( $(window).scrollTop() );
        if( scrolltop >= $(document).height() - $(window).height() - 5 ){
        	cnt++;
			var pageall = Number(cnt*6 + 6);
			var allcnt = Number($("#allcnt").val());
			if (Number(pageall) > Number(allcnt) + 6) {
		    	event.preventDefault();
		    	event.stopPropagation();
		    	return false;
			} else {
	        	$.ajax({
	        		type : 'get',
	        		url : '/member/scroll?member_id=${user.username}',
	        		dataType : 'json',
	        		data : {
	        			"cnt" : cnt
	        		},
	        		success : function(data) {
						var result = "";
						console.log(data);
						if (data != "") {
							$(data.bimgList).each(
								function() {
								var str = "";
								var str1 = "";
								var str2 = "";
								var str3 = "";
								str +=	"<div class='item col-xs-4 col-lg-6 col-xl-4'>"
									+	"<div class='thumbnail'>";
								str += "<input type='hidden' id='board_num' value='"+this.board_num+"'>"
									if (this.boardattach_type == 'V') {
										str1 += "<video src='/resources/fileUpload/board/" + this.boardattach_path + "/"
											 +	this.boardattach_uuid + "_" + this.boardattach_filename + "'" + "controls='controls'/>";
									} else if (this.boardattach_type == 'I') {
										str2 +=	"<img class='group list-group-image'" + "src='/resources/cropFileUpload/board/"
											 +	this.boardattach_path + "/" + this.boardattach_uuid + "_" + this.boardattach_filename + "'/>";
									}
								str3 +=	"</div>"
									 +	"</div>";
								result += str + str1 + str2 + str3;
							});
							$("#products").append(result);
							console.log("result: " + result);
						}
	        		}
	        	});
	        	return true;
			}
        }
    });
    
    <%-- 팔로워 클릭 --%>
    $('.follower').on('click', function(){
    	
    	var user = "${mDto.member_nick}";
    	console.log("내 닉네임" + user);
    	 
	    $.ajax({
	    	url:"/member/follower",
	    	data:{"member_nick":user},
	    	type:"get",
	    	success:function(result) {
	    		$('.modal-title').text("팔로워"); // modal의 header부분에 "팔로우" 값 넣기
    			showfollower(result);
	    	}
	    });
	});
    
    <%-- 팔로잉 클릭 --%>
    $('.following').on('click', function(){
	    
	    var user = "${user.username}";
	    
	    $.ajax({
	    	url:"/member/following",
	    	data:{"member_id":user},
	    	type:"get",
	    	success:function(result) {
	    		$('.modal-title').text("팔로잉"); // modal의 header부분에 "팔로우" 값 넣기
    			showfollowing(result);
	    	}
	    });
	});
	
    <%-- 팔로워목록 모달 띄우기 --%>
    function showfollower(resultArr) {
    	console.log(resultArr);
    	
    	$(".modal_table").empty();
    	
    	var result = '';
    	
    	$.each(resultArr, function(i, obj) {
    		var followerList1 = '';
			var followerList2 = '';
			var followerList3 = '';
			var followerList4 = '';
			
			followerList1 += "<tr>"
						  + "<td style='width:70px;'>";
						  
			if (obj.profileDTO != "" && obj.profileDTO != null) {
				followerList2 += "<img id='modal_userImg' src='/resources/fileUpload/profile/"
						       + obj.profileDTO.profile_uuid + "_" + obj.profileDTO.profile_fileName + "'>" + "</td>";
			} else {
				followerList3 += "<img id='modal_userImg' src='/resources/image/profile.png'></td>";
			}
			
			followerList4 += '<td id="modal_userID">' + obj.member_nick + '</td>'
						   + '<input type="hidden" id="yourId" value="'+obj.member_nick+'">'
						   + '</tr>';
 		 	  			
 		 	result += followerList1 + followerList2 + followerList3 + followerList4;
 		 	
    	});
    	console.log(result);
		$(".modal_table").append(result);
		
		$('#followModal').modal("show"); // id가 "followModal"인 모달창 열기
    }
    
    <%-- 팔로잉목록 모달 띄우기 --%>
	function showfollowing(resultArr) {
		
		console.log(resultArr);
		
		$(".modal_table").empty();
		
		var result = '';
		
		$.each(resultArr, function(i, obj){	
			var followingList1 = '';
			var followingList2 = '';
			var followingList3 = '';
			var followingList4 = '';
			
			followingList1 += "<tr>"
						   +  "<td style='width:70px;'>";
						   
			if (obj.profileDTO != "" && obj.profileDTO != null) {
				followingList2 += "<img id='modal_userImg' src='/resources/fileUpload/profile/"
						       + obj.profileDTO.profile_uuid + "_" + obj.profileDTO.profile_fileName + "'>" + "</td>";
			} else {
				followingList3 += "<img id='modal_userImg' src='/resources/image/profile.png'></td>";
			}
			
			followingList4 += '<td id="modal_userID">' + obj.member_nick + '</td>'
						   + '<input type="hidden" id="yourId" value="'+obj.member_nick+'">'
			 			   +  '<td id="modal_userFollow"><buttton class="btn btn-outline-primary unfol" id="' + obj.member_nick + '"><img id="modal_followingImg" src="/resources/image/following.png"></button></td>'
 		 	  			   +  '</tr>';
 		 	  			
 		 	result += followingList1 + followingList2 + followingList3 + followingList4;
			
		});
		console.log(result);
		$(".modal_table").append(result);
		
		$('#followModal').modal("show"); // id가 "followModal"인 모달창 열기
	}
	
});
  
	<%-- 팔로잉목록 모달에서 언팔하기 --%>
	$(document).on("click", ".unfol", function() {
		
		var user = "${user.username}";		
		var x = $(this).closest("tr"); //버튼과 가장 가까운 부모 요소 찾기
		var unfollow_nick = x.children("#yourId").val(); //부모 요소의 자식중에 id값이 yourid인 값의 value
		
		console.log(unfollow_nick);
		console.log(x);

		$.ajax({
			url:"/member/unfollow",
	    	data:{"member_nick":unfollow_nick,
	    		  "member_id":user},
	    	type:"get",
	    	success:function(result){
	    		if (result == "success") {
	    			console.log(result);
	    			
 		    		showUnfollowSuccess(unfollow_nick);
				}
	    	}
		});		
	});
		
	<%-- 팔로잉목록 모달에서 언팔한 계정 버튼 변경 --%>
	function showUnfollowSuccess(unfollow_nick){

		var x = $("#" + unfollow_nick).closest("td");
		
		console.log(unfollow_nick);
		$("#" + unfollow_nick).remove();
		
		str = '<buttton class="btn btn-outline-primary fol" id="' + unfollow_nick + '">팔로우</button>';
		x.append(str);
	}
	
	<%-- 팔로잉목록 모달에서 언팔한 계정 다시 팔로우하기 --%>
	$(document).on("click", ".fol", function() {
	
		var user = "${user.username}";		
		var x = $(this).closest("tr"); //버튼과 가장 가까운 부모 요소 찾기
		var follow_nick = x.children("#yourId").val(); //부모 요소의 자식중에 id값이 yourid인 값의 value
		
		console.log(follow_nick);
		console.log(x);
	
		$.ajax({
			url:"/member/follow",
	    	data:{"member_nick":follow_nick,
	    		  "member_id":user},
	    	type:"get",
	    	success:function(result){
	    		if (result == "success") {
	    			console.log(result);
	    			
			    		showfollowSuccess(follow_nick);
				}
	    	}
		});	
	});
	
	<%-- 팔로잉목록 모달에서 다시 팔로우한 계정 버튼 변경 --%>
	function showfollowSuccess(follow_nick){

		var x = $("#" + follow_nick).closest("td");
		
		console.log(follow_nick);
		$("#" + follow_nick).remove();
		
		str = '<buttton class="btn btn-outline-primary unfol" id="' + follow_nick + '"><img id="modal_followingImg" src="/resources/image/following.png"></button>';
		x.append(str);
	}
	
</script>
</html>

