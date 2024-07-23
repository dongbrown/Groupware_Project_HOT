function bindInboxEvents() {
    // 전체 선택 체크박스 이벤트
    $('#select-all').change(function() {
        $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
    });

    // 개별 체크박스 이벤트
    $(document).on('change', '.mail-item-checkbox', function() {
        var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
        $('#select-all').prop('checked', allChecked);
    });

    // 삭제 버튼 클릭 이벤트
    $('#deleteBtn').click(function() {
        var selectedEmails = $('.mail-item-checkbox:checked').map(function() {
            return $(this).val();
        }).get();

        if (selectedEmails.length === 0) {
            alert('삭제할 메일을 선택하세요.');
            return;
        }

        EmailCommon.deleteEmails(selectedEmails, function() {
            EmailCommon.loadMailbox('inbox');
        });
    });

    // 메일 검색 이벤트
    $('#searchBtn').click(function() {
        var query = $('#searchInput').val();
        if (query.trim() === '') {
            alert('검색어를 입력하세요.');
            return;
        }
        EmailCommon.searchEmails('inbox', query, function(response) {
            $('#mailItems').html(response);
        });
    });
}

// 페이지 로드 시 이벤트 바인딩
$(document).ready(function() {
    bindInboxEvents();
});