var EmailApp = {
    contextPath: '',

    init: function(contextPath) {
        this.contextPath = contextPath;
        this.bindEvents();
        this.loadInitialMailbox();
        this.updateUnreadCounts();
        setInterval(this.updateUnreadCounts.bind(this), 30000);
    },

    bindEvents: function() {
        $(document).on('click', '.email-link', this.handleMailboxClick.bind(this));
        $('#writeBtn').on('click', this.showWriteForm.bind(this));
        $('#write-selfBtn').on('click', this.showSelfWriteForm.bind(this));
    },

    loadInitialMailbox: function() {
        var currentMailbox = new URLSearchParams(window.location.search).get('mailbox') || 'inbox';
        this.loadMailbox(currentMailbox);
        $('.email-link[data-mailbox="' + currentMailbox + '"]').addClass('active');
    },

    handleMailboxClick: function(e) {
        e.preventDefault();
        var $target = $(e.currentTarget);
        var mailbox = $target.data('mailbox');
        this.loadMailbox(mailbox);
        $('.email-link').removeClass('active');
        $target.addClass('active');
    },

    loadMailbox: function(mailbox, page = 1) {
        $.ajax({
            url: this.contextPath + '/' + mailbox,
            method: 'GET',
            data: { page: page },
            success: function(data) {
                $('#mailContent').html(data);
                history.pushState(null, '', EmailApp.contextPath + '?mailbox=' + mailbox);
            },
            error: function() {
                alert('메일함 로드 중 오류가 발생했습니다.');
            }
        });
    },

    showWriteForm: function(e) {
        e.preventDefault();
        $.ajax({
            url: this.contextPath + '/write',
            method: 'GET',
            success: function(data) {
                $('#mailContent').html(data);
                history.pushState(null, '', EmailApp.contextPath + '/write');
                EmailApp.initializeWriteForm();
            },
            error: function() {
                alert('메일 작성 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    showSelfWriteForm: function(e) {
        e.preventDefault();
        $.ajax({
            url: this.contextPath + '/write-self',
            method: 'GET',
            success: function(data) {
                $('#mailContent').html(data);
                history.pushState(null, '', EmailApp.contextPath + '/write-self');
                EmailApp.initializeWriteForm();
            },
            error: function() {
                alert('내게 쓰기 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    initializeWriteForm: function() {
        // Summernote 초기화 등 필요한 작업 수행
        $('#summernote').summernote({
            height: 300,
            minHeight: null,
            maxHeight: null,
            focus: true
        });
    },

    updateUnreadCounts: function() {
        $.ajax({
            url: this.contextPath + '/unread-counts',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                $('#inboxUnreadCount').text(data.inboxUnreadCount || '');
                $('#selfUnreadCount').text(data.selfUnreadCount || '');
                $('#importantUnreadCount').text(data.importantUnreadCount || '');
                $('#trashCount').text(data.trashCount || '');
            },
            error: function() {
                console.error('안 읽은 메일 개수 업데이트 실패');
            }
        });
    }
};