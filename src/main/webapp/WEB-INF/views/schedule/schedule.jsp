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
<style>
    <c:import url="${path}/css/schedule/schedule.css"/>
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp"></c:import>

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
                <input type="color" class="form-control" id="scheduleColor">
            </div>
            <button type="submit" class="btn btn-primary">저장</button>
        </form>
    </div>
</div>

<!-- 일정 상세 보기 및 수정 모달 -->
<div id="viewScheduleModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h5>일정 상세/수정</h5>
        <form id="updateScheduleForm">
            <div class="form-group">
                <label>타입</label>
                <input type="radio" id="viewScheduleTypeMy" name="viewScheduleType" value="my">
                <label for="viewScheduleTypeMy">내 캘린더</label>
                <input type="radio" id="viewScheduleTypeShare" name="viewScheduleType" value="share">
                <label for="viewScheduleTypeShare">공유 캘린더</label>
            </div>
            <input type="hidden" id="viewScheduleId">
            <div class="form-group">
                <label for="viewScheduleTitle">제목</label>
                <input type="text" class="form-control" id="viewScheduleTitle" required>
            </div>
            <div class="form-group">
                <label for="viewScheduleContent">내용</label>
                <input type="text" class="form-control" id="viewScheduleContent" required>
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
                <label for="viewScheduleColor">색상</label>
                <input type="color" class="form-control" id="viewScheduleColor">
            </div>
            <button type="submit" class="btn btn-primary">수정</button>
            <button type="button" class="btn btn-danger" id="deleteScheduleBtn">삭제</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
<script type="text/javascript" src="${path}/js/schedule/schedule.js"></script>
</body>
</html>