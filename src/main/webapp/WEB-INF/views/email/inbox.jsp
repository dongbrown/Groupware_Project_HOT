<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">받은 메일함</h2>

    <!-- 검색 폼 include -->
    <jsp:include page="search.jsp" />

    <!-- 이메일 목록 -->
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
                            <th>
                                <input type="checkbox" id="select-all">
                            </th>
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

    <!-- 페이지네이션 (필요한 경우) -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- 페이지네이션 로직 구현 -->
        </ul>
    </nav>

    <!-- 작업 버튼 -->
    <div class="mt-3">

    </div>
</div>

<script>
$(document).ready(function() {
    // 이메일 항목 클릭 이벤트
    $(document).on('click', '.email-item', function(e) {
        if (!$(e.target).is('input:checkbox') && !$(e.target).is('.toggle-important')) {
            var emailNo = $(this).data('email-no');
            EmailCommon.viewEmail(emailNo);
        }
    });

    // 중요 표시 토글 이벤트
    $(document).on('click', '.toggle-important', function(e) {
        e.preventDefault();
        e.stopPropagation();
        var emailNo = $(this).data('email-no');
        EmailCommon.toggleImportant(emailNo);
    });

    // 검색 버튼 클릭 이벤트
    $('#searchBtn').click(function() {
        var keyword = $('#searchInput').val();
        if (keyword.trim() !== '') {
            EmailCommon.searchEmails(keyword);
        }
    });

    // 검색 입력 필드에서 엔터 키 이벤트
    $('#searchInput').keypress(function(e) {
        if (e.which == 13) {  // 엔터 키의 keyCode는 13입니다.
            e.preventDefault();
            $('#searchBtn').click();
        }
    });

    // 전체 선택 체크박스 이벤트
    $('#select-all').change(function() {
        $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
    });

    // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
    $(document).on('change', '.mail-item-checkbox', function() {
        var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
        $('#select-all').prop('checked', allChecked);
    });

    // 삭제 버튼 클릭 이벤트
    $('#deleteBtn').click(function() {
        var selectedEmails = $('.mail-item-checkbox:checked').map(function() {
            return $(this).val();
        }).get();

        if (selectedEmails.length === 0) {
            alert('삭제할 메일을 선택하세요.');
            return;
        }

        if (confirm('선택한 메일을 삭제하시겠습니까?')) {
            EmailCommon.moveEmailsToTrash(selectedEmails, function() {
                EmailCommon.loadMailbox('inbox');
            });
        }
    });
});
</script>