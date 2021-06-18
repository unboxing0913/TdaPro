<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<title>회원가입</title>
</head>
<style>
body {
  background: #C5E1A5;
}
form {
  width: 60%;
  margin: 60px auto;
  background: #efefef;
  padding: 60px 120px 80px 120px;
  text-align: center;
  -webkit-box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
  box-shadow: 2px 2px 3px rgba(0,0,0,0.1);
}
label {
  display: block;
  position: relative;
  margin: 40px 0px;
}
.label-txt {
  position: absolute;
  top: -1.6em;
  padding: 10px;
  font-family: sans-serif;
  font-size: .8em;
  letter-spacing: 1px;
  color: rgb(120,120,120);
  transition: ease .3s;
}
.input {
  width: 100%;
  padding: 10px;
  background: transparent;
  border: none;
  outline: none;
}

.line-box {
  position: relative;
  width: 100%;
  height: 2px;
  background: #BCBCBC;
}

.line {
  position: absolute;
  width: 0%;
  height: 2px;
  top: 0px;
  left: 50%;
  transform: translateX(-50%);
  background: #8BC34A;
  transition: ease .6s;
}

.input:focus + .line-box .line {
  width: 100%;
}

.label-active {
  top: -3em;
}

button {
  display: inline-block;
  padding: 12px 24px;
  background: rgb(220,220,220);
  font-weight: bold;
  color: rgb(120,120,120);
  border: none;
  outline: none;
  border-radius: 3px;
  cursor: pointer;
  transition: ease .3s;
}

button:hover {
  background: #8BC34A;
  color: #ffffff;
}

.h-txt{
	color: rgb(120,120,120);
}
</style>

<body>

<form>
  <h3 class="h-txt">회원가입</h3>
  <label>
    <p class="label-txt">아이디 입력</p>
    <input type="text" class="input" placeholder="Your ID" required autofocus>
    <div class="line-box">
      <div class="line"></div>
    </div>
  </label>
  <label>
    <p class="label-txt">비밀번호</p>
    <input type="password" class="input" placeholder="Password" required>
    <div class="line-box">
      <div class="line"></div>
    </div>
  </label>
  <label>
  	<label class="btn btn-outline-success" for="btncheck1">아이디 저장
    <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off" value="remember-me"></label>
  </label>
  <button type="submit">로그인</button>
  <button type="submit">회원가입</button>
</form>
</body>
<script>
$(document).ready(function(){

	  $('.input').focus(function(){
	    $(this).parent().find(".label-txt").addClass('label-active');
	  });

	  $(".input").focusout(function(){
	    if ($(this).val() == '') {
	      $(this).parent().find(".label-txt").removeClass('label-active');
	    };
	  });

	});
</script>
</html>

