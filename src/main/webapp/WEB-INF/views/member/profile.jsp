<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/css/profile.css">
<style>
video{
width: 300px;
}
.thumbnail img{
width: 300px;
height: 168.75px;
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

</style>
    <div id="main_container">
        <section class="b_inner">
            <div class="hori_cont">
                <div class="profile_wrap">
                    <div class="profile_img">
                        <img src="imgs/thumb.jpeg" alt="착한호랑이">
                    </div>
                </div>
                <div class="detail">
                    <div class="top">
                        <div class="user_name">KindTiger</div>

                        <a href="/member/modifyProfile?member_id=${user.username}" class="profile_edit" style="font-size: 15px;">프로필편집</a>

                        <a href="#" class="logout">로그아웃</a>
                    </div>

                    <ul class="middle">
                        <li><span>게시물</span>3</li>
                        <li><span>팔로워</span>3</li>
                        <li><span>팔로잉</span>3</li>
                    </ul>
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
					<c:forEach items="${bimgList}" var="bimgList">
				        <div class="item  col-xs-4 col-lg-6 col-xl-4">
				            <div class="thumbnail">
				            	<c:choose>
				            		<c:when test="${bimgList.boardattach_type eq 'V'}">
					                    <video src="/resources/fileUpload/board/${bimgList.boardattach_path}/${bimgList.boardattach_uuid}_${bimgList.boardattach_filename}" controls="controls"></video>
				            		</c:when>
				            		<c:when test="${bimgList.boardattach_type eq 'I'}">
										<img class="group list-group-image" src="/resources/fileUpload/board/${bimgList.boardattach_path}/${bimgList.boardattach_uuid}_${bimgList.boardattach_filename}"/>
				            		</c:when>
				            	</c:choose>
				            </div>
						</div>
				    </c:forEach>
			    </div>
			</div>
            
        </section>
    </div>
</body>
<script>
$(document).ready(function() {
    $('#list').click(function(event){event.preventDefault();$('#products .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();$('#products .item').removeClass('list-group-item');$('#products .item').addClass('grid-group-item');});
/*     $("video").mouseenter(function() {
    	$(this).get(0).play();
	});
    $('video').mouseleave(function(){
    	$(this).get(0).pause();
	}); */
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
									if (this.boardattach_type == 'V') {
										str1 += "<video src='/resources/fileUpload/board/" + this.boardattach_path + "/"
											 +	this.boardattach_uuid + "_" + this.boardattach_filename + "'" + "controls='controls'/>";
									} else if (this.boardattach_type == 'I') {
										str2 +=	"<img class='group list-group-image'" + "src='/resources/fileUpload/board/"
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
});
</script>
</html>

