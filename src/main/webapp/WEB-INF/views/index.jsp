<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp"></c:import>
    <!-- 메인 컨텐트 제작 -->
        <div id="main-wrap">
            <!-- 첫번째 줄 wrap (사원정보, 메일, 전자결재 확인 등) -->
             <div id="first-wrap">
                <div id="member-card">
                    <div id="changeBtn"><img src="https://i.imgur.com/tTdzHN7.png" width="25px"></div>
                    <div id="member-card-profile"></div>
                    <h4 style="margin-top: 30px; font-weight: bolder;">홍 길 동</h3>
                    <a>개발 부서/팀</a>
                    <div id="member-card-mail">
                        <div><a href=""><img src="https://i.imgur.com/LIHIxyI.png" width="40px" style="margin-bottom: 3px;"></a></div>
                        <div><a href=""><img src="https://i.imgur.com/JjYn69Q.png" width="40px"></a></div>
                    </div>

                </div>
                <div id="approval-card">전자결재</div>
                <div id="search-card">직원 조회</div>
                <div id="mail-card">받은메일</div>
             </div>
             <!-- 두번째 줄 wrap (게시판, 프로젝트/작업현황, 회의안건) -->
             <div id="second-wrap">
                <div id="board-card">게시판</div>
                <div id="project-card">
                    <div>프로젝트 현황</div>
                    <div>작업 현황</div>
                </div>
            <div id="agenda-card">회의안건</div>

             </div>
            <!-- 세번째 줄 wrap (켈린더, 오늘의 일정, 홍보배너, 회사점심식단표) -->
             <div id="third-wrap">
                <div id="calender-card">켈린더</div>
                <div id="today-work-card">오늘의 일정</div>
                <div id="banner-card">홍보배너</div>
                <div id="menu-card">회사점심식단표</div>
             </div>


        </div>

</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${path }/js/common/header.js"></script>
</html>
