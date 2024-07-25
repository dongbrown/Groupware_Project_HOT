<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="email-container">
    <div class="email-toolbar mb-3 d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center">
            <div class="btn-group me-2" role="group">
                <input type="checkbox" class="btn-check" id="select-all" autocomplete="off">
                <label class="btn btn-outline-secondary" for="select-all"><i class="fas fa-check"></i></label>
                <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-ellipsis-v"></i>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" id="deleteBtn"><i class="fas fa-trash me-2"></i>삭제</a></li>
                    <li><a class="dropdown-item" href="#"><i class="fas fa-envelope me-2"></i>읽음 표시</a></li>
                </ul>
            </div>
            <button class="btn btn-outline-secondary me-2" id="refreshBtn"><i class="fas fa-sync-alt"></i></button>
        </div>
        <div class="email-count">
            <span>${totalCount} / ${unreadCount} 안읽음</span>
        </div>
    </div>

    <div class="email-list">
        <c:forEach var="email" items="${emails}">
            <div class="email-item d-flex align-items-center py-2 border-bottom" data-email-no="${email.emailNo}">
                <div class="checkbox-wrapper me-2">
                    <input type="checkbox" class="form-check-input mail-item-checkbox" value="${email.emailNo}">
                </div>
                <div class="star-wrapper me-2">
                    <i class="far fa-star"></i>
                </div>
                <div class="sender-wrapper me-3 text-truncate" style="max-width: 200px;">
                    ${email.sender.employeeName}
                </div>
                <div class="subject-wrapper flex-grow-1 text-truncate">
                    <span class="fw-bold">${email.emailTitle}</span>
                    <span class="text-muted"> - ${email.emailContent}</span>
                </div>
                <div class="date-wrapper ms-3" style="min-width: 100px;">
                    <fmt:formatDate value="${email.emailSendDate}" pattern="MM.dd HH:mm"/>
                </div>
            </div>
        </c:forEach>
    </div>

    <nav aria-label="Page navigation" class="mt-3">
        <ul class="pagination justify-content-center">
            <li class="page-item"><a class="page-link" href="#">이전</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">다음</a></li>
        </ul>
    </nav>
</div>

<script>
$(document).ready(function() {
    bindInboxEvents();
});
</script>
<script src="${pageContext.request.contextPath}/js/email-common.js"></script>
<script src="${pageContext.request.contextPath}/js/inbox.js"></script>