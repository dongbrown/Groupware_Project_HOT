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
        var senderEmail = $('.sender-email').text().trim();
        var emailTitle = $('.email-title').text().trim();
        var emailContent = $('.email-content').html();

        // URL에서 .jsp 제거 및 파라미터 인코딩
        window.location.href = EmailCommon.contextPath + '/write?action=reply' +
                               '&to=' + encodeURIComponent(senderEmail) +
                               '&subject=' + encodeURIComponent('Re: ' + emailTitle) +
                               '&content=' + encodeURIComponent(emailContent);
    },

    forwardEmail: function(emailNo) {
        var emailTitle = $('.email-title').text().trim();
        var emailContent = $('.email-content').html();

        // URL에서 .jsp 제거 및 파라미터 인코딩
        window.location.href = EmailCommon.contextPath + '/write?action=forward' +
                               '&subject=' + encodeURIComponent('Fwd: ' + emailTitle) +
                               '&content=' + encodeURIComponent(emailContent);
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
    },

    markAsRead: function(emailNo) {
        $.ajax({
            url: EmailCommon.contextPath + '/email/mark-as-read/' + emailNo,
            type: 'POST',
            success: function(response) {
                console.log('이메일이 읽음 상태로 변경되었습니다.');
                // 필요한 경우 UI 업데이트
            },
            error: function() {
                console.error('이메일 상태 변경에 실패했습니다.');
            }
        });
    },

    toggleImportant: function(emailNo) {
        $.ajax({
            url: EmailCommon.contextPath + '/email/toggle-important/' + emailNo,
            type: 'POST',
            success: function(response) {
                console.log(response);
                // 필요한 경우 UI 업데이트
            },
            error: function() {
                console.error('중요 표시 변경에 실패했습니다.');
            }
        });
    },

    downloadAttachment: function(attachmentId, filename) {
        window.location.href = EmailCommon.contextPath + '/email/download/' + attachmentId;
    }
};

$(document).ready(function() {
    EmailView.init();
});