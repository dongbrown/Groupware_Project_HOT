<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사내 메일</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <link href="${path}/css/email/email.css" rel="stylesheet">
    <link href="${path}/css/email/trash.css" rel="stylesheet">
    <link href="${path}/css/email/write.css" rel="stylesheet">
    <link href="${path}/css/email/email-view.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

<!-- 사이드바 include -->
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<!-- 콘텐츠 Wrapper -->
<div id="content-wrapper" class="d-flex flex-column" data-employee-no="${loginEmployee.employeeNo}">
    <!-- 메인 콘텐츠 -->
    <div id="content">
        <!-- 헤더 include -->
        <c:import url="/WEB-INF/views/common/header.jsp" />

        <!-- 페이지 콘텐츠 시작 -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                   <div class="emailSidebar">
				    <div class="d-flex mb-3">
				        <button class="btn btn-primary flex-grow-1 me-2" id="writeBtn">메일 쓰기</button>
				        <button class="btn btn-primary flex-grow-1" id="write-selfBtn">내게 쓰기</button>
				    </div>
				    <ul class="list-group">
				        <li class="list-group-item active" data-mailbox="inbox"><i class="fas fa-inbox me-2"></i>받은메일함 <span class="badge bg-primary rounded-pill">999+</span></li>
				        <li class="list-group-item" data-mailbox="sent"><i class="fas fa-paper-plane me-2"></i>보낸메일함</li>
				        <li class="list-group-item" data-mailbox="self"><i class="fas fa-user me-2"></i>내게쓴메일함 <span class="badge bg-secondary rounded-pill">20</span></li>
				        <li class="list-group-item" data-mailbox="important"><i class="fas fa-star me-2"></i>중요메일함</li>
				        <li class="list-group-item" data-mailbox="trash"><i class="fas fa-trash me-2"></i>휴지통 <span class="badge bg-danger rounded-pill">30</span></li>
				    </ul>
				</div>
                </div>
                <div class="col-md-10" id="mailContent">
                    <!-- 메일 목록 또는 메일 쓰기 영역 -->
                </div>
            </div>
        </div>
        <!-- 페이지 콘텐츠 끝 -->
    </div>
    <!-- 메인 콘텐츠 끝 -->

    <!-- 푸터 include -->
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
<!-- 콘텐츠 Wrapper 끝 -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<script type="text/javascript" src="${path}/js/email/email-common.js"></script>

<script>
// contextPath를 전역 변수로 설정
var contextPath = '${pageContext.request.contextPath}/email';

$(document).ready(function() {
    // EmailCommon 초기화
    if (typeof EmailCommon !== 'undefined' && typeof EmailCommon.init === 'function') {
        EmailCommon.init(contextPath);

        // URL에서 현재 메일함 정보 가져오기
        var currentMailbox = new URLSearchParams(window.location.search).get('mailbox') || 'inbox';

        // 해당 메일함 로드
        EmailCommon.loadMailbox(currentMailbox);

        // 사이드바 메뉴 항목 클릭 이벤트 처리
        $('.list-group-item').on('click', function(e) {
            e.preventDefault();
            var mailbox = $(this).data('mailbox');
            EmailCommon.loadMailbox(mailbox);

            // URL 업데이트
            history.pushState(null, '', contextPath + '?mailbox=' + mailbox);

            // 활성 클래스 토글
            $('.list-group-item').removeClass('active');
            $(this).addClass('active');
        });
    }
});
</script>
</body>
</html>