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
		height: 40px;
		font-size: 13px;
		text-align: left;
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
	.chat_img {
		margin: 0 auto; 
		width:40px; 
		height:40px; 
		border-radius: 70%; 
		overflow: hidden;
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
	                  <h5>${chatList.member.member_nick} ??? 
	                  	<c:if test="${chatList.message_read eq 'n'.charAt(0)}">
		                  <i class="readMessage">???</i>
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
	        	<h3>??? ?????????</h3>
	        	<br>
	        	<button type="button" id="letsModal" class="btn btn-primary" data-bs-toggle="modal" data-bs-target=".bd-example-modal-sm">????????? ?????????</button>
        	</div>
        </div>
      </div>
    </div>
</div>
<!-- ????????? ????????? ?????? window -->
<div class="modal fade bd-example-modal-sm" id="modalWindow" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content" style="width:300px; height:auto; max-height: 500px;">
      <input type="text" class="searchMember" placeholder="??????.." style="border: none;">
      <hr>
      <ul class="modal_ul" style="text-align: center; margin: 5px 0 5px 0;">
      	<li>
      		<div class="chat_img" style="margin:0 30px 0 70px;">
      			<img src="/resources/image/profile.png">
      		</div>
      		<b>?????????</b>
      		<br>?????????
      	</li>
      </ul>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">
var socket;
var username = "${user.username}";
//????????? ???????????? ????????? ?????? ??????
var auth = "${user}";
window.onload = function(){
	if (auth != "anonymousUser") {
		var ws = new WebSocket("ws://localhost:9090/loginConfirm");
		socket = ws;
		socket.onopen = function(){
			console.log("socket connected");
		}
		
		//???????????? ?????? ?????? ????????? ??????????????? ????????? ????????? ??????
		socket.onmessage = function(){
			$.ajax({
				url: "/chat/chat",
				data: {"member_id": username},
				type: "post",
				success: function(result){
					//????????? ????????? ???????????????
					$("#inbox_chat").empty();
					refreshChatList(result); //????????? ????????? ?????? ??????
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

//????????? ????????? ????????? ???????????? modal open
$(document).ready(function(){
	//????????? ?????? ????????? ?????? Ajax..
	$("#letsModal").on("click",function(){
		$.ajax({
			url: "/chat/chat",
			data: {"member_id": username},
			type: "post",
			success: function(result){
				//li ?????? ????????? ?????? ?????? ??????
				recommendChat(result);
			}
		});
		//????????? open
		$("#modalWindow").fadeIn();

	});
});

//modal window ????????? ?????? Ajax
$(".searchMember").on("keyup",function(){
	var keyword = $(this).val();
	if (keyword.length > 0) {
		$.ajax({
			url: "/chat/search",
			data: {"keyword": keyword},
			type: "post",
			success: function(result){
				recommendChat(result);
			}
		});
	}
});
//??????????????? ???????????? ?????? ????????? ?????? ??????
function recommendChat(result){
	var uploadUl = $(".modal_ul");
	uploadUl.empty();
	var str = "";
	$(result).each(function(i,obj){
		str += "<li class='recommendList' >";
  		str += 	'<div class="chat_img" style="width:40px; margin:0 30px 0 70px;">';
  		if (obj.member.profileDTO != null) {
			str += '<img src="/resources/fileUpload/profile/'+obj.member.profileDTO.profile_uuid+'_'+obj.member.profileDTO.profile_fileName+'">';
		} else {
	  		str +=	 '<img src="/resources/image/profile.png">';			
		}
  		str += 	'</div>';
  		str += '<input type="hidden" id="thisLiId" value="'+obj.member.member_id+'" >'
  		str += '<input type="hidden" id="thisLiNick" value="'+obj.member.member_nick+'" >'
  		str += 	'<b>'+obj.member.member_nick+'</b>';
  		str += 	'<br>'+obj.member.member_name;
  		str += '</li>';
	});
	uploadUl.append(str);
}
//modal???????????? ????????? ????????? ????????? ??????..
$(document).on("click",".recommendList",function(){
	var yourid = $(this).children("#thisLiId").val();
	var yourNick = $(this).children("#thisLiNick").val();
	
	//????????? ??????????????? ??????????????? ????????? ?????? ??????
	$.ajax({
		url: "/chat/selectChatRoom",
		data: {"chatRoom_user": username,
			   "chatRoom_user2": yourid},
		type: "post",
		success: function(data){
			if (data > 0) { //?????? ???????????? ???????????? ????????? ?????? ?????? ?????? ??????
				requestMessageHistory(username,data,yourid,yourNick);
				//????????? ????????? Div class?????? ??????
				$("#modalWindow").removeClass("in");
				$(".modal-backdrop").remove();
				$("#modalWindow").fadeOut();
			}
		}
	});
});

//?????? DM?????? ?????? ????????? ??????
$(document).on("click", ".chat_list.active_chat", function(){ 
	var roomNum = $(this).children("#chatRoomNumber").val();
	var receiver = $(this).children("#message_receiver").val();
	var nick = $(this).children("#member_nick").val();
	requestMessageHistory(username, roomNum, receiver,nick); //????????? ?????? ???????????? ?????? ??????
});

//????????? ?????? ?????? Ajax
function requestMessageHistory(username,roomNum,receiver,nick){
	$.ajax({
		url: "/chat/messageList",
		data: {"member_id": username,
			   "chatRoom_num":roomNum},
		type: "post",
		success: function(result){
			showMessageResult(result,roomNum,receiver,nick); //????????? ?????? ?????? ?????? ??????
		}
	});
}

//????????? ?????? ?????? ??????
function showMessageResult(result,roomNum,receiver,nick){
	var uploadDiv = $(".mesgs");
	uploadDiv.empty(); //???????????? ????????? div?????? ?????????
	var str = "";
	str += '<span class="opponent">'+nick+'???</span>';
   	str += '<hr>'
    str += '<div class="msg_history" id="msg_div" style="height: 470px;">';
   	if (result != null) { //????????? ???????????? ???????????? ??????????????? ????????? ????????? ??????
   		$(result).each(function(i,obj){
   			if (obj.message_sender == username) { //????????? ???????????? ????????? ????????? ????????? ??????
   	            str += '<div class="outgoing_msg">';
   	            str += '<div class="sent_msg">';
   	            if (obj.attachFile != null) { //????????? ????????? ?????????????????? ?????????
   					if (obj.attachFile.chatAttach_fileType == "v") { //??????????????? ??????????????? ??????????????? ??????
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
   	            if (obj.member.profileDTO == null) { //???????????? ?????????????????? ????????? ??????	
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
   	            //str += '<input type="hidden" id="roomNum" name="roomNum" value="'+obj.chatRoom_num+'">';
   	            str += '</div></div>';
   			}
   		});
	}
	
	str += '</div>';
    str += '<div class="type_msg">';
    str += '<div class="input_msg_write">';
    str += '<form method="post" id="messageForm" enctype="multipart/form-data">';
    str += '<input type="hidden" id="roomNum" name="roomNum" value="'+roomNum+'">';
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
	//message ?????? ????????? ????????? ?????? ????????? ?????? ??????
	var scrollDiv = document.getElementById("msg_div");
	scrollDiv.scrollTop = scrollDiv.scrollHeight;
	
	//????????? ???????????? ???????????? ???????????? ???????????? ??????..
	socket.onmessage = function(msg) {
		receivedMsg(msg,roomNum); //?????? ????????? ?????? ?????? ??????
		
		//?????? ????????? ????????? ?????????????????? ?????? Ajax??????
		$.ajax({
			url: "/chat/chat",
			data: {"member_id": username},
			type: "post",
			success: function(result){
				//????????? ????????? ???????????????
				$("#inbox_chat").empty();
				refreshChatList(result); //????????? ????????? ?????? ??????
			}
		});
		
	}
}

//?????? ????????? ?????? ??????
function receivedMsg(msg,thisRoom){
	var data = JSON.parse(msg.data);
	var chatRoom_num = data.chatRoom_num;
	var message_sender = data.message_sender;
	var message_content = data.message_content;
	var message_receiver = data.message_receiver;
	var yourProfile = data.member.profileDTO;
	var messageHistoryDiv = $(".msg_history");
	//?????? ???????????? ??????????????? ????????? ??????
	if (thisRoom != chatRoom_num) {
		return;
	}
	var msgStr = "";
	if (username == message_sender) {
		msgStr += '<div class="outgoing_msg">';
		msgStr += '<div class="sent_msg">';
		if (data.attachFile != null) { //??????????????? ????????? ?????????????????? ?????????????????? ?????? ??????
			if (data.attachFile.chatAttach_fileType == "v") {
				msgStr += "<video id='chatVod' src='/resources/image/download.mp4' autoplay loop muted/>";
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
				msgStr += "<video id='chatImg' src='/resources/image/download.mp4' autoplay loop muted/>";
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
	
	if (data.attachFile != null) { //???????????? ?????? ??????????????? ??????
		var thisFile = data.attachFile.chatAttach_path+"/"+data.attachFile.chatAttach_uuid+"_"+data.attachFile.chatAttach_fileName;
		setTimeout(function() {
			if (data.attachFile.chatAttach_fileType == "i") {
				$("#chatImg").attr("src","/resources/fileUpload/chat/"+thisFile);				
			} else if (data.attachFile.chatAttach_fileType == "v"){
				$("#chatVod").attr("src","/resources/fileUpload/chat/"+thisFile);
			}
		}, 5000);
	}
	//???????????? ??????????????? ??????
	var scrollDiv = document.getElementById("msg_div");
	scrollDiv.scrollTop = scrollDiv.scrollHeight;
	
}

//????????? ???????????? ???????????? ??? ?????? ????????? ????????? ????????????..
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
        str += '<h5>'+obj.member.member_nick+' ???';
        if (obj.message_read == 'n') {
			str += '<i class="readMessage">???</i>';
		}
		str += '<span class="chat_date">'+obj.message_sendTime+'</span></h5>';
        str += '<p>'+obj.message_content+'</p>';
        str += '</div></div></div>';
	});
	refreshDiv.append(str);
}

//textarea ????????? event ??????.. 
$(document).on("keypress","#message_content",function(e){
	//shift + enter??? ???????????? ??????
	if(e.which === 13 && !e.shiftKey) {
		//?????? ????????? ???????????????
		$(".msg_send_btn").click();
	}
});
//send ?????? click ?????????
$(document).on("click",".msg_send_btn",function(){
	var messageContent = $("#message_content").val();
	//json???????????? socket handler??? ??????..
	var jsonObj = new Object();
	jsonObj.chatRoom_num = $("#roomNum").val();
	jsonObj.message_sender = username;
	jsonObj.message_content = messageContent;
	jsonObj.message_receiver = $("#receiver").val();
	//????????? ????????? ????????? ????????? ????????? ????????? ??????
	if (!messageContent.replace(/\s/g, "").length) {
		$("#message_content").val("");
	}else {
		if (messageContent != "" && messageContent.length > 0) {
			socket.send(JSON.stringify(jsonObj));
			$("#message_content").val("");
		}
	}
});

//???????????? ?????? ???????????????
$(document).on("click",".msg_attach_btn",function(){
	$("#attachFile").click();
});

//????????? ???????????? controller??? websocket handler??? ??????
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
	//ajax??? ???????????? ?????? ??????..
	$.ajax({
		url:"/attachSend",
		data: formData,
		cache: false,
		processData: false,
		contentType: false,
		type: "POST",
		success: function(result){
			//????????? ????????? ????????? ??????
			socket.send(JSON.stringify(jsonObj));
		}, error: function(){
			alert("system error");
		}
	});
});
	
	
</script>
</html>