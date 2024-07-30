<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<div class="email-write-container">
    <h2 class="email-write-title">내게 쓰기</h2>
    <form id="emailForm" class="email-write-form">
        <div class="form-group">
            <label for="receivers">받는 사람:</label>
            <input type="text" id="receivers" name="receivers" class="form-control"
                value="${loginEmployee.employeeId}@hot.com(${loginEmployee.employeeName })" readonly>
        </div>
        <div class="form-group">
            <label for="emailTitle">제목:</label>
            <input type="text" id="emailTitle" name="emailTitle" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="summernote">내용:</label>
            <textarea id="summernote" name="content"></textarea>
        </div>
        <div class="form-group">
            <label for="attachment">첨부 파일:</label>
            <div id="dropZone" class="drop-zone">
                파일을 여기에 드래그하거나 클릭하여 선택하세요
                <input type="file" id="fileInput" multiple style="display: none;">
            </div>
            <div id="fileList" class="file-list"></div>
        </div>
        <div class="button-group">
            <button type="submit" class="btn btn-primary">보내기</button>
            <button type="button" class="btn btn-danger" id="cancel">취소</button>
        </div>
    </form>
</div>

<script>
$(document).ready(function() {
    if (typeof EmailCommon !== 'undefined' && typeof EmailCommon.initSummernote === 'function') {
        EmailCommon.initSummernote();
    }

    if (typeof EmailCommon !== 'undefined' && typeof EmailCommon.initFileAttachment === 'function') {
        EmailCommon.initFileAttachment();
    }

    $('#emailForm').submit(function(e) {
        e.preventDefault();
        var receivers = $('#receivers').val().split('(')[0]; // 이메일 주소만 추출
        EmailCommon.saveEmail(false, receivers);
    });

    $('#cancel').click(function() {
        if (confirm('작성 중인 내용이 저장되지 않습니다. 정말 취소하시겠습니까?')) {
            EmailCommon.loadMailbox('inbox');
        }
    });
});
</script>