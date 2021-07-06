console.log("Review Reply Module");

var review_replyService = (function(){
	
	
	
	function add(reply,callback,error){
			console.log("댓글 등록");
				
		$.ajax({
				type : 'post',
				url : '/review/replies/new',
				data : JSON.stringify(reply),
				contentType : "application/json ; charset=utf-8",
				success : function(result,status,xhr){
							if(callback){
								callback(result);
							}
				},
				error:function(xhr,status,er){
							if(error){
								error(er);
							}
			   }	
		   })
	   	   
	}
		
   
	
	
	function getList(param,callback,error){
		console.log("목록 처리");
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/review/replies/pages/" + bno + "/" + page +".json",
			function(data){
				if(callback){
					//callback(data); //댓글의 목록만 가져오는경우
					callback(data.replyCnt,data.list); //댓글 숫자와 목록을 가져오는경우
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
			});
	
	}
	
	
	
	function remove(rno,replyer,callback,error){
		console.log("삭제 처리");
		
		$.ajax({
				type : 'delete',
				url : '/review/replies/'+rno,
				
				data: JSON.stringify({rno:rno , replyer:replyer}),
				contentType:"application/json; charset=utf8",
				
				success : function(deleteResult,status,xhr){
					if(callback){
						callback(deleteResult);
					}
				},
				error : function(xhr,status,er){
					if(error){
						error(er);
					}
				}
		});
	}
	
	
	function update(reply,callback,error){
		console.log("수정 처리");
		console.log("RNO : "+reply.rno);
		
		$.ajax({
				type : 'put',
				url : '/review/replies/'+reply.rno,
				data : JSON.stringify(reply),
				contentType : "application/json;charset=utf-8",
				success : function(result,status,xhr){
							if(callback){
								callback(result);
							}
				},
				error:function(xhr,status,er){
							if(error){
								error(er);
							}
			    }					
		});
	}
	
	
	function get(rno,callback,error){
		console.log("댓글 조회 처리");
		
		$.get("/review/replies/"+rno+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status,err){
				if(error){
					error();
				}
		});	
	}
	
	
	function displayTime(timeValue){
		console.log("시간처리");
		var today = new Date();
  		
  		var gap = today.getTime() - timeValue;
  		
  		var dateObj = new Date(timeValue);
  		var str = "";
  		
  		if(gap < (1000*60*60*24)){		
	  		var hh = dateObj.getHours();
	  		var mi = dateObj.getMinutes();
	  		var ss = dateObj.getSeconds();	
	  		
	  		return [ (hh > 9 ? '' : '0')+hh,':',(mi > 9 ? '' : '0' ) + mi,':',(ss > 9 ? '' : '0')+ss].join('');
  		}else{
  			var yy = dateObj.getFullYear();
  			var mm = dateObj.getMonth() + 1;  //getMonth() is zero-based
  			var dd = dateObj.getDate();
  			
  			return [yy,'/',(mm > 9 ? '':'0' )+mm,'/',(dd > 9 ? '':'0') + dd].join('');
  		}						
	}
	
		
	return {
		add:add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};	
	
	

})();