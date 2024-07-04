<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="${path}/css/project/insertProject.css" rel="stylesheet" type="text/css">

<section>
	<div id="project-first-wrap">
		<div>
			<div id="project-insert-title">프로젝트 생성</div>
		</div>
		<div style="display: flex; flex-direction: column; align-items:center;">
			<div style="display: flex; flex-direction: row; justify-content: center; margin-top: 30px;">
				<div id="project-insert-body">
					<!-- 프로젝트 이름 -->
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">프로젝트
							이름</span> <input type="text" class="form-control"
							aria-label="Sizing example input"
							aria-describedby="inputGroup-sizing-default">
					</div>
					<!-- 프로젝트 생성자 이름 -->
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
						<input type="text" class="form-control"
							aria-label="Sizing example input"
							aria-describedby="inputGroup-sizing-default" value="${loginEmployee.employeeName }" disabled>
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
					<div id="project-contents" class="form-floating">
						<textarea class="form-control" placeholder="Leave a comment here"
							id="floatingTextarea"></textarea>
						<label for="floatingTextarea">프로젝트 설명</label> <span
							id="project-contents-count" style="margin-left: auto;">0/1000</span>
					</div>

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
								<option value="1">경영</option>
								<option value="2">디자인2팀</option>
								<option value="3">디자인1팀</option>
								<option value="4">개발3팀</option>
								<option value="5">개발2팀</option>
								<option value="6">개발1팀</option>
							</select>
						</div>
					</div>
					<!-- 체크한 사원 추가 div -->
					<div id="saved-members"></div>

				</div>
				<!-- 사원 조회 생성 -->
				<div id="input-member"></div>
			</div>
			<div style="width:250px;">
			<button style="margin-bottom: 70px; margin-left:30px;" type="button"
				class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#updateSelectModal">프로젝트 등록</button>
				</div>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="updateSelectModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">등록하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary">등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</div>
<script src="${path }/js/project/insertProject.js"></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>