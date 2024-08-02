<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="${path}/css/project/updateWorkDetail.css" rel="stylesheet" type="text/css">

<section>
<div id="work-first-wrap">
		<!-- 작업 조회시 업데이트 창 -->
		<div>
			<div id="work-update-title">작업 조회</div>
		</div>
		<div id="work-update-window">
			<div style="display: flex; flex-direction: row; justify-content: center; margin-top: 30px;">
				<div id="work-update-body">
				<input style="display:none;" type="text" name="workNo" value="${work.projectWorkNo }">
					<!-- 작업 이름 -->
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">작업
							이름</span> <input type="text" id="work-title" class="form-control" name="workTitle"
							aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
					</div>

					<!-- 작업 중요도 셀렉트  -->
					<div class="input-group mb-3">
						<span class="input-group-text" id="inputGroup-sizing-default">작업
							중요도</span> <select id="work-rank" class="form-select" aria-label="Default select example">
							<option selected>선택하세요.</option>
							<option value="1" style="color: red;">상</option>
							<option value="2" style="color: rgb(255, 132, 0);">중</option>
							<option value="3" style="color: green;">하</option>
						</select>
					</div>
					<!-- 작업 설명 -->
					<p style="font-weight: bolder;">작업 설명</p>
					<div class="form-floating">
						<textarea class="form-control" placeholder="Leave a comment here"
							id="floatingTextarea"></textarea>
						<label for="floatingTextarea">작업 설명</label> <span
							id="work-contents-count" style="margin-left: auto;">0/1000</span>
					</div>
					<!-- 작업 종료 예정일 -->
					<br>
					<div>
						<div class="input-group mb-3" style="display:flex; justify-content:center; justify-content: space-evenly;">
							<div style="width:60%">
					<!-- 작업 진행현황 -->
								<label for="customRange3" id="progressResult" class="form-label" style="font-weight: bolder;">진행 현황</label>
								<input type="range" id="work-progress" class="form-range" min="0" max="100" step="5" id="customRange3">
							</div>

							<div>
								<label for="date"  class="form-label" style="font-weight: bolder;">마감 날짜</label><br>
								<input type="date" id="work-end-date">
							</div>
						</div>
					</div>
					<br>
					<div>
						<p style="font-weight:bolder; font-size:20px;">작업 파일 다운로드</p>
					</div>

					<!-- 기존 파일 값 출력 -->
					<div id="fileListContainer">
						<c:if test="${work.projectAtt[0].attNo != ''}">
							<c:forEach items="${work.projectAtt }" var="att">
								<div class="fileListContainer">
									<a href="<c:out value="${path}/upload/projectWork/${att.attRename }"/>" download><c:out value="${att.attOriginalname }"/></a>
								</div>
							</c:forEach>
						</c:if>
					</div>
					<br>


					<!-- Modal -->
					<div class="modal fade" id="updateSelectModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">수정하시겠습니까?</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">취소</button>
									<button type="button" id="updateWorkBtn" class="btn btn-primary">수정</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
</div>
<script>
const path='${path}';
const empNo ="${work.employeeNo }";
 $(document).ready(function() {
	$("#work-title").val("${work.projectWorkTitle }");
	$('#work-rank').val("${work.projectWorkRank }");
	$('#floatingTextarea').text("${work.projectWorkContent }");
	$('#work-end-date').val("${work.projectWorkEndDate }");
	$('#work-progress').val(Number("${work.projectWorkProgress }"));
	$("#progressResult").text('진행 현황: ${work.projectWorkProgress }%');
	$('#work-progress').on('input', function() {
		$("#progressResult").text('진행 현황: ' + $(this).val() + '%');
	});
});
</script>
<script src='${path }/js/common/pagebar.js'></script>
<script src="${path }/js/project/projectListInfo.js"></script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>