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
<link href="${path}/css/project/updateProject.css" rel="stylesheet" type="text/css">
<section>
	<div id="project-first-wrap">
		<div >
			<div id="project-update-title">프로젝트 수정</div>
		</div>

		<div id="project-update-main">
			<div id="project-list">
				<p id="proejct-list-title" style="font-weight: bolder; font-size: 20px; margin-top:80px;">프로젝트 목록</p>

				<div id="projectListTable" class="table-responsive">
					<div>

						<table
							class="table text-start align-middle table-bordered table-hover mb-0"
							style="text-align: center;">
							<thead>
								<tr class="text-dark">
									<th scope="col">날짜</th>
									<th scope="col">번호</th>
									<th scope="col">담당자</th>
									<th scope="col">프로젝트 제목</th>
									<th scope="col" style="width: 300px;">진행률</th>
									<th scope="col">삭제</th>
								</tr>
							</thead>
							<tbody>
							<tr class="project-choice">
									<td>01 Jan 2045</td>
									<td>2</td>
									<td>김동훈</td>
									<td>프로젝트 제목 01</td>
									<td>
										<div class="graph-container">
											<div class="bar" data-percentage="55"></div>
											<div style="margin-top: 5px; margin-left:5px;">55%</div>
										</div>
									</td>
									<td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
								</tr>

								<tr class="project-choice">
									<td>01 Jan 2045</td>
									<td>2</td>
									<td>김명준</td>
									<td>프로젝트 제목 02</td>
									<td>
										<div class="graph-container">
											<div class="bar" data-percentage="30"></div>
											<div style="margin-top: 5px; margin-left:5px;">30%</div>
										</div>
									</td>
									<td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
								</tr>
								<tr class="project-choice">
									<td>01 Jan 2045</td>
									<td>3</td>
									<td>최선웅</td>
									<td>프로젝트 제목 03</td>
									<td>
										<div class="graph-container">
											<div class="bar" data-percentage="80"></div>
											<div style="margin-top: 5px; margin-left:5px;">80%</div>
										</div>
									</td>
									<td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
								</tr>
								<tr class="project-choice">
									<td>01 Jan 2045</td>
									<td>4</td>
									<td>임성욱</td>
									<td>프로젝트 제목 04</td>
									<td>
										<div class="graph-container">
											<div class="bar" data-percentage="50"></div>
											<div style="margin-top: 5px; margin-left:5px;">50%</div>
										</div>
									</td>
									<td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
								</tr>
								<tr class="project-choice">
									<td>01 Jan 2045</td>
									<td>5</td>
									<td>고재현</td>
									<td>프로젝트 제목 05</td>
									<td>
										<div class="graph-container">
											<div class="bar" data-percentage="90"></div>
											<div style="margin-top: 5px; margin-left:5px;">90%</div>
										</div>
									</td>
									<td><a class="btn btn-sm btn-danger" href="">삭제</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<br>
				<!-- 페이징 처리 예정 -->
				<div class="btn-toolbar mb-3" role="toolbar"
					aria-label="Toolbar with button groups"
					style="display: flex; justify-content: center;">
					<div class="btn-group me-2" role="group" aria-label="First group">
						<button type="button" class="btn btn-secondary">prev</button>
						<button type="button" class="btn btn-outline-secondary">1</button>
						<button type="button" class="btn btn-outline-secondary">2</button>
						<button type="button" class="btn btn-outline-secondary">3</button>
						<button type="button" class="btn btn-outline-secondary">4</button>
						<button type="button" class="btn btn-secondary">next</button>
					</div>
				</div>
			</div>


			<div>

				<div id="project-update-window">
					<div class="modal-body">
						<!-- 프로젝트 이름 -->
						<div class="input-group mb-3">
							<span class="input-group-text" id="inputGroup-sizing-default">프로젝트
								이름</span> <input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default"
								value="${projectNo}">
						</div>
						<!-- 프로젝트 생성자 이름 -->
						<div class="input-group mb-3">
							<span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
							<input type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" value="홍길동"
								disabled>
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
								aria-describedby="inputGroup-sizing-default"
								placeholder="입력하세요.">
						</div>


						<br>
						<!--  최대 참여 인원(수)-->
						<div id="member-list" style="display: flex; flex-direction: row;">
							<div class="input-group mb-3">
								<span class="input-group-text" id="inputGroup-sizing-default">총인원</span>
								<input id="totalMember" type="text" class="form-control"
									aria-label="Sizing example input"
									aria-describedby="inputGroup-sizing-default" value="0" disabled>
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
							<button style="margin-bottom: 70px;" type="button"
								class="btn btn-secondary" id="projectUpdateCancle">취소</button>
								<button style="margin-bottom: 70px;" type="button"
								class="btn btn-primary" data-bs-toggle="modal"
								data-bs-target="#updateSelectModal">프로젝트 수정</button>
						</div>


						<!-- Modal -->
						<div class="modal fade" id="updateSelectModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">저장하시겠습니까?</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">취소</button>
										<button type="button" class="btn btn-primary">저장</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 사원 조회 생성 -->
					<div id="input-member"></div>
					<!-- 선택된 프로젝트 파일이 없습니다. 이미지 -->

				</div>
					<div id="noneProjectImg" style="margin-left:30px;">
						<img src="https://i.imgur.com/oGbyqGQ.png" width="600px" height="600px">
					</div>





			</div>
		</div>
	</div>
</section>
</div>
<script src="${path }/js/project/updateProject.js"></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>