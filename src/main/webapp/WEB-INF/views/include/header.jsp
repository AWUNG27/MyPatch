<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication property="principal" var="user"/>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

    <!-- Facebook Meta Tags / 페이스북 오픈 그래프 -->
    <meta property="og:url" content="http://kindtiger.dothome.co.kr/insta">
    <meta property="og:type" content="website">
    <meta property="og:title" content="instagram">
    <meta property="og:description" content="instagram clone">
    <meta property="og:image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">
    <!-- Twitter Meta Tags / 트위터 -->
    <meta name="twitter:card" content="instagram clone">
    <meta name="twitter:title" content="instagram">
    <meta name="twitter:description" content="instagram clone">
    <meta name="twitter:image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">
    <!-- Google / Search Engine Tags / 구글 검색 엔진 -->
    <meta itemprop="name" content="instagram">
    <meta itemprop="description" content="instagram clone">
    <meta itemprop="image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">


    <title>JOINUS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/2.0.0-alpha.2/cropper.min.js" integrity="sha512-IlZV3863HqEgMeFLVllRjbNOoh8uVj0kgx0aYxgt4rdBABTZCl/h5MfshHD9BrnVs6Rs9yNN7kUQpzhcLkNmHw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/2.0.0-alpha.2/cropper.min.css" integrity="sha512-6QxSiaKfNSQmmqwqpTNyhHErr+Bbm8u8HHSiinMEz0uimy9nu7lc/2NaXJiUJj2y4BApd5vgDjSHyLzC8nP6Ng==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <link rel="stylesheet" href="/resources/css/reset.css">
    <link rel="stylesheet" href="/resources/css/common.css">
    <link rel="stylesheet" href="/resources/css/style.css">
    <link rel="stylesheet" href="/resources/css/login.css">
    <link rel="shortcut icon" href="imgs/instagram.png">
    
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>

</head>
<style type="text/css">
	
	#modal{
		width: 100%;
  		height: 100%;
	}
	
	.select-button{
		padding: 6px 25px;
	  	background-color:#0095F6;
	  	border-radius: 4px;
	  	color: white;
	  	cursor: pointer;
	  	text-align: center;
	}

	.modal-header {
	  	height: 42px;
	  	display: flex;
	  	justify-content: center;
	  	align-items: center;
	}
	
	.modal-body{
	  	height: auto; 
	  	min-height: 400px; 
	  	border-radius: 0;
	  	display: flex;
	  	justify-content: center; 
	  	align-items: center;
	}
	
	.right_icons img{
		width: 35px;
		margin-left: 5px;
		margin-right: 5px;
	}

