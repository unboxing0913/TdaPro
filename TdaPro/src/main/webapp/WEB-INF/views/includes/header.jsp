<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TS Art Design</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
	integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"
	integrity="sha384-Atwg2Pkwv9vp0ygtn1JAojH0nYbwNJLPhwyoVbhoPwBhjQPR5VtM2+xf0Uwh9KtT"
	crossorigin="anonymous"></script>



<body>

	<div class="b-example-divider"></div>

	<nav class="py-2 bg-light border-bottom">
		<div class="container d-flex flex-wrap">
			<ul class="nav me-auto">
				<li class="nav-item"><a href="/"
					class="nav-link link-dark px-2 active" aria-current="page">Home</a></li>
				<li class="nav-item"><a href="/maps"
					class="nav-link link-dark px-2">오시는길</a></li>
				<li class="nav-item"><a href="/notice/list"
					class="nav-link link-dark px-2">공지사항</a></li>
				<li class="nav-item"><a href="/completion/list"
					class="nav-link link-dark px-2">완공게시판</a></li>
				<li class="nav-item"><a href="/review/list"
					class="nav-link link-dark px-2">후기</a></li>
			</ul>
			<ul class="nav">
			
			<!-- 로그인 / 로그아웃 헤더 설정 -->
			<sec:authorize access="isAnonymous()">	
				<li class="nav-item">
				<a href="/customLogin" class="nav-link link-dark px-2">Login</a></li>
			</sec:authorize>	
			<sec:authorize access="isAuthenticated()">	
				<li class="nav-item">
				<a href="/customLogout" class="nav-link link-dark px-2">LogOut</a></li>	
			</sec:authorize>		
			
				<li class="nav-item"><a href="/customSignUp" class="nav-link link-dark px-2">Sign up</a></li>
			</ul>
		</div>
	</nav>

	<header class="py-3 mb-4 border-bottom">
		<div class="container d-flex flex-wrap justify-content-center">
			<a href="/"
				class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
				<img src="/resources/images/logo.png" / width="40" height="32">
				&nbsp;&nbsp;&nbsp;<span class="fs-4">TS Art Design</span>
			</a>
		</div>
	</header>

	
	<div class="container d-flex flex-wrap">

	