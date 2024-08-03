<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="${path }/css/approval/myapproval.css" rel="stylesheet" text="text/css"/>
<section class="document-section">
	<div class="document-div shadow bg-body rounded">
    <c:choose>
        <c:when test="${myapprovalType == 1}">
            <h2>내 기안 문서</h2>
 			<table class="documentList" border="1">
				<thead>
					<tr>
						<th style="width:13%;">결재번호</th>
						<th style="width:10%;">결재유형</th>
						<th style="width:27%;">제목</th>
						<th style="width:8%;">기안자</th>
						<th style="width:10%;">기안부서</th>
						<th style="width:12%;">기안일</th>
						<th style="width:12%;">결재완료일</th>
						<th style="width:12%;">결재상태</th>
					</tr>
				</thead>
				<tbody id="approvalBody">
					<c:if test="${not empty mydoc }">
						<c:forEach var="doc" items="${mydoc }">
							<c:if test="${doc.approval.approvalStatus != '5'}">
								<tr onclick="location.assign('${path}/approval/specApproval.do?targetNo=${doc.approvalNo}')">
									<td>${doc.approvalNo}</td>
									<td>
										<c:choose>
											<c:when test="${doc.approvalNo.substring(0,1) eq '1'}">
												출퇴근 정정
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '2'}">
												휴가 신청결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '3'}">
												초과근무 결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '4'}">
												경비지출 결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '5'}">
												출장 신청결재
											</c:when>
										</c:choose>
									</td>
									<td>${doc.approval.approvalTitle}</td>
									<td>${doc.approval.employeeNo.employeeName}</td>
									<td>${doc.approval.employeeNo.departmentCode.departmentTitle}</td>
									<td>${doc.approval.approvalDate}</td>
									<td>
										<c:forEach var="approver" items="${doc.approverEmployee}">
									        ${approver.approverDate}
									    </c:forEach>
	    							</td>
									<td>
										<c:choose>
											<c:when test="${doc.approval.approvalStatus eq '1'}">
												대기
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '2'}">
												진행 중
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '3'}">
												완료
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '4'}">
												반려
											</c:when>
										</c:choose>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
        </c:when>
        <c:when test="${myapprovalType == 2}">
            <h2>수신 문서</h2>
			<table class="documentList" border="1">
				<thead>
					<tr>
						<th style="width:10%;">결재번호</th>
						<th style="width:10%;">결재유형</th>
						<th style="width:30%;">제목</th>
						<th style="width:8%;">기안자</th>
						<th style="width:10%;">기안부서</th>
						<th style="width:12%;">기안일</th>
						<th style="width:12%;">결재완료일</th>
						<th style="width:12%;">결재상태</th>
					</tr>
				</thead>
				<tbody id="approvalBody">
					<c:if test="${not empty mydoc }">
						<c:forEach var="doc" items="${mydoc }">
								<tr onclick="location.assign('${path}/approval/specApproval.do?targetNo=${doc.approvalNo}')">
									<td>${doc.approvalNo}</td>
									<td>
										<c:choose>
											<c:when test="${doc.approvalNo.substring(0,1) eq '1'}">
												출퇴근 정정
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '2'}">
												휴가 신청결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '3'}">
												초과근무 결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '4'}">
												경비지출 결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '5'}">
												출장 신청결재
											</c:when>
										</c:choose>
									</td>
									<td>${doc.approval.approvalTitle}</td>
									<td>${doc.approval.employeeNo.employeeName}</td>
									<td>${doc.approval.employeeNo.departmentCode.departmentTitle}</td>
									<td>${doc.approval.approvalDate}</td>
									<td>
										<c:forEach var="approver" items="${doc.approverEmployee}">
									        ${approver.approverDate}
									    </c:forEach>
	    							</td>
									<td>
										<c:choose>
											<c:when test="${doc.approval.approvalStatus eq '1'}">
												대기
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '2'}">
												진행 중
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '3'}">
												완료
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '4'}">
												반려
											</c:when>
										</c:choose>
									</td>
								</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty mydoc }">
						<td colspan="8" style="text-align: center;">
							수신 받은 문서가 없습니다.
						</td>
					</c:if>
				</tbody>
			</table>
        </c:when>
        <c:when test="${myapprovalType == 3}">
            <h2>참조 문서</h2>
			<table class="documentList" border="1">
				<thead>
					<tr>
						<th style="width:10%;">결재번호</th>
						<th style="width:10%;">결재유형</th>
						<th style="width:30%;">제목</th>
						<th style="width:8%;">기안자</th>
						<th style="width:10%;">기안부서</th>
						<th style="width:12%;">기안일</th>
						<th style="width:12%;">결재완료일</th>
						<th style="width:12%;">결재상태</th>
					</tr>
				</thead>
				<tbody id="approvalBody">
					<c:if test="${not empty mydoc }">
						<c:forEach var="doc" items="${mydoc }">
								<tr onclick="location.assign('${path}/approval/specApproval.do?targetNo=${doc.approvalNo}')">
									<td>${doc.approvalNo}</td>
									<td>
										<c:choose>
											<c:when test="${doc.approvalNo.substring(0,1) eq '1'}">
												출퇴근 정정
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '2'}">
												휴가 신청결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '3'}">
												초과근무 결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '4'}">
												경비지출 결재
											</c:when>
											<c:when test="${doc.approvalNo.substring(0,1) eq '5'}">
												출장 신청결재
											</c:when>
										</c:choose>
									</td>
									<td>${doc.approval.approvalTitle}</td>
									<td>${doc.approval.employeeNo.employeeName}</td>
									<td>${doc.approval.employeeNo.departmentCode.departmentTitle}</td>
									<td>${doc.approval.approvalDate}</td>
									<td>
										<c:forEach var="approver" items="${doc.approverEmployee}">
									        ${approver.approverDate}
									    </c:forEach>
	    							</td>
									<td>
										<c:choose>
											<c:when test="${doc.approval.approvalStatus eq '1'}">
												대기
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '2'}">
												진행 중
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '3'}">
												완료
											</c:when>
											<c:when test="${doc.approval.approvalStatus eq '4'}">
												반려
											</c:when>
										</c:choose>
									</td>
								</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty mydoc }">
						<td colspan="8" style="text-align: center;">
							참조 받은 문서가 없습니다.
						</td>
					</c:if>
				</tbody>
			</table>
        </c:when>
        <c:when test="${myapprovalType == 4}">
            <h2>열람 문서</h2>
			<table class="documentList" border="1">
				<thead>
					<tr>
						<th style="width:10%;">결재번호</th>
						<th style="width:10%;">결재유형</th>
						<th style="width:30%;">제목</th>
						<th style="width:8%;">기안자</th>
						<th style="width:10%;">기안부서</th>
						<th style="width:12%;">기안일</th>
						<th style="width:12%;">결재완료일</th>
						<th style="width:12%;">결재상태</th>
					</tr>
				</thead>
				<tbody id="approvalBody">
					<c:if test="${not empty mydoc }">
						<c:forEach var="doc" items="${mydoc }">
							<c:if test="${doc.approval.approvalStatus != '5'}">
							<tr onclick="location.assign('${path}/approval/specApproval.do?targetNo=${doc.approvalNo}')">
								<td>${doc.approvalNo}</td>
								<td>
									<c:choose>
										<c:when test="${doc.approvalNo.substring(0,1) eq '1'}">
											출퇴근 정정
										</c:when>
										<c:when test="${doc.approvalNo.substring(0,1) eq '2'}">
											휴가 신청결재
										</c:when>
										<c:when test="${doc.approvalNo.substring(0,1) eq '3'}">
											초과근무 결재
										</c:when>
										<c:when test="${doc.approvalNo.substring(0,1) eq '4'}">
											경비지출 결재
										</c:when>
										<c:when test="${doc.approvalNo.substring(0,1) eq '5'}">
											출장 신청결재
										</c:when>
									</c:choose>
								</td>
								<td>${doc.approval.approvalTitle}</td>
								<td>${doc.approval.employeeNo.employeeName}</td>
								<td>${doc.approval.employeeNo.departmentCode.departmentTitle}</td>
								<td>${doc.approval.approvalDate}</td>
								<td>
									<c:forEach var="approver" items="${doc.approverEmployee}">
								        ${approver.approverDate}
								    </c:forEach>
    							</td>
								<td>
									<c:choose>
										<c:when test="${doc.approval.approvalStatus eq '1'}">
											대기
										</c:when>
										<c:when test="${doc.approval.approvalStatus eq '2'}">
											진행 중
										</c:when>
										<c:when test="${doc.approval.approvalStatus eq '3'}">
											완료
										</c:when>
										<c:when test="${doc.approval.approvalStatus eq '4'}">
											반려
										</c:when>
									</c:choose>
								</td>
							</tr>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${empty mydoc }">
						<td colspan="8" style="text-align: center;">
							열람 가능한 문서가 없습니다.
						</td>
					</c:if>
				</tbody>
			</table>
        </c:when>
        <c:when test="${myapprovalType == 5}">
            <h2>임시저장 문서</h2>
            <c:if test="${not empty mydoc }">
	            <ul class="draft-list">
	            	<c:forEach var="doc" items="${mydoc}">
		                <li>
		                    <strong>${doc.approval.approvalTitle}</strong><br>
		                    <span>최종 수정: ${doc.approval.approvalDate}</span><br>
		                    <div class="btn-div">
			                    <div>
				                    <button class="edit-btn" onclick="location.assign('${path}/approval/specApproval.do?targetNo=${doc.approvalNo}')">수정</button>
				                    <button class="submit-btn">제출</button>
			                    </div>
			                    <div>
			                    	<button class="delete-btn">삭제</button>
			                    </div>
		                    </div>
		                </li>
					</c:forEach>
	            </ul>
            </c:if>
        </c:when>
    </c:choose>
    </div>
</section>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp"/>