<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="${path }/css/humanResource/allEmpVacation.css" rel="stylesheet" ty	pe="text/css">
<section class="allEmpVacation-section">
	<div class="allEmpVacation-div">
		<h2>전 사원 휴가내역</h2>
		<div class="search-div">
			<form id="searchForm" class="search-form">
				<input type="date" name="searchDate" class="mr-1">
				<select id="department" name="departmentCode" class="mr-1">
					<option value="0">부서 전체</option>
				</select>
				<select id="status" name="status" class="mr-1">
					<option value="">전체</option>
					<option value="연차">연차</option>
					<option value="반차">반차</option>
					<option value="병가">병가</option>
					<option value="육아휴직">육아휴직</option>
					<option value="출산휴가">출산휴가</option>
				</select>
                <div class="input-group">
                    <input type="text" name="employeeName" class="form-control bg-light border-0 small" placeholder="이름 검색"
                        aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button" onclick="">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
			</form>
		</div>
		<div class="table-div">
			<table class="table v-table">
				<thead class="table-dark">
					<tr>
						<th>사번</th>
						<th>이름</th>
						<th>직급</th>
						<th>부서</th>
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
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/allEmpVacation.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>