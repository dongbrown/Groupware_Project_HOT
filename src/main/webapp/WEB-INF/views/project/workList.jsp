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
   <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
					  예산 사용 내역 추가
					</button>

					<!-- 예산 사용 내역 Modal -->
					<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="staticBackdropLabel">예산 사용 내역</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					       	<div class="input-group mb-3">
								<span class="input-group-text" id="inputGroup-sizing-default">사용처</span>
								<input type="text" id="work-title" class="form-control" name="budgetUse"
									aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
							</div>
							<div class="form-floating">
								<textarea class="form-control" placeholder="Leave a comment here"
									id="budgetTextarea"></textarea>
								<label for="budgetTextarea">사용 내역</label>
							</div>
							<br>
							<div class="input-group mb-3">
								<span class="input-group-text" id="inputGroup-sizing-default">사용 금액</span>
								<input type="text" id="project-budget" class="form-control"
									aria-label="Sizing example input"
									aria-describedby="inputGroup-sizing-default" placeholder="입력하세요.">
							</div>
							<div>
								<label for="date"  class="form-label" style="font-weight: bolder;">사용 날짜</label><br>
								<input type="date" id="budget-end-date">
							</div>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					        <button type="button" class="btn btn-primary">등록</button>
					      </div>
					    </div>
					  </div>
					</div>
</section>
</div>
<script>
const path="${path}"
</script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>