</style>
<body>
    <header id="header">
        <section class="h_inner">

            <h1 class="logo">
                <a href="/">
                    <img alt="#" src="/resources/image/logo.png" style="width:150px;">
                </a>
            </h1>

            <div class="search_field">
                <input type="text" placeholder="검색" tabindex="0">

                <div class="fake_field">
                    <span class=sprite_small_search_icon></span>
                    <span>검색</span>
                </div>
            </div>


            <div class="right_icons">
            	<div>
                <a href="#" data-bs-toggle="modal" data-bs-target="#modal" id="boardRegist"><img src="/resources/image/kakao.png"></a>
              </div>
                <sec:authorize access="isAnonymous()">
	                <div><a href="/member/login"><img src="/resources/image/login.png"></a></div>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
	                <div><a href="javascript:logoutConfirm(logoutAction);"><img src="/resources/image/logout.png"></a></div>
			        <form action="/logout" name="logoutAction" method="post">
						<sec:csrfInput/>
					</form>
                </sec:authorize>
                <div><a href=""><img src="/resources/image/dm.png"></a></div>
				<!-- 익명회원 접근시 -->
                <sec:authorize access="isAnonymous()">
	                <div><a href="javascript:isUser()"><img src="/resources/image/profile.png"></a></div>
	                <input type="hidden" value="anonymous" id="anonymous">
                </sec:authorize>
                <!-- 인증회원 접근시 -->
                <sec:authorize access="isAuthenticated()">
	                <div><a href="/member/profile?member_id=${user.username}"><img src="/resources/image/profile.png"></a></div>
	                <input type="hidden" value="${user.username}" id="auth">
                </sec:authorize>
            </div>
        </section>
    </header>
    <!-- The Board Regist Modal -->
		<div class="modal" id="modal">
			
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					
					<!-- Modal Header -->
					<div class="modal-header">
						<div class="col-1" id="modalLeft" style="display: none;"> 
							<button style="margin: auto; border: 0; outline: 0; background-color: transparent;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  									<path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
								</svg>
							</button>
						</div>
						<div class="col-10">
							<h4 class="modal-title" id="title" style="text-align: center;">새 게시물 만들기</h4>
						</div>
						<div class="col-1" id="modalRight" style="display: none;">
							<button style="margin: auto; font-size: 14px; border: 0; outline: 0; background-color: transparent;">
								다음
							</button>
						</div>
					</div>
					
					<!-- Modal Body -->
					<div id="modal-body" class="modal-body" style="padding: 0 0 0 0;">
						<div class="col-9 text-center">
							<div id="1st" style="">
								<svg aria-label="이미지나 동영상과 같은 미디어를 나타내는 아이콘" class="_8-yf5 " color="#262626" fill="#262626" height="77" role="img" viewBox="0 0 97.6 77.3" width="96">
									<path d="M16.3 24h.3c2.8-.2 4.9-2.6 4.8-5.4-.2-2.8-2.6-4.9-5.4-4.8s-4.9 2.6-4.8 5.4c.1 2.7 2.4 4.8 5.1 4.8zm-2.4-7.2c.5-.6 1.3-1 2.1-1h.2c1.7 0 3.1 1.4 3.1 3.1 0 1.7-1.4 3.1-3.1 3.1-1.7 0-3.1-1.4-3.1-3.1 0-.8.3-1.5.8-2.1z" fill="currentColor">
									</path>
									<path d="M84.7 18.4L58 16.9l-.2-3c-.3-5.7-5.2-10.1-11-9.8L12.9 6c-5.7.3-10.1 5.3-9.8 11L5 51v.8c.7 5.2 5.1 9.1 10.3 9.1h.6l21.7-1.2v.6c-.3 5.7 4 10.7 9.8 11l34 2h.6c5.5 0 10.1-4.3 10.4-9.8l2-34c.4-5.8-4-10.7-9.7-11.1zM7.2 10.8C8.7 9.1 10.8 8.1 13 8l34-1.9c4.6-.3 8.6 3.3 8.9 7.9l.2 2.8-5.3-.3c-5.7-.3-10.7 4-11 9.8l-.6 9.5-9.5 10.7c-.2.3-.6.4-1 .5-.4 0-.7-.1-1-.4l-7.8-7c-1.4-1.3-3.5-1.1-4.8.3L7 49 5.2 17c-.2-2.3.6-4.5 2-6.2zm8.7 48c-4.3.2-8.1-2.8-8.8-7.1l9.4-10.5c.2-.3.6-.4 1-.5.4 0 .7.1 1 .4l7.8 7c.7.6 1.6.9 2.5.9.9 0 1.7-.5 2.3-1.1l7.8-8.8-1.1 18.6-21.9 1.1zm76.5-29.5l-2 34c-.3 4.6-4.3 8.2-8.9 7.9l-34-2c-4.6-.3-8.2-4.3-7.9-8.9l2-34c.3-4.4 3.9-7.9 8.4-7.9h.5l34 2c4.7.3 8.2 4.3 7.9 8.9z" fill="currentColor">
									</path>
									<path d="M78.2 41.6L61.3 30.5c-2.1-1.4-4.9-.8-6.2 1.3-.4.7-.7 1.4-.7 2.2l-1.2 20.1c-.1 2.5 1.7 4.6 4.2 4.8h.3c.7 0 1.4-.2 2-.5l18-9c2.2-1.1 3.1-3.8 2-6-.4-.7-.9-1.3-1.5-1.8zm-1.4 6l-18 9c-.4.2-.8.3-1.3.3-.4 0-.9-.2-1.2-.4-.7-.5-1.2-1.3-1.1-2.2l1.2-20.1c.1-.9.6-1.7 1.4-2.1.8-.4 1.7-.3 2.5.1L77 43.3c1.2.8 1.5 2.3.7 3.4-.2.4-.5.7-.9.9z" fill="currentColor">
									</path>
								</svg>
							
							
								<h2>사진과 동영상을 여기에 끌어다 놓으세요</h2>
							
								<form action="/board/fileUpload" method="post" enctype="multipart/form-data" role="prsentation">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
									<input accept="image/jpeg,image/png,image/heic,image/heif,video/mp4,video/quicktime" 
										   id="addFile" name="uploadFile" multiple type="file" style="display: none;"/>
									<label class="select-button" for="addFile">컴퓨터에서 선택</label>
								</form>
							</div>
							<div id="2nd" class="2nd" style="display: none;">
								
							</div>
							<div id="3rd" style="display: none;">
							</div>
						</div>
						<div id="cropRatio" class="col-3 text-center" style="display: none;">
							<ul id="ratio">
								<li id="original"><a href="#" style="none;">원본 이미지</a></li>
								<hr>
								<li id="square"><a href="#" style="none;">정방향</a></li>
								<hr>
								<li id="movie">16:9</li>
								<hr>
								<li id="rectangular"><a href="#" style="none;">4:3</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		
