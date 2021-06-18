<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1>Estimate Read Page</h1>
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
			<label>제목</label><input class="form-control" name="title" readonly="readonly">
		</div>
		<br>
		<div class="from-group">
			<label>내용</label>
			<textarea class="form-control form-control-lg" name="content" readonly="readonly"></textarea>
		</div>
		<br>
		
		<div class="from-group">
			<label>작성자</label><input class="form-control" name="writer" readonly="readonly">
		</div>
		<hr>
		
		<button type="submit" class="btn btn-primary btn-lg">수정</button>
		<button type="submit" class="btn btn-secondary btn-lg">목록으로</button>
	
	</form>
	
	</div>
<%@include file="../includes/footer.jsp" %>