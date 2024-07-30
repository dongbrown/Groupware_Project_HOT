var EmailCommon = {
    contextPath: '',
    files: [],
    initialized: false,

    // 초기화 함수
    init: function(contextPath) {
        if (this.initialized) return;
        this.initialized = true;

        this.contextPath = contextPath;
        this.bindEvents();
    },

    // 이벤트 바인딩
    bindEvents: function() {
        // 메일함 선택 이벤트
        $(document).off('click', '.list-group-item').on('click', '.list-group-item', function(e) {
            e.preventDefault();
            $('.list-group-item').removeClass('active');
            $(this).addClass('active');
            var mailbox = $(this).data('mailbox');
            EmailCommon.loadMailbox(mailbox);
        });

        // 메일 쓰기 버튼 이벤트
        $(document).off('click', '#writeBtn').on('click', '#writeBtn', function(e) {
            e.preventDefault();
            EmailCommon.showWriteForm();
        });

        // 내게 쓰기 버튼 이벤트
        $(document).off('click', '#write-selfBtn').on('click', '#write-selfBtn', function(e) {
            e.preventDefault();
            EmailCommon.showSelfWriteForm();
        });

        // 전체 선택 체크박스 이벤트
        $(document).off('change', '#select-all').on('change', '#select-all', function() {
            $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
        });

        // 개별 체크박스 이벤트
        $(document).off('change', '.mail-item-checkbox').on('change', '.mail-item-checkbox', function() {
            var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
            $('#select-all').prop('checked', allChecked);
        });

        // 삭제 버튼 이벤트
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

        // 검색 버튼 이벤트
        $(document).off('click', '#searchBtn').on('click', '#searchBtn', function() {
            var keyword = $('#searchInput').val();
            if (keyword.trim() === '') {
                alert('검색어를 입력하세요.');
                return;
            }
            EmailCommon.searchEmails(keyword);
        });

        // 검색 입력창 엔터 키 이벤트
        $(document).off('keypress', '#searchInput').on('keypress', '#searchInput', function(e) {
            if (e.which == 13) {  // 엔터 키
                e.preventDefault();
                $('#searchBtn').click();
            }
        });

        // 이메일 항목 클릭 이벤트
        $(document).off('click', '.email-item').on('click', '.email-item', function(e) {
            if (!$(e.target).is('input:checkbox') && !$(e.target).is('.toggle-important')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.viewEmail(emailNo);
            }
        });

        // 파일 드래그 앤 드롭 이벤트
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

        // 파일 선택 이벤트
        $(document).off('click', '#dropZone').on('click', '#dropZone', function() {
            $('#fileInput').click();
        });

        $(document).off('change', '#fileInput').on('change', '#fileInput', function() {
            EmailCommon.handleFiles(this.files);
        });

        // 파일 삭제 이벤트
        $(document).off('click', '.remove-file').on('click', '.remove-file', function() {
            var index = $(this).data('index');
            EmailCommon.files.splice(index, 1);
            EmailCommon.updateFileList();
        });

        // 이메일 전송 이벤트
        $(document).off('submit', '#emailForm').on('submit', '#emailForm', function(e) {
            e.preventDefault();
            EmailCommon.saveEmail(false);
        });

        // 임시저장 버튼 이벤트
        $(document).off('click', '#saveDraftBtn').on('click', '#saveDraftBtn', function(e) {
            e.preventDefault();
            EmailCommon.saveEmail(true);
        });

        // 수신자 입력창 키보드 이벤트
        $(document).off('keydown', '#receivers').on('keydown', '#receivers', function(e) {
            var $receiversList = $('#receiversList');
            var $highlighted = $receiversList.find('.keyboard-selected');

            switch(e.which) {
                case 40: // 방향키 내리기
                    e.preventDefault();
                    EmailCommon.moveSelection($highlighted, 'down');
                    break;
                case 38: // 방향키 올리기
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

        // 중요 메일 토글 이벤트
        $(document).off('click', '.toggle-important').on('click', '.toggle-important', function(e) {
            e.preventDefault();
            e.stopPropagation();
            var emailNo = $(this).closest('.email-item').data('email-no');
            EmailCommon.toggleImportant(emailNo);
        });

        // 사이드바 메일함 링크 클릭 이벤트
        $(document).off('click', '.email-link').on('click', '.email-link', function(e) {
            e.preventDefault();
            var mailbox = $(this).data('mailbox');
            EmailCommon.loadMailbox(mailbox);
        });

        // 메일 쓰기 버튼 클릭 이벤트
        $(document).off('click', '#writeEmailBtn').on('click', '#writeEmailBtn', function(e) {
            e.preventDefault();
            EmailCommon.showWriteForm();
        });

        // 내게 쓰기 버튼 클릭 이벤트
        $(document).off('click', '#writeSelfEmailBtn').on('click', '#writeSelfEmailBtn', function(e) {
            e.preventDefault();
            EmailCommon.showWriteSelfForm();
        });
    },

    // 키보드 선택 이동 함수
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

    // 선택된 항목이 보이도록 스크롤 조정
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

    // 메일함 로드 함수
    loadMailbox: function(mailbox) {
        $.ajax({
            url: this.contextPath + '/' + mailbox,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions(mailbox);
            },
            error: function() {
                alert(mailbox + ' 메일함을 로드하는데 실패했습니다.');
            }
        });
    },

    // 메일함별 초기화 함수
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
        }
    },

    // 받은 메일함 초기화
    initInbox: function() {
        this.reattachEventListeners();
    },

    // 보낸 메일함 초기화
    initSent: function() {
        // 보낸 메일함 특정 초기화 로직
    },

    // 메일 쓰기 폼 초기화
    initWriteForm: function() {
        if ($('#summernote').length) {
            this.initSummernote();
        }
        if ($('#receivers').length) {
            this.initReceiverAutocomplete();
        }
    },

    // 휴지통으로 이동
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

    // 이메일 검색
    searchEmails: function(keyword) {
        $.ajax({
            url: this.contextPath + '/search',
            type: 'GET',
            data: { keyword: keyword },
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.reattachEventListeners();

                // 검색 결과 개수 표시 (옵션)
                var resultCount = $('#emailList tr').length;
                $('.search-result-count').text('검색 결과: ' + resultCount + '개');
            },
            error: function(xhr, status, error) {
                console.error('이메일 검색에 실패했습니다:', error);
                alert('이메일 검색에 실패했습니다.');
            }
        });
    },

    // 이메일 보기
    viewEmail: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/view/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.markEmailAsRead(emailNo);
            },
            error: function() {
                alert('이메일을 불러오는데 실패했습니다.');
            }
        });
    },

    // 메일 쓰기 폼 표시
    showWriteForm: function() {
        $.ajax({
            url: this.contextPath + '/write',
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('write');
            },
            error: function() {
                alert('메일 작성 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    // 내게 쓰기 폼 표시
    showSelfWriteForm: function() {
        $.ajax({
            url: this.contextPath + '/write-self',
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('write-self');
            },
            error: function() {
                alert('메일 작성 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    // Summernote 에디터 초기화
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
            ]
        });
    },

    // 파일 처리
    handleFiles: function(newFiles) {
        for (var i = 0; i < newFiles.length; i++) {
            if (!this.files.some(f => f.name === newFiles[i].name)) {
                this.files.push(newFiles[i]);
            }
        }
        this.updateFileList();
    },

// 파일 목록 업데이트
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

    // 이메일 저장 (전송 또는 임시저장)
    saveEmail: function(isDraft) {
        var formData = new FormData($('#emailForm')[0]);

         // 수신자 정보가 전달되지 않았다면 폼에서 가져옴 (내게쓰기는 전달 / 메일쓰기는 폼에서)
		 if (!receivers) {
		   receivers = $('#receivers').val();
		 }
		 formData.set('receivers', receivers);

        var emailTitle = $('#emailTitle').val().trim();
        formData.set('emailTitle', emailTitle);

        formData.set('emailContent', $('#summernote').summernote('code'));

        var receivers = this.getSelectedReceivers();
        formData.set('receivers', receivers.join(','));

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
                    EmailCommon.loadMailbox('drafts');
                } else {
                    alert('메일이 성공적으로 전송되었습니다.');
                    EmailCommon.loadMailbox('sent');
                }
            },
            error: function(xhr, status, error) {
                console.error("Email save error:", xhr.responseText);
                alert((isDraft ? '임시저장' : '메일 전송') + '에 실패했습니다. 오류: ' + error);
            }
        });
    },

    // 수신자 자동완성 초기화
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

    // 선택된 수신자 추가
    addSelectedReceiver: function(email, name) {
        var $selectedReceivers = $('#selectedReceivers');
        var $tag = $('<span class="selected-receiver"></span>')
            .text(name + ' <' + email + '>')
            .append('<span class="remove-receiver">×</span>')
            .data('email', email);
        $selectedReceivers.append($tag);
    },

    // 선택된 수신자 목록 가져오기
    getSelectedReceivers: function() {
        return $('#selectedReceivers .selected-receiver').map(function() {
            return $(this).data('email');
        }).get();
    },

    // 직원 검색
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

    // 직원 목록 표시
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

    // 이메일을 읽음으로 표시
    markEmailAsRead: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/mark-as-read/' + emailNo,
            type: 'POST',
            success: function(response) {
                console.log('이메일을 읽음으로 표시했습니다.');
                EmailCommon.updateUnreadCount();
            },
            error: function(xhr, status, error) {
                console.error('이메일 읽음 표시 실패:', error);
            }
        });
    },

    // 중요 메일 토글
    toggleImportant: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/toggle-important/' + emailNo,
            type: 'POST',
            success: function(response) {
                EmailCommon.loadMailbox('inbox'); // 메일함 새로고침
            },
            error: function(xhr, status, error) {
                console.error('중요 표시 변경 실패:', error);
            }
        });
    },

    // 답장 폼 표시
    replyEmail: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/reply/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('write');
            },
            error: function() {
                alert('답장 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    // 전달 폼 표시
    forwardEmail: function(emailNo) {
        $.ajax({
            url: this.contextPath + '/forward/' + emailNo,
            type: 'GET',
            success: function(response) {
                $('#mailContent').html(response);
                EmailCommon.initializeMailboxFunctions('write');
            },
            error: function() {
                alert('전달 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    // 읽지 않은 메일 수 업데이트
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
    },

    // 임시저장 메일함 로드
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

    // 임시저장 메일 편집
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

    // 이벤트 리스너 재연결
    reattachEventListeners: function() {
        $('.email-item').off('click').on('click', function(e) {
            if (!$(e.target).is('input:checkbox') && !$(e.target).is('.toggle-important')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.viewEmail(emailNo);
            }
        });

        $('.toggle-important').off('click').on('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            var emailNo = $(this).closest('.email-item').data('email-no');
            EmailCommon.toggleImportant(emailNo);
        });

        $('.mail-item-checkbox').off('change').on('change', function() {
            var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
            $('#select-all').prop('checked', allChecked);
        });

        $('#select-all').off('change').on('change', function() {
            $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
        });
    },

    // 휴지통 메일을 읽음으로 표시
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

    // 메일 영구 삭제
    deletePermanently: function(emailNos) {
        if (confirm("선택한 " + emailNos.length + "개의 이메일을 영구적으로 삭제하시겠습니까?")) {
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
        }
    },

    // 첨부파일 다운로드
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
    },

    // 이메일 첨부파일 목록 로드
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
    }
};

// DOM이 로드된 후 실행
$(document).ready(function() {
    var contextPath = '/email';
    EmailCommon.init(contextPath);

    // 페이지 로드 시 읽지 않은 메일 수 업데이트
    EmailCommon.updateUnreadCount();

    // 주기적으로 읽지 않은 메일 수 업데이트 (1분마다)
    setInterval(function() {
        EmailCommon.updateUnreadCount();
    }, 60000);
});