var EmailCommon = {
    contextPath: '',
    files: [],
    initialized: false,

    init: function(contextPath) {
        if (this.initialized) return;
        this.initialized = true;

        this.contextPath = contextPath;
        this.bindEvents();
        this.loadMailbox('inbox');
    },

    bindEvents: function() {
        $(document).off('click', '.list-group-item').on('click', '.list-group-item', function(e) {
            e.preventDefault();
            $('.list-group-item').removeClass('active');
            $(this).addClass('active');
            var mailbox = $(this).data('mailbox');
            EmailCommon.loadMailbox(mailbox);
        });

        $(document).off('click', '#writeBtn').on('click', '#writeBtn', function(e) {
            e.preventDefault();
            EmailCommon.showWriteForm();
        });

        $(document).off('change', '#select-all').on('change', '#select-all', function() {
            $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
        });

        $(document).off('change', '.mail-item-checkbox').on('change', '.mail-item-checkbox', function() {
            var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
            $('#select-all').prop('checked', allChecked);
        });

        $(document).off('click', '#deleteBtn').on('click', '#deleteBtn', function() {
            var selectedEmails = $('.mail-item-checkbox:checked').map(function() {
                return $(this).val();
            }).get();

            if (selectedEmails.length === 0) {
                alert('삭제할 메일을 선택하세요.');
                return;
            }

            EmailCommon.moveEmailsToTrash(selectedEmails, function() {
                EmailCommon.loadMailbox('inbox');
            });
        });

        $(document).off('click', '#searchBtn').on('click', '#searchBtn', function() {
            var keyword = $('#searchInput').val();
            if (keyword.trim() === '') {
                alert('검색어를 입력하세요.');
                return;
            }
            EmailCommon.searchEmails(keyword);
        });

        $(document).off('click', '.email-item').on('click', '.email-item', function(e) {
            if (!$(e.target).is('input:checkbox')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.viewEmail(emailNo);
            }
        });

        $(document).off('dragover', '#dropZone').on('dragover', '#dropZone', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).addClass('drag-over');
        });

        $(document).off('dragleave', '#dropZone').on('dragleave', '#dropZone', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).removeClass('drag-over');
        });

        $(document).off('drop', '#dropZone').on('drop', '#dropZone', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).removeClass('drag-over');
            EmailCommon.handleFiles(e.originalEvent.dataTransfer.files);
        });

        $(document).off('click', '#dropZone').on('click', '#dropZone', function() {
            $('#fileInput').click();
        });

        $(document).off('change', '#fileInput').on('change', '#fileInput', function() {
            EmailCommon.handleFiles(this.files);
        });

        $(document).off('click', '.remove-file').on('click', '.remove-file', function() {
            var index = $(this).data('index');
            EmailCommon.files.splice(index, 1);
            EmailCommon.updateFileList();
        });

        $(document).off('submit', '#emailForm').on('submit', '#emailForm', function(e) {
            e.preventDefault();
            EmailCommon.saveEmail();
        });

        $(document).off('keydown', '#receivers').on('keydown', '#receivers', function(e) {
            var $receiversList = $('#receiversList');
            var $highlighted = $receiversList.find('.keyboard-selected');

            switch(e.which) {
                case 40: // down arrow
                    e.preventDefault();
                    EmailCommon.moveSelection($highlighted, 'down');
                    break;
                case 38: // up arrow
                    e.preventDefault();
                    EmailCommon.moveSelection($highlighted, 'up');
                    break;
                case 13: // enter
                    e.preventDefault();
                    if ($highlighted.length > 0) {
                        $highlighted.click();
                    }
                    break;
            }
        });
    },

    moveSelection: function($highlighted, direction) {
        var $items = $('#receiversList').find('.receiver-item');
        var index = $items.index($highlighted);

        $highlighted.removeClass('keyboard-selected');

        if (direction === 'down') {
            index = (index + 1) % $items.length;
        } else {
            index = (index - 1 + $items.length) % $items.length;
        }

        $items.eq(index).addClass('keyboard-selected');
    },

    loadMailbox: function(mailbox) {
        $.ajax({
            url: this.contextPath + '/' + mailbox,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initMailboxSpecificFunctions();
            },
            error: function() {
                alert(mailbox + ' 메일함을 로드하는데 실패했습니다.');
            }
        });
    },

    moveEmailsToTrash: function(emailNos, callback) {
        if (!Array.isArray(emailNos)) {
            emailNos = [emailNos];
        }

        $.ajax({
            url: this.contextPath + '/move-to-trash',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                var message = emailNos.length > 1 ?
                    '선택한 이메일들이 휴지통으로 이동되었습니다.' :
                    '선택한 이메일이 휴지통으로 이동되었습니다.';
                alert(message);
                if (callback) callback();
            },
            error: function() {
                alert('이메일을 휴지통으로 이동하는데 실패했습니다.');
            }
        });
    },

    searchEmails: function(keyword) {
        $.ajax({
            url: this.contextPath + '/search',
            type: 'GET',
            data: { keyword: keyword },
            success: function(response) {
                $('#mailContent').html(response);
            },
            error: function() {
                alert('이메일 검색에 실패했습니다.');
            }
        });
    },

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

    showWriteForm: function() {
        $.ajax({
            url: this.contextPath + '/write',
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initMailboxSpecificFunctions();
            },
            error: function() {
                alert('메일 작성 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    initMailboxSpecificFunctions: function() {
        if ($('#summernote').length) {
            this.initSummernote();
        }
        if ($('#receivers').length) {
            this.initReceiverAutocomplete();
        }
    },

    initSummernote: function() {
        $('#summernote').summernote({
            height: 300,
            minHeight: null,
            maxHeight: null,
            focus: true,
            lang: 'ko-KR',
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['link', 'video']],
                ['view', ['fullscreen', 'codeview', 'help']]
            ]
        });
    },

    handleFiles: function(newFiles) {
        for (var i = 0; i < newFiles.length; i++) {
            if (!this.files.some(f => f.name === newFiles[i].name)) {
                this.files.push(newFiles[i]);
            }
        }
        this.updateFileList();
    },

    updateFileList: function() {
        var fileList = $('#fileList');
        fileList.empty();
        for (var i = 0; i < this.files.length; i++) {
            var fileItem = $('<div class="file-item"></div>');
            fileItem.text(this.files[i].name);
            var removeBtn = $('<span class="remove-file" data-index="' + i + '">X</span>');
            fileItem.append(removeBtn);
            fileList.append(fileItem);
        }
    },

    saveEmail: function() {
        var formData = new FormData($('#emailForm')[0]);

        formData.append('emailTitle', $('#emailTitle').val());
        formData.append('emailContent', $('#summernote').summernote('code'));

        var receivers = this.getSelectedReceivers();
        formData.append('receivers', receivers.join(','));

        this.files.forEach(function(file, index) {
            formData.append('attachments', file);
        });

        $.ajax({
            url: this.contextPath + '/send',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert('메일이 성공적으로 전송되었습니다.');
                EmailCommon.loadMailbox('sent');
            },
            error: function(xhr, status, error) {
                console.error("Email save error:", xhr.responseText);
                alert('메일 전송에 실패했습니다. 오류: ' + error);
            }
        });
    },

    initReceiverAutocomplete: function() {
        var $receivers = $('#receivers');
        var $receiversList = $('#receiversList');
        var $selectedReceivers = $('#selectedReceivers');
        var debounceTimer;

        $receivers.off('input').on('input', function() {
            var keyword = $(this).val();
            clearTimeout(debounceTimer);

            debounceTimer = setTimeout(function() {
                if (keyword.length > 0) {
                    EmailCommon.searchEmployees(keyword);
                } else {
                    $receiversList.empty().hide();
                }
            }, 300);
        });

        $(document).off('click', '.receiver-item').on('click', '.receiver-item', function() {
            var email = $(this).data('email');
            var name = $(this).find('.employee-name').text();
            EmailCommon.addSelectedReceiver(email, name);
            $receiversList.empty().hide();
            $receivers.val('');
        });

        $selectedReceivers.on('click', '.remove-receiver', function() {
            $(this).parent().remove();
        });

        $receivers.off('keydown').on('keydown', function(e) {
            var $items = $receiversList.find('.receiver-item');
            var $selected = $items.filter('.keyboard-selected');
            var index = $items.index($selected);

            switch (e.which) {
                case 40: // down arrow
                    e.preventDefault();
                    EmailCommon.moveSelection($selected, 'down');
                    break;
                case 38: // up arrow
                    e.preventDefault();
                    EmailCommon.moveSelection($selected, 'up');
                    break;
                case 13: // enter
                    e.preventDefault();
                    if ($selected.length > 0) {
                        $selected.click();
                    }
                    break;
            }
        });
    },

    addSelectedReceiver: function(email, name) {
        var $selectedReceivers = $('#selectedReceivers');
        var $tag = $('<span class="selected-receiver"></span>')
            .text(name + ' <' + email + '>')
            .append('<span class="remove-receiver">×</span>')
            .data('email', email);
        $selectedReceivers.append($tag);
    },

    getSelectedReceivers: function() {
        return $('#selectedReceivers .selected-receiver').map(function() {
            return $(this).data('email');
        }).get();
    },

    searchEmployees: function(keyword) {
        $.ajax({
            url: this.contextPath + '/search-employees',
            type: 'GET',
            data: { keyword: keyword },
            success: function(response) {
                EmailCommon.displayEmployeeList(response);
            },
            error: function(xhr, status, error) {
                console.error('직원 검색 중 오류가 발생했습니다:', error);
                console.log('서버 응답:', xhr.responseText);
            }
        });
    },

    displayEmployeeList: function(employees) {
        var $receiversList = $('#receiversList');
        $receiversList.empty();

        if (employees.length === 0) {
            $receiversList.hide();
            return;
        }

        employees.forEach(function(employee, index) {
            var $item = $('<div class="receiver-item" tabindex="0"></div>');
            var $nameEmail = $('<span class="name-email"></span>');
            $nameEmail.append('<span class="employee-name">' + employee.name + '</span>');
            $nameEmail.append('<span class="employee-email">' + employee.email + '</span>');
            $item.append($nameEmail);
            $item.data('email', employee.email);
            if (index === 0) {
                $item.addClass('keyboard-selected');
            }
            $receiversList.append($item);
        });

        $receiversList.show();
    },

    markEmailAsRead: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/mark-as-read/' + emailNo,
            type: 'POST',
            success: function(response) {
                console.log('이메일을 읽음으로 표시했습니다.');
            },
            error: function(xhr, status, error) {
                console.error('이메일 읽음 표시 실패:', error);
            }
        });
    },

	toggleImportant: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/toggle-important/' + emailNo,
            type: 'POST',
            success: function(response) {
                alert(response);
                EmailCommon.loadMailbox('inbox'); // 메일함 새로고침
            },
            error: function(xhr, status, error) {
                console.error('중요 표시 변경 실패:', error);
            }
        });
    },

    replyEmail: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/reply/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initMailboxSpecificFunctions();
            },
            error: function() {
                alert('답장 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    forwardEmail: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/forward/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initMailboxSpecificFunctions();
            },
            error: function() {
                alert('전달 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    updateUnreadCount: function() {
        $.ajax({
            url: this.contextPath + '/unread-count',
            type: 'GET',
            success: function(count) {
                $('.unread-count').text(count);
            },
            error: function(xhr, status, error) {
                console.error('읽지 않은 메일 수 업데이트 실패:', error);
            }
        });
    }
};

$(document).ready(function() {
    var contextPath = '/email';
    EmailCommon.init(contextPath);

    // 페이지 로드 시 읽지 않은 메일 수 업데이트
    EmailCommon.updateUnreadCount();

    // 주기적으로 읽지 않은 메일 수 업데이트 (예: 1분마다)
    setInterval(function() {
        EmailCommon.updateUnreadCount();
    }, 60000);
});