<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	.readMessage {
		display:inline-flex; 
		border-radius:50%; 
		background-color:#2478FF; 
		width:10px; 
		height:10px; 
		vertical-align:middle; 
		margin-bottom: 5px;
	}
	
	.incoming_msg_img {
		margin:0 auto; 
		width:40px; 
		height:40px; 
		border-radius: 70%; 
		overflow: hidden;
	}
	
	video {
		width: 200px;
	}
	
	#message_content {
		width: 85%;
		resize: none;
		border: none;
	}

	.msg_attach_btn{
		background: #05728f none repeat scroll 0 0;
	    border: medium none;
	    border-radius: 50%;
	    color: #fff;
	    cursor: pointer;
	    font-size: 17px;
	    height: 33px;
	    position: absolute;
	    right: 40px;
	    top: 11px;
	    width: 33px;
	}
	img {
		width: 100%; 
		height: 100%; 
		object-fit: cover;
	}
	.modal_ul li {
		margin: 5px 0 5px 0;
	}
	.modal_ul li:hover	{
		background-color: #2478FF;
		color: white;
		cursor: pointer;
	}
	.searchMember {
		margin-top : 10px;
		padding-left : 10px;
	}
</style>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet" href="/resources/css/chat.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">
<div class="container" style="margin-top: 90px;">
<div class="messaging">
      <div class="inbox_msg">
        <div class="inbox_people" id="inbox_people">
          <div class="headind_srch">
            <div class="recent_heading">
              <h4>Direct Message</h4>
            </div>
          </div>
          <div class="inbox_chat" id="inbox_chat">
          	<c:forEach items="${chatList}" var="chatList">
	            <div class="chat_list active_chat" id="chatDiv">
	              <input type="hidden" id="chatRoomNumber" value="${chatList.chatRoom_num}">
	              <input type="hidden" id="message_receiver" value="${chatList.member.member_id}">
	              <input type="hidden" id="member_nick" value="${chatList.member.member_nick}">
	              <div class="chat_people">
	                <div class="chat_img" style="margin:0 auto; width:40px; height:40px; border-radius: 70%; overflow: hidden;">
	                	<c:choose>
	                		<c:when test="${chatList.member.profileDTO eq null}">
			                	<img src="/resources/image/profile.png"> 
	                		</c:when>
	                		<c:otherwise>
	                			<img src="/resources/fileUpload/profile/${chatList.member.profileDTO.profile_uuid}_${chatList.member.profileDTO.profile_fileName}"
	                			style="width: 100%; height: 100%; object-fit: cover;"> 
	                		</c:otherwise>
	                	</c:choose>
	                </div>
	                <div class="chat_ib">
	                  <h5>${chatList.member.member_nick} 님 
	                  	<c:if test="${chatList.message_read eq 'n'.charAt(0)}">
		                  <i class="readMessage">　</i>
	                  	</c:if>
	                  	<span class="chat_date">
	                  		${chatList.message_sendTime}
	                  	</span>
	                  </h5>
	                  <p>${chatList.message_content}</p>
	                </div>
	              </div>
	            </div>
          	</c:forEach>
          </div>
        </div>
        <div class="mesgs" style="padding-top: 10px; vertical-align: middle;">
        	<div class="msg_history" style="text-align: center; padding-top: 220px;">
	        	<h3>내 메세지</h3>
	        	<br>
	        	<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-sm">메세지 보내기</button>
        	</div>
        </div>
      </div>
    </div>
</div>
<!-- 메세지 보내기 모달 window -->
<div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content" style="width:200px; height:auto; max-height: 500px;">
      <input type="text" class="searchMember" placeholder="검색.." style="border: none;">
      <hr>
      <ul class="modal_ul" style="text-align: center; margin: 5px 0 5px 0;">
      	<li>정승현</li>
      	<li>정승현</li>
      	<li>정승현</li>
      	<li>정승현</li>
      	<li>정승현</li>
      	<li>정승현</li>
      </ul>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">
