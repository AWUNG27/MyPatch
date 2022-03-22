function boardModal(result) {
	
	console.log(result);
	console.log(result.replyList);
	console.log(result.blist);
	
	var user = "";
	var board = "";
	
	board += result.board_content
	
	user += "<div class='profile_img'>";
	user += "<img src='/resources/fileUpload/profile/" + result.member.profileDTO.profile_uuid + "_" + result.member.profileDTO.profile_fileName + "'>";
	user += "</div>";
	user += "<div class='user_name'>";
	user += result.member.member_nick;
	user += "</div>";
	
	
	var user_container = $(".user_container_modal");
	var board_content = $(".board_content");
	
	user_container.append(user);
	board_content.append(board);
		
	$(result.blist).each(function(x, attachObj) {
			
		console.log("bList : " + attachObj.boardattach_path);
		var fileCallPath = attachObj.boardattach_path + "/" + attachObj.boardattach_uuid + "_" + attachObj.boardattach_filename;
		console.log("fileCallPath : " + fileCallPath);
			
		var str = "";
			
		str += "<img style='width:100%; max-width: none;' src='/resources/fileUpload/board/" + fileCallPath + "'>";
			
		var modalBoardImage = $(".carousel-item.active");
		modalBoardImage.append(str);
			
	});

	$(result.replyList).each(function(i, obj) {
		
		console.log("result reply : " + obj.reply_content);
		var str = "";
		var profileImg = "";
		if (obj.member.profileDTO != null){
			profileImg = obj.member.profileDTO.profile_uuid+"_"+obj.member.profileDTO.profile_fileName;			
		}
		str += "<div class='replys' style='margin: 5px;'>";
		str += '<div class="chat_img" style="margin:0 15px 0 10px; width:30px; height:30px; border-radius: 70%; overflow: hidden; float:left; position:relative; top:-2.5px;">';
		if (obj.member.profileDTO == null){
			str += "<img style='width: 100%; height: 100%; object-fit: cover;' src='/resources/image/profile.png'> ";
		} else {
			str += "<img style='width: 100%; height: 100%; object-fit: cover;' src='/resources/fileUpload/profile/"+profileImg+"'> ";			
		}
		str += "</div>";
		str += "<p id='reply_content' style='height:30px; position: relative; top:2.5px;'>";
		str += "<b>"+obj.member.member_nick+"</b>" + " " + obj.reply_content;
		str += "</p>";
		str += "</div>";
		
		var reply_field = $(".reply_field");
		reply_field.append(str);
		
		if(this.rereplyList != null) {
			
			$(this.rereplyList).each(function(z, reObj) {
				
				console.log("rereply_content : " + reObj.rereply_content);
				var str2 = "";
				var profileImg = "";
				if (reObj.member.profileDTO != null){
					profileImg = reObj.member.profileDTO.profile_uuid+"_"+reObj.member.profileDTO.profile_fileName;			
				}
				
				str2 += "<div class='rereplys' style='margin: 5px;'>";
				str2 += '<div class="chat_img" style="margin:0 15px 0 50px; width:30px; height:30px; border-radius: 70%; overflow: hidden; float:left; position:relative; top:-2.5px;">';
				if (reObj.member.profileDTO == null){
					str2 += "<img style='width: 100%; height: 100%; object-fit: cover;' src='/resources/image/profile.png'> ";
				} else {
					str2 += "<img style='width: 100%; height: 100%; object-fit: cover;' src='/resources/fileUpload/profile/"+profileImg+"'> ";			
				}
				str2 += "</div>";
				str2 += "<p id='rereply_content' style='height:30px; position: relative; top:2.5px;'>";
				str2 += "<b>"+ reObj.member.member_nick+ "</b>" + " " + reObj.rereply_content;
				str2 += "</p>";
				str2 += "</div>";
				
				var replysDiv = $(".replys");
				replysDiv.append(str2);
				
			});
		
		}
		
	});
	
}

$(document).ready(function(){       
    $('.modal.fade').on('hidden.bs.modal', function () {
            
        $(".user_container_modal").empty();
		$(".board_content").empty(); 
		$(".carousel-item.active").empty();  
		$(".reply_field").empty();
		$(".replys").empty();
         
    });
 
});
