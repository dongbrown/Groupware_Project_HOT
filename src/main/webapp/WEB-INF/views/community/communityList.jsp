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
        <div>


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