var socket;
var username = "${user.username}";
//인증된 회원에게 웹소켓 세션 생성
var auth = "${user}";
window.onload = function(){
	if (auth != "anonymousUser") {
		var ws = new WebSocket("ws://localhost:9090/loginConfirm");
		socket = ws;
		socket.onopen = function(){
			console.log("socket connected");
		}
		
		//채팅창이 아닌 다른 화면을 보고있을때 감지..
		socket.onmessage = function(){
			$.ajax({
				url: "/chat/chat",
				data: {"member_id": username},
				type: "post",
				success: function(result){
					//채팅창 목록을 초기화시킴
					$("#inbox_chat").empty();
					refreshChatList(result); //채팅방 리스트 출력 함수
				}
			});
		}
	}
}
//Ajax spring security header..
$(document).ready(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
    $(document).ajaxSend(function(e, xhr, options){
    	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
    });
});

//메세지 보내기 modal open
$(".newMsgBtn").on("click",function(){
	$(".modal.fade.bd-example-modal-sm").fadeIn();
});

//DM목록 클릭 이벤트 등록
$(document).on("click", ".chat_list.active_chat", function(){ 
	var roomNum = $(this).children("#chatRoomNumber").val();
	var receiver = $(this).children("#message_receiver").val();
	var nick = $(this).children("#member_nick").val();
	requestMessageHistory(username, roomNum, receiver,nick); //메세지 목록 불러오는 함수 실행
});

//메세지 목록 호출하는 함수
function requestMessageHistory(username,roomNum,receiver,nick){
	$.ajax({
		url: "/chat/messageList",
		data: {"member_id": username,
			   "chatRoom_num":roomNum},
		type: "post",
		success: function(result){
			showMessageResult(result,receiver,nick); //메세지 내역 출력 함수
		}
	});
}

//메세지 내역 출력 함수
function showMessageResult(result,receiver,nick){
	var uploadDiv = $(".mesgs");
	uploadDiv.empty(); //메세지가 들어갈 div태그 비우기
	var str = "";
	str += '<span class="opponent">'+nick+'님</span>';
   	str += '<hr>'
       str += '<div class="msg_history" id="msg_div" style="height: 470px;">';
	$(result).each(function(i,obj){
		if (obj.message_sender == username) { //센더와 리시버로 분기해 메세지 위치를 구분
            str += '<div class="outgoing_msg">';
            str += '<div class="sent_msg">';
            if (obj.attachFile != null) { //메세지 내용이 첨부파일일때 분기문
				if (obj.attachFile.chatAttach_fileType == "v") { //첨부파일이 비디오인지 이미지인지 분기
					str += "<video src='/resources/fileUpload/chat/"+obj.attachFile.chatAttach_path+"/"+obj.attachFile.chatAttach_uuid+"_"+obj.attachFile.chatAttach_fileName+"' autoplay loop muted/>";
				} else {
					str += "<img style='width:200px;' src='/resources/fileUpload/chat/"+obj.attachFile.chatAttach_path+"/"+obj.attachFile.chatAttach_uuid+"_"+obj.attachFile.chatAttach_fileName+"'>";
				}
			} else {
	            str += '<p>'+obj.message_content+'</p>';				
			}
            str += '<span class="time_date">'+obj.message_sendTime+'</span> </div>';
            str += '</div>';
		} else if (obj.message_receiver == username){
            str += '<div class="incoming_msg">';
            if (obj.member.profileDTO == null) { //상대방의 프로필사진이 있는지 분기	
	            str += '<div class="incoming_msg_img"> <img src="/resources/image/profile.png"> </div>';
			} else {
				str += '<div class="incoming_msg_img"> <img src="/resources/fileUpload/profile/'+obj.member.profileDTO.profile_uuid+'_'+obj.member.profileDTO.profile_fileName+'"> </div>';
			}
            str += '<div class="received_msg">';
            str += '<div class="received_withd_msg">';
            if (obj.attachFile != null) {
				if (obj.attachFile.chatAttach_fileType == "v") {
					str += "<video src='/resources/fileUpload/chat/"+obj.attachFile.chatAttach_path+"/"+obj.attachFile.chatAttach_uuid+"_"+obj.attachFile.chatAttach_fileName+"' autoplay loop muted/>";
				} else {
					str += "<img style='width:200px;' src='/resources/fileUpload/chat/"+obj.attachFile.chatAttach_path+"/"+obj.attachFile.chatAttach_uuid+"_"+obj.attachFile.chatAttach_fileName+"' />";
				}
			} else {
	            str += '<p>'+obj.message_content+'</p>';				
			}
            str += '<span class="time_date">'+obj.message_sendTime+'</span></div>';
            str += '<input type="hidden" id="roomNum" name="roomNum" value="'+obj.chatRoom_num+'">';
            str += '</div></div>';
		}
	});
	str += '</div>';
       str += '<div class="type_msg">';
       str += '<div class="input_msg_write">';
       str += '<form method="post" id="messageForm" enctype="multipart/form-data">';
       str += '<input type="file" id="attachFile" name="file" style="display: none;" accept=".jpg, .jpeg, .png, .mp4">';
       str += '<input type="hidden" id="receiver" value="'+receiver+'">'
       str += '<sec:csrfInput/>';
       str += '<textarea onKeyPress="javascript: if (event.keyCode==13) return false;" class="message_content" id="message_content" name="message_content" placeholder="Type a message" maxlength="300"></textarea>';	        
       str += '<button class="msg_attach_btn" type="button"><i class="fa fa-file-image-o" aria-hidden="true"></i></button>&nbsp;';
       str += '<button class="msg_send_btn" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>';
       str += '</form>';
       str += '</div>';
       str += '</div>';
	uploadDiv.append(str);
	//message 목록 최신순 보기를 위한 스크롤 하단 이동
	var scrollDiv = document.getElementById("msg_div");
	scrollDiv.scrollTop = scrollDiv.scrollHeight;
	var thisRoom = $("#roomNum").val();
	//대화창 이용중에 서버에서 메세지를 받았을때 감지..
	socket.onmessage = function(msg) {
		receivedMsg(msg,thisRoom);
		
		$.ajax({
			url: "/chat/chat",
			data: {"member_id": username},
			type: "post",
			success: function(result){
				//채팅창 목록을 초기화시킴
				$("#inbox_chat").empty();
				refreshChatList(result); //채팅방 리스트 출력 함수
			}
		});
		
	}
}

