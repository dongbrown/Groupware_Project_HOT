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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="${path }/css/humanResource/createEmployee.css" rel="stylesheet" type="text/css">
<section class="createEmployee">
	<div class="createEmployee-div shadow bg-body rounded mb-4">
		<h2>사원 계정 생성</h2>
		<div class="create-div">
			<form id="createForm">
				<div class="id-div mb-0">
					아이디 : <input type="text" placeholder="아이디" name="employeeId" style="margin-left:5px;" required><p style="color:red;font-size:0.9rem"></p>
				</div>
				비밀번호 : <input type="text" name="employeePassword" value="1234" readonly style="background-color: lightgray;"><br>
				부서 : <select name="departmentCode" required></select><br>
				직급 :
					<select name="positionCode" required>
						<option value='1'>대표이사</option>
						<option value='2'>부장</option>
						<option value='3'>차장</option>
						<option value='4'>과장</option>
						<option value='5'>대리</option>
						<option value='6'>사원</option>
					</select><br>
				이름 : <input type="text" name="employeeName" placeholder="이름" required><br>
				주민등록번호 : <input type="text" name="preSsn" required> - <input type="text" name="postSsn" required><br>
				휴대폰 번호 : <input type="text" placeholder="핸드폰번호 입력, '-'빼고 입력하세요 " name="employeePhone" required><br>
				주소 :
					<input type="button" onclick="sample2_execDaumPostcode()" value="주소 찾기"><br>
					<input type="text" id="address" placeholder="주소" style="width: 300px;" name="employeeAddress" readonly required><br>
					<input type="text" id="detailAddress" placeholder="상세주소" style="width: 300px;"><br>
				월급 : <input type="number" name="employeeSalary" placeholder="월급" required><br>
				입사일 : <input type="date" name="employeeHireDate" required><br>
				총 휴가일수 : <input type="number" placeholder="총 휴가일수" name="employeeTotalVacation" required><br>
			</form>
			<button type="button" class="btn btn-primary" onclick="createEmployee()">생성</button>
		</div>
	</div>
</section>
</div>
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:2000;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/createEmployee.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>