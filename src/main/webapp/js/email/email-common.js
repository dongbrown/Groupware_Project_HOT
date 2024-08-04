var EmailCommon = {
    contextPath: '',
    files: [],
    initialized: false,

    init: function(contextPath) {
        if (this.initialized) return;
        this.initialized = true;

        this.contextPath = contextPath;
        this.bindEvents();

        this.updateUnreadCounts();
        setInterval(this.updateUnreadCounts.bind(this), 30000);
    },

    bindEvents: function() {
        $(document).off('click', '.email-link').on('click', '.email-link', function(e) {
            e.preventDefault();
            $('.email-link').removeClass('active');
            $(this).addClass('active');
            var mailbox = $(this).data('mailbox');
            EmailCommon.loadMailbox(mailbox);
        });

        $(document).off('click', '#permanentDeleteBtn').on('click', '#permanentDeleteBtn', function() {
            var selectedEmails = EmailCommon.getSelectedEmails();
            if (selectedEmails.length === 0) {
                alert('영구 삭제할 메일을 선택하세요.');
                return;
            }
            if (confirm('선택한 ' + selectedEmails.length + '개의 메일을 영구적으로 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.')) {
                EmailCommon.deletePermanently(selectedEmails);
            }
        });

        $(document).off('click', '#writeBtn, #writeEmailBtn').on('click', '#writeBtn, #writeEmailBtn', function(e) {
            e.preventDefault();
            if (!$(this).data('clicked')) {
                $(this).data('clicked', true);
                EmailCommon.showWriteForm();
                setTimeout(() => $(this).data('clicked', false), 1000);
            }
        });

        $(document).off('click', '#write-selfBtn, #writeSelfEmailBtn').on('click', '#write-selfBtn, #writeSelfEmailBtn', function(e) {
            e.preventDefault();
            if (!$(this).data('clicked')) {
                $(this).data('clicked', true);
                EmailCommon.showSelfWriteForm();
                setTimeout(() => $(this).data('clicked', false), 1000);
            }
        });

        $(document).off('change', '#select-all').on('change', '#select-all', function() {
            $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
        });

        $(document).off('change', '.mail-item-checkbox').on('change', '.mail-item-checkbox', function() {
            var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
            $('#select-all').prop('checked', allChecked);
        });

        $(document).off('click', '#readBtn').on('click', '#readBtn', function() {
            var selectedEmails = EmailCommon.getSelectedEmails();
            if (selectedEmails.length === 0) {
                alert('읽음 처리할 메일을 선택하세요.');
                return;
            }
            EmailCommon.markAsRead(selectedEmails);
        });

        $(document).off('click', '#importantBtn').on('click', '#importantBtn', function() {
            var selectedEmails = EmailCommon.getSelectedEmails();
            if (selectedEmails.length === 0) {
                alert('중요 표시할 메일을 선택하세요.');
                return;
            }
            EmailCommon.toggleImportant(selectedEmails);
        });

        $(document).off('click', '#deleteBtn').on('click', '#deleteBtn', function() {
            var selectedEmails = EmailCommon.getSelectedEmails();
            if (selectedEmails.length === 0) {
                alert('삭제할 메일을 선택하세요.');
                return;
            }
            if (confirm('선택한 ' + selectedEmails.length + '개의 메일을 삭제하시겠습니까?')) {
                EmailCommon.moveEmailsToTrash(selectedEmails);
            }
        });

        $(document).off('click', '#searchBtn').on('click', '#searchBtn', function() {
            var keyword = $('#searchInput').val();
            if (keyword.trim() === '') {
                alert('검색어를 입력하세요.');
                return;
            }
            EmailCommon.searchEmails(keyword);
        });

        $(document).off('keypress', '#searchInput').on('keypress', '#searchInput', function(e) {
            if (e.which == 13) {
                e.preventDefault();
                $('#searchBtn').click();
            }
        });

        $(document).off('click', '.email-item').on('click', '.email-item', function(e) {
            if (!$(e.target).is('input:checkbox') && !$(e.target).is('.toggle-important')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.loadEmailContent(emailNo);
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
            EmailCommon.saveEmail(false);
        });

        $(document).off('click', '#saveDraftBtn').on('click', '#saveDraftBtn', function(e) {
            e.preventDefault();
            EmailCommon.saveEmail(true);
        });

        $(document).off('click', '.toggle-important').on('click', '.toggle-important', function(e) {
            e.preventDefault();
            e.stopPropagation();
            var emailNo = $(this).closest('.email-item').data('email-no');
            EmailCommon.toggleImportant([emailNo]);
        });

        $(document).off('click', '#restoreBtn').on('click', '#restoreBtn', function() {
            var selectedEmails = EmailCommon.getSelectedEmails();
            if (selectedEmails.length === 0) {
                alert('복구할 메일을 선택하세요.');
                return;
            }
            EmailCommon.restoreFromTrash(selectedEmails);
        });

        $(document).on('click', '.btn-reply', function() {
            var emailNo = $('#emailNo').val();
            EmailCommon.replyEmail(emailNo);
        });

        $(document).on('click', '.btn-forward', function() {
            var emailNo = $('#emailNo').val();
            EmailCommon.forwardEmail(emailNo);
        });

        $(document).on('click', '.btn-delete', function() {
            var emailNo = $('#emailNo').val();
            EmailCommon.deleteEmail(emailNo);
        });
    },

    getSelectedEmails: function() {
        return $('.mail-item-checkbox:checked').map(function() {
            return $(this).val();
        }).get();
    },

    moveSelection: function($highlighted, direction) {
        var $items = $('#receiversList').find('.receiver-item');
        var currentIndex = $items.index($highlighted);
        $highlighted.removeClass('keyboard-selected');

        if (direction === 'down') {
            currentIndex = (currentIndex + 1) % $items.length;
        } else {
            currentIndex = (currentIndex - 1 + $items.length) % $items.length;
        }

        $items.eq(currentIndex).addClass('keyboard-selected');
        this.ensureVisible($items.eq(currentIndex));
    },

    ensureVisible: function($element) {
        var container = $('#receiversList');
        var containerTop = container.scrollTop();
        var containerBottom = containerTop + container.height();
        var elemTop = $element.offset().top - container.offset().top + containerTop;
        var elemBottom = elemTop + $element.height();

        if (elemTop < containerTop) {
            container.scrollTop(elemTop);
        } else if (elemBottom > containerBottom) {
            container.scrollTop(elemBottom - container.height());
        }
    },

    loadMailbox: function(mailbox, page = 1) {
        $.ajax({
            url: this.contextPath + '/' + mailbox,
            type: 'GET',
            data: { page: page },
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions(mailbox);
                history.pushState(null, '', EmailCommon.contextPath + '/' + mailbox);

                $('.email-link').removeClass('active');
                $('.email-link[data-mailbox="' + mailbox + '"]').addClass('active');
            },
            error: function() {
                alert(mailbox + ' 메일함을 로드하는데 실패했습니다.');
            }
        });
    },

    loadInbox: function(page = 1) {
        this.loadMailbox('inbox', page);
    },

    loadSent: function(page = 1) {
        this.loadMailbox('sent', page);
    },

    loadSelf: function(page = 1) {
        this.loadMailbox('self', page);
    },

    loadImportant: function(page = 1) {
        this.loadMailbox('important', page);
    },

    loadTrash: function(page = 1) {
        this.loadMailbox('trash', page);
    },

    initializeMailboxFunctions: function(mailbox) {
        switch(mailbox) {
            case 'inbox':
                this.initInbox();
                break;
            case 'sent':
                this.initSent();
                break;
            case 'write':
                this.initWriteForm();
                break;
            case 'trash':
                this.initTrash();
                break;
        }
    },

    initInbox: function() {
        this.reattachEventListeners();
    },

    initSent: function() {
        this.reattachEventListeners();
    },

    initWriteForm: function() {
        if ($('#summernote').length) {
            this.initSummernote();
        }
        if ($('#receivers').length) {
            this.initReceiverAutocomplete();
        }
    },

    initTrash: function() {
        this.reattachEventListeners();
    },

    moveEmailsToTrash: function(emailNos) {
        if (!Array.isArray(emailNos)) {
            emailNos = [emailNos];
        }
        $.ajax({
            url: this.contextPath + '/move-to-trash',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                alert('선택한 이메일을 휴지통으로 이동했습니다.');
                $('#mailContent').html(response);
                EmailCommon.reattachEventListeners();
            },
            error: function(xhr, status, error) {
                console.error('이메일 삭제 실패:', error);
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
                EmailCommon.reattachEventListeners();

                var resultCount = $('#emailList tr').length;
                $('.search-result-count').text('검색 결과: ' + resultCount + '개');
            },
            error: function(xhr, status, error) {
                console.error('이메일 검색에 실패했습니다:', error);
                alert('이메일 검색에 실패했습니다.');
            }
        });
    },

    loadEmailContent: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/view/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.loadEmailAttachments(emailNo);
                EmailCommon.markAsRead([emailNo]);
            },
            error: function() {
                alert('이메일 내용을 불러오는데 실패했습니다.');
            }
        });
    },

    showWriteForm: function() {
        $.ajax({
            url: this.contextPath + '/write',
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('write');
                history.pushState(null, '', EmailCommon.contextPath + '/write');
            },
            error: function() {
                alert('메일 작성 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    showSelfWriteForm: function() {
        $.ajax({
            url: this.contextPath + '/write-self',
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('write-self');
                history.pushState(null, '', EmailCommon.contextPath + '/write-self');
            },
            error: function() {
                alert('내게 쓰기 폼을 불러오는데 실패했습니다.');
            }
        });
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
                ['insert', ['link', 'picture', 'video']],
                ['view', ['fullscreen', 'codeview', 'help']]
            ],
            callbacks: {
            	onInit: function() {
                	// 이미지 드래그 방지
                	$(document).on('dragstart', 'img', function(event) {
                    event.preventDefault();
              	  });
            	}
        	}
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

    saveEmail: function(isDraft) {
        if (this.isSaving) return;
        this.isSaving = true;

        var formData = new FormData($('#emailForm')[0]);

        var receivers = this.getSelectedReceivers();
        formData.set('receivers', receivers);

        if (!formData.get('receivers')) {
            formData.set('receivers', $('#receivers').val());
        }

        var emailTitle = $('#emailTitle').val().trim();
        formData.set('emailTitle', emailTitle);

        formData.set('emailContent', $('#summernote').summernote('code'));

        this.files.forEach(function(file, index) {
            formData.append('attachments', file);
        });

        var url = isDraft ? this.contextPath + '/save-draft' : this.contextPath + '/send';

        $.ajax({
            url: url,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (isDraft) {
                    alert('메일이 임시저장되었습니다.');
                    window.location.href = EmailCommon.contextPath + '/inbox';
                } else {
                    alert('메일이 성공적으로 전송되었습니다.');
                    window.location.href = EmailCommon.contextPath + '/inbox';
                }
            },
            error: function(xhr, status, error) {
                console.error("Email save error:", xhr.responseText);
                alert((isDraft ? '임시저장' : '메일 전송') + '에 실패했습니다. 오류: ' + error);
            },
            complete: function() {
                EmailCommon.isSaving = false;
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

    markAsRead: function(emailNos) {
        if (!Array.isArray(emailNos)) {
            emailNos = [emailNos];
        }
        $.ajax({
            url: this.contextPath + '/mark-as-read',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                console.log('이메일을 읽음으로 표시했습니다.');
                EmailCommon.updateUnreadCount();
                $('#mailContent').html(response);
                EmailCommon.reattachEventListeners();
            },
            error: function(xhr, status, error) {
                console.error('이메일 읽음 표시 실패:', error);
            }
        });
    },

    toggleImportant: function(emailNos) {
        if (!Array.isArray(emailNos)) {
            emailNos = [emailNos];
        }
        $.ajax({
            url: this.contextPath + '/toggle-important',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                console.log('이메일의 중요 표시를 변경했습니다.');
                $('#mailContent').html(response);
                EmailCommon.reattachEventListeners();
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
                EmailCommon.initializeMailboxFunctions('write');
                history.pushState(null, '', EmailCommon.contextPath + '/reply/' + emailNo);
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
                EmailCommon.initializeMailboxFunctions('write');
                history.pushState(null, '', EmailCommon.contextPath + '/forward/' + emailNo);
            },
            error: function() {
                alert('전달 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    deleteEmail: function(emailNo) {
        if (confirm('이 이메일을 삭제하시겠습니까?')) {
            $.ajax({
                url: this.contextPath + '/delete',
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

    updateUnreadCounts: function() {
        $.ajax({
            url: this.contextPath + '/unread-counts',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                $('#inboxUnreadCount').text(data.inboxUnreadCount > 0 ? data.inboxUnreadCount : '');
                $('#selfUnreadCount').text(data.selfUnreadCount > 0 ? data.selfUnreadCount : '');
                $('#importantUnreadCount').text(data.importantUnreadCount > 0 ? data.importantUnreadCount : '');
                $('#trashCount').text(data.trashCount > 0 ? data.trashCount : '');
            },
            error: function(xhr, status, error) {
                console.error('Failed to update unread counts:', error);
            }
        });
    },

    loadDrafts: function() {
        $.ajax({
            url: this.contextPath + '/drafts',
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('drafts');
            },
            error: function() {
                alert('임시저장 메일함을 로드하는데 실패했습니다.');
            }
        });
    },

    editDraft: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/edit-draft/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('write');
            },
            error: function() {
                alert('임시저장 메일을 불러오는데 실패했습니다.');
            }
        });
    },

    reattachEventListeners: function() {
        $('.email-item').off('click').on('click', function(e) {
            if (!$(e.target).is('input:checkbox') && !$(e.target).is('.toggle-important')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.loadEmailContent(emailNo);
            }
        });

        $('.toggle-important').off('click').on('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            var emailNo = $(this).closest('.email-item').data('email-no');
            EmailCommon.toggleImportant([emailNo]);
        });

        $('.mail-item-checkbox').off('change').on('change', function() {
            var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
            $('#select-all').prop('checked', allChecked);
        });

        $('#select-all').off('change').on('change', function() {
            $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
        });
    },

    markTrashAsRead: function(emailNos) {
        $.ajax({
            url: this.contextPath + '/trash/mark-as-read',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                alert(response);
                EmailCommon.loadMailbox('trash');
            },
            error: function(xhr, status, error) {
                alert("읽음 처리 중 오류가 발생했습니다: " + xhr.responseText);
            }
        });
    },

    deletePermanently: function(emailNos) {
        if (!Array.isArray(emailNos)) {
            emailNos = [emailNos];
        }

        $.ajax({
            url: this.contextPath + '/trash/delete-permanently',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                alert(response);
                EmailCommon.loadMailbox('trash');
            },
            error: function(xhr, status, error) {
                alert("영구 삭제 중 오류가 발생했습니다: " + xhr.responseText);
            }
        });
    },

    restoreFromTrash: function(emailNos) {
        if (!Array.isArray(emailNos)) {
            emailNos = [emailNos];
        }

        $.ajax({
            url: this.contextPath + '/trash/restore',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(emailNos),
            success: function(response) {
                alert(response);
                EmailCommon.loadMailbox('trash');
            },
            error: function(xhr, status, error) {
                alert("복구 중 오류가 발생했습니다: " + xhr.responseText);
            }
        });
    },

    loadEmailAttachments: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/attachments/' + emailNo,
            type: 'GET',
            success: function(attachments) {
                var $attachmentList = $('#attachmentList');
                $attachmentList.empty();
                attachments.forEach(function(att) {
                    var $item = $('<li>')
                        .append($('<a>')
                            .text(att.emailAttOriginalFilename)
                            .attr('href', '#')
                            .click(function(e) {
                                e.preventDefault();
                                EmailCommon.downloadAttachment(att.emailAttNo, att.emailAttOriginalFilename);
                            })
                        );
                    $attachmentList.append($item);
                });
            },
            error: function() {
                console.error('첨부 파일 목록을 불러오는데 실패했습니다.');
            }
        });
    },

    downloadAttachment: function(attachmentId, filename) {
        var url = this.contextPath + '/download/' + attachmentId;

        fetch(url)
            .then(response => response.blob())
            .then(blob => {
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = filename;
                link.click();
            })
            .catch(error => {
                console.error('파일 다운로드 중 오류 발생:', error);
                alert('파일 다운로드에 실패했습니다.');
            });
    }
};

// DOM이 로드된 후 실행
$(document).ready(function() {
    var contextPath = '/email';
    EmailCommon.init(contextPath);
    $('#writeBtn').click(function(e) {
        e.preventDefault();
        EmailCommon.showWriteForm();
    });

    $('#write-selfBtn').click(function(e) {
        e.preventDefault();
        EmailCommon.showSelfWriteForm();
    });
});