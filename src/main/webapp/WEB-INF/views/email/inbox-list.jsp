<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">
        <c:choose>
            <c:when test="${mailbox eq 'inbox'}">받은 메일함</c:when>
            <c:when test="${mailbox eq 'sent'}">보낸 메일함</c:when>
            <c:when test="${mailbox eq 'important'}">중요 메일함</c:when>
            <c:when test="${mailbox eq 'self'}">내게 쓴 메일함</c:when>
            <c:when test="${mailbox eq 'trash'}">휴지통</c:when>
            <c:otherwise>메일함</c:otherwise>
        </c:choose>
        <span class="email-count">${fn:length(emails)}</span>
    </h2>

    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
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
                    <tbody id="emailList">
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
                                    <c:choose>
                                        <c:when test="${fn:length(email.emailTitle) > 30}">
                                            ${fn:substring(email.emailTitle, 0, 30)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${email.emailTitle}
                                        </c:otherwise>
                                    </c:choose>
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
            </div>
            <!-- 페이지바를 위한 div -->
            <div id="pageBar" class="d-flex justify-content-center mt-3">ㅇ</div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/pagebar.js"></script>
<script>
    $(document).ready(function() {
        const currentPage = ${currentPage};
        const totalPages = ${totalPages};
        let currentSize = 10;
        const mailbox = '${mailbox}';

        function goToPage(page) {
            $.ajax({
                url: '${pageContext.request.contextPath}/email/' + mailbox,
                data: { page: page, size: currentSize },
                success: function(response) {
                    $('#emailList').html($(response).find('#emailList').html());
                    history.pushState(null, '', '${pageContext.request.contextPath}/email/' + mailbox + '?page=' + page);
                    createPageBar(page);
                }
            });
        }

        function createPageBar(page) {
            const $pageBar = createPagination(page, totalPages, 'goToPage');
            $('#pageBar').html($pageBar);
        }

        createPageBar(currentPage);
    });
</script>