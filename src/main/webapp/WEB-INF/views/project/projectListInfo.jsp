<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<!-- 프로젝트 조회시 업데이트 창 -->
		<div>
			<div id="project-update-title">프로젝트 조회</div>
		</div>
		<div id="project-update-window">
			<div style="display: flex; flex-direction: row; justify-content: center; margin-top: 30px;">
				<div id="project-update-body">
				<input style="display:none;" type="text" name="projectNo" value="${project.projectNo }">
				<input style="display:none;" type="text" name="employeeNo" value="${project.employeeNo }">
					<!-- 프로젝트 이름 -->
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">프로젝트
							이름</span> <input type="text" id="project-title" class="form-control" name="projectTitle"
							aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
					</div>
					<!-- 프로젝트 생성자 이름 -->
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
						<input type="text" id="project-emp" class="form-control"
							aria-label="Sizing example input" value="${project.employeeCode.employeeName }"
							aria-describedby="inputGroup-sizing-default" disabled>
					</div>
					<!-- 프로젝트 중요도 셀렉트  -->
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">프로젝트
							중요도</span> <select id="project-rank" class="form-select"
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
						<label for="floatingTextarea">프로젝트 설명</label> <span
							id="project-contents-count" style="margin-left: auto;">0/1000</span>
					</div>
					<!-- 프로젝트 종료 예정일 -->
					<br>
					<div>
						<div class="input-group mb-3" style="display:flex; justify-content:center; justify-content: space-evenly;">
							<div style="width:60%">
					<!-- 프로젝트 진행현황 -->
								<label for="customRange3" id="progressResult" class="form-label" style="font-weight: bolder;">진행 현황</label>
								<input type="range" id="project-progress" class="form-range" min="0" max="100" step="5" id="customRange3">
							</div>

							<div>
								<label for="date"  class="form-label" style="font-weight: bolder;">마감 날짜</label><br>
								<input type="date" id="project-end-date">
							</div>
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
							<span class="input-group-text" id="inputGroup-sizing-default">총인원</span>
							<input id="totalMember" type="text" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default" value="0" disabled>
						</div>
					</div>
				</div>

				<!-- 기존 사원 불러오기 -->
					<div style="margin-left:30px; display:flex; flex-direction:column;">
					<h4 style="font-weight:bolder; margin-left:10px;">참여 사원 리스트</h4>
						<c:if test="${not empty emps }">
							<c:forEach var="emps" items="${emps}">
								<div id="checked-member-wrab" class="saved-item">${emps.employee.departmentCode.departmentTitle}: ${emps.employee.employeeName} 사번 / ${emps.employee.employeeNo}</div>
							</c:forEach>
						</c:if>
					<c:if
						test="${project.employeeCode.employeeNo == loginEmployee.employeeNo}">
						<button type="button" id="selectWorkList" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#exampleModal"
							style="margin-top: 20px;">프로젝트-작업 보기</button>

						<!-- 해당 프로젝트 - 작업들 조회 모달창 -->
						<div class="modal fade" id="exampleModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5" id="exampleModalLabel">${project.projectTitle }
											- 작업 리스트</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div id="projectInfoWorkList" class="modal-body">
										<!-- 작업 목록 출력 -->
										<div id="work-first-wrap">
											<div id="work-update-main">
												<div id="work-list">
													<p id="work-list-title"
														style="font-weight: bolder; font-size: 20px;">작업
														목록</p>

													<div id="workListTable" class="table-responsive">
														<div>
															<div style="height: auto; width: auto;">
																<table id="work-list-table"
																	class="table text-start align-middle table-bordered table-hover mb-0"
																	style="text-align: center;">
																	<thead>
																		<tr class="text-dark">
																			<th scope="col">날짜</th>
																			<th scope="col">번호</th>
																			<th scope="col">작업 제목</th>
																			<th scope="col" style="width: 300px;">진행률</th>
																		</tr>
																	</thead>
																	<tbody>
																	</tbody>
																</table>
															</div>
														</div>
													</div>
													<br>
													<!-- 페이지 바 -->
													<div class="pagebar-div" style="display:flex; justify-content:center;"></div>
												</div>
												<div></div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
					</c:if>
				</div>

			</div>
		</div>
	</div>
</section>
</div>
<script>
const path='${path}';
const empNo ="${project.employeeCode.employeeNo }";
const projectNo = "${project.projectNo }";
$(document).ready(function() {
	$("#project-title").val("${project.projectTitle }");
	$('#project-rank').val("${project.projectRank }");
	$('#floatingTextarea').text("${project.projectContent }");
	$('#project-budget').val("${project.projectBudget }");
	$('#project-end-date').val("${project.projectEndDate }");
	$('#project-progress').val(Number("${project.projectProgress }"));
	$("#progressResult").text('진행 현황: ${project.projectProgress }%');
	$('#project-progress').on('input', function() {
	$("#progressResult").text('진행 현황: ' + $(this).val() + '%');
	});
});
</script>
<script src='${path }/js/common/pagebar.js'></script>
<script src="${path }/js/project/projectListInfo.js"></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>