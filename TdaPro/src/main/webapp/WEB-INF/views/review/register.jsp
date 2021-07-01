<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- header -->
<%@include file="../includes/header.jsp" %>

<!-- upload css -->
<link href="/resources/css/upload_css.css" rel="stylesheet" type="text/css">

<!-- register body -->
<div class="row">
	<div class="col-lg-12">
		<h1>Review Register Page</h1>
		<hr>
	</div>
</div>

<div class="col-lg-12 col-md-12 col-sm-12">
	
	<form role="form" action="/review/register" method="post">
		<div class="from-group">
			<label>제목</label><input class="form-control" name="title">
		</div>
		<br>
		<div class="from-group">
			<label>내용</label>
			<textarea class="form-control form-control-lg" name="content"></textarea>
		</div>
		<br>
		<div class="from-group">
			<label>작성자</label><input class="form-control" name="writer">
		</div>
		<hr>
		
		<button type="submit" class="btn btn-primary btn-lg">입력</button>
		<button type="reset" class="btn btn-secondary btn-lg">다시쓰기</button>
	
	</form>
	
	<br>

<!-- 첨부파일 부분 -->	
<div class="card mb-2">
	
	<div class="card-header bg-light">
	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-folder-symlink" viewBox="0 0 16 16">
	  <path d="m11.798 8.271-3.182 1.97c-.27.166-.616-.036-.616-.372V9.1s-2.571-.3-4 2.4c.571-4.8 3.143-4.8 4-4.8v-.769c0-.336.346-.538.616-.371l3.182 1.969c.27.166.27.576 0 .742z"/>
	  <path d="m.5 3 .04.87a1.99 1.99 0 0 0-.342 1.311l.637 7A2 2 0 0 0 2.826 14h10.348a2 2 0 0 0 1.991-1.819l.637-7A2 2 0 0 0 13.81 3H9.828a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 6.172 1H2.5a2 2 0 0 0-2 2zm.694 2.09A1 1 0 0 1 2.19 4h11.62a1 1 0 0 1 .996 1.09l-.636 7a1 1 0 0 1-.996.91H2.826a1 1 0 0 1-.995-.91l-.637-7zM6.172 2a1 1 0 0 1 .707.293L7.586 3H2.19c-.24 0-.47.042-.683.12L1.5 2.98a1 1 0 0 1 1-.98h3.672z"/>
	</svg>
	첨부파일
	</div>		
	
	<div class="card-body">			
		<div class="form-group uploadDiv">
			<input type="file" name='uploadFile' multiple>
		</div>
			
		<div class="uploadResult">
			<ul>
			</ul>
		</div>
	</div>
</div>

</div>	
<!-- footer -->
<%@include file="../includes/footer.jsp" %>


<script>
$(document).ready(function(e){
	
	var formObj = $("form[role='form']");
	
	// 입력 버튼 클릭
	$("button[type='submit']").on("click",function(e){
		e.preventDefault(); // 첨부파일을 위해 기본동작 막음
		console.log("등록버튼 클릭");
		
		var str="";
		
		// 입력시 파일정보 <input> hidden타입에 보관
		$(".uploadResult ul li").each(function(i,obj){
			var jobj = $(obj);
			console.dir(jobj);
			
			// name은 인덱스번호와 같은 이름을 사용
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});
		formObj.append(str).submit();
	});
	

	
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
			dataType: 'json',
			success:function(result){
				console.log(result);
				showUploadResult(result);  //업로드 결과 and 섬네일 (결과반영)
			}
		});
		
	})
	
	//업로드된 파일에 휴지통 버튼 클릭시 삭제
	$(".uploadResult").on("click","button",function(e){
		console.log("파일 삭제");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/review/deleteFile',
			data : {fileName: targetFile, type: type},
			dataType:'text',
			type:'POST',
			success:function(result){
				alert(result);
				targetLi.remove();
			}
		});
	});

	



});
</script>