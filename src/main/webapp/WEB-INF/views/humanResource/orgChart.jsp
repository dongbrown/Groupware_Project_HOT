<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/humanResource/orgChart.css" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/apextree"></script>
<section class="org-section">
	<div class="org-div">
		<div id="svg-tree"></div>
	</div>
</section>
</div>
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/orgChart.js'></script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>