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
    <link href="${pageContext.request.contextPath}/css/community/community.css" rel="stylesheet">
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
                    <!-- 즐겨찾는 커뮤니티 섹션 -->
                    <div class="section">
                        <h2>즐겨찾는 커뮤니티</h2>
                        <div class="group-container" id="bookmarkedCommunities">
                            <c:forEach var="community" items="${communities}">
                                <c:set var="isBookmarked" value="false" />
                                <c:forEach var="member" items="${community.members}">
                                    <c:if test="${member.employeeNo eq loginEmployee.employeeNo and member.communityUserBookmark eq 'Y'}">
                                        <c:set var="isBookmarked" value="true" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${isBookmarked}">
                                    <div class="group" data-community-no="${community.communityNo}">
                                        <div class="group-title">
                                            ${community.communityTitle}
                                            <span class="star active" data-community-no="${community.communityNo}">★</span>
                                        </div>
                                        <div class="member-icons">
                                            <c:forEach var="photo" items="${community.employeePhotoList}" begin="0" end="2" varStatus="status">
                                                <c:choose>
                                                    <c:when test="${empty photo or photo eq 'NULL'}">
                                                        <img src="${pageContext.request.contextPath}/images/profile.png" alt="Default User" class="user-icon" title="Employee ${status.index + 1}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/images/${photo}" alt="User" class="user-icon" title="Employee ${status.index + 1}">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:if test="${fn:length(community.employeePhotoList) > 3}">
                                                <span class="more-members">+${fn:length(community.employeePhotoList) - 3}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- 내 커뮤니티 섹션 -->
                    <div class="section">
                        <h2>내 커뮤니티</h2>
                        <div class="group-container">
                            <c:forEach var="community" items="${communities}">
                                <div class="group" data-community-no="${community.communityNo}">
                                    <div class="group-title">
                                        ${community.communityTitle}
                                        <c:set var="isBookmarked" value="false" />
                                        <c:forEach var="member" items="${community.members}">
                                            <c:if test="${member.employeeNo eq loginEmployee.employeeNo and member.communityUserBookmark eq 'Y'}">
                                                <c:set var="isBookmarked" value="true" />
                                            </c:if>
                                        </c:forEach>
                                        <span class="star ${isBookmarked ? 'active' : ''}" data-community-no="${community.communityNo}">
                                            ${isBookmarked ? '★' : '☆'}
                                        </span>
                                    </div>
                                    <div class="member-icons">
                                        <c:forEach var="photo" items="${community.employeePhotoList}" begin="0" end="2" varStatus="status">
                                            <c:choose>
                                                <c:when test="${empty photo or photo eq 'NULL'}">
                                                    <img src="${path}/images/profile.png" alt="Default User" class="user-icon" title="Employee ${status.index + 1}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${path}/images/${photo}" alt="User" class="user-icon" title="Employee ${status.index + 1}">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:if test="${fn:length(community.employeePhotoList) > 3}">
                                            <span class="more-members">+${fn:length(community.employeePhotoList) - 3}</span>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="add-group" id="addGroupBtn">+</div>
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

            <!-- 커뮤니티 생성 모달  -->
            <div id="createCommunityModal" class="modal">
              <div class="modal-content">
                <span class="close" id="closeModal">&times;</span>
                <h2 class="modal-title">커뮤니티 생성</h2>
                <form id="createCommunityForm">
                  <div class="form-group">
                    <label for="communityTitle">커뮤니티명</label>
                    <input type="text" id="communityTitle" class="form-control" required>
                  </div>
                  <div class="form-group">
                    <label for="communityIntroduce">소개</label>
                    <textarea id="communityIntroduce" class="form-control" required></textarea>
                  </div>
                  <div class="form-group">
                    <label>공개 여부</label>
                    <div class="radio-group">
                      <label>
                        <input type="radio" name="communityIsOpen" value="Y" checked> 공개
                      </label>
                      <label>
                        <input type="radio" name="communityIsOpen" value="N"> 비공개
                      </label>
                    </div>
                  </div>
                  <div class="btn-group">
                    <button type="submit" class="btn btn-primary">등록</button>
                    <button type="button" class="btn btn-secondary" id="close-btn">취소</button>
                  </div>
                </form>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/community/community.js"></script>

</body>
</html>