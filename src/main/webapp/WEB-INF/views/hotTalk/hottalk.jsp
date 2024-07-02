<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
<link href="${path }/css/hotTalk/hottalk.css" rel="stylesheet">
<section>
	<div>
		<h4 class="page-title"> &nbsp; &nbsp; HotTalk</h4>
	</div>
	<i class="fas fa-cog"></i>
</section>
</div>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>
<script type="text/javascript" src="${path }/js/hotTalk/hottalk.js"></script>
