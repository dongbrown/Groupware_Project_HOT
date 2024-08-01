$(document).ready(function() {
    EmailApp.init();

    $('#sidebarWriteBtn').click(function(e) {
        e.preventDefault();
        EmailCommon.showWriteForm(false);
    });

    $('#sidebarWriteSelfBtn').click(function(e) {
        e.preventDefault();
        EmailCommon.showWriteForm(true);
    });
});

var EmailApp = {
    init: function() {
        this.bindEvents();
        this.loadInitialMailbox();
    },
    bindEvents: function() {
        // 메일함 클릭 이벤트 바인딩
        $(document).on('click', '.list-group-item', this.handleMailboxClick.bind(this));
    },
    loadInitialMailbox: function() {
        // 초기 메일함 로드 (예: 받은 메일함)
        var currentMailbox = new URLSearchParams(window.location.search).get('mailbox') || 'inbox';
        EmailCommon.loadMailbox(currentMailbox);
        $('.list-group-item[data-mailbox="' + currentMailbox + '"]').addClass('active');
    },
    handleMailboxClick: function(e) {
        e.preventDefault();
        var $target = $(e.currentTarget);
        var mailbox = $target.data('mailbox');
        EmailCommon.loadMailbox(mailbox);
        history.pushState(null, '', contextPath + '?mailbox=' + mailbox);
        $('.list-group-item').removeClass('active');
        $target.addClass('active');
    }
};

var EmailCommon = {
    loadMailbox: function(mailbox) {
        $.ajax({
            url: contextPath + '/email/' + mailbox,
            method: 'GET',
            success: function(data) {
                $('#mailContent').html(data);
                // URL 업데이트
                history.pushState(null, '', contextPath + '/email?mailbox=' + mailbox);
            },
            error: function() {
                alert('메일함 로드 중 오류가 발생했습니다.');
            }
        });
    }
};
