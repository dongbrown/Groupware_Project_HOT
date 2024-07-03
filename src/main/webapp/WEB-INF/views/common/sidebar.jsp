<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="${path }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${path }/css/sb-admin-2.min.css" rel="stylesheet">

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
                        <a class="collapse-item" href="${path}/approvalAll.do">전체</a>
                        <a class="collapse-item" href="${path}/approvalWait.do">결재대기</a>
                        <a class="collapse-item" href="${path}/approvalProcess.do">결재진행</a>
                        <a class="collapse-item" href="${path}/approvalComplete.do">결재완료</a><br>

                        <h6 class="collapse-header">문서함</h6>
                        <a class="collapse-item" href="${path}/documentAll.do">전체문서</a>
                        <a class="collapse-item" href="${path}/draftDocument.do">기안문서</a>
                        <a class="collapse-item" href="${path}/referenceDocument.do">참조문서</a>
                        <a class="collapse-item" href="${path}/viewDocument.do">열람문서</a>
                        <a class="collapse-item" href="${path}/temporaryStorage.do">임시저장</a>
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
                        <a class="collapse-item" href="utilities-color.html">전체 프로젝트 조회</a>
                        <a class="collapse-item" href="utilities-border.html">프로젝트 생성</a>
                        <a class="collapse-item" href="utilities-animation.html">프로젝트 수정</a><br>
                        <h6 class="collapse-header">작업</h6>
                        <a class="collapse-item" href="utilities-color.html">전체 작업 조회</a>
                        <a class="collapse-item" href="utilities-border.html">작업 생성</a>
                        <a class="collapse-item" href="utilities-animation.html">작업 수정</a>
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
                        <a class="collapse-item" href="utilities-color.html">내 캘린더</a>
                        <a class="collapse-item" href="utilities-border.html">공유 캘린더</a>
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
                        <a class="collapse-item" href="utilities-border.html">HotTalk</a>
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
                        <a class="collapse-item" href="utilities-color.html">즐겨찾는 커뮤니티</a>
                        <a class="collapse-item" href="utilities-border.html">내 커뮤니티</a>
                        <a class="collapse-item" href="utilities-animation.html">공개 커뮤니티</a>
                    </div>
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
                        <a class="collapse-item" href="utilities-color.html">주소록 조회</a><br>
                        <h6 class="collapse-header">조직도</h6>
                        <a class="collapse-item" href="utilities-color.html">조직도 조회</a>
                        <a class="collapse-item" href="utilities-border.html">조직도 수정</a>
                    </div>
                </div>
            </li>
            <c:if test="${loginEmployee.departmentCode==2}">
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
                        <a class="collapse-item" href="utilities-color.html">1</a>
                        <a class="collapse-item" href="utilities-border.html">2</a>
                        <a class="collapse-item" href="utilities-animation.html">3</a>
                        <a class="collapse-item" href="utilities-other.html">4</a>
                        <a class="collapse-item" href="utilities-other.html">5</a>
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

