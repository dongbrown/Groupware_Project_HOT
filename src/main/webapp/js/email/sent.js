// sent.js
$(document).ready(function() {
    EmailCommon.init(contextPath);

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

        if (selectedEmails.length > 0) {
            EmailCommon.deleteEmails(selectedEmails)
                .done(function() {
                    alert('선택한 이메일이 삭제되었습니다.');
                    EmailCommon.loadSentMails();
                })
                .fail(function() {
                    alert('이메일 삭제 중 오류가 발생했습니다.');
                });
        } else {
            alert('삭제할 이메일을 선택해주세요.');
        }
    });

    // 검색 이벤트
    $('#searchForm').submit(function(e) {
        e.preventDefault();
        var keyword = $('#searchInput').val();
        if (keyword) {
            EmailCommon.searchEmails(keyword)
                .done(function(response) {
                    // 검색 결과를 표시하는 로직
                    // 예: $('#searchResults').html(response);
                })
                .fail(function() {
                    alert('검색 중 오류가 발생했습니다.');
                });
        }
    });

    // 이메일 행 클릭 이벤트 (이메일 내용 보기)
    $('#mailItems').on('click', 'tr', function(e) {
        if (!$(e.target).is('input:checkbox')) {
            var emailNo = $(this).data('email-no');
            EmailCommon.viewEmail(emailNo);
        }
    });

    // 메일 쓰기 버튼 클릭 이벤트
    $('#composeBtn').click(function() {
        EmailCommon.showComposeForm();
    });
});