<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- member_header -->
<%@include file="./includes/member_header.jsp" %>
<title>로그아웃 페이지</title>
</head>

<body>

<h3 class="h-txt">로그아웃 페이지</h3>
<form role="form" action="/customLogout" method='post'>
<label>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }"/>
	<button class="btn btn-lg btn-success">로그아웃</button>
</label>
</form>


</body>

	

<!-- member_footer -->
<%@include file="./includes/member_footer.jsp" %>