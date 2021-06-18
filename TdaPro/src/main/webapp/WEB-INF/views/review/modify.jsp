<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1>Review Modify Page</h1>
		<hr>
	</div>
</div>

<div class="col-lg-12 col-md-12 col-sm-12">
	
	<form role="form" action="/review/register" method="post">
		
		<div class="from-group">
			<label>Bno</label><input class="form-control" name="bno" readonly="readonly">
		</div>
		<br>
		
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
			<label>작성자</label><input class="form-control" name="writer" readonly="readonly">
		</div>
		<hr>
		
		<button type="submit" class="btn btn-primary btn-lg">확인</button>
		<button type="submit" class="btn btn-danger btn-lg">삭제</button>
		<button type="submit" class="btn btn-secondary btn-lg">목록으로</button>
	
	</form>
	
	</div>
<%@include file="../includes/footer.jsp" %>