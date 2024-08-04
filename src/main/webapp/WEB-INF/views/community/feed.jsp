<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="contextPath" content="${pageContext.request.contextPath}">
<title>피드</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="${path}/css/feed/feed.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>

<!-- 사이드바 include -->
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>

<!-- 콘텐츠 Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">
    <!-- 메인 콘텐츠 -->
    <div id="content">
        <!-- 헤더 include -->
        <c:import url="/WEB-INF/views/common/header.jsp"/>

        <!-- 페이지 콘텐츠 시작 -->
        <div class="container mt-5" id="community-container" data-id="${communityNo}">
            <div class="header">
                <div class="header-left">
                    <h1>${community.communityTitle}</h1>
                    <p class="community-intro">${community.communityIntroduce}</p>
                </div>
                <div class="header-right">
                    <button onclick="showAddParticipant()" class="btn-add-participant">
                        <i class="fas fa-user-plus"></i> 참석자 추가
                    </button>
                    <button onclick="withdrawCommunity()" class="">
                    	탈퇴
                    </button>
                </div>
            </div>

            <!-- 피드 작성 폼 -->
            <div class="writeFeed">
                <form id="feedForm">
                    <textarea id="feedContent" name="content" rows="4" placeholder="새로운 소식이나 정보를 공유하세요!"></textarea>
                    <div class="button-container">
                        <input type="file" id="file-upload" style="display: none;" />
                        <button type="button" class="upload-btn" onclick="document.getElementById('file-upload').click();">
                            <i class="fas fa-image"></i>
                        </button>
                        <button type="submit" class="submit-btn">올리기</button>
                    </div>
                </form>
            </div>

            <!-- 피드 목록 -->
            <div id="feed-container">
                <!-- 피드 항목들 요기  -->
            </div>

            <!-- 참석자 추가 모달 -->
            <div id="addParticipantModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5><i class="fas fa-user-plus"></i> 참석자 초대</h5>
                        <span class="close">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div class="search-container">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" id="participantSearch" class="form-control" placeholder="이름으로 검색">
                        </div>
                        <div id="organizationTree" class="mt-3">
                            <!-- 조직도  -->
                        </div>
                        <div id="selectedParticipants" class="mt-3">
                            <h6><i class="fas fa-users"></i> 선택된 참석자</h6>
                            <ul id="participantList"></ul>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="inviteButton" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> 초대하기
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 페이지 콘텐츠 끝 -->
    </div>
    <!-- 메인 콘텐츠 끝 -->

    <!-- 푸터 include -->
    <c:import url="/WEB-INF/views/common/footer.jsp"/>
</div>
<!-- 콘텐츠 Wrapper 끝 -->

<script>
	var contextPath = '${pageContext.request.contextPath}';
	var currentEmployeeNo = '${loginEmployee.employeeNo}';
</script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${path}/js/feed/feed.js"></script>

</body>
</html>