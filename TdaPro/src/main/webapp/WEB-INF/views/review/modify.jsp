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
		}
		
		formObj.submit();  // 수정
		
	});
	
	
})

</script>