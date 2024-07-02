<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<style>
	<c:import url="${path}/css/project/updateProject.css"/>
</style>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<c:import url="/WEB-INF/views/common/header.jsp"></c:import>
<body>
	<div id="project-update-main">
		<div id="project-update-title">프로젝트 수정</div>

		<div id="project-update-window"
			style="display: flex; flex-direction: row;">
			<div class="modal-body">
				<!-- 프로젝트 이름 -->
				<div class="input-group mb-3">
					<span class="input-group-text" id="inputGroup-sizing-default">프로젝트
						이름</span> <input type="text" class="form-control"
						aria-label="Sizing example input"
						aria-describedby="inputGroup-sizing-default" value="${projectNo}">
				</div>
				<!-- 프로젝트 생성자 이름 -->
				<div class="input-group mb-3">
					<span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
					<input type="text" class="form-control"
						aria-label="Sizing example input"
						aria-describedby="inputGroup-sizing-default" value="홍길동" disabled>
				</div>
				<!-- 프로젝트 중요도 체크박스  -->
				<div class="input-group mb-3">
					<span class="input-group-text" id="inputGroup-sizing-default">프로젝트
						중요도</span> <select class="form-select"
						aria-label="Default select example">
						<option selected>선택하세요.</option>
						<option value="1" style="color: red;">상</option>
						<option value="2" style="color: rgb(255, 132, 0);">중</option>
						<option value="3" style="color: green;">하</option>
					</select>
				</div>
				<!-- 프로젝트 설명 -->
				<p style="font-weight: bolder;">프로젝트 설명</p>
				<div class="form-floating">
					<textarea class="form-control" placeholder="Leave a comment here"
						id="floatingTextarea"></textarea>
					<label for="floatingTextarea">프로젝트 설명</label>
				</div>
				<!-- 프로젝트 종료 예정일 -->
				<br>
				<div>
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">프로젝트
							종료일</span> <select id="year" class="form-select" aria-label="Year"
							required>
							<option value="" selected>년</option>

						</select> <select id="month" class="form-select" aria-label="Month"
							required>
							<option value="" selected>월</option>
						</select> <select id="day" class="form-select" aria-label="Day" required>
							<option value="" selected>일</option>

						</select>
					</div>
				</div>
				<br>
				<!-- 프로젝트 배정 예산 -->
				<div class="input-group mb-3">
					<span class="input-group-text" id="inputGroup-sizing-default">배정예산</span>
					<input type="text" id="project-budget" class="form-control"
						aria-label="Sizing example input"
						aria-describedby="inputGroup-sizing-default" placeholder="입력하세요.">
				</div>


				<br>
				<!--  최대 참여 인원(수)-->
				<div id="member-list" style="display: flex; flex-direction: row;">
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">총
							인원</span> <input id="totalMember" type="text" class="form-control"
							aria-label="Sizing example input"
							aria-describedby="inputGroup-sizing-default" value="1" disabled>
					</div>

					<div class="input-group mb-3" style="margin-left: 20px;">
						<span class="input-group-text" id="inputGroup-sizing-default">부서</span>
						<select id="select-dept" class="form-select"
							aria-label="Default select example">
							<option selected>선택하세요.</option>
							<option value="개발1팀">개발1팀</option>
							<option value="개발2팀">개발2팀</option>
							<option value="개발3팀">개발3팀</option>
							<option value="홍보팀">홍보팀</option>
							<option value="디자인1팀">디자인1팀</option>
							<option value="디자인2팀">디자인2팀</option>
						</select>
					</div>
				</div>
				<!-- 체크한 사원 추가 div -->
				<div id="saved-members">
					<div id="checked-member-wrab" class="saved-item">
						개발3팀: 홍길동 사번 / 512341234
						<button class="btn-close" type="button"></button>
					</div>
					<div id="checked-member-wrab" class="saved-item">
						개발3팀: 홍길동 사번 / 112341234
						<button class="btn-close" type="button"></button>
					</div>
					<div id="checked-member-wrab" class="saved-item">
						개발3팀: 홍길동 사번 / 212341234
						<button class="btn-close" type="button"></button>
					</div>
				</div>
				<div
					style="display: flex; justify-content: center; align-items: center; margin-top: 30px;">
					<button type="button" class="btn btn-primary">프로젝트 수정</button>
				</div>

			</div>
			<!-- 사원 조회 생성 -->
			<div id="input-member"></div>

		</div>

	</div>
</body>
<script type="text/javascript" src="${path }/js/project/updateProject.js"></script>
</html>