<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- upload css -->
<link href="/resources/css/upload_css.css" rel="stylesheet" type="text/css">

<!-- header -->
<%@include file="../includes/header.jsp" %>


<!-- get body -->
<div class="row">
	<div class="col-lg-12">
		<h1>Review Read Page</h1>
		<hr>
	</div>
</div>

<div class="col-lg-12 col-md-12 col-sm-12">



	<!-- readonly : 읽기전용 -->
	<div class="from-group">
		<label>게시글 번호</label><input class="form-control" name="bno"
			readonly="readonly" value="${board.bno}">
	</div>
	<br>

	<div class="from-group">
		<label>제목</label><input class="form-control" name="title"
			readonly="readonly" value="${board.title}">
	</div>
	<br>
	<div class="from-group">
		<label>내용</label>
		<textarea class="form-control form-control-lg" name="content"
			readonly="readonly">${board.content}</textarea>
	</div>
	<br>

	<div class="from-group">
		<label>작성자</label><input class="form-control" name="writer"
			readonly="readonly" value="${board.writer}">
	</div>
	<hr>
	
	<!-- security의 정보를 가져와 pinfo에 넣어줌 -->
	<sec:authentication property="principal" var="pinfo"/>
	
	<!-- 로그인한 사용자만이 수정버튼이 활성화 될수잇도록 처리 -->
	<sec:authorize access="isAuthenticated()">
		<c:if test="${pinfo.username eq board.writer}">  <!-- 아이디가 작성자와 같은 회원일경우만 수정버튼 활성화(username은 시큐리티에서 id)  -->
			<button class="btn btn-primary btn-lg" data-oper='modify'>수정하기</button>
		</c:if>	
	</sec:authorize>

	
	<button class="btn btn-secondary btn-lg" data-oper='list'>목록으로</button>

	<!-- 수정/삭제 페이지로 보내기위한 Form 처리 -->


	<form id='operForm' action="/review/modify" method="get">
		<input type="hidden" id='bno' name='bno'
			value='<c:out value="${board.bno}"/>'>

		<!-- 페이지정보인 pageNum,amount (/get매핑 컨트롤러 매개변수로 받아옴) -->
		<input type="hidden" name='pageNum'
			value='<c:out value="${cri.pageNum}"/>'> <input type="hidden"
			name='amount' value='<c:out value="${cri.amount}"/>'>

		<!-- 조회페이지에서 검색 처리 -->
		<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
		<input type="hidden" name="keyword"
			value='<c:out value="${cri.keyword}"/>'>
	</form>

	<br>


<!-- 첨부파일 화면처리 -->
<div class="card mb-2">
	
	<div class="card-header bg-light">
	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-files" viewBox="0 0 16 16">
  		<path d="M13 0H6a2 2 0 0 0-2 2 2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2 2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm0 13V4a2 2 0 0 0-2-2H5a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1zM3 4a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4z"/>
	</svg>
	Files
	</div>		
	
	<div class="card-body">	
		<!-- 첨부파일 보여지는 영역  -->	
		<div class="uploadResult">
			<ul>
			</ul>
		</div>
		
		<!-- 첨부파일(이미지)클릭시 원본이미지 보여지는공간  -->
		<div class='bigPictureWrapper'>
			<div class='bigPicture'>
			</div>
		</div>
	</div>
	
</div>
	
	
<!-- 댓글 목록 화면처리 -->
<div class="card lg-12">
	<div class="card-header bg-light">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-text-fill" viewBox="0 0 16 16">
  			<path d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM4.5 5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7zm0 2.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7zm0 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4z"/>
		</svg>
		댓글
		
		<!-- 로그인 한 사용자만 댓글등록 버튼 활성화 -->
		<sec:authorize access="isAuthenticated()">
			<button id="addReplyBtn" class="btn btn-primary" style='float:right'>댓글 등록</button>
		</sec:authorize>
		
		</div>
		<div class="card-body">
			<ul class="chat">
				<li data-rno=''>
					<div>
						<div class="header lg-12">
							<strong class="primary-font ">user00</strong>
							<small style="float:right">2021-06-28</small>
						</div>
						<p>댓글 내용입니다.</p>
					</div>
				</li>
			</ul>
		</div>
</div>

</div>



<!--댓글 등록시 Modal 창 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 등록</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>내용</label> <input class="form-control" name='reply' value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>작성자</label> <input class="form-control" name='replyer' value='replyer' readonly="readonly">
				</div>
				<div class="form-group">
					<label>날짜</label> <input class="form-control" name='replyDate' value=''>
				</div>
			</div>
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-outline-success">수정</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-outline-danger">삭제</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-outline-primary">등록</button>
				<button id='modalCloseBtn' type="button" class="btn btn-outline-secondary">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 댓글 페이징처리 -->
<div class="col-lg-12">
	<div class="page_footer">
	</div>
</div>
<!-- footer -->
<%@include file="../includes/footer.jsp" %>

