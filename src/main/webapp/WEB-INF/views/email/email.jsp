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
					    <li class="list-group-item" onclick="EmailCommon.loadInbox()">
					        <i class="fas fa-inbox me-2"></i>받은메일함
					        <span class="badge bg-primary rounded-pill" id="inboxUnreadCount">${inboxUnreadCount}</span>
					    </li>
					    <li class="list-group-item" onclick="EmailCommon.loadSent()">
					        <i class="fas fa-paper-plane me-2"></i>보낸메일함
					    </li>
					    <li class="list-group-item" onclick="EmailCommon.loadSelf()">
					        <i class="fas fa-user me-2"></i>내게쓴메일함
					        <span class="badge bg-secondary rounded-pill" id="selfUnreadCount">${selfUnreadCount}</span>
					    </li>
					    <li class="list-group-item" onclick="EmailCommon.loadImportant()">
					        <i class="fas fa-star me-2"></i>중요메일함
					        <span class="badge bg-warning rounded-pill" id="importantUnreadCount">${importantUnreadCount}</span>
					    </li>
					    <li class="list-group-item" onclick="EmailCommon.loadTrash()">
					        <i class="fas fa-trash me-2"></i>휴지통
					        <span class="badge bg-danger rounded-pill" id="trashCount">${trashCount}</span>
					    </li>
					</ul>
				</div>
                </div>
				<div class="col-md-10" id="mailContent">
				    <!-- 메일 목록 또는 메일 쓰기 영역 -->
				    <c:if test="${not empty mailbox}">
				        <c:choose>
				            <c:when test="${mailbox eq 'inbox'}">
				                <jsp:include page="inbox.jsp" />
				            </c:when>
				            <c:when test="${mailbox eq 'sent'}">
				                <jsp:include page="sent.jsp" />
				            </c:when>
				            <c:when test="${mailbox eq 'self'}">
				                <jsp:include page="self.jsp" />
				            </c:when>
				            <c:when test="${mailbox eq 'important'}">
				                <jsp:include page="important.jsp" />
				            </c:when>
				            <c:when test="${mailbox eq 'trash'}">
				                <jsp:include page="trash.jsp" />
				            </c:when>
				            <c:when test="${mailbox eq 'write'}">
				                <jsp:include page="write.jsp" />
				            </c:when>
				            <c:when test="${mailbox eq 'write-self'}">
				                <jsp:include page="write-self.jsp" />
				            </c:when>
				        </c:choose>
				    </c:if>
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
<script type="text/javascript" src="${path}/js/common/pagebar.js"></script>

<script>
let contextPath = '${pageContext.request.contextPath}/email';
let path = '${pageContext.request.contextPath}';
var EmailApp = {
    init: function() {
        if (this.initialized) return;
        this.initialized = true;

        EmailCommon.init(contextPath);
        this.bindEvents();
        this.loadInitialMailbox();
    },
    bindEvents: function() {
        $(document).on('click', '.list-group-item', this.handleMailboxClick.bind(this));
        $(document).on('submit', '#emailForm', this.handleEmailSubmit);
        $(document).on('click', '#cancel', this.handleCancel);
    },
    loadInitialMailbox: function() {
        var currentMailbox = new URLSearchParams(window.location.search).get('mailbox') || 'inbox';
        EmailCommon.loadMailbox(currentMailbox);
        $('.list-group-item[data-mailbox="' + currentMailbox + '"]').addClass('active');
    },
    handleMailboxClick: function(e) {
        e.preventDefault();
        var $target = $(e.currentTarget);
        var mailbox = $target.data('mailbox');
        EmailCommon.loadMailbox(mailbox);
        history.pushState(null, '', contextPath + '?mailbox=' + mailbox);
        $('.list-group-item').removeClass('active');
        $target.addClass('active');
    },
    handleEmailSubmit: function(e) {
        e.preventDefault();
        var receivers = $('#receivers').val().split('(')[0]; // 이메일 주소만 추출
        EmailCommon.saveEmail(false, receivers);
    },
    handleCancel: function() {
        if (confirm('작성 중인 내용이 저장되지 않습니다. 정말 취소하시겠습니까?')) {
            EmailCommon.loadMailbox('inbox');
        }
    }
};

$(document).ready(function() {
    EmailApp.init();
});
</script>
</body>
</html>