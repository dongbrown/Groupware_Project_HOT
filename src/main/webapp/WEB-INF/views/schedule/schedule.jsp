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
<script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/gcal.min.js'></script>
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
                <div class="calendar-legend">
                    <h1>일정관리</h1>
                    <div id="calendar2-container">
                        <div id="calendar2"></div>
                    </div>
                    <!-- 내 일정 -->
                    <div class="calendar-section">
                        <div class="calendar-type toggle-header">
                            <img src="${path}/images/under.png" id="under" alt="v"
                                class="arrow-icon" /> 내 일정
                        </div>
                        <div class="legend-items">
                            <c:forEach var="schedule" items="${mySchedules}">
                                <div class="legend-item">
                                    <input type="checkbox" class="schedule-checkbox"
                                        data-id="${schedule.id}" checked>
                                    <span>${schedule.title}</span>
                                    <span class="legend-color"
                                        style="background-color: ${schedule.color};"></span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- 공유 일정 -->
                    <div class="calendar-section">
                        <div class="calendar-type toggle-header">
                            <img src="${path}/images/under.png" id="under" alt="v"
                                class="arrow-icon" /> 공유 일정
                        </div>
                        <div class="legend-items">
                            <c:forEach var="schedule" items="${sharedSchedules}">
                                <div class="legend-item">
                                    <input type="checkbox" class="schedule-checkbox"
                                        data-id="${schedule.id}" checked>
                                    <span>${schedule.title}</span>
                                    <span class="legend-color"
                                        style="background-color: ${schedule.color};"></span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- 전사 일정  -->
                    <div class="calendar-section">
                        <div class="calendar-type toggle-header">
                            <img src="${path}/images/under.png" id="under" alt="v"
                                class="arrow-icon" /> 전사 일정
                        </div>
                        <div class="legend-items">
                            <c:forEach var="schedule" items="${companySchedules}">
                                <div class="legend-item">
                                    <input type="checkbox" class="schedule-checkbox"
                                        data-id="${schedule.id}" data-type="company" checked>
                                    <span>${schedule.title}</span>
                                    <span class="legend-color"
                                        style="background-color: ${schedule.color};"></span>
                                </div>
                            </c:forEach>
                        </div>
                        <div>
                            <c:if test="${loginEmployee.positionCode.positionCode == 1}">
                                <button id="addCompanyScheduleBtn" class="btn btn-primary">전사일정
                                    등록</button>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div id="calendar-container">
                    <div id="calendar"></div>
                </div>
            </div>

            <!-- 일정 추가 모달(내 일정 / 공유 일정) -->
            <div id="scheduleModal" class="modal fade" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">일정 추가</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <form id="addScheduleForm">
                            <div class="modal-body">
                                <div class="form-group schedule-type-group">
                                    <div class="radio-group">
                                        <div class="radio-item">
                                            <input type="radio" id="scheduleTypeMy" name="scheduleType"
                                                value="my" checked> <label for="scheduleTypeMy">내
                                                일정</label>
                                        </div>
                                        <div class="radio-item">
                                            <input type="radio" id="scheduleTypeShare"
                                                name="scheduleType" value="share"> <label
                                                for="scheduleTypeShare">공유 일정</label>
                                        </div>
                                    </div>
                                </div>
                                <div id="participantSelection" class="form-group"
                                    style="display: none;">
                                    <label class="form-label">참석자 선택</label>
                                    <div class="participant-selection-container">
                                        <div class="department-list">
                                            <h6>부서 목록</h6>
                                            <ul id="departmentList"></ul>
                                        </div>
                                        <div class="employee-list">
                                            <h6>사원 목록</h6>
                                            <ul id="employeeList"></ul>
                                        </div>
                                        <div class="selected-employees">
                                            <h6>선택된 참석자</h6>
                                            <ul id="selectedEmployeeList"></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleTitle">제목</label> <input type="text"
                                        class="form-control" id="scheduleTitle" required>
                                </div>
                                <div class="form-group">
                                    <label for="schedulePlace">장소</label> <input type="text"
                                        class="form-control" id="schedulePlace" required>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleContent">내용</label> <input type="text"
                                        class="form-control" id="scheduleContent" required>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleDate">시작 날짜</label> <input type="date"
                                        class="form-control" id="scheduleDate" required>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleEnd">종료 날짜</label> <input type="date"
                                        class="form-control" id="scheduleEnd">
                                </div>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input"
                                        id="scheduleAllDay"> <label class="form-check-label"
                                        for="scheduleAllDay">종일</label>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleColor">색상</label> <input type="hidden"
                                        id="scheduleColor">
                                    <div class="color-picker">
                                        <div class="color-option" style="background-color: #FF0000;"
                                            data-color="#FF0000"></div>
                                        <div class="color-option" style="background-color: #FFA500;"
                                            data-color="#FFA500"></div>
                                        <div class="color-option" style="background-color: #FFFF00;"
                                            data-color="#FFFF00"></div>
                                        <div class="color-option" style="background-color: #008000;"
                                            data-color="#008000"></div>
                                        <div class="color-option" style="background-color: #0000FF;"
                                            data-color="#0000FF"></div>
                                        <div class="color-option" style="background-color: #4B0082;"
                                            data-color="#4B0082"></div>
                                        <div class="color-option" style="background-color: #EE82EE;"
                                            data-color="#EE82EE"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">저장</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 전사일정 등록 모달 -->
            <div id="companyScheduleModal" class="modal fade" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">전사일정 등록</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <form id="addCompanyScheduleForm">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="companyScheduleTitle">제목</label> <input type="text"
                                        class="form-control" id="companyScheduleTitle" required>
                                </div>
                                <div class="form-group">
                                    <label for="companySchedulePlace">장소</label> <input type="text"
                                        class="form-control" id="companySchedulePlace" required>
                                </div>
                                <div class="form-group">
                                    <label for="companyScheduleContent">내용</label>
                                    <textarea class="form-control" id="companyScheduleContent"
                                        required></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="companyScheduleDate">시작 날짜</label> <input
                                        type="date" class="form-control" id="companyScheduleDate"
                                        required>
                                </div>
                                <div class="form-group">
                                    <label for="companyScheduleEnd">종료 날짜</label> <input
                                        type="date" class="form-control" id="companyScheduleEnd">
                                </div>
                                <div class="form-group">
                                    <label for="companyScheduleColor">색상</label> <input
                                        type="hidden" id="companyScheduleColor">
                                    <div class="color-picker">
                                        <div class="color-option company-color-option"
                                            style="background-color: #FF0000;" data-color="#FF0000"></div>
                                        <div class="color-option company-color-option"
                                            style="background-color: #FFA500;" data-color="#FFA500"></div>
                                        <div class="color-option company-color-option"
                                            style="background-color: #FFFF00;" data-color="#FFFF00"></div>
                                        <div class="color-option company-color-option"
                                            style="background-color: #008000;" data-color="#008000"></div>
                                        <div class="color-option company-color-option"
                                            style="background-color: #0000FF;" data-color="#0000FF"></div>
                                        <div class="color-option company-color-option"
                                            style="background-color: #4B0082;" data-color="#4B0082"></div>
                                        <div class="color-option company-color-option"
                                            style="background-color: #EE82EE;" data-color="#EE82EE"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">저장</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>



			<!-- 일정 조회/수정 모달 -->
            <div id="viewScheduleModal" class="modal fade" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">일정 상세</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                        </div>
                        <form id="updateScheduleForm">
                            <div class="modal-body">
                                <input type="hidden" id="viewScheduleId">
                                <div class="form-group">
                                    <div class="radio-group">
                                        <div class="radio-item">
                                            <input type="radio" id="viewScheduleTypeMy"
                                                name="viewScheduleType" value="my" checked> <label
                                                for="viewScheduleTypeMy">내 일정</label>
                                        </div>
                                        <div class="radio-item">
                                            <input type="radio" id="viewScheduleTypeShare"
                                                name="viewScheduleType" value="share"> <label
                                                for="viewScheduleTypeShare">공유 일정</label>
                                        </div>
                                    </div>
                                </div>
                                <div id="viewParticipantSelection" class="form-group"
                                    style="display: none;">
                                    <label class="form-label">참석자 선택</label>
                                    <div class="participant-selection-container">
                                        <div class="department-list">
                                            <h6>부서 목록</h6>
                                            <ul id="viewDepartmentList"></ul>
                                        </div>
                                        <div class="employee-list">
                                            <h6>사원 목록</h6>
                                            <ul id="viewEmployeeList"></ul>
                                        </div>
                                        <div class="selected-employees">
                                            <h6>선택된 참석자</h6>
                                            <ul id="viewSelectedEmployeeList"></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="viewScheduleTitle">제목</label> <input type="text"
                                        class="form-control" id="viewScheduleTitle" required>
                                </div>
                                <div class="form-group">
                                    <label for="viewSchedulePlace">장소</label> <input type="text"
                                        class="form-control" id="viewSchedulePlace">
                                </div>
                                <div class="form-group">
                                    <label for="viewScheduleContent">내용</label>
                                    <textarea class="form-control" id="viewScheduleContent"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="viewScheduleStart">시작 날짜</label> <input type="date"
                                        class="form-control" id="viewScheduleStart" required>
                                </div>
                                <div class="form-group">
                                    <label for="viewScheduleEnd">종료 날짜</label> <input type="date"
                                        class="form-control" id="viewScheduleEnd">
                                </div>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input"
                                        id="viewScheduleAllDay"> <label
                                        class="form-check-label" for="viewScheduleAllDay">종일</label>
                                </div>
                                <div class="form-group">
                                    <label for="viewScheduleColor">라벨</label> <input type="hidden"
                                        id="viewScheduleColor">
                                    <div class="color-picker">
                                        <div class="color-option" style="background-color: #FF0000;"
                                            data-color="#FF0000"></div>
                                        <div class="color-option" style="background-color: #FFA500;"
                                            data-color="#FFA500"></div>
                                        <div class="color-option" style="background-color: #FFFF00;"
                                            data-color="#FFFF00"></div>
                                        <div class="color-option" style="background-color: #008000;"
                                            data-color="#008000"></div>
                                        <div class="color-option" style="background-color: #0000FF;"
                                            data-color="#0000FF"></div>
                                        <div class="color-option" style="background-color: #4B0082;"
                                            data-color="#4B0082"></div>
                                        <div class="color-option" style="background-color: #EE82EE;"
                                            data-color="#EE82EE"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">수정</button>
                                <button type="button" class="btn btn-danger"
                                    id="deleteScheduleBtn">삭제</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- 페이지 콘텐츠 끝 -->
    </div>
    <!-- 메인 콘텐츠 끝 -->

    <!-- 푸터 include -->
    <c:import url="/WEB-INF/views/common/footer.jsp" />
    </div>
    <!-- 콘텐츠 Wrapper 끝 -->
    <script>
    // 전사일정 데이터를 변수로 전달
    var companySchedules = [
        <c:forEach items="${companySchedules}" var="schedule" varStatus="status">
            {
                id: ${schedule.id},
                title: "${schedule.title}",
                start: "${schedule.start}",
                end: "${schedule.end}",
                color: "${schedule.color}"
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // ceo만 전사 일정 삭제 가능하도록 변수로 js에 전달
    var isCeo = ${loginEmployee.positionCode.positionCode == 1};
    </script>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    <script type="text/javascript" src="${path}/js/schedule/schedule.js"></script>
</body>
</html>