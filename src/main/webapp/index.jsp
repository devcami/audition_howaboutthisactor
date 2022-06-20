<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>

.blink {
  -webkit-animation: blink 2.5s linear infinite;
} 
@-webkit-keyframes blink {
    0% { color: #8ac6d1; }
    20% { color: #bbded6 }
    40% { color: #fae3d9; }
    60% { color: #ffb6b9; }
    80% { color: #b5e4a3; }
    100% { color: #cba3e4; }
}

</style>
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
				<img src="<%=request.getContextPath()%>/images/movie.jpg" class="d-block w-100" alt="">
				<div class="carousel-caption d-none d-md-block">
					<h5>First slide label</h5>
					<p>Some representative placeholder content for the first slide.</p>
				</div>
			</div>
			<div class="carousel-item" data-bs-interval="6000">
				<img src="<%=request.getContextPath()%>/images/slate.jpg" class="d-block w-100" alt="">
				<div class="carousel-caption d-none d-md-block">
					<h5>Second slide label</h5>
					<p>Some representative placeholder content for the second slide.</p>
				</div>
			</div>
			<div class="carousel-item" data-bs-interval="6000">
				<img src="<%=request.getContextPath()%>/images/hollywood.jpg" class="d-block w-100" alt="">
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
		<div class="title">너 뭐 돼? 웅 나 <span class="point blink">배우어때</span></div>
		<br />
		<div class="subtitle">배우어때에서는 배우님들의 커리어를 탄탄하게 채워줄 각종 오디션 정보들을 지원하고 있으며  <br />
			프로덕션 관계자 여러분들께는 제작하고 있는 작품에 딱 맞는 배우님을 찾을 수 있도록 지원하고 있습니다. <br />
		</div>
		<div class="subtitle" id="mar">
			힘든 커리어 관리 <span class="point">그만 !!</span><br />
			맞는 작품, 배우 찾아다니기 <span class="point">그만 !!! </span><br />
			간편지원으로 빠른 지원과 편한 커리어 관리를 원하신다면 <span class="point blink">배우어때</span><br />
		</div>
		<div class="list">
			<div class="list-item">
				<div class="list-item-title">배우찾기</div>
				<div class="list-item-detail">나의 작품에 딱 맞는 배우찾기</div>
				<button class="list-item-button" 
				onclick="location.href='<%= request.getContextPath() %>/actor/actorList'">
				click</button>
			</div>
	
			<div class="list-item">
				<div class="list-item-title">공고찾기</div>
				<div class="list-item-detail">나에게 딱 맞는 작품찾기</div>
				<button class="list-item-button"
					onclick="location.href='<%= request.getContextPath() %>/ann/annListAsync'">
					click</button>
			</div>
			<div class="list-item">
				<div class="list-item-title">게시판</div>
				<div class="list-item-detail">다양한 정보를 공유해요 !</div>
				<button class="list-item-button"
					onclick="location.href='<%= request.getContextPath() %>/board/boardList'">
					click</button>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>