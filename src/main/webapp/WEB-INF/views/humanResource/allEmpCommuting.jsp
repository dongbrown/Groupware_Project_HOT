<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="${path }/css/humanResource/allEmpCommuting.css" rel="stylesheet" type="text/css">
<section class="allEmpCommuting">
	<div class="allEmpCommuting-div shadow bg-body rounded p-3">
		<h2>전 사원 근태 내역</h2>
		<div class="search-div">
			<form id="searchForm" class="search-form">
				<input type="date" name="searchDate" class="mr-1">
				<select id="department" name="departmentCode" class="mr-1">
					<option value="0">부서 전체</option>
				</select>
				<select id="status" name="status" class="mr-1">
					<option value="">전체</option>
					<option value="정상">정상</option>
					<option value="결근">결근</option>
					<option value="지각">지각</option>
					<option value="출장">출장</option>
					<option value="연차">연차</option>
					<option value="반차">반차</option>
				</select>
                <div class="input-group">
                    <input type="text" name="employeeName" class="form-control bg-light border-0 small" placeholder="이름 검색"
                        aria-label="Search" aria-describedby="basic-addon2">
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button" onclick="searchEmpCommuting(1)">
                            <i class="fas fa-search fa-sm"></i>
                        </button>
                    </div>
                </div>
			</form>
		</div>
		<div class="table-div">
			<table class="table com-table">
				<thead class="table-dark">
					<tr>
						<th>근무 일자</th>
						<th>사번</th>
						<th>부서</th>
						<th>직급</th>
						<th>사원명</th>
						<th>출근시간</th>
						<th>퇴근시간</th>
						<th>연장 근무 시간</th>
						<th>총 근무 시간</th>
						<th>근무 상태</th>
						<th></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<div class="pagebar-div mt-3"></div>
	</div>
</section>
</div>
<div class="modal fade" tabindex="-1" id="update-modal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">출퇴근 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<input type="hidden" id="modalCommutingNo">
		<p>사번 : <span id="modalEmpNo"></span></p>
		<p><span id="modalEmpDept"></span> <span id="modalEmpName"></span> <span id="modalEmpPosition"></span></p>
		<p>날짜 : <span id="modalComDate"></span></p>
		출근 시간 : <input type="time" id="modalGoTime"><br>
		퇴근 시간 : <input type="time" id="modalLeaveTime"><br>
		근무 상태 :
		<select id="modalStatus">
			<option value="정상">정상</option>
			<option value="결근">결근</option>
			<option value="지각">지각</option>
			<option value="출장">출장</option>
			<option value="연차">연차</option>
			<option value="반차">반차</option>
		</select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="updateCommuting()">수정</button>
      </div>
    </div>
  </div>
</div>
<script>const path='${path}';</script>
<script src='${path }/js/humanResource/allEmpCommuting.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>