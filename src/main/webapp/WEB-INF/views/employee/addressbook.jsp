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
				<button class="btn btn-primary dropdown-toggle department-menu-title" type="button"
					id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">부서선택</button>
				<div class="dropdown-menu animated--fade-in department-menu" aria-labelledby="dropdownMenuButton"></div>
			</div>
			<div class="input-group">
				<input type="text" class="form-control border-0 small search-name"
					placeholder="이름 입력" aria-label="Search"
					aria-describedby="basic-addon2">
				<div>
					<button class="btn btn-primary search-btn" type="button" onclick="searchEmployee(1)">
						<i class="fas fa-search fa-sm"></i>
					</button>
				</div>
			</div>
		</form>
	</div>
	<div class="card-div"></div>
	<div class="pagebar-div"></div>
</section>
</div>
<script>const path='${path}'; const searchName='${name}';</script>
<script src='${path }/js/employee/addressbook.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<script src='${path }/js/common/loading.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>