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
			<div class="header">
				<h1>Community</h1>
				<button onclick="showAddParticipant()">+ 참석자 추가</button>
				</div>

				<h2>AI 딥러닝 스터디</h2>
				<p>참석자: 김명준, 임성욱, 최선웅, 고재현, 김동훈</p>

				<div>
				<h3>소개</h3>
				<p>생성형 AI 적용 및 알고리즘을 공부하는 스터디입니다.</p>
				</div>
				<div class="writeFeed">
				        <form action="submit_post.jsp" method="post" enctype="multipart/form-data">
				            <textarea name="content" rows="4" placeholder="새로운 소식이나 정보를 공유하세요!"></textarea>
				            <div class="button-container">
				                <input type="file" id="file-upload" style="display: none;" />
				                <button type="button" class="upload-btn" onclick="document.getElementById('file-upload').click();">
				                    <img src="image_icon.png" alt="이미지 업로드" width="20" height="20" />
				                </button>
				                <input type="submit" value="올리기" class="submit-btn" />
				            </div>
				        </form>
				    </div>

				<div id="feed-container">
				<!-- 게시물들이 여기에-->
				</div>

            <!-- 페이지 콘텐츠 끝 -->
        </div>
        <!-- 메인 콘텐츠 끝 -->

        <!-- 푸터 include -->
        <c:import url="/WEB-INF/views/common/footer.jsp"/>
    </div>
    <!-- 콘텐츠 Wrapper 끝 -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${path}/js/feed/feed.js"></script>




	</body>
</html>