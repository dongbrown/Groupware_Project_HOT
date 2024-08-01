var EmailView = {
    init: function() {
        this.bindEvents();
    },

    bindEvents: function() {
        $(document).on('click', '.email-item', function(e) {
            if (!$(e.target).is('input:checkbox')) {
                var emailNo = $(this).data('email-no');
                EmailView.loadEmailContent(emailNo);
            }
        });

        $(document).on('click', '.btn-reply', function() {
            var emailNo = $('#emailNo').val();
            EmailView.replyEmail(emailNo);
        });

        $(document).on('click', '.btn-forward', function() {
            var emailNo = $('#emailNo').val();
            EmailView.forwardEmail(emailNo);
        });

        $(document).on('click', '.btn-delete', function() {
            var emailNo = $('#emailNo').val();
            EmailView.deleteEmail(emailNo);
        });
    },

    loadEmailContent: function(emailNo) {
        $.ajax({
            url: EmailCommon.contextPath + '/email/view/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.loadEmailAttachments(emailNo);
            },
            error: function() {
                alert('이메일 내용을 불러오는데 실패했습니다.');
            }
        });
    },

    replyEmail: function(emailNo) {
        EmailCommon.replyEmail(emailNo);
    },

    forwardEmail: function(emailNo) {
        EmailCommon.forwardEmail(emailNo);
    },

    deleteEmail: function(emailNo) {
        if (confirm('이 이메일을 삭제하시겠습니까?')) {
            $.ajax({
                url: EmailCommon.contextPath + '/email/delete',
                type: 'POST',
                data: JSON.stringify([emailNo]),
                contentType: 'application/json',
                success: function(response) {
                    alert('이메일이 삭제되었습니다.');
                    EmailCommon.loadMailbox('inbox');
                },
                error: function() {
                    alert('이메일 삭제에 실패했습니다.');
                }
            });
        }
    }
};

$(document).ready(function() {
    EmailView.init();
});