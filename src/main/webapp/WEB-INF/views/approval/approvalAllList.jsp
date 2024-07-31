<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="${path }/css/approval/approvalAllList.css" rel="stylesheet" type="text/css">

<section class="document-section">
	<div class="document-div shadow bg-body rounded">
	<div class="documentTitle">
		<h3>전체 결재 문서</h3>
		<a href="<c:url value='/approval/newApproval.do' />">
			<button class="btn btn-primary">작성하기</button>
		</a>
	</div>

	<div class="approvalStatusTable">
		<div>
			결재대기 <span></span>건
		</div>
		<div>
			결재진행 <span></span>건
		</div>
		<div>
			결재예정 <span></span>건
		</div>
		<div>
			결재완료 <span></span>건
		</div>
	</div>

	<div class="search-bar">
		<select id="selectType">
			<option>전체</option>
			<option value="1">결재대기</option>
			<option value="2">결재진행</option>
			<option value="6">결재예정</option>
			<option value="3">결재완료</option>
		</select>
		<input type="text" id="searchType" placeholder="검색어를 입력하세요" oninput="filterList()">
	</div>

	<table class="documentList" border="1">
		<thead>
			<tr>
				<th style="width:10%;">결재번호</th>
				<th style="width:7%;">종류</th>
				<th style="width:36%;">제목</th>
				<th style="width:10%;">기안자</th>
				<th style="width:10%;">기안부서</th>
				<th style="width:10%;">기안일</th>
				<th style="width:10%;">결재완료일</th>
				<th style="width:7%;">상태</th>
			</tr>
		</thead>
		<tbody id="approvalBody">
			<c:if test="${not empty approvalAll}">
				<c:forEach var="approval" items="${approvalAll}">
					<tr data-status="${approval.status}">
						<td>${approval.approvalNo}</td>
						<td>${approval.approvalTitle}</td>
						<td>${approval.employeeNo.employeeName}</td>
						<td>${approval.departmentCode.departmentTitle}</td>
						<td>${approval.approvalDraftDate}</td>
						<td>${approval.approverDate}</td>
						<td>${approval.status}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty approvalAll}">
				<tr>
					<td colspan="8">
						<p>조회된 결과가 없습니다.</p>
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	</div>
</section>
<script>const path='${path}';</script>
<script src='${path }/js/approval/approvalAllList.js'></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>