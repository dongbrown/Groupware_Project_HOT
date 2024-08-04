<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h2>${mailbox eq 'inbox' ? '받은메일함' :
      mailbox eq 'sent' ? '보낸메일함' :
      mailbox eq 'self' ? '내게쓴메일함' :
      mailbox eq 'important' ? '중요메일함' :
      mailbox eq 'trash' ? '휴지통' : '메일함'}
</h2>

<table class="table">
    <thead>
        <tr>
            <th><input type="checkbox" id="select-all"></th>
            <th>중요</th>
            <th>읽음</th>
            <th>${mailbox eq 'sent' ? '받는 사람' : '보낸 사람'}</th>
            <th>제목</th>
            <th>날짜</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${emails}" var="email">
            <tr class="email-item" data-email-no="${email.emailNo}">
                <td>
                    <input type="checkbox" class="mail-item-checkbox" value="${email.emailNo}">
                </td>
                <td>
                    <a href="#" class="toggle-important" data-email-no="${email.emailNo}">
                        <i class="fas fa-star ${email.receivers[0].emailReceiverIsImportant eq 'Y' ? 'text-warning' : 'text-muted'}"></i>
                    </a>
                </td>
                <td>
                    <i class="fas ${email.receivers[0].emailReceiverIsRead eq 'Y' ? 'fa-envelope-open' : 'fa-envelope'} ${email.receivers[0].emailReceiverIsRead eq 'Y' ? 'text-muted' : 'text-primary'}"></i>
                </td>
                <td>${mailbox eq 'sent' ? email.receivers[0].employee.employeeName : email.sender.employeeName}</td>
                <td>
                    ${email.emailTitle}
                    <c:if test="${email.hasAttachment}">
                        <i class="fas fa-paperclip ml-2"></i>
                    </c:if>
                </td>
                <td>
                    <fmt:formatDate value="${email.emailSendDate}" pattern="yyyy-MM-dd HH:mm"/>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- 페이지네이션 -->
<div id="pageBar" class="d-flex justify-content-center mt-3">
</div>

<script>
    $(document).ready(function() {
        EmailCommon.reattachEventListeners();

        // 페이지네이션 생성
        createPageBar(${currentPage}, ${totalPages}, 'EmailCommon.loadMailbox', '${mailbox}');
    });
</script>