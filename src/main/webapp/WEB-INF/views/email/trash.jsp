<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="trash-container">
    <div class="trash-header">
        <h2>휴지통 <span class="email-count">${emails.size()} / 100</span></h2>
        <div class="trash-actions">
            <button id="searchBtn" class="btn btn-light btn-sm">메일 검색</button>
        </div>
    </div>

    <div class="trash-toolbar">
        <div class="toolbar-left">
            <input type="checkbox" id="select-all" class="form-check-input">
            <label for="select-all" class="form-check-label">전체 선택</label>
            <button id="readBtn" class="btn btn-secondary btn-sm">읽음</button>
            <button id="deleteBtn" class="btn btn-danger btn-sm">영구삭제</button>
            <button id="restoreBtn" class="btn btn-primary btn-sm">복구</button>
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
                    <p>휴지통에 메일이 없습니다.</p>
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
                            <tr class="email-item" data-email-no="${email.emailNo}">
                                <td>
                                    <input type="checkbox" class="form-check-input email-checkbox" value="${email.emailNo}">
                                </td>
                                <td>${email.sender.employeeName}</td>
                                <td>
                                    <c:out value="${email.emailTitle}" />
<%--                                     <c:if test="${email.hasAttachment}">
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
    $("#select-all").change(function() {
        $(".email-checkbox").prop('checked', $(this).prop("checked"));
    });

    // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
    $(document).on('change', ".email-checkbox", function() {
        $("#select-all").prop('checked', $('.email-checkbox:checked').length == $('.email-checkbox').length);
    });

    // 읽음 버튼 클릭 이벤트
    $("#readBtn").click(function() {
        var selectedEmails = getSelectedEmails();
        if (selectedEmails.length > 0) {
            EmailCommon.markTrashAsRead(selectedEmails);
        } else {
            alert("선택된 이메일이 없습니다.");
        }
    });

    // 영구삭제 버튼 클릭 이벤트
    $("#deleteBtn").click(function() {
        var selectedEmails = getSelectedEmails();
        if (selectedEmails.length > 0) {
            EmailCommon.deletePermanently(selectedEmails);
        } else {
            alert("선택된 이메일이 없습니다.");
        }
    });

    // 복구 버튼 클릭 이벤트
    $("#restoreBtn").click(function() {
        var selectedEmails = getSelectedEmails();
        if (selectedEmails.length > 0) {
            EmailCommon.restoreFromTrash(selectedEmails);
        } else {
            alert("선택된 이메일이 없습니다.");
        }
    });

    // 이메일 항목 클릭 이벤트 (체크박스 클릭 제외)
    $(document).on('click', '.email-item', function(e) {
        if (!$(e.target).is('input:checkbox')) {
            var emailNo = $(this).data('email-no');
            EmailCommon.viewEmail(emailNo);
        }
    });

    // 선택된 이메일 번호 가져오기
    function getSelectedEmails() {
        return $('.email-checkbox:checked').map(function() {
            return $(this).val();
        }).get();
    }
});
</script>