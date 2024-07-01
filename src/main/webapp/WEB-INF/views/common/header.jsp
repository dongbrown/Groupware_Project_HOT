<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!DOCTYPE html>
<html>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
	<c:import url="${path}/css/common/header.css"/>
</style>

<head>
<meta charset="EUC-KR">
<title>H.O.T 그룹웨어</title>
</head>
<!-- 프로젝트 생성 모달 창 -->
    <!-- create Modal -->
    <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
    <div id="modal-size" class="modal-dialog">
    <div class="modal-content">
    <div class="modal-header">
        <h1 class="modal-title fs-5" id="createModalLabel">프로젝트 생성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
    <div style="display: flex; flex-direction: row;">
    <div class="modal-body">
    </div>
        <!-- 프로젝트 이름 -->
     <div class="input-group mb-3">
            <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 이름</span>
            <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
     </div>
            <!-- 프로젝트 생성자 이름 -->
     <div class="input-group mb-3">
	        <span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
	        <input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="홍길동" disabled>
     </div>
            <!-- 프로젝트 중요도 체크박스  -->
     <div class="input-group mb-3">
	      <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 중요도</span>
	      <select class="form-select" aria-label="Default select example">
	          <option selected>선택하세요.</option>
	          <option value="1" style="color: red;">상</option>
	          <option value="2" style="color: rgb(255, 132, 0);">중</option>
	          <option value="3" style="color: green;">하</option>
	        </select>
	</div>
     <!-- 프로젝트 설명 -->
     <p style="font-weight: bolder;">프로젝트 설명</p>
     <div id="project-contents" class="form-floating">
     <textarea id="floatingTextarea-project" class="form-control" placeholder="Leave a comment here" id="floatingTextarea"></textarea>
     <label for="floatingTextarea">프로젝트 설명</label>
     <span id="project-contents-count" style="margin-left: auto;">0/1000</span>
     </div>

     <!-- 프로젝트 종료 예정일 -->
     <br>
	 <div>
	     <div class="input-group mb-3">
	         <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 종료일</span>
	         <select id="year" class="form-select" aria-label="Year" required>
	             <option value="" selected>년</option>
	               <!-- 연도 옵션 추가  올해와 내년만 출력되게 설정-->

	         </select>
	         <select id="month" class="form-select" aria-label="Month" required>
	             <option value="" selected>월</option>
	             <!-- 월 옵션 추가 -->

	         </select>
	         <select id="day" class="form-select" aria-label="Day" required>
	             <option value="" selected>일</option>
	             <!-- 일 옵션 추가 -->

	         </select>
	     </div>
	 </div>
	 <br>
    <!-- 프로젝트 배정 예산 -->
    <div class="input-group mb-3">
        <span class="input-group-text" id="inputGroup-sizing-default">배정예산</span>
        <input type="text" id="project-budget" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" placeholder="입력하세요.">
    </div>

	<br>
    <!--  최대 참여 인원(수)-->
    <div id="member-list" style="display: flex; flex-direction: row;">
                <div class="input-group mb-3">
                    <span class="input-group-text" id="inputGroup-sizing-default">총 인원</span>
                    <input id="totalMember" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" value="1" disabled>
                    </div>

                <div class="input-group mb-3" style="margin-left: 20px;">
                    <span class="input-group-text" id="inputGroup-sizing-default">부서</span>
                    <select id="select-dept" class="form-select" aria-label="Default select example">
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
            <div id="saved-members"></div>

        </div>
                <!-- 사원 조회 생성 -->
        <div id="input-member"></div>
    </div>

     <div class="modal-footer">
             <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
             <button type="button" class="btn btn-primary">프로젝트 생성</button>
             </div>
         </div>
         </div>
     </div>
     <!-- ------------------ -->

     <!-- 프로젝트 수정 모달 창 -->
            <!-- Modal -->
    <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
        <div id="modal-size" class="modal-dialog modal-lg">
            <div class="modal-content align-items-center justify-content-center">

                    <p style="font-weight: bolder; font-size: 20px; margin-top: 20px;">프로젝트 목록</p>

                <div id="projectListTable" class="table-responsive">
                    <div>

                        <table class="table text-start align-middle table-bordered table-hover mb-0"  style="text-align: center;">
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
                                    <td>1</td>
                                    <td>김동훈</td>
                                    <td>프로젝트 제목 01</td>
                                    <td>
                                        <div class="graph-container">
                                            <div class="bar" data-percentage="55"></div>
                                            <div style="margin-top: 5px;"> 55%</div>
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
                                            <div style="margin-top: 5px;"> 30%</div>
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
                                            <div style="margin-top: 5px;"> 80%</div>
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
                                            <div style="margin-top: 5px;"> 50%</div>
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
                                            <div style="margin-top: 5px;">90%</div>
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
                    <div class="btn-toolbar mb-3" role="toolbar" aria-label="Toolbar with button groups" style="display: flex; justify-content: center;">
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
        </div>
    </div>
	<!-- ------------------------------------------------------------------------------- -->




	<!-- 프로젝트 -- 작업 생성 모달 창 -->
    <!-- create Modal -->
    <div class="modal fade" id="createWorkModal" tabindex="-1" aria-labelledby="createWorkModalLabel" aria-hidden="true">
        <div id="modal-size" class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="createWorkModalLabel">작업 생성</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div style="display: flex; flex-direction: row;">
                    <div class="modal-body">
                        <!-- 프로젝트 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 이름</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default" disabled>
                        </div>
                        <!-- 프로젝트 생성자 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">프로젝트 담당자</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default" value="홍길동" disabled>
                        </div>
                        <hr style="border: 1.5px solid rgb(9, 9, 87);">
                        <!-- 작업 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">작업 이름</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default">
                        </div>
                        <!-- 작업 생성자 이름 -->
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="inputGroup-sizing-default">작업 담당자</span>
                            <input type="text" class="form-control" aria-label="Sizing example input"
                                aria-describedby="inputGroup-sizing-default" value="김명준" disabled>
                        </div>

                        <!-- 작업 설명 -->
                        <p style="font-weight: bolder;">작업 설명</p>
                        <div id="work-contents" class="form-floating">
                            <textarea class="form-control" placeholder="Leave a comment here"
                                id="floatingTextarea-work"></textarea>
                            <label for="floatingTextarea">작업 설명</label>
                            <span id="work-contents-count" style="margin-left: auto;">0/1000</span>
                        </div>


                        <!-- 작업 종료 예정일 -->
                        <br>
                        <div>
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="inputGroup-sizing-default">작업 종료일</span>
                                <select id="year" class="form-select" aria-label="Year" required>
                                    <option value="" selected>년</option>
                                    <!-- 연도 옵션 추가 올해와 내년만 출력되게 설정-->

                                </select>
                                <select id="month" class="form-select" aria-label="Month" required>
                                    <option value="" selected>월</option>
                                    <!-- 월 옵션 추가 -->

                                </select>
                                <select id="day" class="form-select" aria-label="Day" required>
                                    <option value="" selected>일</option>
                                    <!-- 일 옵션 추가 -->

                                </select>
                            </div>
                        </div>
                        <br>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary">프로젝트 생성</button>
                </div>
            </div>
        </div>
    </div>