<script src="/resources/js/insta.js"></script>
<script type="text/javascript">
	
	//Ajax spring security header..
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	console.log(csrfHeaderName);
	console.log(csrfTokenValue);
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	});
	
	var fileList = []; //파일 정보를 담아 둘 배열
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	//var maxSize = 10485760; // 10MB
	var title = $("#title");
	
	var showImage = $("#2nd");
	var cropper = null;
	
	// cropper 세팅값들
	var w = 1; // 크롭영역 가로길이
	var h = 1; // 크롭영역 높이
	var a = 1.0; // 크롭영역 크기(이미지기준)
	
	$(function() {
		
		$("#boardRegist").on("click", function() {
			var option = {
					
			};
		});
		
		$("#addFile").change(function() {
			
			var str = "";
			
			str += "<h4 class='modal-title' id='title' style='text-align: center;'>" +
				  "자르기" +
				   "</h4>";
			
			title.html(str);
			
			$("#modalLeft").removeAttr('style');
			$("#modalRight").removeAttr('style');

			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);
			
			// add File Data to formData
			for(var i = 0; i < files.length; i++){
				
			if (!checkExtension(files[i].name)) {
					return false;
				}
				
				formData.append("uploadFile", files[i]);
				
			}
			
			$.ajax({		
				url: '/board/fileUpload',
				processData: false,
				contentType: false,
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				 },
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result) {
					console.log(result);
					// image 또는 video 파일이 들어오면 파일 업로드 표시 사라지게하기
					if (!result.length == 0) {
						$("#1st").css("display", "none");
						$("#cropRatio").css("display", "");
					}
					
					$("#2nd").css("display", "");
					showUploadedFile(result);
					//const image = document.getElementById('img');
					var imgSrc = document.getElementById('img');
					//var realKing = imgSrc.attr('src');
					console.log("imgSrc : " + imgSrc.src);
					
					cropperFunction(w, h, a);
					
				}
			}); // end $.ajax
	        
		});
		
		console.log(fileList);
		
		
		// 드래그 & 드랍 *수정 필요함!
		$("#modal").on("dragenter", function(e) {
			e.preventDefault();
			e.stopPropagation();
		}).on("dragover", function(e) {
			e.preventDefault();
			e.stopPropagation();
		}).on("dragleave", function(e) {
			e.preventDefault();
			e.stopPropagation();
		}).on("drop", function(e) {
			e.preventDefault();
			
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);
			
			var files = e.originalEvent.dataTransfer.files; // 이거 비동기 통신으로 controller단에 보내줘야함!!!!
	 
	        if(files != null && files != undefined){
	            var tag = "";
	            var str = "";
	            for(i=0; i<files.length; i++){
	                var f = files[i];
	                fileList.push(f);
	                var fileName = f.name;
	                var fileSize = f.size / 1024 / 1024;
	                fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
	                tag += 
	                        "<div class='fileList' style='display: none;'>" +
	                            "<span class='fileName'>"+fileName+"</span>" +
	                            "<span class='fileSize'>"+fileSize+" MB</span>" +
	                            "<span class='clear'></span>" +
	                        "</div>";
	            }
	            
	            str += "<h4 class='modal-title' id='title' style='text-align: center;'>" +
				   "자르기" +
				   "</h4>";
				   
				title.html(str);
				
				$("#modalLeft").removeAttr('style');
				$("#modalRight").removeAttr('style');
	            
	            $("#modal-body").append(tag);
	            
	        }
	        
	        $.ajax({		
				url: '/board/fileUpload',
				processData: false,
				contentType: false,
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				 },
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result) {
					alert("업로드 성공~");
				}
			}); // end $.ajax
			
		});
		
		$("#original").on("click", function() {
			var imgSrc = document.getElementById('img');
			var x = 1;
			var y = 1;
			reShowUploadedFile(imgSrc);
			cropperFunction(x, y, a);
		});
		
		$("#square").on("click", function() {
			var imgSrc = document.getElementById('img');
			var x = 1;
			var y = 1;
			var z = 0.8;
			
			reShowUploadedFile(imgSrc);
			cropperFunction(x, y, z);
		});
		 
		$("#movie").on("click", function() {
			var imgSrc = document.getElementById('img');
			var x = 16;
			var y = 9;
			reShowUploadedFile(imgSrc);
			cropperFunction(x, y, a);
		});
		
		$("#rectangular").on("click", function() {
			var imgSrc = document.getElementById('img');
			var x = 4;
			var y = 5;
			reShowUploadedFile(imgSrc);
			cropperFunction(x, y, a);
		});
		
	});
	
