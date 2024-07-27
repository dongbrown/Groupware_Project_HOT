<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
    <h2 class="mb-4">휴지통 <span class="badge bg-secondary">${emails.size()} / 100</span></h2>

    <!-- 검색 폼 include -->
    <jsp:include page="search.jsp" />

    <!-- 이메일 목록 -->
    <div class="card">
        <div class="card-body">
            <div class="d-flex justify-content-between mb-3">
                <div>
                    <button id="readBtn" class="btn btn-sm btn-secondary">읽음</button>
                    <button id="deleteBtn" class="btn btn-sm btn-danger">영구삭제</button>
                    <button id="restoreBtn" class="btn btn-sm btn-primary">복구</button>
                </div>

            </div>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="select-all" class="form-check-input">
                            </th>
                            <th>보낸 사람</th>
                            <th>제목</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody id="emailList">
                        <c:choose>
                            <c:when test="${empty emails}">
                                <tr>
                                    <td colspan="4" class="text-center">
                                        <div class="py-5">
                                            <i class="fas fa-envelope fa-3x mb-3"></i>
                                            <p>휴지통에 메일이 없습니다.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${emails}" var="email">
                                    <tr class="email-item" data-email-no="${email.emailNo}">
                                        <td>
                                            <input type="checkbox" class="form-check-input email-checkbox" value="${email.emailNo}">
                                        </td>
                                        <td>${email.sender.employeeName}</td>
                                        <td>
                                            <c:out value="${email.emailTitle}" />
                                            <%-- <c:if test="${email.hasAttachment}">
                                                <i class="fas fa-paperclip"></i>
                                            </c:if> --%>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${email.emailSendDate}" pattern="yyyy-MM-dd HH:mm"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
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
        var selectedEmails = $('.email-checkbox:checked').map(function() {
            return $(this).val();
        }).get();
        if (selectedEmails.length > 0) {
            // TODO: 선택된 이메일을 읽음 처리하는 로직 구현
            console.log("읽음 처리할 이메일:", selectedEmails);
        } else {
            alert("선택된 이메일이 없습니다.");
        }
    });

    // 영구삭제 버튼 클릭 이벤트
    $("#deleteBtn").click(function() {
        var selectedEmails = $('.email-checkbox:checked').map(function() {
            return $(this).val();
        }).get();
        if (selectedEmails.length > 0) {
            if (confirm("선택한 이메일을 영구적으로 삭제하시겠습니까?")) {
                // TODO: 선택된 이메일을 영구 삭제하는 로직 구현
                console.log("영구 삭제할 이메일:", selectedEmails);
            }
        } else {
            alert("선택된 이메일이 없습니다.");
        }
    });

    // 복구 버튼 클릭 이벤트
    $("#restoreBtn").click(function() {
        var selectedEmails = $('.email-checkbox:checked').map(function() {
            return $(this).val();
        }).get();
        if (selectedEmails.length > 0) {
            // TODO: 선택된 이메일을 복구하는 로직 구현
            console.log("복구할 이메일:", selectedEmails);
        } else {
            alert("선택된 이메일이 없습니다.");
        }
    });

    // 이메일 항목 클릭 이벤트 (체크박스 클릭 제외)
    $(document).on('click', '.email-item', function(e) {
        if (!$(e.target).is('input:checkbox')) {
            var emailNo = $(this).data('email-no');
            // TODO: 이메일 상세 보기 로직 구현
            console.log("상세 보기할 이메일 번호:", emailNo);
        }
    });
});
</script>