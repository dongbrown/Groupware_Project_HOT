<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <title>HOT Solution</title>

    <!-- Custom fonts for this template-->
    <link href="${path }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${path }/css/sb-admin-2.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center">
                <div class="sidebar-brand-icon rotate-n-15">
                    <!-- 회사로고 여기에~ -->
                </div>
                <div class="sidebar-brand-text mx-3">HOT Solution</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="${path }/">
                    <i class="fas fa-fw fa-home"></i> <!-- HOME 아이콘으로 대체하세요~ -->
                    <span>HOME</span>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#approval"
                    aria-expanded="true" aria-controls="approval">
                    <i class="fas fa-clipboard"></i>
                    <span>전자결재</span>
                </a>
                <div id="approval" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">결재함</h6>
                        <a class="collapse-item" href="${path}/approval/approvalAll.do">전체</a>
                        <a class="collapse-item" href="${path}/approval/approvalWait.do">결재대기</a>
                        <a class="collapse-item" href="${path}/approval/approvalProcess.do">결재진행</a>
                        <a class="collapse-item" href="${path}/approval/approvalComplete.do">결재완료</a><br>

                        <h6 class="collapse-header">문서함</h6>
                        <a class="collapse-item" href="${path}/approval/documentAll.do">전체문서</a>
                        <a class="collapse-item" href="${path}/approval/draftDocument.do">기안문서</a>
                        <a class="collapse-item" href="${path}/approval/referenceDocument.do">참조문서</a>
                        <a class="collapse-item" href="${path}/approval/viewDocument.do">열람문서</a>
                        <a class="collapse-item" href="${path}/approval/temporaryStorage.do">임시저장</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#project"
                    aria-expanded="true" aria-controls="project">
                    <i class="fas fa-briefcase"></i>
                    <span>프로젝트</span>
                </a>
                <div id="project" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">프로젝트</h6>
                        <a class="collapse-item" href="${path}/project/projectListAll.do?employeeNo=${loginEmployee.employeeNo}">전체 프로젝트 조회</a>
                        <a class="collapse-item" href="${path}/project/projectinsert.do">프로젝트 생성</a>
                        <a class="collapse-item" href="${path}/project/projectupdate.do">프로젝트 수정</a><br>
                        <h6 class="collapse-header">작업</h6>
                        <a class="collapse-item" href="${path}/project/workListAll.do?employeeNo=${loginEmployee.employeeNo}">전체 작업 조회</a>
                        <a class="collapse-item" href="${path}/work/workinsert.do">작업 생성</a>
                        <a class="collapse-item" href="${path}/work/workupdate.do">작업 수정</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#schedule"
                    aria-expanded="true" aria-controls="schedule">
                    <i class="fas fa-calendar-check"></i>
                    <span>일정관리</span>
                </a>
                <div id="schedule" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">캘린더</h6>
                        <a class="collapse-item" href="${path }/schedule/">내 캘린더</a>
                        <a class="collapse-item" href="${path }/schedule/">공유 캘린더</a>
                    </div>
                </div>
            </li>
            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#email"
                    aria-expanded="true" aria-controls="email">
                    <i class="fas fa-envelope"></i>
                    <span>메일</span>
                </a>
                <div id="email" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">메일 조회</h6>
                        <a class="collapse-item" href="utilities-color.html">전체 메일</a>
                        <a class="collapse-item" href="utilities-border.html">받은 메일함</a>
                        <a class="collapse-item" href="utilities-animation.html">내게 쓴 메일함</a>
                        <a class="collapse-item" href="utilities-other.html">보낸 메일함</a>
                        <a class="collapse-item" href="utilities-other.html">중요 메일함</a>
                        <a class="collapse-item" href="utilities-other.html">임시 메일함</a>
                        <a class="collapse-item" href="utilities-other.html">휴지통</a><br>
                        <h6 class="collapse-header">메일 발송</h6>
                        <a class="collapse-item" href="utilities-other.html">메일 발송</a>
                        <a class="collapse-item" href="utilities-other.html">내게 쓰기</a>
                    </div>
                </div>
            </li>
            <!--
             Nav Item - Utilities Collapse Menu
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#vacation"
                    aria-expanded="true" aria-controls="vacation">
                    <i class="fas fa-plane"></i>
                    <span>휴가/휴직</span>
                </a>
                <div id="vacation" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">삽입하기</h6>
                        <a class="collapse-item" href="utilities-color.html">6974</a>
                    </div>
                </div>
            </li>
             -->
            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#hottalk"
                    aria-expanded="true" aria-controls="hottalk">
                    <i class="fas fa-comments"></i>
                    <span>SNS</span>
                </a>
                <div id="hottalk" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">핫톡</h6>
                        <a class="collapse-item" href="${path }/hottalk">HotTalk</a>
                        <a class="collapse-item" href="utilities-animation.html">환경설정</a>
                    </div>
                </div>
            </li>
            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#community"
                    aria-expanded="true" aria-controls="community">
                    <i class="fas fa-users"></i>
                    <span>커뮤니티</span>
                </a>
                <div id="community" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">커뮤니티 목록</h6>
                        <a class="collapse-item" href="${path }/community/">즐겨찾는 커뮤니티</a>
                        <a class="collapse-item" href="${path }/community/">내 커뮤니티</a>
						<a class="collapse-item" href="${path}/community/communityList">커뮤니티 리스트</a>                    </div>
                </div>
            </li>
            <!-- Divider -->
            <hr class="sidebar-divider my-0">
            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#organization"
                    aria-expanded="true" aria-controls="organization">
                    <i class="fas fa-sitemap"></i>
                    <span>조직관리</span>
                </a>
                <div id="organization" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">주소록</h6>
                        <a class="collapse-item" href="${path }/employee/addressbook">주소록 조회</a><br>
                        <h6 class="collapse-header">조직도</h6>
                        <a class="collapse-item" href="utilities-color.html">조직도 조회</a>
                    </div>
                </div>
            </li>
            <c:if test="${loginEmployee.departmentCode.departmentAuthority eq '100' or loginEmployee.departmentCode.departmentAuthority eq '10'}">
                <!-- Nav Item - Utilities Collapse Menu -->
	            <li class="nav-item">
	                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#human"
	                    aria-expanded="true" aria-controls="human">
	                    <i class="fas fa-id-card"></i>
	                    <span>인사관리</span>
	                </a>
	                <div id="human" class="collapse" aria-labelledby="headingUtilities"
	                    data-parent="#accordionSidebar">
	                    <div class="bg-white py-2 collapse-inner rounded">
	                        <h6 class="collapse-header">인사 잘하기</h6>
	                        <a class="collapse-item" href="${path }/hr/employee">사원 관리</a>
	                        <a class="collapse-item" href="${path }/hr/department">부서관리</a>
	                        <a class="collapse-item" href="${path }/hr/allEmpCommuting">전 사원 근태내역</a>
	                        <a class="collapse-item" href="#">전 사원 휴가 내역</a>
	                        <a class="collapse-item" href="${path }/createEmployee">사원 계정 생성</a>
	                    </div>
	                </div>
	            </li>
            </c:if>


            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->