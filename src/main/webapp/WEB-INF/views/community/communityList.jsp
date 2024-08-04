<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
                <div class="page-header">
                    <h1 class="text-primary">커뮤니티 목록</h1>
                    <p class="lead">모든 커뮤니티 목록입니다. 원하는 커뮤니티에 가입하여 활동을 시작해보세요.</p>
                </div>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">커뮤니티 목록</h6>
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
                                            <td class="community-title">
                                                <c:choose>
                                                    <c:when test="${community.communityIsOpen ne 'N'}">
                                                        <a href="${pageContext.request.contextPath}/community/feed?communityNo=${community.communityNo}">
                                                            ${community.communityTitle}
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${community.communityTitle}
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${community.communityIsOpen eq 'N'}">
                                                    <img src="${pageContext.request.contextPath}/images/lock.png" alt="비공개" class="lock-icon" style="width: 16px; height: 16px; margin-left: 5px; vertical-align: middle">
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
                                                        <c:choose>
                                                            <c:when test="${community.communityIsOpen eq 'N'}">
                                                                <button class="btn btn-warning btn-sm join-btn" data-community-id="${community.communityNo}" data-is-private="true">가입신청</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-primary btn-sm join-btn" data-community-id="${community.communityNo}" data-is-private="false">가입</button>
                                                            </c:otherwise>
                                                        </c:choose>
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

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var contextPath = '${pageContext.request.contextPath}';
        var currentEmployeeNo = '${loginEmployee.employeeNo}';
    </script>
    <script src="${pageContext.request.contextPath}/js/community/communityList.js"></script>
</body>
</html>
