<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
	h1 {
	    margin-left: 15px;
	    margin-bottom: 20px;
	}

@media (min-width: 768px) {

    .brand-pills > li > a {
        border-top-right-radius: 0px;
    	border-bottom-right-radius: 0px;
    }
    
    li.brand-nav.active a:after{
    	content: " ";
    	display: block;
    	width: 0;
    	height: 0;
    	border-top: 20px solid transparent;
    	border-bottom: 20px solid transparent;
    	border-left: 9px solid #428bca;
    	position: absolute;
    	top: 50%;
    	margin-top: -20px;
    	left: 100%;
    	z-index: 2;
    }
}

.modal{ 
  position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
}

.modal_content{
  width:180px; height:180px;
  background:#fff; border-radius:10px;
  position:relative; top:50%; left:50%;
  margin-top:-100px; margin-left:-100px;
  text-align:center;
  box-sizing:border-box;
  line-height:23px; cursor:pointer;
}
#modal_li {
	height: 60px;
	padding-top: 20px;
}
#modal_li:hover {
	color:blue;
	font-weight: bold;
}
</style>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<div class="container" style="margin-top: 120px; width:768px;">
	<div class="row">
        <div role="tabpanel">
            <div class="col-sm-3">
                <ul class="nav nav-pills brand-pills nav-stacked" role="tablist">
                    <li role="presentation" class="brand-nav active"><a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">회원정보 수정</a></li>
                    <li role="presentation" class="brand-nav"><a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">비밀번호 변경</a></li>
                    <li role="presentation" class="brand-nav"><a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">회원 탈퇴</a></li>
                </ul>
            </div>
            <div class="col-sm-9">
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="tab1">
                        <form action="/member/modifyProfile" id="profileFrm" name="profileFrm" class="bg-white border py-4 px-5" method="post" enctype="multipart/form-data" style="border:none; text-align: center;">
				          <div class="text-center mb-3">
				            <i class="fab fa-bootstrap fa-5x text-secondary mb-2"></i>
				          </div>
				          <div id="imagediv" style="margin:0 auto; width:100px; height:100px; border-radius: 70%; overflow: hidden;">
							  <c:choose>							  
								  <c:when test="${empty profileDTO}">
									  <img id="profileImage" src="/resources/image/profile.png" style="width: 100%; height: 100%; object-fit: cover;">
									  <input type='hidden' id='profile_uuid' name='profile_uuid' value="">					  
									  <input type='hidden' id='profile_fileName' name='profile_fileName' value="">
								  </c:when>
								  <c:otherwise>							  
									  <img id="profileImage" src="/resources/fileUpload/profile/${profileDTO.profile_uuid}_${profileDTO.profile_fileName}" style="width: 100%; height: 100%; object-fit: cover;">
									  <input type='hidden' id='profile_uuid' name='profile_uuid' value="${profileDTO.profile_uuid}">					  
									  <input type='hidden' id='profile_fileName' name='profile_fileName' value="${profileDTO.profile_fileName}">				  
								  </c:otherwise>
							  </c:choose>
				          </div>
				          <span style="color:black; font-weight: bold; font-size: 40px;">${memberDTO.member_nick}</span>
				          <br>
				          <sec:csrfInput/>
				          <input type="hidden" id="member_id" name="member_id" value="${user.username}">
				          <input type="file" id="profile" style="display: none;">
				          <div class="form-floating mb-3">
				            <input class="form-control" id="fullname" name="member_name" placeholder="Name" type="text" style="height:50px;" maxlength="6" value="${memberDTO.member_name}"/><label id="label-name">이름</label>
				          </div>
				          <br>
				          <div class="form-floating mb-3">
				            <input class="form-control" id="nickname" name="member_nick" placeholder="Nickname" type="text" style="height:50px;" maxlength="20" value="${memberDTO.member_nick}"/><label id="label-nickname">닉네임</label>
				          </div>
				          <div class="form-floating mb-3" style="text-align: left;">
				          	<c:choose>
				          		<c:when test="${memberDTO.member_alarm eq 'Y'.charAt(0)}">
									<input type="checkbox" checked="checked" name="alarmConfirm" style="width: 20px; height:20px; position: relative; top: 1.5px;">&nbsp;<span style="position: relative; top: -1.5px;">알림 수신 동의</span>
				          		</c:when>
				          		<c:otherwise>
									<input type="checkbox" name="alarmConfirm" style="width: 20px; height:20px; position: relative; top: 1.5px;">&nbsp;<span style="position: relative; top: -1.5px;">알림 수신 동의</span>
				          		</c:otherwise>
				          	</c:choose>
				          </div>
				          <br>
				          <div class="mb-2">
				            <button class="btn btn-primary fw-bold w-100 bg-gradient" id="modifyProfile" type="button">프로필 변경</button>
				          </div>
				        </form>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="tab2">
                        <form action="/logout" id="passwordFrm" name="passwordFrm" class="bg-white border py-4 px-5" method="post">
				          <div class="text-center mb-3">
				            <i class="fab fa-bootstrap fa-5x text-secondary mb-2"></i>
				            <p class="text-muted fw-bold">
				              비밀번호 변경
				            </p>
				          </div>
				          <br>
				          <sec:csrfInput/>
				          <div class="form-floating mb-3">
				            <input class="form-control" id="origin" name="origin" placeholder="Password" type="password" maxlength="20" style="height:50px;"/><label id="label-origin">기존 비밀번호</label>
				          </div>
				          <br>
				          <div class="form-floating mb-3">
				            <input class="form-control" id="password" name="password" placeholder="Password" type="password" maxlength="20" style="height:50px;"/><label id="label-password">새 비밀번호</label>
				          </div>
				          <br>
				          <div class="form-floating mb-3">
				            <input class="form-control" id="password2" name="password2" placeholder="Password" type="password" maxlength="20" style="height:50px;"/><label id="label-password2">비밀번호 확인</label>
				          </div>
				          <br>
				          <div class="mb-2">
				            <button class="btn btn-primary fw-bold w-100 bg-gradient" id="modifyPassword" type="button">비밀번호 변경</button>
				          </div>
				        </form>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="tab3">
                        <form action="#" name="exitForm" class="bg-white border py-4 px-5" method="post">
				          <div class="text-center mb-3">
				            <i class="fab fa-bootstrap fa-5x text-secondary mb-2"></i>
				            <p class="text-muted fw-bold">
				              회원 탈퇴
				            </p>
				          </div>
				          <br>
				          <sec:csrfInput/>
				          <div class="form-floating mb-3">
				            <input class="form-control" id="password" name="password" placeholder="Password" type="password" maxlength="20" style="height:50px;"/><label id="label-password">기존 비밀번호</label>
				          </div>
				          <br>
				          <div class="mb-2">
				            <button class="btn btn-primary fw-bold w-100 bg-gradient" id="exitMember" type="button">회원 탈퇴</button>
				          </div>
				        </form>
                    </div>
                </div>
            </div>
        </div>
	</div>
