<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/employee/vacation.css" rel="stylesheet" type="text/css">
<section class="vacation-section">
	<h2>휴가~</h2>
	<div>
		<div>

		</div>
		<div>
			<h4>휴가 사용 내역</h4>
			<table>
				<tr>
					<th></th>
				</tr>
			</table>
		</div>
	</div>
</section>
</div>
<script>const path='${path}'; const no=${loginEmployee.employeeNo};</script>
<script src='${path }/js/employee/vacation.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>