<%@include file="./includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	
	<div class="container d-flex flex-wrap">

	<div id="carouselExampleCaptions" class="carousel slide"
		data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleCaptions"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="/resources/images/1.jpg" class="d-block w-auto" alt="사진1">
				<div class="carousel-caption d-none d-md-block">
					<h5>TS Art Design</h5>
					<p>We like creative work</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="/resources/images/2.png" class="d-block w-auto" alt="사진2">
				<div class="carousel-caption d-none d-md-block">
					<h5>TS Art Design</h5>
					<p>We like creative work</p>
				</div>
			</div>
			<div class="carousel-item">
				<img src="/resources/images/3.png" class="d-block w-auto" alt="사진3">
				<div class="carousel-caption d-none d-md-block">
					<h5>TS Art Design</h5>
					<p>We like creative work</p>
				</div>
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	

	</div>
	
	<br>
	<br>

	<div class="container pt-3">
		<div class="row">
			<div class="col-sm-4">
				<h2>About TS Art Design</h2>
				<p>쾌적함과 편리함을 넘어 감성적인 만족을 중시!</p>
				<img src="/resources/images/submain1.jpg" class="img-fluid">
				<p>단 한번의 공사로 끝나는 인연이아닌 고객과<br>항시 소통하며 발빠른 as로 보답하겠습니다.</p>
			</div>
			
			<div class="col-sm-4">
				<h2>High-Quality</h2>
				<p>고객의 라이프스타일을 반영</p>
				<img src="/resources/images/submain2.jpg" class="img-fluid">
				<p>창조적인 아이디어와 감각으로 여러분의 공간을 아름답게 해드릴것을 약속드립니다.</p>
			</div>
			
			<!-- right content -->
			<div class="col-sm-4">
				<h2>Counseling</h2>
				<p>무료 견적 문의 상담은 <br>
					평일 <span class="text-primary">09:00 - 18:00</span> 까지 입니다.<br>
					상담신청은 신청후 예약제로 운영되고있습니다.</p>
				<a href="#"><img src="/resources/images/counseling.png" class="img-fluid"></a>
			</div>
		</div>
	</div>


<%@include file="./includes/footer.jsp" %>	