<header>
    <!-- 메인 카테고리 -->
    <div id="sideHeader1" class="sideHeader">
        <div id="sideHeader-sub">
            <!-- 메인 == 메일 카테고리 -->
            <div id="mail-category" class="headerContent"><a href=""><img src="https://i.imgur.com/c0Ze4Y2.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="mailWrap" class="sideHeader-sub">
                        <table id="mailContent" class="table table-dark table-hover">
                            <tr><th style="white-space: nowrap;">메일 보내기</th></tr>
                            <tr><th>수신 메일함</th></tr>
                            <tr><th>발신 메일함</th></tr>
                            <tr><th>메일 보관함</th></tr>
                            <tr><th>휴지통</th></tr>
                        </table>
                </div>
            <!-- 메인 == 프로젝트 카테고리 -->
                <div id="project-category" class="headerContent"><a href=""><img src="https://i.imgur.com/8yHARRe.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="projectWrap" class="sideHeader-sub">
                    <table id="projectContent" class="table table-dark table-hover">
                        <tr><th>전체 프로젝트 조회</th></tr>
                        <tr><th id="createProject" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#createModal">프로젝트 생성</th></tr>
                        <tr><th id="updateProject" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#updateModal">프로젝트 수정</th></tr>
                        <tr><th id="createProjectWork" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#createWorkModal">프로젝트-작업 수정</th></tr>
                        <tr><th id="updateProjectWork" style="cursor: pointer;"data-bs-toggle="modal" data-bs-target="#updateProjectWork">프로젝트-작업 삭제</th></tr>
                    </table>


            </div>
            <!-- 메인 == 전자결재 카테고리 -->
                <div id="approval-category" class="headerContent"><a href=""><img src="https://i.imgur.com/Nn5TmVd.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="approvalWrap" class="sideHeader-sub">
                    <table id="approvalContent" class="table table-dark table-hover">
                        <tr><th>전자결재 메뉴1</th></tr>
                        <tr><th>전자결재 메뉴2</th></tr>
                        <tr><th>전자결재 메뉴3</th></tr>
                        <tr><th>전자결재 메뉴4</th></tr>
                        <tr><th>전자결재 메뉴5</th></tr>
                        <tr><th>전자결재 메뉴6</th></tr>
                        <tr><th>전자결재 메뉴7</th></tr>
                        <tr><th>전자결재 메뉴8</th></tr>
                    </table>
                </div>
            <!-- 메인 == 켈린더 카테고리 -->
            <div id="calender-category" class="headerContent"><a href=""><img src="https://i.imgur.com/8yHARRe.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
            <div id="calenderWrap" class="sideHeader-sub">
                <table id="calenderContent" class="table table-dark table-hover">
                    <tr><th>켈린더 메뉴1</th></tr>
                    <tr><th>켈린더 메뉴2</th></tr>
                    <tr><th>켈린더 메뉴3</th></tr>
                    <tr><th>켈린더 메뉴4</th></tr>
                    <tr><th>켈린더 메뉴5</th></tr>
                </table>
            </div>

            <!-- 메인 == 커뮤니티 카테고리 -->
            <div id="community-category" class="headerContent"><a href=""><img src="https://i.imgur.com/c0Ze4Y2.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
            <div id="communityWrap" class="sideHeader-sub">
                <table id="communityContent" class="table table-dark table-hover">
                    <tr><th>커뮤니티 메뉴1</th></tr>
                    <tr><th>커뮤니티 메뉴2</th></tr>
                    <tr><th>커뮤니티 메뉴3</th></tr>
                    <tr><th>커뮤니티 메뉴4</th></tr>
                    <tr><th>커뮤니티 메뉴5</th></tr>
                </table>
            </div>

            <!-- 메인 == 채팅 카테고리 -->
            <div id="chat-category" class="headerContent"><a href=""><img src="https://i.imgur.com/Nn5TmVd.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
            <div id="chatWrap" class="sideHeader-sub">
                <table id="chatContent" class="table table-dark table-hover" style="cursor: pointer;">
                    <tr><th>HOT사원</th></tr>
                    <tr><th id="hottalk-list">핫톡목록</th></tr>
                    <tr><th>환경생활</th></tr>
                </table>
            </div>

                <!-- 메인 == 인사 카테고리 -->
                <div id="insa-category" class="headerContent"><a href=""><img src="https://i.imgur.com/8yHARRe.png" width="30px"></a><div style="margin-top: 6px;"></div></div>
                <div id="insaWrap" class="sideHeader-sub">
                    <table id="insaContent" class="table table-dark table-hover">
                        <tr><th>인사 메뉴1</th></tr>
                        <tr><th>인사 메뉴2</th></tr>
                        <tr><th>인사 메뉴3</th></tr>
                        <tr><th>인사 메뉴4</th></tr>
                        <tr><th>인사 메뉴5</th></tr>
                    </table>
                </div>
        </div>
</div>
<div>
</div>
</header>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

