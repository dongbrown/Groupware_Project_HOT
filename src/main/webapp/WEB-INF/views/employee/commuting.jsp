<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/employee/commuting.css" rel="stylesheet" type="text/css">
<section class="commuting-section">
	<h2 class="commuting-title-text"> 출퇴근 내역 </h2>
	<div class="commuting-cards-div">
		<div class="commuting-card shadow-lg p-3 mb-5 bg-body rounded">
			<h4>오늘 출퇴근 시간</h4>
			<div class="commuting-card-text">
				<div class="commuting-text">
					<span>출근 시간</span>
					<span>퇴근 시간</span>
				</div>
				<div class="commuting-text work-time"></div>
			</div>
		</div>
		<div class="commuting-card shadow-lg p-3 mb-5 bg-body rounded">
			<h4 class="work-title">월 근무 현황</h4>
			<div class="commuting-card-text">
				<div class="commuting-text">
					<span>근무 일수</span>
					<span>연장 근무 시간</span>
					<span>총 근무시간</span>
				</div>
				<div class="commuting-text total-work"></div>
			</div>
		</div>
		<div class="commuting-card shadow-lg p-3 mb-5 bg-body rounded">
			<h4 class="att-title">월 근태 현황</h4>
			<div class="commuting-card-text">
				<div class="commuting-text">
					<span>지각</span>
					<span>결근</span>
					<span>연차</span>
				</div>
				<div class="commuting-text att-count"></div>
			</div>
		</div>
	</div>
	<div class="commuting-table-div shadow-lg p-3 mb-3 bg-body rounded">
		<div class="commuting-table-title-div">
			<h4 style="margin-bottom:0; margin-right:2%;">출퇴근 기록</h4>
				<select class="month-select"></select>
		</div>
		<div class="commuting-table" id="commuting-table">
			<table class="com-table">
				<thead class="table-dark">
					<tr>
						<th>근무 일자</th>
						<th>출근 시간</th>
						<th>퇴근 시간</th>
						<th>근무 상태</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>
	<div class="pagebar-div"></div>
</section>
</div>
<script>const path='${path}'; const no=${loginEmployee.employeeNo};</script>
<script src='${path }/js/employee/commuting.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<script src='${path }/js/common/loading.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>