<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div id="carouselExampleDark" class="carousel carousel-dark slide"
		data-bs-ride="carousel">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleDark"
				data-bs-slide-to="0" class="active" aria-current="true"
				aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleDark"
				data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleDark"
				data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active" data-bs-interval="6000"> <!-- 다음장 6초 -->
				<img src="<%=request.getContextPath()%>/images/indexPageTestPic.jpeg" class="d-block w-100" alt="">
				<div class="carousel-caption d-none d-md-block">
					<h5>First slide label</h5>
					<p>Some representative placeholder content for the first slide.</p>
				</div>
			</div>
			<div class="carousel-item" data-bs-interval="6000">
				<img src="<%=request.getContextPath()%>/images/indexPageTestPic.jpeg" class="d-block w-100" alt="">
				<div class="carousel-caption d-none d-md-block">
					<h5>Second slide label</h5>
					<p>Some representative placeholder content for the second slide.</p>
				</div>
			</div>
			<div class="carousel-item" data-bs-interval="6000">
				<img src="<%=request.getContextPath()%>/images/indexPageTestPic.jpeg" class="d-block w-100" alt="">
				<div class="carousel-caption d-none d-md-block">
					<h5>Third slide label</h5>
					<p>Some representative placeholder content for the third slide.</p>
				</div>
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleDark" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleDark" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>


	<div class="main">
	<div class="title">배우어때</div>
	<div class="subtitle">Lorem ipsum dolor sit, amet consectetur
		adipisicing elit.Consectetur necessitatibus commodi dolor illum esse
		laboriosam at numquam! Ipsam architecto, autem consequuntur et,
		perferendis voluptas officia, aspernatur quasi ratione in consectetur.
	</div>
	<div class="list">
		<div class="list-item">
			<div class="list-item-title">배우찾기</div>
			<div class="list-item-detail">Lorem ipsum dolor sit amet
				consectetur adipisicing elit.</div>
			<button class="list-item-button" 
			onclick="location.href='<%= request.getContextPath() %>/actor/actorSearch'">
			click</button>
		</div>

		<div class="list-item">
			<div class="list-item-title">공고찾기</div>
			<div class="list-item-detail">Lorem ipsum dolor sit amet
				consectetur adipisicing elit.</div>
			<button class="list-item-button"
				onclick="location.href='<%= request.getContextPath() %>/ann/annList'">
				click</button>
		</div>
		<div class="list-item">
			<div class="list-item-title">게시판</div>
			<div class="list-item-detail">Lorem ipsum dolor sit amet
				consectetur adipisicing elit.</div>
			<button class="list-item-button">click</button>
		</div>
	</div>
	<div class="fourth position-fixed"></div>
	<script>

	</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>