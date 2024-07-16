<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="${path }/css/humanResource/employee.css" rel="stylesheet" type="text/css">
<section class="employee">
	<div class="employee-div shadow bg-body rounded">
		<h2>사원 관리</h2>
		<div class="search-div">
			<div class="mb-1">
				<select id="keyword">
					<option>사번</option>
					<option>이름</option>
				</select>
				<input type="text" id="keywordValue">
			</div>
			<div>
				<div class="dropdown mb-1 department-select-button">
					<button class="btn btn-primary dropdown-toggle department-menu-title" type="button"
						id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">부서전체</button>
					<div class="dropdown-menu animated--fade-in department-menu" aria-labelledby="dropdownMenuButton"></div>
				</div>
			</div>
			<div class="position-checkbox-div">
				직급 :
			</div>
			<div class="mb-1">
				월급 : <input type="number" id="minSalary"> ~ <input type="number" id="maxSalary">
			</div>
			<div class="mb-1">
				입사일 : <input type="date" id="minHire"> ~ <input type="date" id="minHire">
			</div>
			<div class="mb-1">
				퇴사일 : <input type="date" id="minResign"> ~ <input type="date" id="minResign">
			</div>
			<button class="btn btn-danger mb-1">검색하기</button>
		</div>
		<div class="table-div">
			<table class="table emp-table">
				<thead class="table-dark">
					<tr>
						<th>사번</th>
						<th>부서</th>
						<th>직급</th>
						<th>이름</th>
						<th>아이디</th>
						<th>휴대폰번호</th>
						<th>주소</th>
						<th>생년월일</th>
						<th>월급</th>
						<th>입사일</th>
						<th>퇴사일</th>
						<th>총 휴가일수</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		<div class="pagebar-div"></div>
		</div>
	</div>
</section>
</div>
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/employee.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>