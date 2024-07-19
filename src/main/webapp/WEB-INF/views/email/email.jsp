<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사내 메일</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://webfontworld.github.io/gmarket/GmarketSans.css" rel="stylesheet">
<link href="${path}/css/email/email.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}" />

<!-- 사이드바 include -->
<c:import url="/WEB-INF/views/common/sidebar.jsp" />

<!-- 콘텐츠 Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">
    <!-- 메인 콘텐츠 -->
    <div id="content">
        <!-- 헤더 include -->
        <c:import url="/WEB-INF/views/common/header.jsp" />

        <!-- 페이지 콘텐츠 시작 -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3">
                    <div class="emailSidebar">
                        <button class="btn btn-primary w-100 mb-3">메일 쓰기</button>
                        <ul class="list-group">
                            <li class="list-group-item active"><i class="fas fa-inbox me-2"></i>받은메일함 <span class="badge bg-primary rounded-pill">999+</span></li>
                            <li class="list-group-item"><i class="fas fa-paper-plane me-2"></i>보낸메일함</li>
                            <li class="list-group-item"><i class="fas fa-user me-2"></i>내게쓴메일함 <span class="badge bg-secondary rounded-pill">20</span></li>
                            <li class="list-group-item"><i class="fas fa-star me-2"></i>중요메일함</li>
                            <li class="list-group-item"><i class="fas fa-trash me-2"></i>휴지통 <span class="badge bg-danger rounded-pill">30</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="main-content">
                        <div class="toolbar mb-3">
                            <div class="btn-group" role="group">
                                <input type="checkbox" class="btn-check" id="select-all" autocomplete="off">
                                <label class="btn btn-outline-primary" for="select-all"><i class="fas fa-check"></i></label>
                                <button type="button" class="btn btn-outline-danger"><i class="fas fa-trash"></i></button>
                                <button type="button" class="btn btn-outline-secondary"><i class="fas fa-reply"></i></button>
                                <button type="button" class="btn btn-outline-secondary"><i class="fas fa-share"></i></button>
                            </div>
                            <div class="ms-auto">
                                <span class="me-2">20 / 155 안읽음 삭제</span>
                                <input type="text" class="form-control d-inline-block w-auto" placeholder="메일 검색">
                                <button class="btn btn-outline-secondary"><i class="fas fa-cog"></i></button>
                            </div>
                        </div>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>보낸 사람</th>
                                    <th>제목</th>
                                    <th>날짜</th>
                                </tr>
                            </thead>
                            <tbody id="mailItems">
                                <!-- 메일 항목들이 여기에 동적으로 추가됩니다 -->
                            </tbody>
                        </table>
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled"><a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a></li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">4</a></li>
                                <li class="page-item"><a class="page-link" href="#">5</a></li>
                                <li class="page-item"><a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <!-- 페이지 콘텐츠 끝 -->
    </div>
    <!-- 메인 콘텐츠 끝 -->

    <!-- 푸터 include -->
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
<!-- 콘텐츠 Wrapper 끝 -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${path}/js/email/email.js"></script>

</body>
</html>