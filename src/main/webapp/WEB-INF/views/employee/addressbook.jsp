<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/employee/addressbook.css" rel="stylesheet" type="text/css">
<section class="address">
	<div class="address-title">
		주소록
	</div>
	<div class="address-search-div">
		<form class="address-search-form">
			<div class="dropdown mb-4 address-department-select-button">
				<button class="btn btn-primary dropdown-toggle" type="button"
					id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">부서선택</button>
				<div class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton">
					<c:forEach items="${departments }" var="d">
						<c:if test="${d.departmentHighCode le 1 }">
							<a class="dropdown-item" href="#">${d.departmentTitle }</a>
						</c:if>
						<c:if test="${d.departmentHighCode gt 1 }">
							<a class="dropdown-item" href="#">--${d.departmentTitle }</a>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="input-group">
				<input type="text" class="form-control border-0 small"
					placeholder="이름 입력" aria-label="Search"
					aria-describedby="basic-addon2">
				<div>
					<button class="btn btn-primary" type="button">
						<i class="fas fa-search fa-sm"></i>
					</button>
				</div>
			</div>
		</form>
	</div>
	<div class="card-div">
		<c:forEach items="${employees }" var="e">
			<div class="border-left-primary address-card">
				<div class="card-left-div">
					<div class="img-div">
						<c:if test="${not empty e.employeePhoto }">
							<img src="${path }/upload/employee/${e.employeePhoto }" class="employee-img">
						</c:if>
						<c:if test="${empty e.employeePhoto }">
							<img src="${path }/images/undraw_profile.svg" class="employee-img">
						</c:if>
					</div>
				</div>
				<div class="employee-info-div">
					<span>
						<c:out value="${e.employeeName }"/>
						<c:out value=" ${e.positionCode.positionTitle }"/>
					</span>
					<span><c:out value="${e.departmentCode.departmentTitle }"/></span>
					<span><c:out value="${e.employeeId }@hot.com"/></span>
					<span><c:out value="${e.employeePhone }"/></span>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="pagebar-div">

	</div>
</section>
</div>
<script>const path='${path}';</script>
<script src='${path }/js/employee/addressbook.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>