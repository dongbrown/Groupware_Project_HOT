<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/email/view.css">
</head>

<div class="email-view-container">
  <div class="email-view-header">
    <div class="title-row">
      <h1 class="email-title">${email.emailTitle}</h1>
      <button class="btn btn-icon btn-print" onclick="window.print()">
        <i class="fas fa-print"></i>
      </button>
    </div>
    <input type="hidden" id="emailNo" value="${email.emailNo}">

    <div class="email-meta">
      <div class="sender-info">
        <img src="${pageContext.request.contextPath}/images/profile/${email.sender.employeeId}.jpg" alt="Sender Profile" class="sender-avatar">
        <div class="sender-details">
          <span class="sender-name">${email.sender.employeeName}</span>
          <span class="sender-email">&lt;${email.sender.employeeId}@hot.com&gt;</span>
        </div>
      </div>
      <span class="email-date">
        <fmt:formatDate value="${email.emailSendDate}" pattern="yyyy년 MM월 dd일 HH:mm"/>
      </span>
    </div>
  </div>

  <div class="email-view-body">
    <div class="email-content">
      ${email.emailContent}
    </div>
  </div>

  <div class="email-view-footer">
    <c:if test="${not empty attachments}">
      <div class="email-attachments">
        <h3>첨부 파일</h3>
        <ul id="attachmentList" class="attachment-list">
          <c:forEach items="${attachments}" var="attachment">
            <li class="attachment-item">
              <span class="attachment-icon">
                <i class="fas fa-file"></i>
              </span>
              <span class="attachment-name">${attachment.emailAttOriginalFilename}</span>
              <a href="${pageContext.request.contextPath}/email/download/${attachment.emailAttNo}"
                 class="btn btn-sm btn-primary download-btn"
                 data-filename="${attachment.emailAttOriginalFilename}">
                <i class="fas fa-download"></i> 다운로드
              </a>
            </li>
          </c:forEach>
        </ul>
      </div>
    </c:if>
  </div>

  <div class="email-actions-bottom">
    <button class="btn btn-primary btn-reply">
      <i class="fas fa-reply"></i> 답장
    </button>
    <button class="btn btn-secondary btn-forward">
      <i class="fas fa-share"></i> 전달
    </button>
    <button class="btn btn-danger btn-delete">
      <i class="fas fa-trash"></i> 삭제
    </button>
  </div>
</div>

<script>
$(document).ready(function() {
  // 첨부 파일 관련 기능 초기화 (필요한 경우)
  EmailCommon.initAttachments();
});
</script>
<script src="${pageContext.request.contextPath}/js/email/email-common.js"></script>