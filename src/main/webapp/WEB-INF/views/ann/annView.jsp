<%@page import="common.model.dto.Cast"%>
<%@page import="common.model.dto.WorkAttachment"%>
<%@page import="java.util.List"%>
<%@page import="common.model.dto.Work"%>
<%@page import="ann.model.dto.AnnExt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ann.css" />
<% 
	AnnExt ann = (AnnExt) request.getAttribute("ann");
	Work work = ann.getWork();
	List<WorkAttachment> workAttachments = work.getAttachments();
	Cast cast = work.getCast();
%>
<section id="ann-view-container">
	<div class="container">
		<div class="ann-info">
			<h2 id="ann-title"><%= ann.getAnnTitle() %></h2>
			<span id="cast-role"><%= cast.getCastRole() %></span>&nbsp;|&nbsp;<span id="cast-name"><%= cast.getCastName() %>역</span>
			<h5 id="work-title"> <%= work.getProduction() %>&nbsp;|&nbsp;<%= work.getDirector() %>&nbsp;|&nbsp;<<%= work.getTitle() %>> </h5>
			<hr />
			<p><%= ann.getAnnEndDate() %> 마감 | <%= ann.getAnnRegDate() %> 게시</p>
			<button id="btn-apply">간편지원</button>
		</div>
		<hr />
		<div class="work-info">
		</div>	
		<div class="work-content">
		</div>
		<div class="cast-info">
		</div>
		<div class="attachments">
		</div>
	</div>

</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
