<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 페이지 테스트 로그인한 사용자 아닌사용자 -->
<h1>all 페이지</h1>

<sec:autorize access="isAnonymous()">
	<a href="/customLogin">로그인</a>
</sec:autorize>
</body>
</html>