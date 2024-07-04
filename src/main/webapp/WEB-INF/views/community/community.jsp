<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<style>
    <c:import url="${path}/css/community/community.css"/>
</style>
</head>
<body>
<!-- 페이지 Wrapper -->
<div id="wrapper">
    <!-- 사이드바 include -->
    <c:import url="/WEB-INF/views/common/sidebar.jsp"/>

    <!-- 콘텐츠 Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- 메인 콘텐츠 -->
        <div id="content">
            <!-- 헤더 include -->
            <c:import url="/WEB-INF/views/common/header.jsp"/>

            <!-- 페이지 콘텐츠 시작 -->
            <div class="container-fluid">
                <div class="community-container">
                    <div class="section">
                        <h2>즐겨찾는 커뮤니티</h2>
                        <div class="group">
                            <div class="group-title">축구 모임 <span class="star">★</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                        <div class="group">
                            <div class="group-title">AI 딥러닝 스터디 <span class="star">★</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                        <div class="group">
                            <div class="group-title">주말 등산 모임 <span class="star">★</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                    </div>

                    <div class="section">
                        <h2>내 커뮤니티</h2>
                        <div class="group">
                            <div class="group-title">축구 모임 <span class="star">★</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                        <div class="group">
                            <div class="group-title">AI 딥러닝 스터디 <span class="star">★</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                        <div class="group">
                            <div class="group-title">주말 등산 모임 <span class="star">★</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                        <div class="group">
                            <div class="group-title">아이디어 브레인 스토밍 <span class="star">☆</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                        <div class="group">
                            <div class="group-title">마케팅 업무 <span class="star">☆</span></div>
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                            <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon">
                        </div>
                        <div class="add-group" id="addGroupBtn">
                            +
                        </div>
                    </div>
                </div>

                <!-- 커뮤니티 생성 모달 -->
                <div id="createCommunityModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h5>커뮤니티 만들기</h5>
                        <form id="createCommunityForm">
                            <div class="form-group">
                                <label for="communityTitle">커뮤니티명</label>
                                <input type="text" class="form-control" id="communityTitle" required>
                            </div>
                            <div class="form-group">
                                <label for="communityIntroduce">소개</label>
                                <textarea class="form-control" id="communityIntroduce" rows="3"></textarea>
                            </div>
                            <div class="form-group">
                                <label>공개 여부</label>
                                <div>
                                    <input type="radio" id="communityIsOpenY" name="communityIsOpen" value="Y" checked>
                                    <label for="communityIsOpenY">공개</label>
                                    <input type="radio" id="communityIsOpenN" name="communityIsOpen" value="N">
                                    <label for="communityIsOpenN">비공개</label>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">등록</button>
                        </form>
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
</div>
<!-- 페이지 Wrapper 끝 -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${path}/js/community/community.js"></script>
</body>
</html>