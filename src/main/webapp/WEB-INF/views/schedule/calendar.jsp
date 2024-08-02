<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css"
	rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css"
	rel="stylesheet">
<link href="${path}/css/schedule/schedule.css" rel="stylesheet">
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/gcal.min.js'></script>
</head>
<body>
	<c:set var="loginEmployee"
		value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

	<!-- 페이지 Wrapper -->

	<!-- 사이드바 include -->
	<c:import url="/WEB-INF/views/common/sidebar.jsp" />

	<!-- 콘텐츠 Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">
		<!-- 메인 콘텐츠 -->
		<div id="content">
			<!-- 헤더 include -->
			<c:import url="/WEB-INF/views/common/header.jsp" />

			<!-- 페이지 콘텐츠 시작 -->
			<div class="container-fluid">
				<div id="calendar-container">
                    <div id="todayCalendar"></div>
                </div>
			</div>
			<!-- 페이지 콘텐츠 끝 -->
		</div>
		<!-- 메인 콘텐츠 끝 -->

		<!-- 푸터 include -->
		<c:import url="/WEB-INF/views/common/footer.jsp" />
	</div>
	<!-- 콘텐츠 Wrapper 끝 -->
	<script type="text/javascript" src="${path}/js/schedule/calendar.js"></script>
</body>
</html>