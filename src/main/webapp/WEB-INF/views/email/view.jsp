<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="email-view-container">
    <div class="email-view-header">
        <h1 class="email-title">${email.emailTitle}</h1>
        <input type="hidden" id="emailNo" value="${email.emailNo}">

        <div class="email-meta">
            <div class="sender-info">
                <img src="${pageContext.request.contextPath}/images/profile/${email.employee.employeeId}.jpg" alt="Sender Profile" class="sender-avatar">
                <div class="sender-details">
                    <span class="sender-name">${email.employee.employeeName}</span>
                    <span class="sender-email">&lt;${email.employee.employeeId}@hot.com&gt;</span>
                    <span class="email-date">
                        <fmt:formatDate value="${email.emailSendDate}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                    </span>
                </div>
            </div>
            <div class="email-actions-top">
                <button class="btn btn-light btn-sm" title="답장">
                    <i class="fas fa-reply"></i>
                </button>
                <button class="btn btn-light btn-sm" title="전달">
                    <i class="fas fa-share"></i>
                </button>
                <button class="btn btn-light btn-sm" title="삭제" onclick="deleteEmail(${email.emailNo})">
                    <i class="fas fa-trash"></i>
                </button>
            </div>
        </div>
    </div>

    <div class="email-view-body">
        <div class="email-content">
            ${email.emailContent}
        </div>
    </div>

    <div class="email-view-footer">
<%--         <c:if test="${not empty email.emailAttachments}">
            <div class="email-attachments">
                <h3>첨부 파일</h3>
                <ul class="attachment-list">
                    <c:forEach var="attachment" items="${email.emailAttachments}">
                        <li>
                            <i class="fas fa-paperclip"></i>
                            <a href="${pageContext.request.contextPath}/email/download/${attachment.emailAttNo}" class="attachment-link">
                                ${attachment.emailAttOriginalFilename}
                            </a>
                            <span class="attachment-size">(${attachment.emailAttFileSize} KB)</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if> --%>
    </div>

    <div class="email-actions-bottom">
        <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/email/reply/${email.emailNo}'">
            <i class="fas fa-reply"></i> 답장
        </button>
        <button class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/email/forward/${email.emailNo}'">
            <i class="fas fa-share"></i> 전달
        </button>
        <button class="btn btn-danger" onclick="deleteEmail(${email.emailNo})">
            <i class="fas fa-trash"></i> 삭제
        </button>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/email-common.js"></script>
<script src="${pageContext.request.contextPath}/js/view.js"></script>