<!-- Review_Reply script -->
<script type="text/javascript" src="/resources/js/review_reply.js"></script>

<!-- review_reply.js 전송방식 테스트 -->
<script>
/*
console.log("review_reply.js Test")

var bnoValue='<c:out value="${board.bno}"/>';


//등록테스트
review_replyService.add({
			reply:"JS TEST",
			replyer:"tester",
			bno:bnoValue
		},function(result){
			alert("Result:"+result);
		});


//목록처리 테스트
review_replyService.getList({bno:bnoValue,page:1},function(list){
	for(var i = 0, len = list.length||0 ; i < len ; i ++){
		console.log(list[i]);
	}
});



//삭제 처리 테스트(실제 존재하는 번호로 테스트)
review_replyService.remove(13,function(count){
	console.log(count);
		if(count === "success"){
			alert("REMOVE");
		}
	},function(err){
		alert("ERROR");
	});


//수정처리 테스트
review_replyService.update({
	rno:11,
	bno : bnoValue,
	reply : "수정처리 테스트"
	},function(result){
		alert("UPDATE");
	});
*/

/*
//댓글 조회처리 테스트
review_replyService.get(11,function(data){
	console.log(data);
});
*/

</script>

<!-- script -->
<script type="text/javascript">
$(document).ready(function(){
	
	//해당 게시물의 첨부파일을 가져오는부분 (가장먼저 동작해야함)
	(function(){
		var bno = '<c:out value="${board.bno}"/>';
		$.getJSON("/review/getAttachList",{bno:bno},function(arr){
			console.log(arr);
			var str = "";
			
		//조회게시판에 첨부파일을 보여주기위한 스크립트
			$(arr).each(function(i,attach){
				
			//image type
			if(attach.fileType){
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<img src='/review/display?fileName="+fileCallPath+"' class='img-responsive img-thumbnail'>";
				str += "</div>";
				str += "</li>"
			}else{
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<span>"+attach.fileName+"</span></br>";
				str += "<img src='/resources/images/attach.png' class='img-responsive img-thumbnail'>";
				str += "</div>";
				str += "</li>";
				}
			});
		
			$(".uploadResult ul").html(str);
		});
	})();
	
	//첨부파일 클릭시 이미지의 경우 원본이미지 보이기 , 일반파일의 경우 다운로드
	$(".uploadResult").on("click","li",function(e){
		 console.log("view image");
	 	 var liObj = $(this);
	 	 var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
	 	 
	 	 if(liObj.data("type")){
	 		 showImage(path.replace(new RegExp(/\\/g),"/")); //원본이미지 보여주기
	 	 }else{
	 		 //download
	 		 self.location="/review/download?fileName="+path
	 	 }
	 });
	
	 //원본이미지 보여주기위한 함수
	 function showImage(fileCallPath){
		 //alert(fileCallPath);
		 $(".bigPictureWrapper").css("display","flex").show();
		 $(".bigPicture").html("<img src='/review/display?fileName="+fileCallPath+"'>").animate({width:'100%',height:'100%'},1000);
		 
	 }
	 
	 
	 //원본 이미지 창 닫기
	 $(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		},1000);
	 }); 
	
	
	var bnoValue='<c:out value="${board.bno}"/>';
	var review_replyUL = $(".chat");
	
	showList(1); //조회목록 가져오게하기위한 함수
	
	//게시글 조회시 댓글목록 가져오기위한 함수
	function showList(page){
		review_replyService.getList({bno:bnoValue,page:page||1 } , function(replyCnt,list){
			
			console.log("전체댓글 수:" +replyCnt);
			console.log("list : " +list)
			console.log(list.length);
			
			//page변수를 이용해 원하는 댓글페이지를 가져오게 하기위함 -1 경우 마지막페이지 찾아서 다시호출
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			
				if(list == null || list.length == 0){ // list = null 오타때문에 list값이 계속 오류나는 문제발생 해결
					review_replyUL.html("");
					return;
				}			
				
			
				for(var i = 0 ; i < list.length ; i++){
					str += "<li data-rno="+list[i].rno+"><div><div class='header'>";
					str += "<strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += "<small style='float:right'>"+review_replyService.displayTime(list[i].replyDate)+"</small></div>";
					str += "<p>"+list[i].reply+"</p></div></li>";
					
				}
			
			review_replyUL.html(str);
			showReplypage(replyCnt); // 게시글 조회하면서 페이징처리도 할수있도록 추가
		});
	}
	
	
	//댓글 추가하기위한 modal 관련
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $('#modalModBtn');
	var modalRemoveBtn = $('#modalRemoveBtn');
	var modalRegisterBtn = $('#modalRegisterBtn');
	
	var replyer = null; // 시큐리시 댓글/수정 시 서버쪽에서도 작성자를 사용할수있도록 만들어줌
	
	//스프링 시큐리티의 username을 replyer라는 변수로 처리할수있도록
	<sec:authorize access="isAuthenticated()">
		replyer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	
	//시큐리티처리를 위한 csrf 정보 
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	//댓글 등록 버튼 클릭시 modal창 보이기
	$("#addReplyBtn").on("click",function(e){
		
		modal.find("input").val("");;
		modal.find("input[name='replyer']").val(replyer); // 현재 로그인한 사용자의 이름으로 고정되도록
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id!='modalCloseBtn']").hide();
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
	});
	
	// Ajax로 토큰을 전송하는 방식이 아닌 기본설정으로 토큰을 전송하는 방식
	$(document).ajaxSend(function(e,xhr,options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue); 
	});
	
	//댓글 등록 처리
	modalRegisterBtn.on("click",function(e){
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
			};
		review_replyService.add(reply,function(result){
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide");
			
			//showList(1); //추가후 다시 댓글목록을 갱신
			showList(-1);
		});
	});
	
	
	//댓글 목록 클릭 이벤트처리
	$(".chat").on("click","li",function(e){
		var rno = $(this).data("rno");
		console.log(rno);
		review_replyService.get(rno,function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(review_replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
			modal.data("rno",reply.rno); //data-rno값 처리
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");			
		});
	});
	
	
	//댓글 수정 이벤트처리 (모달창에있는 data-rno 값으로)
	modalModBtn.on("click",function(e){
		
		var originalReplyer = modalInputReplyer.val();
		
		//기존의 작성자까지 같이전송
		var reply = {
				rno : modal.data("rno"),
				reply : modalInputReply.val(),
				replyer : originalReplyer
			};
		
		if(!replyer){
			alert("로그인후 수정이 가능합니다");
			modal.modal("hide");
			return;
		}
		
		console.log("Original Replyer : "+originalReplyer); // 댓글의 원래 작성자
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다");
			modal.modal("hide");
			return;
		}
		
		review_replyService.update(reply,function(result){
			alert(result);
			modal.modal("hide");
			//showList(1);
			showList(pageNum); //수정시 현재댓글이 포함된 페이지로이동
		});	
	});
	
	//댓글 삭제 이벤트처리 (모달창에있는 data-rno 값으로)
	modalRemoveBtn.on("click",function(e){
		var rno = modal.data("rno");
		
		console.log("RNO : " +rno);
		console.log("REPLYER : "+replyer);
		
		if(!replyer){
			alert("로그인후 삭제가 가능합니다");
			modal.modal("hide");
			return;
		}
		
		var originalReplyer = modalInputReplyer.val();
		console.log("Original Replyer : "+originalReplyer); // 댓글의 원래 작성자
		
		if(replyer != originalReplyer){
			alert("자신이 작성한 댓글만 삭제가 가능합니다");
			modal.modal("hide");
			return;
		}
		
		review_replyService.remove(rno,originalReplyer,function(result){
			alert(result);
			modal.modal("hide");
			//showList(1);
			showList(pageNum); //삭제시 현재댓글이 포함된 페이지로이동
		});
	});
	
	
	
	var pageNum = 1;
	var replyPageFooter = $(".page_footer");
	
	//댓글 페이징처리 (PageMaker의 JavaScript 버전으로 작성)
	function showReplypage(replyCnt){
		 
		 var endNum = Math.ceil(pageNum/10.0)*10;
		 var startNum = endNum - 9;
		 
		 var prev = startNum != 1;
		 var next = false;
		 
		 if(endNum * 10 >= replyCnt){
			 endNum = Math.ceil(replyCnt/10.0);
		 }
		 if(endNum * 10 < replyCnt){
			 next = true;
		 }
		 
		 
		 var str = "<ul class='pagination justify-content-md-end'>";
		 if(prev){
			 str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a><li>"
		 }
		 
		 for(var i = startNum ; i <= endNum ; i++){
			 var active = pageNum == i?"active":"";
			 str+="<li class='page-item"+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		 }
		 if(next){
			 str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
		 }
		 str+= "</ul></div>";
		 console.log(str);
		 replyPageFooter.html(str);
	 };
	
	//페이지 번호 클릭시 새로운 댓글 가져오도록 설정
	replyPageFooter.on("click","li a",function(e){
		 e.preventDefault();
	 	 console.log("page click");
	 	 
	 	 var targetPageNum = $(this).attr("href");
	 	 
	 	 console.log("targetPageNum:"+targetPageNum);
	 	 
	 	 pageNum = targetPageNum;
	 	 showList(pageNum);
	 });
	
	
	
	console.log(review_replyService);
	
	var operForm = $('#operForm');
	
	//버튼이동 스크립트 (Form)
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/review/modify").submit(); //수정페이지로 이동
	});
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove();
		operForm.attr("action","/review/list")
		operForm.submit();  //가지고있던 bno값을 지우고 list로 이동
	});
	
	
	
	
	
});
</script>