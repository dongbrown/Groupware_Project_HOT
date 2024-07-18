<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<style>
<c:import url="${path}/css/community/communityList.css"/>
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
            <h1 class="h3 mb-2 text-gray-800">커뮤니티 목록</h1>
            <p class="mb-4">모든 커뮤니티 목록입니다.</p>

            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <!-- <h6 class="m-0 font-weight-bold text-primary">커뮤니티</h6> -->
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="communityTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>커뮤니티 이름</th>
                                    <th>회원 수</th>
                                    <th>소개</th>
                                    <th>가입</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${communities}" var="community">
                                    <tr>
                                        <td>${community.communityNo}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${community.communityIsOpen ne 'N'}">
                                                    <a href="${pageContext.request.contextPath}/community/feed/list?communityNo=${community.communityNo}">
                                                        ${community.communityTitle}
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    ${community.communityTitle}
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${community.communityIsOpen eq 'N'}">
                                                <img src="${pageContext.request.contextPath}/images/lock.png" alt="비공개" style="width: 16px; height: 16px; margin-left: 5px;">
                                            </c:if>
                                        </td>
                                        <td>${fn:length(community.members)}</td>
                                        <td>${community.communityIntroduce}</td>
                                        <td>
                                            <c:set var="isMember" value="false" />
                                            <c:forEach items="${community.members}" var="member">
                                                <c:if test="${member.employeeNo eq loginEmployee.employeeNo}">
                                                    <c:set var="isMember" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${isMember}">
                                                    <button class="btn btn-secondary btn-sm" disabled>가입중</button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-primary btn-sm join-btn" data-community-id="${community.communityNo}">가입</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
<script type="text/javascript" src="${path}/js/community/communityList.js"></script>

</body>
</html>