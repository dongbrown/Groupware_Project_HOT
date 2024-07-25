var EmailCommon = {
    contextPath: '',
    files: [], // 첨부 파일을 저장할 배열

    init: function(contextPath) {
        this.contextPath = contextPath;
        this.bindEvents();
        this.loadMailbox('inbox');
        this.initReceiverAutocomplete();
    },

    bindEvents: function() {
        // 메일함 선택 이벤트
        $(document).on('click', '.list-group-item', function(e) {
            e.preventDefault();
            $('.list-group-item').removeClass('active');
            $(this).addClass('active');
            var mailbox = $(this).data('mailbox');
            EmailCommon.loadMailbox(mailbox);
        });

        // 메일 작성 버튼 클릭 이벤트
        $(document).on('click', '#writeBtn', function(e) {
            e.preventDefault();
            EmailCommon.showWriteForm();
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

            EmailCommon.moveEmailsToTrash(selectedEmails, function() {
                EmailCommon.loadMailbox('inbox');
            });
        });

        // 검색 버튼 클릭 이벤트
        $(document).on('click', '#searchBtn', function() {
            var keyword = $('#searchInput').val();
            if (keyword.trim() === '') {
                alert('검색어를 입력하세요.');
                return;
            }
            EmailCommon.searchEmails(keyword);
        });

        // 메일 항목 클릭 이벤트 (체크박스 제외)
        $(document).on('click', '.email-item', function(e) {
            if (!$(e.target).is('input:checkbox')) {
                var emailNo = $(this).data('email-no');
                EmailCommon.viewEmail(emailNo);
            }
        });

        // 드래그 앤 드롭 이벤트
        $(document).on('dragover', '#dropZone', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).addClass('drag-over');
        });

        $(document).on('dragleave', '#dropZone', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).removeClass('drag-over');
        });

        $(document).on('drop', '#dropZone', function(e) {
            e.preventDefault();
            e.stopPropagation();
            $(this).removeClass('drag-over');
            EmailCommon.handleFiles(e.originalEvent.dataTransfer.files);
        });

        // 파일 선택 클릭 이벤트
        $(document).on('click', '#dropZone', function() {
            $('#fileInput').click();
        });

        $(document).on('change', '#fileInput', function() {
            EmailCommon.handleFiles(this.files);
        });

        // 파일 제거 이벤트
        $(document).on('click', '.remove-file', function() {
            var index = $(this).data('index');
            EmailCommon.files.splice(index, 1);
            EmailCommon.updateFileList();
        });

        // 메일 저장 폼 제출 이벤트
        $(document).on('submit', '#emailForm', function(e) {
            e.preventDefault();
            EmailCommon.saveEmail();
        });
    },

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

    moveEmailsToTrash: function(emailNos, callback) {
        if (!Array.isArray(emailNos)) {
            emailNos = [emailNos]; // 단일 이메일 ID를 배열로 변환
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
                EmailCommon.initSummernote();
            },
            error: function() {
                alert('메일 작성 폼을 불러오는데 실패했습니다.');
            }
        });
    },

    initSummernote: function() {
        $('#summernote').summernote({
            height: 800,
            lang: 'ko-KR',
            toolbar: [
                ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
                ['color', ['color']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['picture']]
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋음체', '바탕체'],
            fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72', '96'],
            focus: true,
            callbacks: {
                onImageUpload: function(files) {
                    for (var i = 0; i < files.length; i++) {
                        EmailCommon.uploadImage(files[i], this);
                    }
                }
            }
        });
    },

    uploadImage: function(file, editor) {
        var formData = new FormData();
        formData.append("file", file);
        $.ajax({
            data: formData,
            type: "POST",
            url: this.contextPath + "/upload-image",
            contentType: false,
            enctype: 'multipart/form-data',
            processData: false,
            success: function(url) {
                $(editor).summernote('insertImage', url);
            },
            error: function() {
                alert('이미지 업로드에 실패했습니다.');
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

    saveEmail: function() {
        var formData = new FormData($('#emailForm')[0]);

        console.log("Form Data:", $('#emailForm').serialize());
        console.log("Receivers:", $('#receivers').val());
        console.log("Email Title:", $('#emailTitle').val());

        formData.append('emailTitle', $('#emailTitle').val());
        formData.append('emailContent', $('#summernote').summernote('code'));
        formData.append('receivers', $('#receivers').val());

        this.files.forEach(function(file, index) {
            formData.append('attachments', file);
        });

        for (var pair of formData.entries()) {
            console.log(pair[0] + ': ' + pair[1]);
        }

        $.ajax({
            url: this.contextPath + '/send',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert('메일이 성공적으로 저장되었습니다.');
                EmailCommon.loadMailbox('sent');
            },
            error: function(xhr, status, error) {
                console.error("Email save error:", xhr.responseText);
                alert('메일 저장에 실패했습니다. 오류: ' + error);
            }
        });
    },

    initReceiverAutocomplete: function() {
        var $receivers = $('#receivers');
        var $receiversList = $('#receiversList');
        var debounceTimer;

        $receivers.on('input', function() {
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

        $(document).on('click', '.receiver-item', function() {
            var email = $(this).data('email');
            var currentReceivers = $receivers.val();
            var newReceivers = currentReceivers ? currentReceivers + ', ' + email : email;
            $receivers.val(newReceivers);
            $receiversList.empty().hide();
        });

        $receivers.on('change', function() {
            var emails = $(this).val().split(',').map(function(email) {
                return email.trim();
            });

            var $selectedReceivers = $('#selectedReceivers');
            $selectedReceivers.empty();

            emails.forEach(function(email) {
                if (email) {
                    var $tag = $('<span class="selected-receiver"></span>')
                        .text(email)
                        .append('<span class="remove-receiver">×</span>');
                    $selectedReceivers.append($tag);
                }
            });
        });

        $(document).on('click', '.remove-receiver', function() {
            var removedEmail = $(this).parent().text().slice(0, -1);
            var currentEmails = $receivers.val().split(',').map(function(email) {
                return email.trim();
            });
            var updatedEmails = currentEmails.filter(function(email) {
                return email !== removedEmail;
            });
            $receivers.val(updatedEmails.join(', ')).trigger('change');
        });
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

        employees.forEach(function(employee) {
            var $item = $('<div class="receiver-item"></div>');
            var $nameEmail = $('<span class="name-email"></span>');
            $nameEmail.append('<span class="employee-name">' + employee.name + '</span>');
            $nameEmail.append('<span class="employee-email">' + employee.email + '</span>');
            $item.append($nameEmail);
            $item.data('email', employee.email);
            $receiversList.append($item);
        });

        $receiversList.show();
    },
};

// 페이지 로드 시 초기화
$(document).ready(function() {
    EmailCommon.init('/email');
});