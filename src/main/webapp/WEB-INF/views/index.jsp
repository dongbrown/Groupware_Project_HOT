<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8"></html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<c:import url="/WEB-INF/views/common/header.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="${path}/css/common/index.css" rel="stylesheet" type="text/css">
<section>
	 <!-- 메인 컨텐트 제작 -->
        <div id="main-wrap">
            <!-- 첫번째 줄 wrap (사원정보, 메일, 전자결재 확인 등) -->
             <div id="first-wrap">
                <div class="card__giratorio">
                    <div class="card__giratorio-conteudo">
                        <div class="card__giratorio-conteudo--frente">
                            <div class="changeBtn"><img src="https://i.imgur.com/tTdzHN7.png" width="25px"></div>
                        <div id="member-card-profile" style="background-image:url(${path }/upload/employee/${loginEmployee.employeePhoto })"></div>
                        <h4 style="margin-top: 30px; font-weight: bolder; color:white;"><c:out value="${loginEmployee.employeeName}" />  </h3>
                        <a style="color:white;"><c:out value="${loginEmployee.departmentCode.departmentTitle}" /></a>
                        <div id="member-card-mail">
                            <div><a href="${path }/employee/profile"><img src="https://i.imgur.com/LIHIxyI.png" width="40px" style="margin-bottom: 3px;"></a></div>
                            <div><a href=""><img src="https://i.imgur.com/JjYn69Q.png" width="40px"></a></div>
                        </div>
                        </div>
                        <div class="card__giratorio-conteudo--traseira">
                            <div class="changeBtn"><img src="https://i.imgur.com/tTdzHN7.png" width="25px"></div>
                            <div style="display:flex;">
                            	<button class="btn btn-primary btn-go-work" onclick="goWork()">출근</button>
                            	<button class="btn btn-warning btn-leave-work" onclick="leaveWork()">퇴근</button>
                            </div>
                        </div>
                    </div>
                    </div>

                <div id="mail-card">
                <div class="moreSmallBtn"><a href="#" style="">more+</a></div>
                <p style="font-weight:bolder; font-size:17px; margin:10px;color:#4E73DF;">신규 커뮤니티 목록</p>
                	<div>
						<table class="table table-hover table-striped" >
						  <thead>
						    <tr>
						      <th scope="col">no</th>
						      <th scope="col">커뮤니티</th>
						    </tr>
						  </thead>
						  <tbody id="comuList" class="table-group-divider">
						  </tbody>
						</table>
					</div>
				</div>
             </div>
             <!-- 두번째 줄 wrap (게시판, 프로젝트/작업현황, 회의안건) -->
             <div id="second-wrap">
                <div id="board-card">
					<div id="approvalIcon">
						<div>
							<img alt="" src="https://i.imgur.com/fAPILB4.png">
							<div class="approvalCount"></div>
						</div>
						<div>
							<img alt="" src="https://i.imgur.com/vzoUDYF.png">
							<div class="approvalCount"></div>
						</div>
						<div>
							<img alt="" src="https://i.imgur.com/MsGYwVk.png">
							<div class="approvalCount"></div>
						</div>
						<div>
							<img alt="" src="https://i.imgur.com/qnqBhzw.png">
							<div class="approvalCount"></div>
						</div>
					</div>
					<div id="mainAprrovalTable">
					<div class="moreBtn"><a href="#" style="">more+</a></div>
						<p style="font-weight:bolder; font-size:20px; margin:10px; text-align:center; color:#4E73DF;">최근 결재 문서</p>
	                	<div>
							<table class="table table-hover table-striped" >
							  <thead>
							    <tr>
							      <th scope="col">결재번호</th>
							      <th scope="col">종류</th>
							      <th scope="col">제목</th>
							    </tr>
							  </thead>
							  <tbody class="table-group-divider">
							  </tbody>
							</table>
						</div>
					</div>
                </div>
                <div id="project-card">

                    <div id="projectBox">
                    <p style="font-weight:bolder; font-size:20px; margin:10px;color:#4E73DF;">프로젝트현황</p>
                    <div class="moreProjectBtn"><a href="#" style="">more+</a></div>
					        <div class="donut-chart" data-percent="50">
					            <svg width="100%" height="100%" viewBox="0 0 42 42">
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#e6e6e6" stroke-width="3"></circle>
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#3498db" stroke-width="3" stroke-dasharray="100" stroke-dashoffset="100" class="donut"></circle>
					                <div id="projectChart1" style="text-align:center;">프로젝트 1</div>
					                <div id="projectChartEmp1" style="text-align:center;">담당자 : 이홍보</div>
					            </svg>
					            <div class="percent">0%</div>
					        </div>
					        <div class="donut-chart" data-percent="30">
					            <svg width="100%" height="100%" viewBox="0 0 42 42">
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#e6e6e6" stroke-width="3"></circle>
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#2980b9" stroke-width="3" stroke-dasharray="100" stroke-dashoffset="100" class="donut"></circle>
					                <div id="projectChart2" style="text-align:center;">프로젝트 1</div>
					                <div id="projectChartEmp2" style="text-align:center;">담당자 : 이홍보</div>
					            </svg>
					            <div class="percent">0%</div>
					        </div>
					        <div class="donut-chart" data-percent="70">
					            <svg width="100%" height="100%" viewBox="0 0 42 42">
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#e6e6e6" stroke-width="3"></circle>
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#1abc9c" stroke-width="3" stroke-dasharray="100" stroke-dashoffset="100" class="donut"></circle>
					                <div id="projectChart3" style="text-align:center;">프로젝트 1</div>
					                <div id="projectChartEmp3" style="text-align:center;">담당자 : 이홍보</div>
					            </svg>
					            <div class="percent">0%</div>
					        </div>
                    </div>
                    <div id="projectBox">
						<p style="font-weight:bolder; font-size:20px; margin:10px;color:#4E73DF;">작업현황</p>
						<div class="moreProjectBtn"><a href="#" style="">more+</a></div>
					        <div class="donut-chart" data-percent="90">
					            <svg width="100%" height="100%" viewBox="0 0 42 42">
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#e6e6e6" stroke-width="3"></circle>
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#3498db" stroke-width="3" stroke-dasharray="100" stroke-dashoffset="100" class="donut"></circle>
					                <div id="workChart1" style="text-align:center;">작업 1</div>
					            </svg>
					            <div class="percent">0%</div>
					        </div>
					        <div class="donut-chart" data-percent="30">
					            <svg width="100%" height="100%" viewBox="0 0 42 42">
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#e6e6e6" stroke-width="3"></circle>
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#2980b9" stroke-width="3" stroke-dasharray="100" stroke-dashoffset="100" class="donut"></circle>
					                <div id="workChart2" style="text-align:center;">작업 1</div>
					            </svg>
					            <div class="percent">0%</div>

					        </div>
					        <div class="donut-chart" data-percent="50">
					            <svg width="100%" height="100%" viewBox="0 0 42 42">
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#e6e6e6" stroke-width="3"></circle>
					                <circle cx="21" cy="21" r="15.91549430918954" fill="transparent" stroke="#1abc9c" stroke-width="3" stroke-dasharray="100" stroke-dashoffset="100" class="donut"></circle>
					                <div id="workChart3" style="text-align:center;">작업 1</div>
					            </svg>
					            <div class="percent">0%</div>
					        </div>
					</div>
                </div>
				<div id="agenda-card">
					<div class="moreBtn">
					    <a href="${path}/email/inbox?page=1" id="moreMailBtn" style="">more+</a>
					</div>
					<p style="font-weight:bolder; font-size:20px; margin:10px; text-align:center; color:#4E73DF;">최근 메일함</p>
				    <table class="table table-hover">
				        <thead>
				            <tr>
				                <th scope="col" style="width: 10%;">no</th>
				                <th scope="col" style="width: 20%;">발신자</th>
				                <th scope="col" style="width: 70%;">제목</th>
				            </tr>
				        </thead>
				        <tbody id="mainMailList">
				        </tbody>
				    </table>
				</div>
             </div>
            <!-- 세번째 줄 wrap (켈린더, 오늘의 일정, 홍보배너, 회사점심식단표) -->
             <div id="third-wrap">
                <div id="calender-card">
					<div id="calendar">
				        <div id="calendar-header">
				            <button id="prev-month" class="month-nav"><i class="fas fa-chevron-left"></i></button>
				            <h2 id="current-month"></h2>
				            <button id="next-month" class="month-nav"><i class="fas fa-chevron-right"></i></button>
				        </div>
				        <div id="weekdays"></div>
				        <div id="calendar-body"></div>
				    </div>
				</div>
                <div id="today-work-card">
                	<div style="margin:10px;">
                		<p style="font-weight:bolder; font-size:20px; margin:10px; text-align:center; color:white;">오늘의 일정</p>
                		<div id="todolist">
                			<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							  <label class="form-check-label" for="flexCheckDefault">
							    09:00 - 11:00 팀 프로젝트 작업 진행
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault2">
							  <label class="form-check-label" for="flexCheckDefault2">
							    13:00 - 15:00 클라이언트 미팅 & 프로토타입 시연
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault3">
							  <label class="form-check-label" for="flexCheckDefault3">
							    총 프로젝트 진행 상황 팀장 보고
							  </label>
							</div>
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault4">
							  <label class="form-check-label" for="flexCheckDefault4">
							    해외 출장 관련 보고서 제출
							  </label>
							</div>
                		</div>
                	</div>
                </div>
                <div id="banner-card">
               <div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
				  <div class="carousel-inner">
				    <div class="carousel-item active">
				      <img src="https://images.unsplash.com/photo-1716719125964-82d18b8fd1f7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="d-block w-100" alt="...">
				    </div>
				    <div class="carousel-item">
				      <img src="https://images.unsplash.com/photo-1711967151343-9e2f55d6146a?q=80&w=2520&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="d-block w-100" alt="...">
				    </div>
				    <div class="carousel-item">
				      <img src="https://images.unsplash.com/photo-1711967150571-c370e850e637?q=80&w=2556&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" class="d-block w-100" alt="...">
				    </div>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div>
                </div>
                <div id="menu-card">
                 	<p style="font-weight:bolder; font-size:20px; margin:15px; text-align:center; color:#4E73DF;">이번주 식단표</p>
                 	<div>
					<table id="menu-table" class="table table-striped-columns table-borderless">
					  <thead >
					    <tr>
					      <th scope="col">Mon</th>
					      <th scope="col">Tue</th>
					      <th scope="col">Wed</th>
					      <th scope="col">Thu</th>
					      <th scope="col">Fri</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td>참치김치국</td>
					      <td>새우까스</td>
					      <td>숙주나물무침</td>
					      <td>오징어젓갈</td>
					      <td>배추김치</td>
					    </tr>
					    <tr>
					      <td>청국장찌개</td>
					      <td>간장돈불고기</td>
					      <td>새송이버섯조림</td>
					      <td>열무나물무침</td>
					      <td>깍두기</td>
					    </tr>
					    <tr>
					      <td>유부장국</td>
					      <td>카레라이스</td>
					      <td>비엔나야채볶음</td>
					      <td>마늘쫑건새우조림</td>
					      <td>배추김치</td>
					    </tr>
					    <tr>
					      <td>오이미역냉국</td>
					      <td>닭볶음탕</td>
					      <td>두부양념조림</td>
					      <td>단배추나물</td>
					      <td>배추김치</td>
					    </tr>
					    <tr>
					      <td>소고기콩나물국</td>
					      <td>고기산적떡조림</td>
					      <td>천사채샐러드</td>
					      <td>브로콜리초무침</td>
					      <td>깍두기</td>
					    </tr>
					  </tbody>
					</table>
					</div>
				</div>
             </div>


        </div>
</section>
</div>

<script src="${path }/email/email-common.js"></script>
<script>
	const path='${path}';
	const no=${loginEmployee.employeeNo};
    $(document).ready(function() {
        $('#moreMailBtn').click(function(e) {
            e.preventDefault();
            window.location.href = '${path}/email/inbox';
        });
    });
</script>
<script src="${path }/js/index.js"></script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>