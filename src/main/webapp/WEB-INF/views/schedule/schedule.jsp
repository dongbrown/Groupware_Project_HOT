<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="${path}/css/schedule/schedule.css" rel="stylesheet">
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

				<!--@@@@@@ div 위치 조정 필요@@@@@ -->
            	<div class="calendar-legend">
                    <h5>2024년 6월</h5>
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: red;"></span>
                        <span>개인 캘린더</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: blue;"></span>
                        <span>팀 업무 진행</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: green;"></span>
                        <span>협업 진행</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: yellow;"></span>
                        <span>OO 프로젝트</span>
                    </div>
                    <div class="legend-item">
                        <span class="legend-color" style="background-color: orange;"></span>
                        <span>전사일정</span>
                    </div>
                </div>
				<!-- @@@@@@@@@@@@  -->

                <div id="calendar"></div>

                <div id="calendar-container">
                    <div id="calendar"></div>
                </div>

                <!-- 일정 추가 모달 -->
                <div id="scheduleModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h5>일정 추가</h5>
                        <form id="addScheduleForm">
                            <div class="form-group">
                                <label>타입</label>
                                <input type="radio" id="scheduleTypeMy" name="scheduleType" value="my" checked>
                                <label for="scheduleTypeMy">내 캘린더</label>
                                <input type="radio" id="scheduleTypeShare" name="scheduleType" value="share">
                                <label for="scheduleTypeShare">공유 캘린더</label>
                            </div>
                            <div class="form-group">
                                <label for="scheduleTitle">제목</label>
                                <input type="text" class="form-control" id="scheduleTitle" required>
                            </div>
                            <div class="form-group">
                                <label for="schedulePlace">장소</label>
                                <input type="text" class="form-control" id="schedulePlace" required>
                            </div>
                            <div class="form-group">
                                <label for="scheduleContent">내용</label>
                                <input type="text" class="form-control" id="scheduleContent" required>
                            </div>
                            <div class="form-group">
                                <label for="scheduleDate">시작 날짜</label>
                                <input type="date" class="form-control" id="scheduleDate" required>
                            </div>
                            <div class="form-group">
                                <label for="scheduleEnd">종료 날짜</label>
                                <input type="date" class="form-control" id="scheduleEnd">
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="scheduleAllDay">
                                <label class="form-check-label" for="scheduleAllDay">종일</label>
                            </div>
                            <div class="form-group">
                                <label for="scheduleColor">색상</label>
                                <input type="hidden" id="scheduleColor">
                                <div class="color-picker">
                                    <div class="color-option" style="background-color: #FF0000;" data-color="#FF0000"></div>
                                    <div class="color-option" style="background-color: #FFA500;" data-color="#FFA500"></div>
                                    <div class="color-option" style="background-color: #FFFF00;" data-color="#FFFF00"></div>
                                    <div class="color-option" style="background-color: #008000;" data-color="#008000"></div>
                                    <div class="color-option" style="background-color: #0000FF;" data-color="#0000FF"></div>
                                    <div class="color-option" style="background-color: #4B0082;" data-color="#4B0082"></div>
                                    <div class="color-option" style="background-color: #EE82EE;" data-color="#EE82EE"></div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">저장</button>
                        </form>
                    </div>
                </div>

                <div id="viewScheduleModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h5>일정 상세/수정</h5>
                        <form id="updateScheduleForm">
                            <input type="hidden" id="viewScheduleId">
                            <div class="form-group">
                                <label>타입</label>
                                <input type="radio" id="viewScheduleTypeMy" name="viewScheduleType" value="my">
                                <label for="viewScheduleTypeMy">내 캘린더</label>
                                <input type="radio" id="viewScheduleTypeShare" name="viewScheduleType" value="share">
                                <label for="viewScheduleTypeShare">공유 캘린더</label>
                            </div>
                            <div class="form-group">
                                <label for="viewScheduleTitle">제목</label>
                                <input type="text" class="form-control" id="viewScheduleTitle" required>
                            </div>
                            <div class="form-group">
                                <label for="viewSchedulePlace">장소</label>
                                <input type="text" class="form-control" id="viewSchedulePlace">
                            </div>
                            <div class="form-group">
                                <label for="viewScheduleContent">내용</label>
                                <textarea class="form-control" id="viewScheduleContent"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="viewScheduleStart">시작 날짜</label>
                                <input type="date" class="form-control" id="viewScheduleStart" required>
                            </div>
                            <div class="form-group">
                                <label for="viewScheduleEnd">종료 날짜</label>
                                <input type="date" class="form-control" id="viewScheduleEnd">
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="viewScheduleAllDay">
                                <label class="form-check-label" for="viewScheduleAllDay">종일</label>
                            </div>
                            <div class="form-group">
                                <label for="viewScheduleColor">라벨</label>
                                <input type="hidden" id="viewScheduleColor">
                                <div class="color-picker">
                                    <div class="color-option" style="background-color: #FF0000;" data-color="#FF0000"></div>
                                    <div class="color-option" style="background-color: #FFA500;" data-color="#FFA500"></div>
                                    <div class="color-option" style="background-color: #FFFF00;" data-color="#FFFF00"></div>
                                    <div class="color-option" style="background-color: #008000;" data-color="#008000"></div>
                                    <div class="color-option" style="background-color: #0000FF;" data-color="#0000FF"></div>
                                    <div class="color-option" style="background-color: #4B0082;" data-color="#4B0082"></div>
                                    <div class="color-option" style="background-color: #EE82EE;" data-color="#EE82EE"></div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">수정</button>
                            <button type="button" class="btn btn-danger" id="deleteScheduleBtn">삭제</button>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
<script type="text/javascript" src="${path}/js/schedule/schedule.js"></script>
</body>
</html>