//새로운 메세지를 출력하는 함수
function receivedMsg(msg,thisRoom){
	var data = JSON.parse(msg.data);
	var chatRoom_num = data.chatRoom_num;
	var message_sender = data.message_sender;
	var message_content = data.message_content;
	var message_receiver = data.message_receiver;
	var yourProfile = data.member.profileDTO;
	var messageHistoryDiv = $(".msg_history");
	//내가 보고있는 채팅화면과 다르면 종료
	if (thisRoom != chatRoom_num) {
		return;
	}
	var msgStr = "";
	if (username == message_sender) {
		msgStr += '<div class="outgoing_msg">';
		msgStr += '<div class="sent_msg">';
		if (data.attachFile != null) { //첨부파일이 경로에 저장되는동안 로딩이미지를 먼저 출력
			if (data.attachFile.chatAttach_fileType == "v") {
				msgStr += "<video id='chatVod' src='/resources/image/loading.gif' autoplay loop muted/>";
			} else {
				msgStr += "<img id='chatImg' style='width:200px;' src='/resources/image/loading.gif' />";
			}
		} else {
			msgStr += '<p>'+message_content+'</p>';				
		}
		msgStr += '</div>';				
		msgStr += '</div>';
	} else if (username == message_receiver){
		msgStr += '<div class="incoming_msg">';
		if (yourProfile == null) {
			msgStr += '<div class="incoming_msg_img"> <img src="/resources/image/profile.png"> </div>';
		} else {
			msgStr += '<div class="incoming_msg_img"> <img src="/resources/fileUpload/profile/'+yourProfile.profile_uuid+'_'+yourProfile.profile_fileName+'"> </div>';
		}
		msgStr += '<div class="received_msg">';
		msgStr += '<div class="received_withd_msg">';
		if (data.attachFile != null) {
			if (data.attachFile.chatAttach_fileType == "v") {
				msgStr += "<video id='chatImg' src='/resources/image/loading.gif' autoplay loop muted/>";
			} else {
				msgStr += "<img id='chatImg' style='width:200px;' src='/resources/image/loading.gif'/>";
			}
		} else {
			msgStr += '<p>'+message_content+'</p>';				
		}
		msgStr += '</div>';
		msgStr += '</div></div><br>';
	}
	messageHistoryDiv.append(msgStr);
	
	if (data.attachFile != null) { //이미지를 원래 첨부파일로 변경
		var thisFile = data.attachFile.chatAttach_path+"/"+data.attachFile.chatAttach_uuid+"_"+data.attachFile.chatAttach_fileName;
		setTimeout(function() {
			if (data.attachFile.chatAttach_fileType == "i") {
				$("#chatImg").attr("src","/resources/fileUpload/chat/"+thisFile);				
			} else if (data.attachFile.chatAttach_fileType == "v"){
				$("#chatVod").attr("src","/resources/fileUpload/chat/"+thisFile);
			}
		}, 5000);
	}
	//스크롤바 최하단으로 이동
	var scrollDiv = document.getElementById("msg_div");
	scrollDiv.scrollTop = scrollDiv.scrollHeight;
	
}

