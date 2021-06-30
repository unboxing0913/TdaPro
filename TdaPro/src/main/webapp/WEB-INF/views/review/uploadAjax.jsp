<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
</head>
<style>
.uploadResult {
	width:100%;
	background-color:gray;
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}
.uploadResult ul li{
	list-style:none;
	padding:10px;
	align-content : center;
	text-align : center;
}
.uploadResult ul li img{
	width: 100px;
}
.uploadResult ul li span{
	color : white;
}
.bigPictureWrapper{
	position : absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top : 0%;
	width:100%;
	height: 100%;
	background-color: gray;
	z-index:100;
	background: rgba(255,255,255,0.5);
}
.bigPicture{
	postion:relative;
	display:flex;
	justify-content:center;
	align-items:center;
}
.bigPicture img{
	width:600px;
}
</style>
<body>
<h1>Upload With Ajax</h1>

<div class="uploadDiv">
	<input type='file' name='uploadFile' multiple>
</div>

<div class="uploadResult">
	<ul>
	</ul>
</div>

<button id='uploadBtn'>Upload</button>





<!-- Ajax 첨부파일을 보다 쉽게하기위한 jQuery추가 -->
<script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
<script>
	$(document).ready(function(){
		
		// 파일 확장자 , 크기  처리 ( 업로드 상세 처리 )
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName,fileSize){
			
			//크기
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			//확장자 종류
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드 할수 없습니다.");
				return false;
			}
			return true;
		}
		
		
		//파일 이름 출력
		var uploadResult = $(".uploadResult ul");		
		function showUploadedFile(uploadResultArr){
			var str = "";
			
			$(uploadResultArr).each(function(i,obj){
				
				//이미지 파일이 아닐경우에는 attach.png 로 보이게 수정
				if(!obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);//링크파일다운시 사용
					str += "<li><a href='/review/download?fileName="+fileCallPath+"'>"+"<img src='/resources/images/attach.png'>"+obj.fileName+"</a></li>";
				}else{
				//str += "<li>"+obj.fileName+"</li>";	
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);//링크파일다운시 사용
				// 한글처리와 데이터 섬네일 이미지 보여주기
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li><a href='/review/download?fileName="+fileCallPath+"'>"+"<img src='/review/display?fileName="+fileCallPath+"'></a></li>";
				}
			});
			
			uploadResult.append(str);
		}
		
		
		var cloneObj = $(".uploadDiv").clone(); // 첨부파일 후에 다시 첨부파일을 추가할수잇도록 클론을 만들어 보관
		
		//버튼클릭시 업로드
		$("#uploadBtn").on("click",function(e){
			var formData = new FormData(); //FormData (가상의 form태그)
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			console.log(files);
			
			for(var i = 0; i<files.length;i++){
				// checkExtension 함수로 업로드 상세처리
				if(!checkExtension(files[i].name,files[i].size)){
					return false;
				}
				formData.append("uploadFile",files[i]);
			}
			
			$.ajax({
				url :'/review/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json', // 매핑시 json타입 결과처리
				success : function(result){
					alert("Upload");
					console.log(result);
					showUploadedFile(result);  //첨부한 파일이름 출력
					
					//첨부파일추가 후 다시 추가할수있도록 클론사용
					$(".uploadDiv").html(cloneObj.html()); 
				}
			});
		});	
		
		
		
		
	});
</script>

</body>
</html>