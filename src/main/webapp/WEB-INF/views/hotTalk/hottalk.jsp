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
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>

<h4 class="page-title"> &nbsp; &nbsp; HotTalk</h4>
<section>
	<div class="chat-container">
        <div class="chat-sidebar">
            <div class="user-profile">
                <img src="https://cdn.eroun.net/news/photo/202305/32650_59862_4410.jpg" alt="아이유" class="user-avatar IUimg">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
				    <i class="fas fa-cog"></i>
			 	</a>
                <h3 class="user-name">${loginEmployee.employeeName}</h3>
                <sup class="user-profile my-status"></sup>
                <p class="my-status-message"></p>
              	<div class="dropdown">
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="#">상태 변경</a></li>
				    <li><a class="dropdown-item" href="#">상태메세지 변경</a></li>
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
			<div id="option-result">

			</div>
        </div>
        <div class="chat-main ">
            <div class="chat-header">
                <img src="https://cdn.eroun.net/news/photo/202305/32650_59862_4410.jpg" alt="아이유" class="user-avatar target-avatar IUimg">
                <div style="width: 1000px; margin-left:10px">
                    <h3 class="chat-user-name">${loginEmployee.employeeName}</h3>
                    <sup class="user-status"></sup>
                    <p class="user-status-message"></p>
                </div>
                <div class="make-group-talk">
	                <label for="make-group-btn" class="make-group-btn">
	                    <span class="plus-icon">그룹핫톡 생성</span>
	                </label>
	                <!-- Button trigger modal -->
					<button id="make-group-btn" style="display: none;" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop"></button>

					<!-- Modal -->
					<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="staticBackdropLabel">HotTalk Group 채팅 생성하기</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body" style="display: flex; justify-content: space-around;">
							<div>
								<div>
									<div class="search-bar">
						                <input class="search-input modal-search" type="text" placeholder="사원명으로 검색하기">
						                <i class="fas fa-search fa-sm search-icon"></i>
						            </div>
								</div>
								<div class="modal-employee-result" style="overflow: hidden;"></div>
							</div>
							<div style="display:flex; flex-direction: column; justify-content: space-evenly; font-size: 25px;">
								<div class="moveRight" style="border-radius: 100%; background-color: #6c757d; color: white; width: 40px; height: 40px; text-align: center;">
									<b style="cursor: pointer;">→</b>
								</div>
								<div class="moveLeft" style="border-radius: 100%; background-color: #6c757d; color: white; width: 40px; height: 40px; text-align: center;">
									<b style="cursor: pointer;">←</b>
								</div>
							</div>
							<div>
								<input class="search-input modal-title" type="text" placeholder="채팅방 제목을 입력하세요.">
								<div class="modal-additional-employee" style="width: 239px; margin-top: 10px;">

								</div>
							</div>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">CANCEL</button>
					        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">CREATE</button>
					      </div>
					    </div>
					  </div>
					</div>
	            </div>
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
	const loginEmployee = '${loginEmployee}';
	const loginEmployeeNo= '${loginEmployee.employeeNo}'
	const loginEmployeeName = '${loginEmployee.employeeName}';
</script>
<script type="text/javascript" src="${path }/js/hotTalk/hottalk.js"></script>
