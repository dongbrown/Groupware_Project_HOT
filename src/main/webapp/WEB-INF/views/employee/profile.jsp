<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/employee/profile.css" rel="stylesheet" type="text/css">
<section class="profile-section">
	<div class="profile-div shadow p-3 mb-5 bg-body rounded-4">
		<div class="photo-div">
			<img src="${path }/upload/employee/${loginEmployee.employeePhoto }" class="employee-photo">
			<form method="POST" enctype="multipart/form-data" action="${path }/employeePhotoUpdate">
				<button type="submit" class="btn btn-primary photo-change-btn">이미지 변경</button>
			</form>
		</div>
		<div class="info-div">
			<div class="name-dept">
				<span>${loginEmployee.employeeName }</span>
				<span>${loginEmployee.positionCode.positionTitle }</span>
			</div>
			<div class="other-info">
				<span>${loginEmployee.departmentCode.departmentTitle }</span>
				<span>${loginEmployee.employeeHireDate } 입사</span>
				<span>${loginEmployee.employeeAddress }</span>
				<span>${loginEmployee.employeeBirthDay }</span>
				<span>${loginEmployee.employeePhone }</span>
			</div>
			<button class="btn btn-primary emp-update-btn">수정하기</button>
		</div>
	</div>
</section>
</div>
<script>const path='${path}'; const no=${loginEmployee.employeeNo};</script>
<script src='${path }/js/employee/profile.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>