<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <div class="container-fluid">
                <div class="community-container">
                    <div class="section">
                        <h2>즐겨찾는 커뮤니티</h2>
                        <c:forEach var="community" items="${communities}">
                            <c:set var="isBookmarked" value="false" />
                            <c:forEach var="member" items="${community.members}">
                                <c:if test="${member.employeeNo eq loginEmployee.employeeNo and member.communityUserBookmark eq 'Y'}">
                                    <c:set var="isBookmarked" value="true" />
                                </c:if>
                            </c:forEach>
                            <c:if test="${isBookmarked}">
                                <div class="group" data-community-no="${community.communityNo}">
                                    <div class="group-title">${community.communityTitle} <span class="star" data-community-no="${community.communityNo}">★</span></div>
                                    <c:forEach var="member" items="${community.members}" begin="0" end="4">
                                        <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon" title="Employee ${member.employeeNo}">
                                    </c:forEach>
                                    <c:if test="${fn:length(community.members) > 5}">
                                        <span class="more-members">+${fn:length(community.members) - 5}</span>
                                    </c:if>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <div class="section">
                        <h2>내 커뮤니티</h2>
                        <c:forEach var="community" items="${communities}">
                            <div class="group" data-community-no="${community.communityNo}">
                                <div class="group-title">
                                    ${community.communityTitle}
                                    <c:set var="isBookmarked" value="false" />
                                    <c:forEach var="member" items="${community.members}">
                                        <c:if test="${member.employeeNo eq loginEmployee.employeeNo}">
                                            <c:set var="isBookmarked" value="${member.communityUserBookmark eq 'Y'}" />
                                        </c:if>
                                    </c:forEach>
                                    <span class="star" data-community-no="${community.communityNo}">${isBookmarked ? '★' : '☆'}</span>
                                </div>
                                <c:forEach var="member" items="${community.members}" begin="0" end="4">
                                    <img src="${pageContext.request.contextPath}/img/undraw_profile_1.svg" alt="User" class="user-icon" title="Employee ${member.employeeNo}">
                                </c:forEach>
                                <c:if test="${fn:length(community.members) > 5}">
                                    <span class="more-members">+${fn:length(community.members) - 5}</span>
                                </c:if>
                            </div>
                        </c:forEach>
                        <div class="add-group" id="addGroupBtn">
                            +
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

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${path}/js/community/community.js"></script>

</body>
</html>