<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<section>
	<h2> 메인페이지 </h2>
	<button class="btn btn-primary btn-go-work">출근</button>
	<button class="btn btn-danger btn-leave-work">퇴근</button>
</section>
</div>
<script>
	const path='${path}';
	const no=${loginEmployee.employeeNo};
</script>
<script src="${path }/js/index.js"></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>