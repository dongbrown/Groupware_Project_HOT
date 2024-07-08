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
<link href="${path}/css/project/insertWork.css" rel="stylesheet" type="text/css">

<section>
   <div id="work-first-wrap">
		<div >
			<div id="work-update-title">작업생성할 프로젝트 선택</div>
		</div>

		<div id="work-update-main">
			<div id="work-list">
				<p id="work-list-title" style="font-weight: bolder; font-size: 20px; margin-top:80px;">프로젝트 목록</p>

				<div id="workListTable" class="table-responsive">
					<div>

						<table id="work-list-table" class="table text-start align-middle table-bordered table-hover mb-0"
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

							</tbody>
						</table>
					</div>
				</div>
				<br>
				<!-- 페이징 처리 예정 -->
				<div class="pagebar-div"></div>
			</div>


			<div>

					<!-- 선택된 프로젝트 파일이 없습니다. 이미지 -->
					<div id="noneworkImg" style="margin-left:30px;">
						<img src="https://i.imgur.com/oGbyqGQ.png" width="500px" height="500px">
					</div>





			</div>
		</div>
	</div>
</section>
</div>
<script>
	const path="${path}"
	const empNo ="${loginEmployee.employeeNo }";
</script>
<script src="${path }/js/project/insertWork.js"></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>