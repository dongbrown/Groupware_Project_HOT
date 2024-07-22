var EmailCommon = {
    contextPath: '',

    // 초기화 함수
    init: function(contextPath) {
        this.contextPath = contextPath;
        this.bindEvents();
        this.loadMailbox('inbox'); // 초기에 받은 메일함 로드
    },

    // 이벤트 바인딩 함수
    bindEvents: function() {
        // 메일함 선택 이벤트
        $(document).on('click', '.list-group-item', function() {
            $('.list-group-item').removeClass('active');
            $(this).addClass('active');
            var mailbox = $(this).data('mailbox');
            EmailCommon.loadMailbox(mailbox);
        });

        // 메일 작성 버튼 클릭 이벤트
        $(document).on('click', '#composeBtn', function() {
            EmailCommon.showComposeForm();
        });

        // 전체 선택 체크박스 이벤트
        $(document).on('change', '#select-all', function() {
            $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
        });

        // 개별 체크박스 이벤트
        $(document).on('change', '.mail-item-checkbox', function() {
            var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
            $('#select-all').prop('checked', allChecked);
        });

        // 삭제 버튼 클릭 이벤트
        $(document).on('click', '#deleteBtn', function() {
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

        // 검색 버튼 클릭 이벤트
        $(document).on('click', '#searchBtn', function() {
            var query = $('#searchInput').val();
            if (query.trim() === '') {
                alert('검색어를 입력하세요.');
                return;
            }
            EmailCommon.searchEmails('inbox', query, function(response) {
                $('#mailItems').html(response);
            });
        });

        // 메일 항목 클릭 이벤트 (체크박스 제외)
        $(document).on('click', '.email-item', function(e) {
            if (!$(e.target).is('input:checkbox')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.viewEmail(emailNo);
            }
        });
    },

    // 메일함 로드 함수
    loadMailbox: function(mailbox) {
        $.ajax({
            url: this.contextPath + '/' + mailbox,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
            },
            error: function() {
                alert(mailbox + ' 메일함을 로드하는데 실패했습니다.');
            }
        });
    },

    // 이메일 삭제 함수
    deleteEmails: function(emailNos, callback) {
        $.ajax({
            url: this.contextPath + '/delete',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                alert('선택한 이메일이 삭제되었습니다.');
                if (callback) callback();
            },
            error: function() {
                alert('이메일 삭제에 실패했습니다.');
            }
        });
    },

    // 이메일 검색 함수
    searchEmails: function(mailbox, query, callback) {
        $.ajax({
            url: this.contextPath + '/search',
            type: 'GET',
            data: { mailbox: mailbox, keyword: query },
            success: function(response) {
                if (callback) callback(response);
            },
            error: function() {
                alert('이메일 검색에 실패했습니다.');
            }
        });
    },

    // 이메일 상세 보기 함수
    viewEmail: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/view/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
            },
            error: function() {
                alert('이메일을 불러오는데 실패했습니다.');
            }
        });
    },

    // 메일 작성 폼 표시 함수
    showComposeForm: function() {
        $.ajax({
            url: this.contextPath + '/compose',
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
            },
            error: function() {
                alert('메일 작성 폼을 불러오는데 실패했습니다.');
            }
        });
    }
};

// 페이지 로드 시 초기화
$(document).ready(function() {
    EmailCommon.init('/email');
});