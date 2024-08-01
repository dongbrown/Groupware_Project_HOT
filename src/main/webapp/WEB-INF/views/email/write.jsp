<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="email-write-container">
    <h2 class="email-write-title">새 메일 작성</h2>
    <form id="emailForm" class="email-write-form">
     	<div class="form-group">
		    <label for="receivers">받는 사람:</label>
		    <input type="text" id="receivers" name="receivers" class="form-control">
		    <div id="receiversList" class="receivers-list"></div>
		    <div id="selectedReceivers" class="selected-receivers"></div>
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
                파일을 여기에 드래그하세요
                <input type="file" id="fileInput" multiple style="display: none;">
            </div>
            <div id="fileList" class="file-list"></div>
        </div>
        <div class="button-group">
            <button type="submit" class="btn btn-primary">보내기</button>
            <!-- <button type="button" class="btn btn-secondary" id="saveAsDraft">임시 저장</button> -->
            <button type="button" class="btn btn-danger" id="cancel">취소</button>
        </div>
    </form>
</div>

<script>
$(document).ready(function() {
    if (typeof EmailCommon !== 'undefined') {
        if (typeof EmailCommon.initSummernote === 'function' && !EmailCommon.summernoteInitialized) {
            EmailCommon.initSummernote();
            EmailCommon.summernoteInitialized = true;
        }
        if (typeof EmailCommon.initReceiverAutocomplete === 'function' && !EmailCommon.autocompleteInitialized) {
            EmailCommon.initReceiverAutocomplete();
            EmailCommon.autocompleteInitialized = true;
        }
        if (typeof EmailCommon.initFileAttachment === 'function' && !EmailCommon.fileAttachmentInitialized) {
            EmailCommon.initFileAttachment();
            EmailCommon.fileAttachmentInitialized = true;
        }
    }
});
</script>