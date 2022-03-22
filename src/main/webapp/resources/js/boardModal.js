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
			
		str += "<img style='width:100%; ' src='/resources/fileUpload/board/" + fileCallPath + "'>";
			
		var modalBoardImage = $(".carousel-item.active");
		modalBoardImage.append(str);
			
	});

	$(result.replyList).each(function(i, obj) {
		
		console.log("result reply : " + obj.reply_content);
		var str = "";
		
		str += "<div class='replys' style='margin:5px;'>";
		str += "<div class='reply_img' style='width:30px; margin:0 30px 0 70px;'>";
		str += "<p id='reply_content'>";
		if(obj.member.profileDTO == null) {
					
			str += '<img src="/resources/image/profile.png">';
				
		} else {
			var profileImage = obj.member.profileDTO.profile_uuid + "_" + obj.member.profileDTO.profile_fileName;
			str += "<img src='/resources/fileUpload/profile/" + profileImage + "'>'";
					
		}
		str += "</div>";
		str += obj.member.member_nick + " " + obj.rereply_content;
		str += "</p>";
		str += "</div>";
		
		var reply_field = $(".reply_field");
		reply_field.append(str);
		
		if(this.rereplyList != null) {
			
			$(this.rereplyList).each(function(z, reObj) {
				
				console.log("rereply_content : " + reObj.rereply_content);
				var str2 = "";
				
				str2 += "<div class='rereplys' style='margin:5px;'>";
				str2 += "<p id='rereply_content'>";
				str2 += "<div class='rereply_img' style='width:30px; margin:0 30px 0 70px;'>";
				if(reObj.member.profileDTO == null) {
					
					str2 += "&nbsp;&nbsp;&nbsp;└ "
					str2 += '<img src="/resources/image/profile.png">'
				
				} else {
					var profileImage = reObj.member.profileDTO.profile_uuid + "_" + reObj.member.profileDTO.profile_fileName;
					str2 += "&nbsp;&nbsp;&nbsp;└ " + "<img src='/resources/fileUpload/profile/" + profileImage + "'>'";
					
				}
				str2 += "</div>";
				str2 += reObj.member.member_nick + " " + reObj.rereply_content;
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
