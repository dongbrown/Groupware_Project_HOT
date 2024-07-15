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
<link href="${path}/css/feed/feed.css" rel="stylesheet">
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
                        <button type="submit" class="submit-btn">올리기</button>
                    </div>
                </form>
            </div>

            <!-- 피드 목록 -->
            <div id="feed-container">
                <div class="feed-item"> <!-- 예시 피드 항목 -->
                    <div class="post-header">
                        <img src="user_icon.png" alt="유저 아이콘">
                        <div>
                            <h2>유저 이름</h2>
                            <p>포스트 내용</p>
                        </div>
                    </div>
                    <div class="post-content">
                        포스트 본문
                    </div>
                    <div class="post-actions">
                        <button>좋아요</button>
                        <button>댓글</button>
                    </div>
                </div>
            </div>

            <div id="addParticipantModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5>초대하기</h5>
                        <span class="close">&times;</span>
                    </div>
                    <div class="modal-body">
                        <select id="departmentSelect" class="form-select mb-3">
                            <option value="">부서 선택</option>
                        </select>
                        <select id="employeeSelect" class="form-select mb-3">
                            <option value="">사원 선택</option>
                        </select>
                        <button id="addParticipantBtn" class="btn btn-secondary mb-3">참석자 추가</button>
                        <div id="selectedParticipants" class="mb-3">
                            <h6>선택된 참석자:</h6>
                            <ul id="participantList"></ul>
                        </div>
                        <div id="organizationTree">
                            <!-- 조직도 트리 여기에! -->
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="inviteButton" class="btn btn-primary">초대</button>
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
// 현재 로그인한 직원 번호를 JavaScript 변수로 설정
var currentEmployeeNo = ${loginEmployee.employeeNo};
</script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${path}/js/feed/feed.js"></script>

</body>
</html>