<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%

%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/annEnroll.css" />

<script>
var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl)
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>