<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/employee/vacation.css" rel="stylesheet" type="text/css">
<section class="vacation-section">
	<div class="vacation-div shadow-lg p-3 bg-body rounded">
		<h2 class="mb-5">휴가 내역</h2>
		<div class="vacation-card-div mb-5">
			<div class="vacation-card">
				<span>총 휴가 일수</span>
				<span class="totalVacation"></span>일
			</div>
			<div class="vacation-card">
				<span>사용한 휴가 일수</span>
				<span class="usedVacation"></span>일
			</div>
			<div class="vacation-card">
				<span>남은 휴가 일수</span>
				<span class="unusedVacation"></span>일
			</div>
		</div>
		<div class="vacation-table-div">
			<h4>휴가 사용 내역</h4>
			<select class="month-select mb-3"></select>
			<table class="table vacation-table">
				<thead class="table-dark">
					<tr>
						<th>휴가 신청 일자</th>
						<th>휴가 종류</th>
						<th>휴가 시작일</th>
						<th>휴가 종료일</th>
						<th>휴가 일수</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<div class="pagebar-div"></div>
	</div>
</section>
</div>
<script>const path='${path}'; const no=${loginEmployee.employeeNo};</script>
<script src='${path }/js/employee/vacation.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>