<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="main-content">
    <div class="toolbar mb-3">
        <div class="btn-group" role="group">
            <input type="checkbox" class="btn-check" id="select-all" autocomplete="off">
            <label class="btn btn-outline-primary" for="select-all"><i class="fas fa-check"></i></label>
            <button type="button" class="btn btn-outline-danger" id="deleteBtn"><i class="fas fa-trash"></i></button>
        </div>
        <div class="ms-auto">
            <input type="text" class="form-control d-inline-block w-auto" placeholder="메일 검색" id="searchInput">
            <button class="btn btn-outline-secondary" id="searchBtn"><i class="fas fa-search"></i></button>
        </div>
    </div>
    <table class="table table-hover">
        <thead>
            <tr>
                <th></th>
                <th>받는 사람</th>
                <th>제목</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody id="mailItems">
            <c:forEach var="email" items="${emails}">
                <tr data-email-no="${email.emailNo}">
                    <td>
                        <input type="checkbox" class="mail-item-checkbox" value="${email.emailNo}">
                    </td>
                    <td>${email.receiver}</td>
                    <td>${email.emailTitle}</td>
                    <td><fmt:formatDate value="${email.emailSendDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- 페이지네이션 -->
</div>