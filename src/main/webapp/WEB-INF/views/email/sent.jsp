<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/email-common.css">

<div class="container-fluid">
    <h2 class="mb-4">보낸 메일함 <span class="email-count">${emails.size()}/999</span></h2>



    <div class="email-toolbar">
        <div class="toolbar-left">
            <input type="checkbox" id="select-all" class="form-check-input">
            <label for="select-all" class="form-check-label">전체 선택</label>
            <button id="deleteBtn" class="btn btn-danger btn-sm">삭제</button>
        </div>
        <div class="toolbar-right">
            <select class="form-select form-select-sm">
                <option>필터</option>
            </select>
        </div>
    </div>

    <div class="email-list">
        <c:choose>
            <c:when test="${empty emails}">
                <div class="no-email">
                    <div class="no-email-icon">
                        <i class="fas fa-paper-plane"></i>
                    </div>
                    <p>보낸 메일이 없습니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="table">
                    <thead>
                        <tr>
                            <th></th>
                            <th>받는 사람</th>
                            <th>제목</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${emails}" var="email">
                            <tr class="email-item" data-email-no="${email.emailNo}">
                                <td>
                                    <input type="checkbox" class="form-check-input email-checkbox" value="${email.emailNo}">
                                </td>
                                <td>${email.receivers[0].employee.employeeName}</td>
                                <td>
                                    <c:out value="${email.emailTitle}" />
                                    <c:if test="${email.hasAttachment}">
                                        <i class="fas fa-paperclip"></i>
                                    </c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value="${email.emailSendDate}" pattern="yyyy-MM-dd HH:mm"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
// 여기에 보낸 메일함 관련 JavaScript 코드 추가
</script>