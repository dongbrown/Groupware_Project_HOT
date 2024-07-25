<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="trash-container">
    <div class="trash-header">
        <h2>휴지통 <span class="email-count">${emails.size()} / 100</span></h2>
        <div class="trash-actions">
            <button class="btn btn-light btn-sm">메일 검색</button>
            <select class="form-select form-select-sm">
                <option>메일 정책</option>
            </select>
        </div>
    </div>

    <div class="trash-toolbar">
        <div class="toolbar-left">
            <input type="checkbox" id="selectAll" class="form-check-input">
            <button class="btn btn-sm">읽음</button>
            <button class="btn btn-sm">영구삭제</button>
            <button class="btn btn-sm">복구</button>
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
                        <i class="fas fa-envelope"></i>
                    </div>
                    <p>메일이 없습니다.</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="table">
                    <thead>
                        <tr>
                            <th></th>
                            <th>보낸 사람</th>
                            <th>제목</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${emails}" var="email">
                            <tr>
                                <td>
                                    <input type="checkbox" class="form-check-input email-checkbox" value="${email.emailNo}">
                                </td>
                                <td>${email.sender.employeeName}</td>
                                <td>
                                    <c:out value="${email.emailTitle}" />
                                 <%--    <c:if test="${email.hasAttachment}">
                                        <i class="fas fa-paperclip"></i>
                                    </c:if> --%>
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
    $(document).ready(function() {
        // 전체 선택 체크박스 이벤트
        $("#selectAll").change(function() {
            $(".email-checkbox").prop('checked', $(this).prop("checked"));
        });

        // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
        $(".email-checkbox").change(function() {
            $("#selectAll").prop('checked', $('.email-checkbox:checked').length == $('.email-checkbox').length);
        });
    });
</script>