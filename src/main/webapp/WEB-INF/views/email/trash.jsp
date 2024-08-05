<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">휴지통<span class="email-count">${emails.size()}</span></h2>
    <!-- 검색 폼 include -->
    <jsp:include page="search.jsp" />

    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between mb-3">
                <div>
                    <button id="readBtn" class="btn btn-sm btn-secondary">읽음</button>
                    <button id="permanentDeleteBtn" class="btn btn-sm btn-danger">영구삭제</button>
                    <button id="restoreBtn" class="btn btn-sm btn-primary">복구</button>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="select-all"></th>
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
             <div id="pageBar" class="d-flex justify-content-center mt-3"></div>
        </div>
    </div>
</div>


페이지바를 추가하고 관련 스크립트를 포함한 전체 코드는 다음과 같습니다:
htmlCopy<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">휴지통<span class="email-count">${emails.size()}</span></h2>
    <!-- 검색 폼 include -->
    <jsp:include page="search.jsp" />

    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between mb-3">
                <div>
                    <button id="readBtn" class="btn btn-sm btn-secondary">읽음</button>
                    <button id="permanentDeleteBtn" class="btn btn-sm btn-danger">영구삭제</button>
                    <button id="restoreBtn" class="btn btn-sm btn-primary">복구</button>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="select-all"></th>
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
            <!-- 페이지바 추가 -->
            <div id="pageBar" class="d-flex justify-content-center mt-3"></div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/pagebar.js"></script>
<script>
$(document).ready(function() {
    // EmailCommon 객체가 초기화되었는지 확인
    if (typeof EmailCommon !== 'undefined' && EmailCommon.initialized) {
        // 전체 선택 체크박스 이벤트
        $("#select-all").off('change').on('change', function() {
            $(".email-checkbox").prop('checked', $(this).prop("checked"));
        });

        // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
        $(".email-list").off('change', '.email-checkbox').on('change', '.email-checkbox', function() {
            $("#select-all").prop('checked', $('.email-checkbox:checked').length === $('.email-checkbox').length);
        });

        // 버튼 클릭 이벤트 처리 함수
        function handleButtonClick(action, confirmMessage, successMessage) {
            var selectedEmails = EmailCommon.getSelectedEmails();
            if (selectedEmails.length > 0) {
                if (confirm(confirmMessage)) {
                    action(selectedEmails, function(response) {
                        alert(successMessage);
                    });
                }
            } else {
                alert("선택된 이메일이 없습니다.");
            }
        }

        // 읽음 버튼 클릭 이벤트
        $("#readBtn").off('click').on('click', function() {
            handleButtonClick(EmailCommon.markTrashAsRead,
                              '선택한 메일을 읽음으로 표시하시겠습니까?',
                              '선택한 메일이 읽음으로 표시되었습니다.');
        });

        // 영구삭제 버튼 클릭 이벤트
        $("#permanentDeleteBtn").off('click').on('click', function() {
            handleButtonClick(EmailCommon.deletePermanently,
                              '선택한 메일을 영구적으로 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.',
                              '선택한 메일이 영구적으로 삭제되었습니다.');
        });

        // 복구 버튼 클릭 이벤트
        $("#restoreBtn").off('click').on('click', function() {
            handleButtonClick(EmailCommon.restoreFromTrash,
                              '선택한 메일을 복구하시겠습니까?',
                              '선택한 메일이 복구되었습니다.');
        });

        // 이메일 항목 클릭 이벤트 (체크박스 클릭 제외)
        $(".email-list").off('click', '.email-item').on('click', '.email-item', function(e) {
            if (!$(e.target).is('input:checkbox')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.viewEmail(emailNo);
            }
        });

        // 페이지바 관련 변수 및 함수
        let currentPage = ${currentPage};
        const totalPages = ${totalPages};
        const mailbox = 'trash';

        function goToPage(page) {
            $.ajax({
                url: '${pageContext.request.contextPath}/email/' + mailbox,
                data: { page: page },
                success: function(response) {
                    $('#emailList').html($(response).find('#emailList').html());
                    history.pushState(null, '', '${pageContext.request.contextPath}/email/' + mailbox + '?page=' + page);
                    currentPage = page;
                    createPageBar();
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX error:', textStatus, errorThrown);
                    alert('페이지 로드 중 오류가 발생했습니다.');
                }
            });
        }

        function createPageBar() {
            const $pageBar = createPagination(currentPage, totalPages, 'goToPage');
            $('#pageBar').html($pageBar);
        }

        // 초기 페이지바 생성
        createPageBar();

        // 페이지바 클릭 이벤트
        $(document).on('click', '#pageBar .page-link', function(e) {
            e.preventDefault();
            let page = $(this).text();
            if (page === '이전') {
                page = Math.max(1, currentPage - 1);
            } else if (page === '다음') {
                page = Math.min(totalPages, currentPage + 1);
            } else {
                page = parseInt(page);
            }
            if (page !== currentPage) {
                goToPage(page);
            }
        });
    } else {
        console.error('EmailCommon object is not initialized');
    }
});
</script>