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
    <link href="${path}/css/email/sidebar.css" rel="stylesheet">
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
                    <div class="email-sidebar">
						<div class="compose-wrapper">
						    <button class="compose-btn" onclick="location.href='${path}/email/write'">
						        <i class="fas fa-pen"></i><span>메일쓰기</span>
						    </button>
						    <button class="compose-btn" onclick="location.href='${path}/email/write-self'">
						        <i class="fas fa-user-edit"></i><span>내게쓰기</span>
						    </button>
						</div>
                        <nav class="email-menu">
                            <ul>
                                <li class="menu-item ${mailbox eq 'inbox' ? 'active' : ''}">
                                    <button onclick="location.href='${path}/email/inbox'">
                                        <i class="fas fa-inbox"></i>
                                        <span>받은메일함</span>
                                        <span class="badge">${inboxUnreadCount}</span>
                                    </button>
                                </li>
                                <li class="menu-item ${mailbox eq 'sent' ? 'active' : ''}">
                                    <button onclick="location.href='${path}/email/sent'">
                                        <i class="fas fa-paper-plane"></i>
                                        <span>보낸메일함</span>
                                    </button>
                                </li>
                                <li class="menu-item ${mailbox eq 'self' ? 'active' : ''}">
                                    <button onclick="location.href='${path}/email/self'">
                                        <i class="fas fa-user"></i>
                                        <span>내게쓴메일함</span>
                                        <span class="badge">${selfUnreadCount}</span>
                                    </button>
                                </li>
                                <li class="menu-item ${mailbox eq 'important' ? 'active' : ''}">
                                    <button onclick="location.href='${path}/email/important'">
                                        <i class="fas fa-star"></i>
                                        <span>중요메일함</span>
                                        <span class="badge">${importantUnreadCount}</span>
                                    </button>
                                </li>
                                <li class="menu-item ${mailbox eq 'trash' ? 'active' : ''}">
                                    <button onclick="location.href='${path}/email/trash'">
                                        <i class="fas fa-trash"></i>
                                        <span>휴지통</span>
                                        <span class="badge">${trashCount}</span>
                                    </button>
                                </li>
                            </ul>
                        </nav>
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

$(document).ready(function() {
    EmailCommon.init(contextPath);

    // URL에서 mailbox 파라미터를 가져옴
    var urlParams = new URLSearchParams(window.location.search);
    var mailbox = urlParams.get('mailbox') || 'inbox';

    // mailContent 영역이 비어있다면 해당 메일함을 로드
    if ($('#mailContent').is(':empty')) {
        EmailCommon.loadMailbox(mailbox);
    }
});
</script>
</body>
</html>