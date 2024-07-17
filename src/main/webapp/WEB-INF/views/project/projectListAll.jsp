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
  <section>
  <div class="conteudo__geral">
  		<div>
			<div id="project-insert-title">프로젝트 작업 생성</div>
		</div>
        <div class="conteudo__cartoes-grid">
            <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름</h3>
                </div>
            </a>

              <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름</h3>
                </div>
            </a>

              <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름</h3>
                </div>
            </a>

              <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름</h3>
                </div>
            </a>

              <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름</h3>
                </div>
            </a>

              <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름</h3>
                </div>
            </a>

              <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름</h3>
                </div>
            </a>

              <a class="elemento__cartao" href="#">
                <!-- utilizar background-image direto no css é uma boa prática -->
                <div class="elemento__cartao--fundo"
                    style="background-image: url(https://images.unsplash.com/photo-1604147706283-d7119b5b822c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)">
                </div>
                <div class="elemento__cartao--conteudo">
                    <p class="elemento__cartao--texto-categoria">프로젝트 번호</p>
                    <h3 class="elemento__cartao--texto-titulo">프로젝트 이름프로젝트 이름프로젝트 이름</h3>
                </div>
            </a>



            </div>
    </section>
</div>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>