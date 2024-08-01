<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">검색 결과<span class="email-count">${emails.size()}</span></h2>
    <!-- 검색 폼 include -->
    <jsp:include page="search.jsp" />

    <div class="card">
        <div class="card-body">

            <div class="d-flex justify-content-between mb-3">
                <div>
                    <button id="readBtn" class="btn btn-sm btn-secondary">읽음</button>
                    <button id="deleteBtn" class="btn btn-sm btn-danger">삭제</button>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="select-all"></th>
                            <th>중요</th>
                            <th>읽음</th>
                            <th>보낸 사람</th>
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
                                <td>${email.sender.employeeName}</td>
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
        </div>
    </div>
</div>