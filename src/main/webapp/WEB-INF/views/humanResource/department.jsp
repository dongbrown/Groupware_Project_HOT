<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/humanResource/department.css" rel="stylesheet" type="text/css">
<section class="department">
	<div class="department-title">
		부서 관리
	</div>

</section>
</div>
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/department.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>