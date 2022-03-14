<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="shortcut icon" href="imgs/instagram.png">
<title>테스트용 페이지</title>
</head>
<style>
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
<body>
<!-- Button trigger modal -->
<button type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">
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
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
									2 of 2sadsadsadsadsadsafasdfsdafs2 of 2sadsadsadsadsadsafasdfsdafs
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
<script type="text/javascript">

</script>
</html>