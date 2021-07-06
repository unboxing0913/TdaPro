<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- upload css -->
<link href="/resources/css/upload_css.css" rel="stylesheet" type="text/css">

<!-- header -->
<%@include file="../includes/header.jsp" %>



<!-- modify body -->
<div class="row">
	<div class="col-lg-12">
		<h1>Review Modify Page</h1>
		<hr>
	</div>
</div>

<div class="col-lg-12 col-md-12 col-sm-12">
	
	<form role="form" action="/review/modify" method="post">
		
		<!-- POST방식이 처리되는 부분이므로 CSRF 토큰 추가 -->
		<input type="hiiden" name="${_csrf.parameterName}" value="${_csrf.token }"/>
		
		<!-- 페이징처리를 위한 hidden타입의 input -->
		<input type='hidden' name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
		<input type='hidden' name="amount" value='<c:out value="${cri.amount }"/>'>
		<!-- 수정/삭제 페이지의 검색 처리 -->
		<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
    	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
		
		<div class="from-group">
			<label>게시글 번호</label><input class="form-control" name="bno" readonly="readonly" value='<c:out value="${board.bno}"/>'>
		</div>
		<br>
		
		<div class="from-group">
			<label>제목</label><input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
		</div>
		<br>
		<div class="from-group">
			<label>내용</label>
			<textarea class="form-control form-control-lg" name="content"><c:out value="${board.content}"/></textarea>
		</div>
		<br>
		
		<div class="from-group">
			<label>작성자</label><input class="form-control" name="writer" readonly="readonly" value='<c:out value="${board.writer}"/>'>
		</div>
		<hr>
		
		<div class="from-group">
			<label>RegDate</label><input class="form-control" name="regDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' >
		</div>
		
		<div class="from-group">
			<label>Update Date</label><input class="form-control" name="updateDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' >
		</div>
		<br>
		
		
		<!-- 조회와 마찬가지로 현재 로그인 한 사용자가 게시물의 작성자인 경우에만 수정/삭제가 가능하도록 제어 -->
		
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
			<c:if test="${prinfo.username eq board.writer}">
				<button type="submit" data-oper='modify' class="btn btn-primary btn-lg">수정</button>
				<button type="submit" data-oper='remove' class="btn btn-danger btn-lg">삭제</button>
			</c:if>
		</sec:authorize>
		
		<button type="submit" data-oper='list' class="btn btn-secondary btn-lg">목록으로</button>
	
	</form>
	


<!-- 첨부파일 화면처리 -->
<div class="card mb-2">
	
	<div class="card-header bg-light">
	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-files" viewBox="0 0 16 16">
  		<path d="M13 0H6a2 2 0 0 0-2 2 2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h7a2 2 0 0 0 2-2 2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm0 13V4a2 2 0 0 0-2-2H5a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1zM3 4a1 1 0 0 1 1-1h7a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V4z"/>
	</svg>
	Files
	</div>		
	
	<div class="card-body">	
	
		<!-- 수정시 버튼과 파일교체를 위함 -->
		<div class="form-group uploadDiv">
			<input type="file" name='uploadFile' multiple>
		</div>
		<br>
		
		<!-- 첨부파일 보여지는 영역  -->	
		<div class="uploadResult">
			<ul>
			</ul>
		</div>
		
	</div>
	
</div>

</div>
<!-- footer -->
<%@include file="../includes/footer.jsp" %>



