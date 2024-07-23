var EmailCommon = {
    contextPath: '',
    files: [], // 첨부 파일을 저장할 배열

    init: function(contextPath) {
        this.contextPath = contextPath;
        this.bindEvents();
        this.loadMailbox('inbox');
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

        // 메일 전송 폼 제출 이벤트
        $(document).on('submit', '#emailForm', function(e) {
            e.preventDefault();
            EmailCommon.sendEmail();
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

    sendEmail: function() {
        var formData = new FormData($('#emailForm')[0]);

        // 디버깅을 위한 로그 추가
        console.log("Form Data:", $('#emailForm').serialize());
        console.log("Receivers:", $('#receivers').val());
        console.log("Email Title:", $('#emailTitle').val());

        // 이메일 제목 추가 (수정)
        formData.append('emailTitle', $('#emailTitle').val());

        // Summernote 에디터의 내용을 추가
        formData.append('emailContent', $('#summernote').summernote('code'));

        // 수신자 정보 추가
        formData.append('receivers', $('#receivers').val());

        // FormData 내용 확인을 위한 로그
        for (var pair of formData.entries()) {
            console.log(pair[0] + ': ' + pair[1]);
        }

        // 첨부 파일 추가
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
                console.error("Email send error:", xhr.responseText);
                alert('메일 전송에 실패했습니다. 오류: ' + error);
            }
        });
	}
};

// 페이지 로드 시 초기화
$(document).ready(function() {
    EmailCommon.init('/email');
});