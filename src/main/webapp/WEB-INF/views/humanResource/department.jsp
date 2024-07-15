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
<link href="${path }/css/humanResource/department.css" rel="stylesheet" type="text/css">
<section class="department">
	<div class="department-div shadow bg-body rounded">
		<h2>부서 관리</h2>
		<div class="dept-btn-div">
			<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#create-modal">부서 생성하기</button>
		</div>
		<hr>
		<div class="dept-search-div">
			<form class="department-search-form">
				<div class="dropdown mb-4 address-department-select-button">
					<button class="btn btn-primary dropdown-toggle department-menu-title" type="button"
						id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">부서전체</button>
					<div class="dropdown-menu animated--fade-in department-menu" aria-labelledby="dropdownMenuButton"></div>
				</div>
			</form>
		</div>
		<div class="dept-table-div">
			<table class="dept-table table">
				<thead class="table-dark">
					<tr>
						<th>상위 부서</th>
						<th>부서 이름</th>
						<th>책임자</th>
						<th>사원수</th>
						<th></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		<div class="pagebar-div"></div>
		</div>
	</div>
</section>
</div>
<div class="modal" tabindex="-1" id="create-modal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">부서 생성</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		부서 이름 : <input type="text" placeholder="부서 이름 입력" id="newTitle"><br>
		상위 부서 선택 :
		<select class="modal-dept-select" name="departmentHighTitle"></select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="insertDepartment()">생성</button>
      </div>
    </div>
  </div>
</div>
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/department.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>