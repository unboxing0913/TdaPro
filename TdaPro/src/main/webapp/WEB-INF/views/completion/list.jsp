<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- header -->
<%@include file="../includes/header.jsp" %>

<!-- list body -->

	<div class="col-lg-12">
		<h1 class="page-header">Completion Page</h1>
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
			<%-- <td><a href='/completion/get?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></td> 
			get.jsp -> 목록버튼 클릭시 파라미터 pageNum과 amount를 같이 전달하기위해 밑의 방법으로 <a>태그를 javaScript로 해결 --%>
			<td>
			<a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/>
			<!-- 게시글 댓글수 -->
			<b>[<c:out value="${board.replyCnt}"/>]</b>
			</a>
			<td><c:out value="${board.writer}"/></td>
			<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${board.updateDate}" pattern="yyyy-MM-dd"/></td>		
		</tr>
	</tbody>
	</c:forEach>

</table>

<!-- 검색처리 -->
<form id='searchForm' action="/completion/list" method='get'>
	<select name='type'>
		<option value="" ${pageMaker.cri.type == null?"selected":"" }>--</option>
		<option value="T" ${pageMaker.cri.type eq 'T'?"selected":"" }>제목</option>
		<option value="C" ${pageMaker.cri.type eq 'C'?"selected":"" }>내용</option>
		<option value="W" ${pageMaker.cri.type eq 'W'?"selected":"" }>작성자</option>
		<option value="TC" ${pageMaker.cri.type eq 'TC'?"selected":"" }>제목 or 내용</option>
		<option value="TW" ${pageMaker.cri.type eq 'TW'?"selected":"" }>제목 or 작성자</option>
		<option value="TWC" ${pageMaker.cri.type eq 'TWC'?"selected":"" }>제목 or 내용 or 작성자</option>
	</select> 
	<input type="text" name="keyword" value='${pageMaker.cri.keyword }' />
	<input type='hidden' name="pageNum" value='${pageMaker.cri.pageNum }'>
	<input type='hidden' name="amount" value='${pageMaker.cri.amount }'>
	<button class="btn btn-default">Search</button>

</form>


<!-- page -->
<div class="col-lg-12">
<nav aria-label="Page navigation example" >
	<ul class="pagination justify-content-md-end"> 					
		<c:if test="${pageMaker.prev}">  <!-- 이전 -->
		<li class="page-item"><a class="page-link" href="${pageMaker.startPage-1}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
		</c:if>
			
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		<li class="page-item"><a class="page-link" href="${num}">${num}</a></li>
		</c:forEach>
			
		<c:if test="${pageMaker.next }">
		<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1}"aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
		</c:if>		
	</ul>
</nav>
</div>

<!-- page 이벤트 처리를 위함 ( <a>태그 대신 JavaScript ) -->
<form id="actionForm" action="/completion/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	<!-- 검색후 페이지이동시 검색조건 포함 -->
	<input type="hidden" name="type" value="${pageMaker.cri.type}">
    <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
</form>

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
		self.location = "/completion/register";
	});
	
	
	//page번호 이벤트
	 var actionForm = $("#actionForm");
	 
	 $(".page-item a").on("click",function(e){
		 e.preventDefault();
		 console.log('click');
		 actionForm.find("input[name='pageNum']").val($(this).attr("href")); //pageNum의 값을 href 속성으로 변경
		 actionForm.submit();
	 });
	 
	 //게시물 제목클릭시 hidden타입의 input을  get.jsp 전송 (pageNum과 amount 파라미터가 같이전송된다)
	 $(".move").on("click",function(e){
		 e.preventDefault();
	 	 actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
	 	 actionForm.attr("action","/completion/get");
	 	 actionForm.submit();
	 }); 
	 
	 //검색버튼 이벤트처리 (검색1페이지 , 입력 안할시 경고창)
	 var searchForm = $("#searchForm");
	 $("#searchForm button").on("click",function(e){	
		console.log(".............click");
		
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요");
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();
	 });

});

</script>