</div>

<div class="modal" id="pipi">
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
    <ul id="modal_ul">
    	<li class="pic_mod" id="modal_li">수정</li>
    	<li class="pic_del" id="modal_li" style="color:red;">삭제</li>
    	<li class="pic_cancle" id="modal_li">취소</li>
    </ul>
  </div>
</div>
</body>
<script type="text/javascript">
	//모달윈도우 클릭이벤트
	$(function(){ 
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
	    //Ajax spring security header..
	    $(document).ajaxSend(function(e, xhr, options){
	    	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	    });
	    
		$(".pic_cancle").click(function(){
			$("#pipi").fadeOut();
		});
		$(".pic_mod").click(function(){
			$("#profile").click();
		});
		$(".pic_del").click(function(){
			var user = "${user.username}";
			var uuid = $("#profile_uuid").val();
			var fileName = $("#profile_fileName").val();
			$.ajax({
				url: "/member/removeProfile",
				data: {"member_id": user,
					   "profile_uuid": uuid,
					   "profile_fileName": fileName},
				type: "POST",
				success: function(result){
					console.log(result);
					$("#pipi").fadeOut();
					location.reload();
				},
				error: function(result){
					location.reload();
				}
			});
		});	
	});
	//프로필 이미지 클릭이벤트,,
	$(document).on("click","#profileImage",function(e){
		e.preventDefault();
		var x = $("#profile_fileName").val();
		if (x == "") {
			$("#profile").click();			
		} else {
			$("#pipi").fadeIn();
		}
	});
	
	$(function () {
		var regBlank = /\s/g; //공백
		var regNick = /^[A-Za-z0-9_]{5,20}$/; // 대소문자 숫자 _ 허용
		var regName = /[가-힣]{2,6}$/; //이름 한글 2~6자
		var regPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/; //비번 8자 이상 문자 숫자 특문 포함
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
	    //Ajax spring security header..
	    $(document).ajaxSend(function(e, xhr, options){
	    	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	    });
	    
	    //이미지 변경 Ajax,,,
		$("#profile").on("change", function(){
			$("#pipi").fadeOut();
			var formData = new FormData();
			var file = $(this);
			var fileList = file[0].files;
			formData.append("profile", fileList[0]);
			$.ajax({
				url: "/uploadProfile",
				processData: false, 
				contentType: false,
				data: formData,
				type: "POST",
				dataType:"json",
				success: function(result){
					showProfile(result);
					$('html').css("cursor","wait");
				}
			});
		});
		
	    //변경된 이미지 미리보기,,
		function showProfile(result){
			var src = "/resources/fileUpload/profile/"+result.profile_uuid+"_"+result.profile_fileName;
			var str = "<img id='profileImage' src='"+src+"' style='width: 100%; height: 100%; object-fit: cover;'>";
			var fileDTO = "<input type='hidden' id='profile_uuid' name='profile_uuid' value='"+result.profile_uuid+"'>";
			fileDTO += "<input type='hidden' id='profile_fileName' name='profile_fileName' value='"+result.profile_fileName+"'>";
			setTimeout(function() {
				$("#profileImage").remove();
				$("#profile_uuid").remove();
				$("#profile_fileName").remove();
				$("#imagediv").append(str);
				$("#profileFrm").append(fileDTO);
				$('html').css("cursor","auto");
			}, 5000);

		}
	    
	    //프로필 form submit
	    $("#modifyProfile").on("click", function(e){
	    	var controll = confirm("입력하신 정보로 수정하시겠습니까?");
	    	if (controll) {
	    		var originNick = "${memberDTO.member_nick}";
				var name = $("#fullname").val();
				var nick = $("#nickname").val();
				
				if (name == "" && !regName.test(name)) {
					alert("닉네임과 이름은 필수 입력 항목입니다.");
					return;
				}
				
				if (nick == "" && !regNick.test(nick)) {
					alert("닉네임과 이름은 필수 입력 항목입니다.");
					return;
				}
				
				if (originNick != nick) {
					if (regNick.test(nick)) {
						$.ajax({
							url:"/member/nickChk",
							data: {"nickname" : nick},
							type: "post",
							success: function(result){
								if (result != "") {
									$("#label-nickname").html("이미 존재하는 닉네임입니다.").css("color","red");
									$("#nickname").val(originNick);
								} else {
									$("#profileFrm").submit();
								}
							}
						});
					}
				} else{
					$("#profileFrm").submit();
				}
			}
	    });
	    
	    $("#password").on("blur", function(){
			var password = $(this).val();
			if (regPwd.test(password) && !regBlank.test(password)) {
				$("#label-password").html("사용가능한 비밀번호입니다.").css("color","blue");
				$("#password2").on("keyup",function(){
					var password2 = $(this).val();
					if (password === password2) {
						$("#label-password2").html("비밀번호가 일치합니다.").css("color","blue");
					}else {
						$("#label-password2").html("비밀번호가 일치하지 않습니다.").css("color","red");
					}
				});
			} else {
				$("#label-password").html("문자,숫자,특수문자를 포함해야 합니다.").css("color","red");	
	 			$(this).focus();
				$(this).val("");
			}
		});
	    
	    //비밀번호 변경..
	    $("#modifyPassword").on("click", function(){
	    	var origin = $("#origin").val();
	    	var newPass = $("#password").val();
	    	var newPassChk = $("#password2").val();
    		var user = "${user.username}";
	    	if (origin == "") {
				alert("입력란을 다시 확인해주세요.");
				return;
			} else if (newPass == "" || !regPwd.test(newPass)){
				alert("입력란을 다시 확인해주세요.");
				return;
			} else if (newPass != newPassChk) {
				alert("입력란을 다시 확인해주세요.");
				return;
			}
	    	$.ajax({
	    		url: "/member/pwdModify",
	    		data: {"origin":origin,
	    			   "member_id":user,
	    			   "member_pwd":newPass},
	    		type: "post",
	    		success: function(data){
	    			if (data < 1) {
						alert("기존 비밀번호가 일치하지 않습니다.");
						$("#origin").val("");
					} else {						
		    			alert("비밀번호가 변경되었습니다. 재로그인 후 이용해주세요");
		    			$("#passwordFrm").submit();
					}
	    		}
	    	});
	    });
	    
	    //회원탈퇴..
	    $("#exitMember").on("click", function(){
	    	
	    });
	});
</script>
</html>