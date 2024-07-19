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
<link href="${path}/css/project/projectListAll.css" rel="stylesheet" type="text/css">
<link href="${path}/css/project/project.scss" rel="stylesheet" type="cscc">

<section>
	<div id="btnWrap">
		<a href="#" id="allProjectSearch" class="button">
	        <div class="main-txt">
	            <span>프</span>
	            <span>로</span>
	            <span>젝</span>
	            <span>트</span>
	            <span>&nbsp;</span>
	            <span>전</span>
	            <span>체</span>
	            <span>조</span>
	            <span>회</span>
	        </div>
    	</a>
	    <a href="#" id="joinProjectSearch" class="button reverse" style="background:rgb(0, 128, 192);">
	        <div class="main-txt">
	            <span>참</span>
	            <span>여</span>
	            <span>&nbsp;</span>
	            <span>프</span>
	            <span>로</span>
	            <span>젝</span>
	            <span>트</span>
	            <span>&nbsp;</span>
	            <span>조</span>
	            <span>회</span>
	        </div>
	    </a>
	    <a href="#" id="requestProjectSearch" class="button">
	        <div class="main-txt">
	            <span>요</span>
	            <span>청</span>
	            <span>한</span>
	            <span>&nbsp;</span>
	            <span>프</span>
	            <span>로</span>
	            <span>젝</span>
	            <span>트</span>
	        </div>
    	</a>
	    <a href="#" class="button reverse" style="background:rgb(0, 128, 192);">
	        <div class="main-txt">
	            <span>승</span>
	            <span>인</span>
	            <span>된</span>
	            <span>&nbsp;</span>
	            <span>프</span>
	            <span>로</span>
	            <span>젝</span>
	            <span>트</span>
	        </div>
	    </a>
	    <a href="#" id="allProjectSearch" class="button">
	        <div class="main-txt">
	            <span>프</span>
	            <span>로</span>
	            <span>젝</span>
	            <span>트</span>
	            <span>&nbsp;</span>
	            <span>요</span>
	            <span>청</span>
	        </div>
    	</a>
	</div>
		<div style="height:auto; min-height:600px; margin:0 100px;">
			<div class="conteudo__geral">
				<!-- 프로젝트 목록 div -->
				<div class="conteudo__cartoes-grid">

				</div>
			</div>
		</div>
		<div class="pagebar-div">페이지 바</div>

		<!-- Modal -->
			<div class="modal fade" id="joinModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="exampleModalLabel">참여 요청</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        해당 프로젝트에 참여 요청 하시겠습니까?
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			        <button type="button" id="projectRequestBtn" class="btn btn-primary">요청</button>
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
<script src="${path }/js/project/projectListAll.js"></script>
<script src='${path }/js/common/pagebar.js'></script>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>