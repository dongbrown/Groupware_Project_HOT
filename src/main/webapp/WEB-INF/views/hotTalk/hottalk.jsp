<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:import url="${path }/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="${path }/WEB-INF/views/common/header.jsp"/>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
<link href="${path }/css/hotTalk/hottalk.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<h4 class="page-title"> &nbsp; &nbsp; HotTalk</h4>
<section>
	<div class="chat-container">
        <div class="chat-sidebar">
            <div class="user-profile">
                <img src="https://cdn.eroun.net/news/photo/202305/32650_59862_4410.jpg" alt="아이유" class="user-avatar IUimg">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				    <i class="fas fa-cog"></i>
			 	</a>
                <h2 class="user-name">아이유</h2>
                <p class="user-profile">집에 가고싶어요</p>
              	<div class="dropdown">
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="#">상태 변경</a></li>
				    <li><a class="dropdown-item" href="#">프로필 변경</a></li>
				  </ul>
				</div>
            </div>
            <div class="search-bar">
                <input class="search-input" type="text" placeholder="Search...">
                <i class="fas fa-search fa-sm search-icon"></i>
            </div>
            <div class="chat-nav">
                <button id="chat-option1">HOT사원</button>
                <button id="chat-option2">개인핫톡</button>
                <button id="chat-option3">그룹핫톡</button>
            </div>
            <h4 id="chat-option">HOT 사원</h4>

        </div>
        <div class="chat-main ">
            <div class="chat-header">
                <img src="https://cdn.eroun.net/news/photo/202305/32650_59862_4410.jpg" alt="아이유" class="user-avatar IUimg">
                <div>
                    <h2>아이유</h2>
                    <p>Online</p>
                </div>
                <div class="chat-actions">
                	<input type="text" placeholder="Search..." class="search-input">
                </div>
                <i class="fas fa-search fa-sm"></i>
            </div>
            <div class="chat-messages">
                <!-- 채팅 메세지 출력 -->
            </div>

            <div class="chat-input">
                <input type="text" id="msg" placeholder="Enter Message...">
                <div class="file-upload">
	                <label for="file-input" class="file-upload-btn">
	                    <span class="plus-icon">+</span>
	                </label>
	                <input id="file-input" type="file" style="display: none;">
	                <span id="file-name"></span>
	            </div>
                <button class="send-btn">전송</button>
            </div>
        </div>
    </div>


</section>
</div>
<c:import url="${path }/WEB-INF/views/common/footer.jsp"/>
<script>
	const path = "${pageContext.request.contextPath}";
	const loginEmployeeName = '${loginEmployee.employeeName}';
</script>
<script type="text/javascript" src="${path }/js/hotTalk/hottalk.js"></script>
