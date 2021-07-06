<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- member_header -->
<%@include file="./includes/member_header.jsp" %>
<title>회원가입</title>
</head>

<body>

<h3 class="h-txt">회원가입</h3>
  
<form method="post" action="/member/register"> 
 
  <label>
    <p class="label-txt">아이디 입력</p>
    <input type="text" class="input" name="userid">
    <div class="line-box">
      <div class="line"></div>
    </div>
  </label>
  <label>
    <p class="label-txt">이름</p>
    <input type="text" class="input" name="username">
    <div class="line-box">
      <div class="line"></div>
    </div>
  </label>
  <label>
    <p class="label-txt">비밀번호</p>
    <input type="password" class="input" name="userpw">
    <div class="line-box">
      <div class="line"></div>
    </div>
  </label>
  <button type="submit">가입</button>

</form>
</body>

<!-- member_footer -->
<%@include file="./includes/member_footer.jsp" %>