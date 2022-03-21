function boardModal(result) {
	
	console.log(result);
	console.log(result.replyList);
	console.log(result.blist);
		
	$(result.blist).each(function(x, attachObj) {
			
		console.log("bList : " + attachObj.boardattach_path);
		var fileCallPath = attachObj.boardattach_path + "/" + attachObj.boardattach_uuid + "_" + attachObj.boardattach_filename;
		console.log("fileCallPath : " + fileCallPath);
			
		var str = "";
			
		str += "<img src='/resources/fileUpload/board/'" + fileCallPath + "'>";
			
		var modalBoardImage = $(".carousel-item");
		modalBoardImage.append(str);
			
	});

	$(result.replyList).each(function(i, obj) {
		
		console.log("result reply : " + obj.reply_content);
		var str = "";
		
		str += "<div class='replys'";
		str += "<p id='reply_content'>";
		str += obj.member.member_nick + " " + obj.reply_content;
		str += "</p>";
		str += "</div>";
		
		var reply_field = $(".reply_field");
		reply_field.append(str);
		
		if(this.rereplyList != null) {
			
			$(this.rereplyList).each(function(z, reObj) {
				
				console.log("rereply_content : " + reObj.rereply_content);
				var str2 = "";
				
				str2 += "<div class='rereplys'>";
				str2 += "<p id='rereply_content'>";
				str2 += "&nbsp&nbsp&nbsp" + reObj.member.member_nick + " " + reObj.rereply_content;
				str2 += "</p>";
				str2 += "</div>";
				
				var replysDiv = $(".replys");
				replysDiv.append(str2);
				
			});
		
		}
		
	});
	
}