//새로운 메세지가 발생했을 때 채팅방 목록을 새로고침..
function refreshChatList(data){
	var refreshDiv = $("#inbox_chat");
	var str = "";
	$(data).each(function(i,obj){
		str += '<div class="chat_list active_chat" id="chatDiv">';
        str += '<input type="hidden" id="chatRoomNumber" value="'+obj.chatRoom_num+'">';
       	str += '<input type="hidden" id="message_receiver" value="'+obj.member.member_id+'">';
        str += '<input type="hidden" id="member_nick" value="'+obj.member.member_nick+'">';
        str += '<div class="chat_people">';
        str += '<div class="chat_img" style="margin:0 auto; width:40px; height:40px; border-radius: 70%; overflow: hidden;">';
        if (obj.member.profileDTO == null) {
			str += '<img src="/resources/image/profile.png">';
		} else {
			str += '<img style="width: 100%; height: 100%; object-fit: cover;" src="/resources/fileUpload/profile/'+obj.member.profileDTO.profile_uuid+'_'+obj.member.profileDTO.profile_fileName+'">';
		}
		str += '</div>';
		str += '<div class="chat_ib">';
        str += '<h5>'+obj.member.member_nick+' 님';
        if (obj.message_read == 'n') {
			str += '<i class="readMessage">　</i>';
		}
		str += '<span class="chat_date">'+obj.message_sendTime+'</span></h5>';
        str += '<p>'+obj.message_content+'</p>';
        str += '</div></div></div>';
	});
	refreshDiv.append(str);
}

//textarea 엔터키 event 등록.. 
$(document).on("keypress","#message_content",function(e){
	//shift + enter는 개행으로 처리
	if(e.which === 13 && !e.shiftKey) {
		//클릭 이벤트 발생시키기
		$(".msg_send_btn").click();
	}
});
//send 버튼 click 이벤트
$(document).on("click",".msg_send_btn",function(){
	var messageContent = $("#message_content").val();
	//json데이터로 socket handler에 전송..
	var jsonObj = new Object();
	jsonObj.chatRoom_num = $("#roomNum").val();
	jsonObj.message_sender = username;
	jsonObj.message_content = messageContent;
	jsonObj.message_receiver = $("#receiver").val();
	//입력된 글자가 공백만 있거나 개행만 있는지 확인
	if (!messageContent.replace(/\s/g, "").length) {
		$("#message_content").val("");
	}else {
		if (messageContent != "" && messageContent.length > 0) {
			socket.send(JSON.stringify(jsonObj));
			$("#message_content").val("");
		}
	}
});

//파일첨부 버튼 클릭이벤트
$(document).on("click",".msg_attach_btn",function(){
	$("#attachFile").click();
});

//파일을 첨부하면 controller와 websocket handler로 전송
$(document).on("change","#attachFile",function(){
	var chatRoom_num = $("#roomNum").val();
	var message_receiver = $("#receiver").val();
	var form = $('#messageForm')[0];
	var formData = new FormData(form);
	formData.append("message_receiver", message_receiver);
	formData.append("message_sender", username);
	formData.append("chatRoom_num", chatRoom_num);
	
	var jsonObj = new Object();
	jsonObj.chatRoom_num = chatRoom_num;
	jsonObj.message_sender = username;
	jsonObj.message_receiver = message_receiver;
	//ajax로 이미지는 따로 전송..
	$.ajax({
		url:"/attachSend",
		data: formData,
		cache: false,
		processData: false,
		contentType: false,
		type: "POST",
		success: function(result){
			//성공시 소켓에 메세지 전송
			socket.send(JSON.stringify(jsonObj));
		}, error: function(){
			alert("system error");
		}
	});
});
	
	
</script>
</html>