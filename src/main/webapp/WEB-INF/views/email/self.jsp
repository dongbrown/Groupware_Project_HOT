<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">내게 쓴 메일함<span class="email-count">${emails.size()}</span></h2>
    <!-- 검색 폼 include -->
    <jsp:include page="search.jsp" />

    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between mb-3">
                <div>
                    <button id="deleteBtn" class="btn btn-sm btn-danger">삭제</button>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="select-all"></th>
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

<script>
// 내게 쓴 메일함 관련 JavaScript 코드
</script>