<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/approval/approvalAllList.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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