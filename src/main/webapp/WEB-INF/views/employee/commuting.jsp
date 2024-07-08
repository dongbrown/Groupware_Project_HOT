<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/employee/commuting.css" rel="stylesheet" type="text/css">
<section>
	<h2> 출퇴근 내역 </h2>
	<div>
		<div class="commuting-time-div">
			<div class="commuting-time">
				<div class="commuting-text">
					<span>출근 시간</span>				
					<span>출근 시간</span>				
				</div>
				<div class="commuting-text">
					<span>퇴근 시간</span>
					<span>퇴근 시간</span>
				</div>
			</div>
			<div class="commuting-btn-div">
				<button>출근</button>
				<button>퇴근</button>
			</div>
		</div>
		<div class="worktime-div">
			<p>이번달 근무 현황</p>
			<div class="commuting-text">
				<span>근무 일수</span>
				<span>근무 일수</span>
			</div>
			<div class="commuting-text">
				<span>연장 근무 시간</span>
				<span>연장 근무 시간</span>
			</div>
			<div class="commuting-text">
				<span>총 근무시간</span>
				<span>총 근무시간</span>
			</div>
		</div>
		<div class="attendance-div">
			<p>이번달 근태 현황</p>
			<div class="commuting-text">
				<span>지각</span>
				<span>지각</span>
			</div>
			<div class="commuting-text">
				<span>결근</span>
				<span>결근</span>
			</div>
			<div class="commuting-text">
				<span>연차</span>
				<span>연차</span>
			</div>
		</div>
	</div>
	<div class=commuting-table-div>
		<div>
			<p>출퇴근 기록</p>
			<div>
				<select>월</select>
			</div>
		</div>
		<div class=commuting-table id="commuting-table">
		
		</div>
	</div>
	<div class="pagebar-div">
	
	</div>
</section>
</div>
<script src='${path }/js/employee/commuting.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<script src='${path }/js/common/loading.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>