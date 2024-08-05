<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">보낸 메일함<span class="email-count">${emails.size()}</span></h2>
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
                            <th>받는 사람</th>
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
                                <td>${email.receivers[0].employee.employeeName}</td>
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
            <div id="pageBar" class="d-flex justify-content-center mt-3"></div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/pagebar.js"></script>
<script>
    let currentPage = ${currentPage};
    const totalPages = ${totalPages};
    let currentSize = 10;

    function goToPage(page) {
        console.log('goToPage called with page:', page);
        $.ajax({
            url: '${pageContext.request.contextPath}/email/${mailbox}',
            data: { page: page, size: currentSize },
            success: function(response) {
                console.log('AJAX success, response:', response);
                $('#emailList').html($(response).find('#emailList').html());
                history.pushState(null, '', '${pageContext.request.contextPath}/email/${mailbox}?page=' + page);
                currentPage = page;  // 현재 페이지 업데이트
                createPageBar();  // 페이지바 다시 생성
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

    $(document).ready(function() {
        createPageBar();

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
    });
</script>