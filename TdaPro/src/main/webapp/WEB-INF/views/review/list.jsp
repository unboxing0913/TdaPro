<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- header -->
<%@include file="../includes/header.jsp" %>

<!-- list body -->

	<div class="col-lg-12">
		<h1 class="page-header">Review Page</h1>
		<hr>
		
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">		
		<button id='regBtn' type="button" class="btn btn-outline-dark btn-sm" style="margin-bottom: 5px">게시글 작성</button>
		</div>
	</div>





<table class="table table-bordered table-hover table-striped">
	<thead class="table-dark">
		<tr>
			<th scope="col" class="col-lg-1">#번호</th>
			<th scope="col" class="col-lg-7">제목</th>
			<th scope="col" class="col-lg-2">작성자</th>
			<th scope="col" class="col-lg-1">작성일</th>
			<th scope="col" class="col-lg-1">수정일</th>
		</tr>
	</thead>

	<c:forEach items="${list}" var="board">
	<tbody>
		<tr>		
			<th scope="row"><c:out value="${board.bno}"/></th>
			<td><a href='/review/get?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></td>
			<td><c:out value="${board.writer}"/></td>
			<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${board.updateDate}" pattern="yyyy-MM-dd"/></td>		
		</tr>
	</tbody>
	</c:forEach>

</table>

<!-- BootStrap의 modal 설정 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">알림</h4>
				<button type="button" class="btn-close" aria-label="Close"></button>	
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn-outline-secondary btn-lg" data-dismiss="modal">닫기</button>
				<button type="button" class="btn-outline-primary btn-lg">확인</button>
			</div>
		</div>
	</div>
</div>


<!-- footer -->
<%@include file="../includes/footer.jsp" %>

<!-- script -->

<script type="text/javascript">
$(document).ready(function(){
	
	// Controller에서 받아온 result 결과를 저장
	var result = '<c:out value="${result}"/>';	
	
	checkModal(result);
	
	history.replaceState({},null,null); //뒤로가기시 모달창 해결 
	
	//Modal 설정
	function checkModal(result){
		if(result == '' || history.state){ //뒤로가기시 모달창 해결
			return;
		}
		if(parseInt(result) > 0){
			$(".modal-body").html(parseInt(result)+"번 게시글이 등록 되었습니다.")
		}
		$("#myModal").modal("show");
	}
	
	
	//게시글 등록버튼
	$("#regBtn").on("click",function(){
		self.location = "/review/register";
	});

});

</script>

