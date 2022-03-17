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
		
		if(this.rereplyList != null) {
			
			$(this.rereplyList).each(function(z, reObj) {
				
				console.log("rereply_content : " + reObj.rereply_content);
				
			});
		
		}
		
	});
	
}