<!-- script -->
<script type="text/javascript">
$(document).ready(function(){
	
	//해당 게시물의 첨부파일을 가져오는부분 (가장먼저 동작해야함)
	(function(){
		var bno = '<c:out value="${board.bno}"/>';
		$.getJSON("/review/getAttachList",{bno:bno},function(arr){
			console.log(arr);
			var str = "";
			
		    //수정시 첨부파일을 보여주기위한 스크립트
			$(arr).each(function(i,attach){
				
			//image type
			if(attach.fileType){
				var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<span>"+attach.fileName+"</span>&nbsp&nbsp";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-outline-warning'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash' viewBox='0 0 16 16'>";
				str += "<path d='M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z'/>";
				str += "<path fill-rule='evenodd' d='M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z'/>";
				str += "</svg>";
				str += "</button><br><br>";
				str += "<img src='/review/display?fileName="+fileCallPath+"' class='img-responsive img-thumbnail'>";
				str += "</div>";
				str += "</li>"
			}else{
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<span>"+attach.fileName+"</span>&nbsp&nbsp";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-outline-warning'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash' viewBox='0 0 16 16'>";
				str += "<path d='M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z'/>";
				str += "<path fill-rule='evenodd' d='M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z'/>";
				str += "</svg>";
				str += "</button><br><br>";
				str += "<img src='/resources/images/attach.png' class='img-responsive img-thumbnail'>";
				str += "</div>";
				str += "</li>";
				}
			});
		
			$(".uploadResult ul").html(str);
		});
	})();
	
	
	//휴지통 버튼 클릭시 화면에서 이미지삭제
	$(".uploadResult").on("click","button",function(e){
		console.log("삭제 버튼 클릭");
		
		//삭제 여부묻기 확인클릭시 true
		if(confirm("정말 삭제하시겠습니까?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	
	//첨부파일 추가
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB
	
	//파일처리 함수
	function checkExtension(fileName,fileSize){
		
		//파일크기 5MB 이상 초과시
		if(fileSize >= maxSize){
			alert("파일 크기를 초과 하였습니다.");
			return false;
		}
		
		//업로드가 불가능한 파일 조건처리
		if(regex.test(fileName)){
			alert("업로드가 불가능한 파일 종류입니다.");
			return false;
		}
		
		return true;
	}
	
	//업로드 결과 and 섬네일
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
		}
		var uploadUL = $(".uploadResult ul");
		var str = "";
		
		$(uploadResultArr).each(function(i,obj){
			
			//이미지 타입에 맞춰 결과반영 휴지통(삭제) 버튼 도입   (테스트시에는 image필드로 현재는 fileType으로 수정)
			if(obj.fileType){
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"; //hidden으로 전달할 정보
				str += "<div>";
				str += "<span>"+obj.fileName+"</span>&nbsp&nbsp";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-outline-warning'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash' viewBox='0 0 16 16'>";
				str += "<path d='M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z'/>";
				str += "<path fill-rule='evenodd' d='M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z'/>";
				str += "</svg>";
				str += "</button><br><br>";
				str += "<img src='/review/display?fileName="+fileCallPath+"'class='img-responsive img-thumbnail'>";
				str += "</div>";
				str += "</li>";
			}else{
			    var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			    str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'>"; //hidden으로 전달할 정보
				str += "<div>";
				str += "<span>"+obj.fileName+"</span>&nbsp&nbsp";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-outline-warning'>";
				str += "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash' viewBox='0 0 16 16'>";
				str += "<path d='M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z'/>";
				str += "<path fill-rule='evenodd' d='M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z'/>";
				str += "</svg>";
				str += "</button><br><br>";
				str += "<img src='/resources/images/attach.png' class='img-responsive img-thumbnail'>";
				str += "</div>";
				str += "</li>";
			}	
			
			
		});
		
		uploadUL.append(str);
	}
	
	//시큐리티처리를 위한 csrf 정보 
	var csrfHeaderName="${_csrf.headerName}";
	var csrfTokenValue="${_csrf.token}";
	
	//file추가시 검사
	$("input[type='file']").change(function(e){
		var formData = new FormData(); //FormData (가상의 form태그)
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		// checkExtension 함수로 파일처리
		for(var i = 0 ; i < files.length ; i++){
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}			
			formData.append("uploadFile",files[i]);		
		}
		
		
		$.ajax({
			url:'/review/uploadAjaxAction',
			processData : false,
			contentType : false,
			data: formData,
			type: 'POST',
			beforSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue); // CSRF토큰 값을 전달
			},
			dataType: 'json',
			success:function(result){
				console.log(result);
				showUploadResult(result);  //업로드 결과 and 섬네일 (결과반영)
			}
		});
		
	})
	
	
	
	var formObj = $("form");
	
	// 버튼처리
	$('button').on("click",function(e){
		e.preventDefault(); // 버튼의 기본동작 막기
	
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){ 
			formObj.attr("action","/review/remove"); //삭제
			
		}else if(operation === 'list'){
			formObj.attr("action","/review/list").attr("method","get");
			
			//페이징 처리 부분
			var pageNumTag = $("input[name='pageNum']").clone(); //clone()을 사용해 새로만든 var에 내용을 저장
			var amountTag = $("input[name='amount']").clone();
			
			//검색 처리 부분
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			
			formObj.empty(); //버튼이 list일때 안의 내용 비우기
			formObj.append(pageNumTag); // 수정/삭제를 취소한뒤 필요한 pageNum과 amount만을 가지고 돌아감
			formObj.append(amountTag)
			formObj.append(typeTag); 
			formObj.append(keywordTag); 
		}else if(operation === 'modify'){ //수정버튼 이벤트처리
			console.log("submit clicked");
			var str = "";
			$(".uploadResult ul li").each(function(i,obj){
				var jobj = $(obj);
				console.dir(jobj);
				
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			formObj.append(str).submit();
		}	
		formObj.submit();  // 수정		
	});
	
	
})

</script>