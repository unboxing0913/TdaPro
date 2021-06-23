<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
		
		
		
		
		<button type="submit" data-oper='modify' class="btn btn-primary btn-lg">수정</button>
		<button type="submit" data-oper='remove' class="btn btn-danger btn-lg">삭제</button>
		<button type="submit" data-oper='list' class="btn btn-secondary btn-lg">목록으로</button>
	
	</form>
	
</div>



<!-- footer -->
<%@include file="../includes/footer.jsp" %>



<!-- script -->
<script type="text/javascript">
$(document).ready(function(){
	
	var formObj = $("form");
	
	$('button').on("click",function(e){
		e.preventDefault(); // 버튼의 기본동작 막기
	
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){ 
			formObj.attr("action","/review/remove"); //삭제
		}else if(operation === 'list'){
			formObj.attr("action","/review/list").attr("method","get");
			formObj.empty();
		}
		
		formObj.submit();  // 수정
		
	});
	
	
})

</script>