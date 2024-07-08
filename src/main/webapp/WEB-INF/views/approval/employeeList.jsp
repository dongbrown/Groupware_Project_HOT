<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="form-group">
    <label for="approver">결재자 선택</label>
    <select id="approver" class="form-control">
        <option value="">결재자를 선택하세요</option>
        <c:forEach var="employee" items="${employees}">
            <option value="${employee}">${employee}</option>
        </c:forEach>
    </select>
</div>

<div class="form-group">
    <label for="cc">참조자 선택</label>
    <select id="cc" class="form-control">
        <option value="">참조자를 선택하세요</option>
        <c:forEach var="employee" items="${employees}">
            <option value="${employee}">${employee}</option>
        </c:forEach>
    </select>
</div>