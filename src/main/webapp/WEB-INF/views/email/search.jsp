<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 검색 폼 -->
<div class="mb-3">
    <form id="searchForm" class="d-flex">
        <input type="text" id="searchInput" class="form-control me-2" placeholder="제목 또는 내용으로 검색">
        <button type="button" id="searchBtn" class="btn btn-outline-primary">검색</button>
    </form>
</div>

<!-- 검색 결과 카운트 -->
<div class="mb-3 search-result-count"></div>

<script>
$(document).ready(function() {
    // 검색 버튼 클릭 이벤트
    $('#searchBtn').click(function() {
        var keyword = $('#searchInput').val();
        if (keyword.trim() !== '') {
            EmailCommon.searchEmails(keyword);
        }
    });

    // 검색 입력 필드에서 엔터 키 이벤트
    $('#searchInput').keypress(function(e) {
        if (e.which == 13) {  // 엔터 키의 keyCode는 13입니다.
            e.preventDefault();
            $('#searchBtn').click();
        }
    });
});
</script>