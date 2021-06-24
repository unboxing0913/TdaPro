<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			<label>게시글 번호</label><input class="form-control" name="bno" readonly="readonly" value="${board.bno}">
		</div>
		<br>
		
		<div class="from-group">
			<label>제목</label><input class="form-control" name="title" readonly="readonly" value="${board.title}">
		</div>
		<br>
		<div class="from-group">
			<label>내용</label>
			<textarea class="form-control form-control-lg" name="content" readonly="readonly">${board.content}</textarea>
		</div>
		<br>
		
		<div class="from-group">
			<label>작성자</label><input class="form-control" name="writer" readonly="readonly" value="${board.writer}">
		</div>
		<hr>
		
		<button class="btn btn-primary btn-lg" data-oper='modify'>수정하기</button>
		<button class="btn btn-secondary btn-lg" data-oper='list'>목록으로</button>
	
		<!-- 수정/삭제 페이지로 보내기위한 Form 처리 -->
		
		
		<form id='operForm' action="/review/modify" method="get">
			<input type="hidden" id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
			
			<!-- 페이지정보인 pageNum,amount (/get매핑 컨트롤러 매개변수로 받아옴) -->
			<input type="hidden"  name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			<input type="hidden"  name='amount' value='<c:out value="${cri.amount}"/>'>
		</form>
	
</div>


<!-- footer -->
<%@include file="../includes/footer.jsp" %>


<!-- script -->

<script type="text/javascript">
$(document).ready(function(){
	
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