function re_requestAjax() {
	
	$.ajax({		
		url: '/board/fileUpload',
		processData: false,
		contentType: false,
		beforeSend : function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		 },
		data: formData,
		type: 'POST',
		dataType: 'json',
		success: function(result) {
			console.log(result);
			// image 또는 video 파일이 들어오면 파일 업로드 표시 사라지게하기
			if (!result.length == 0) {
				$("#1st").css("display", "none");
				$("#cropRatio").css("display", "");
			}
			
			$("#2nd").css("display", "");
			showUploadedFile(result);
			//const image = document.getElementById('img');
			
			cropperFunction(w, h);
			
		}
	}); // end $.ajax
}
	
function cropperFunction(w, h, a) {
	var image = document.getElementById('img');
	console.log("w : " + w);
	console.log("h : " + h);
	
	cropper = new Cropper(image, {
		  dragMode: 'crop', // 자르기영역 새로 생성여부
		  aspectRatio: w / h,
		  moveable: true,
		  center: true,
		  viewMode: 2,
		  cropBoxMovable: true, // 자르기영역 이동여부
		  cropBoxResizable: false, // 자르기영역 크기조절 여부
		  autoCropArea: a,
		  guides: true,
		  crop(event) {
			
		    console.log(event.detail.x);
		    console.log(event.detail.y);
		    console.log(event.detail.width);
		    console.log(event.detail.height);
		    console.log(event.detail.rotate);
		    console.log(event.detail.scaleX);
		    console.log(event.detail.scaleY);
		  },
		});
}

function showUploadedFile(uploadResultArr) {
	
	var str = "";
	
	console.log("제발 : " + uploadResultArr[0].boardattach_path);
	console.log("좀 : " + uploadResultArr[0].boardattach_uuid);
	console.log("시발련아 : " + uploadResultArr[0].boardattach_filename);
	
	$(uploadResultArr).each(function(i, obj) {
		var fileCallPath = obj.boardattach_path + "/s_" + obj.boardattach_uuid + "_" + obj.boardattach_filename;
		console.log(fileCallPath);
		str += "<img id='img' src='/board/display?fileName="+fileCallPath+"'>";
	});
	 
	showImage.append(str);
	
}

function reShowUploadedFile(imgSrc) {
	var str = "";
	var fileCallPath = imgSrc.src.substring(45);
	$("#img").remove();
	$(".cropper-container.cropper-bg").remove();
	/* $(".cropper-drag-box.cropper-crop.cropper-modal").remove();
	$(".cropper-crop-box").remove(); */
	
	console.log("fileCallPath : " + fileCallPath);
	
	str += "<img id='img' src='/board/display?fileName="+fileCallPath+"'>";
	
	showImage.append(str);
}
	 
function checkExtension(fileName) {
	
	if(regex.test(fileName)) {
		alert("해당 종류의 파일은 업로드 할 수 없습니다.");
		return false;
	}
	
	return true;
}	
	
function logoutConfirm(logoutAction) {
	var x = confirm('로그아웃 하시겠습니까?');
	if (x) {
		logoutAction.submit();
	}
}

function isUser() {
	alert("로그인이 필요한 서비스 입니다.");
	location.href="/member/login";
}

</script>