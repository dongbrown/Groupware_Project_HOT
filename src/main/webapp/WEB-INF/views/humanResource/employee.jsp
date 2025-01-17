<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="${path }/css/humanResource/employee.css" rel="stylesheet" type="text/css">
<section class="employee">
	<div class="employee-div shadow bg-body rounded">
		<h2>사원 관리</h2>
		<div class="search-div">
			<div class="mb-1">
				<select id="keyword">
					<option value="1">사번</option>
					<option value="2">이름</option>
				</select>
				<input type="text" id="keywordValue">
			</div>
			<form id="searchForm">
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
					<label for="position1">
	            		<input type="checkbox" id="position1" name="positions" value="1">
	            		대표이사
	        		</label>
	        		<label for="position2">
	            		<input type="checkbox" id="position2" name="positions" value="2">
	            		부장
	        		</label>
	        		<label for="position3">
	            		<input type="checkbox" id="position3" name="positions" value="3">
	            		차장
	        		</label>
	        		<label for="position4">
	            		<input type="checkbox" id="position4" name="positions" value="4">
	            		과장
	        		</label>
	        		<label for="position5">
	            		<input type="checkbox" id="position5" name="positions" value="5">
	            		대리
	        		</label>
	        		<label for="position6">
	            		<input type="checkbox" id="position6" name="positions" value="6">
	            		사원
	        		</label>
				</div>
				<div class="mb-1">
					월급 : <input type="number" id="minSalary" name="minSalary"> ~ <input type="number" id="maxSalary" name="maxSalary">
				</div>
				<div class="mb-1">
					입사일 : <input type="date" id="minHire" name="minHire"> ~ <input type="date" id="maxHire" name="maxHire">
				</div>
				<div class="mb-1">
					퇴사일 : <input type="date" id="minResign" name="minResign"> ~ <input type="date" id="maxResign" name="maxResign">
				</div>
				<button type="button" class="btn btn-danger mb-1" onclick="searchEmployee(1)">검색하기</button>
			</form>
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
<div class="modal fade" tabindex="-1" id="update-modal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">사원 정보 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="updateEmp">
					<input type="hidden" name="employeeNo" required>
					이름 : <input type="text" name="employeeName" placeholder="이름" required><br><br>
					부서 : <select id="modalDept" name="departmentCode" required></select><br><br>
					직급 :
					<select id="modalPosition" name="positionCode" required>
						<option value='1'>대표이사</option>
						<option value='2'>부장</option>
						<option value='3'>차장</option>
						<option value='4'>과장</option>
						<option value='5'>대리</option>
						<option value='6'>사원</option>
					</select><br><br>
					월급 : <input type="number" name="employeeSalary" placeholder="월급" required><br><br>
					입사일 : <input type="date" name="employeeHireDate" required><br><br>
					퇴사일 : <input type="date" name="employeeResignationDay"><br><br>
					총 휴가일수 : <input type="number" placeholder="총 휴가일수" name="employeeTotalVacation" required><br><br>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" onclick="updateEmployee()">수정하기</button>
			</div>
		</div>
	</div>
</div>
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/employee.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>