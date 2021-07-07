<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- member_header -->
<%@include file="./includes/member_header.jsp" %>
<title>로그인</title>
</head>
<body>

<h2><c:out value="${error}"/></h2>
<h2><c:out value="${logout}"/></h2>
  
  <form role="form" method="post" action="/login">
  <label>
    <p class="label-txt">아이디 입력</p>
    <input type="text" class="input" placeholder="ID" name="username" autofocus>
    <div class="line-box">
      <div class="line"></div>
    </div>
  </label>
  <label>
    <p class="label-txt">비밀번호</p>
    <input type="password" class="input" placeholder="password" name="password">
    <div class="line-box">
      <div class="line"></div>
    </div>
  </label>
  <label>
  	<label class="btn btn-outline-success" for="btncheck1">아이디 저장
    <input type="checkbox" class="btn-check" id="btncheck1" name="remember-me"></label>
  </label>
  <button type="submit" name="loginBtn">로그인</button>
  <br>
  <br>
  <a href="/customSignUp">회원가입</a>
  
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }"/> <!-- 사이트간 위조 방지 목적 -->

</form>
</body>


<!-- script -->
<script>

//로그인버튼클릭시 전송
$("#loginBtn").on("click",function(e){
	e.preventDefault();
	$("form").submit();
});


</script>

<!-- member_footer -->
<%@include file="./includes/member_footer.jsp" %>

