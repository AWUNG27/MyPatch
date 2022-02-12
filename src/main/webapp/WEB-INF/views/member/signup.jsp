<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
.or{
  position: relative;
}
.or:before{
  content: '';
  height: 1px;
  background: linear-gradient(to right,silver,silver,rgba(255,255,255,0),rgba(255,255,255,0),silver,silver);
  position: absolute;
  left: 0;
  top: 50%;
  width: 100%;
  z-index: 0;
}
</style>

<div id="main_container">
	<section class="py-4">
	  <div class="container">
	    <div class="row d-flex align-items-center justify-content-center">
	      <div style="max-width:500px; width:450px;">
	        <form action="#" class="bg-white border py-4 px-5" method="get">
	          <div class="text-center mb-3">
	            <i class="fab fa-bootstrap fa-5x text-secondary mb-2"></i>
	            <p class="text-muted fw-bold">
	              회원가입
	            </p>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" id="email" name="email" placeholder="Email" type="email" maxlength="50"/><label id="label-email">Email</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" id="fullname" name="fullname" placeholder="Name" type="text" maxlength="6"/><label id="label-name">Name</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" id="nickname" name="nickname" placeholder="Nickname" type="text" maxlength="20"/><label id="label-nickname">Nickname</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" id="password" name="password" placeholder="Password" type="password" maxlength="20"/><label id="label-password">Password</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input class="form-control" id="password2" name="password2" placeholder="Password" type="password" maxlength="20"/><label id="label-password2">Password check</label>
	          </div>
	          <div class="mb-2">
	            <button class="btn btn-primary fw-bold w-100 bg-gradient" id="signupBtn" type="button">Sign Up</button>
	          </div>
	        </form>
	        <div class="bg-white py-4 px-5 text-center border mt-4">
	          <p class="m-0">
	            계정이 존재하나요? <a href="/member/login">Log In</a>
	          </p>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
</div>

			
</body>

<script>

$(document).ready(function() {
	var regBlank = /\s/g; //공백
	var regNick = /^[A-Za-z0-9_]{5,20}$/; // 대소문자 숫자 _ 허용
	var regName = /[가-힣]{2,6}$/; //이름 한글 2~6자
	var regPwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/;
	var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/; //첫글자 -_허용 @이후 .반드시포함

	//Ajax spring security header..
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
    $(document).ajaxSend(function(e, xhr, options){
    	xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
    });
	
	//email 중복검사 ajax..
	$("#email").on("keyup",function(){
		var email = $(this).val();
		if (regEmail.test(email) && !regBlank.test(email)) {
			$.ajax({
				url:"/member/emailChk",
				data: {"email" : email},
				type: "post",
				success: function(result){
					if (result == "") {
						$("#label-email").html("사용 가능한 Email입니다.").css("color","blue");							
					}else {
						$("#label-email").html("이미 존재하는 Email입니다.").css("color","red");													
					}
					$("#email").on("blur", function(){
						if (result != "") {
							$(this).focus();
							$(this).val("");
						}
					});
				}
			});
		} else {
			$("#label-email").html("Email 양식에 맞게 작성해주세요!").css("color","red");
		}
	});
	
	//name 유효성 검증..
	$("#fullname").on("blur", function(){
		var name = $(this).val();
		if (regName.test(name) && !regBlank.test(name)) {
			$("#label-name").html("사용가능한 이름입니다.").css("color","blue");
		} else {
			$("#label-name").html("이름은 공백을 제외한 한글만 입력가능합니다.").css("color","red");	
			$(this).focus();
			$(this).val("");
		}
	});
	
	$("#nickname").on("keyup", function(){
		var nickname = $(this).val();
		if (regNick.test(nickname) && !regBlank.test(nickname)) {
			$.ajax({
				url:"/member/nickChk",
				data: {"nickname" : nickname},
				type: "post",
				success: function(result){
					if (result == "") {
						$("#label-nickname").html("사용 가능한 닉네임입니다.").css("color","blue");							
					}else {
						$("#label-nickname").html("이미 존재하는 닉네임입니다.").css("color","red");													
					}
					$("#nickname").on("blur", function(){
						if (result != "") {
							$(this).focus();
							$(this).val("");
						}
					});
				}
			});
		} else {
			$("#label-nickname").html("닉네임은 영문 대소문자, 숫자, _ 만 사용가능합니다.").css("color","red");
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
	
	$("#signupBtn").on("click", function(){
		var email = $("#email").val();
		var name = $("#fullname").val();
		var nickname = $("#nickname").val();
		var password = $("#password").val();
		var password2 = $("#password2").val();
		
		if (email == "" || !regEmail.test(email)) {
			alert("필수 입력 항목을 확인해주세요!");
			return;
		} else if (name == "" || !regName.test(name)) {
			alert("필수 입력 항목을 확인해주세요!");
			return;
		} else if (nickname == "" || !regNick.test(nickname)) {
			alert("필수 입력 항목을 확인해주세요!");
			return;
		} else if (password == "" || !regPwd.test(password)) {
			alert("필수 입력 항목을 확인해주세요!");
			return;
		} else if (password != password2) {
			alert("비밀번호를 확인해주세요!");
			return;
		}
		
		$.ajax({
			url:"/member/signupSubmit",
			data: {"member_id" : email,
				   "member_name" : name,
				   "member_nick" : nickname,
				   "member_pwd" : password},
			type: "post",
			success: function(result){
				if (result == "success") {
					alert(name +"님 환영합니다. 로그인 후 이용해주세요.");
					location.href="/member/login";
				}
			},error: function(result) {
				alert(result);
			}
		});
	});
});
</script>
</html>