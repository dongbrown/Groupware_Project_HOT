<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>피드</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<style>
    <c:import url="${path}/css/feed/feed.css"/>
</style>
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
        <div class="container mt-5">
            <div class="header">
                <h1>${community.communityTitle}</h1>
                <button onclick="showAddParticipant()">+ 참석자 추가</button>
            </div>

            <p>${community.communityIntroduce}</p>

            <!-- 피드 작성 폼 -->
            <div class="writeFeed">
                <form id="feedForm">
                    <textarea id="feedContent" name="content" rows="4" placeholder="새로운 소식이나 정보를 공유하세요!"></textarea>
                    <div class="button-container">
                        <input type="file" id="file-upload" style="display: none;" />
                        <button type="button" class="upload-btn" onclick="document.getElementById('file-upload').click();">
                            <img src="image_icon.png" alt="이미지 업로드" width="20" height="20" />
                        </button>
                        <button type="button" onclick="submitFeed()" class="submit-btn">올리기</button>
                    </div>
                </form>
            </div>

            <!-- 피드 목록 -->
            <div id="feed-container" data-community-no="${communityNo}">
                <c:forEach items="${feeds}" var="feed">
                    <div class="feed-item" id="feed-${feed.feedNo}">
                        <h5>${feed.employeeName}</h5>
                        <p>${feed.feedContent}</p>
                        <small class="text-muted">${feed.feedEnrollDate}</small>
                        <div class="feed-actions">
                            <button class="btn btn-sm btn-outline-primary" onclick="updateFeed(${feed.feedNo})">수정</button>
                            <button class="btn btn-sm btn-outline-danger" onclick="deleteFeed(${feed.feedNo})">삭제</button>
                        </div>
                    </div>
                </c:forEach>
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
var communityNo = ${communityNo};

// communityNo가 없으면 에러 처리
if (!communityNo) {
    alert("커뮤니티 번호가 필요합니다.");
    // 적절한 페이지로 리다이렉트
    window.location.href = "/error";
}
</script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${path}/js/feed/feed.js"></script>

</body>
</html>