$(document).ready(function() {
    // 초기 로드
    loadMailbox('inbox');

    // 메일함 클릭 이벤트
    $('.list-group-item').click(function() {
        $('.list-group-item').removeClass('active');
        $(this).addClass('active');
        var mailbox = $(this).data('mailbox');
        loadMailbox(mailbox);
    });

    // 메일 쓰기 버튼 클릭 이벤트
    $('#composeBtn').click(function() {
        // 메일 쓰기 폼을 로드하거나 모달을 열기
        loadComposeForm();
    });

    // 전체 선택 체크박스 이벤트
    $(document).on('change', '#select-all', function() {
        $('.mail-item-checkbox').prop('checked', $(this).prop('checked'));
    });

    // 개별 메일 체크박스 이벤트
    $(document).on('change', '.mail-item-checkbox', function() {
        var allChecked = $('.mail-item-checkbox:checked').length === $('.mail-item-checkbox').length;
        $('#select-all').prop('checked', allChecked);
    });

    // 삭제 버튼 클릭 이벤트
    $(document).on('click', '.btn-outline-danger', function() {
        deleteSelectedMails();
    });

    // 메일 검색 이벤트
    $(document).on('input', '.form-control[placeholder="메일 검색"]', function() {
        searchMails($(this).val());
    });
});

function loadMailbox(mailbox) {
    $.ajax({
        url: '${path}/email/' + mailbox + '.jsp',
        method: 'GET',
        success: function(response) {
            $('#mailContent').html(response);
            loadMailItems(mailbox);
        },
        error: function() {
            alert('메일함을 로드하는 데 실패했습니다.');
        }
    });
}

function loadMailItems(mailbox) {
    // 서버에서 메일 목록을 가져와 표시하는 AJAX 요청
    $.ajax({
        url: '${path}/api/mails/' + mailbox,
        method: 'GET',
        success: function(mails) {
            var mailList = '';
            mails.forEach(function(mail) {
                mailList += '<tr>' +
                    '<td><input type="checkbox" class="mail-item-checkbox" value="' + mail.id + '"></td>' +
                    '<td>' + (mailbox === 'sent' ? mail.to : mail.from) + '</td>' +
                    '<td>' + mail.subject + '</td>' +
                    '<td>' + mail.date + '</td>' +
                    '</tr>';
            });
            $('#mailItems').html(mailList);
        },
        error: function() {
            alert('메일 목록을 불러오는 데 실패했습니다.');
        }
    });
}

function loadComposeForm() {
    // 메일 쓰기 폼을 로드하거나 모달을 여는 로직
    $.ajax({
        url: '${path}/email/compose.jsp',
        method: 'GET',
        success: function(response) {
            $('#mailContent').html(response);
        },
        error: function() {
            alert('메일 쓰기 폼을 로드하는 데 실패했습니다.');
        }
    });
}

function deleteSelectedMails() {
    var selectedMails = $('.mail-item-checkbox:checked').map(function() {
        return $(this).val();
    }).get();

    if (selectedMails.length === 0) {
        alert('삭제할 메일을 선택해주세요.');
        return;
    }

    // 서버에 선택된 메일 삭제 요청
    $.ajax({
        url: '${path}/api/mails/delete',
        method: 'POST',
        data: JSON.stringify(selectedMails),
        contentType: 'application/json',
        success: function(response) {
            alert('선택한 메일이 삭제되었습니다.');
            loadMailbox($('.list-group-item.active').data('mailbox'));
        },
        error: function() {
            alert('메일 삭제에 실패했습니다.');
        }
    });
}

function searchMails(query) {
    var currentMailbox = $('.list-group-item.active').data('mailbox');

    $.ajax({
        url: '${path}/api/mails/search',
        method: 'GET',
        data: {
            mailbox: currentMailbox,
            query: query
        },
        success: function(mails) {
            var mailList = '';
            mails.forEach(function(mail) {
                mailList += '<tr>' +
                    '<td><input type="checkbox" class="mail-item-checkbox" value="' + mail.id + '"></td>' +
                    '<td>' + (currentMailbox === 'sent' ? mail.to : mail.from) + '</td>' +
                    '<td>' + mail.subject + '</td>' +
                    '<td>' + mail.date + '</td>' +
                    '</tr>';
            });
            $('#mailItems').html(mailList);
        },
        error: function() {
            alert('메일 검색에 실패했습니다.');
        }
    });
}

function loadPage(page) {
    var currentMailbox = $('.list-group-item.active').data('mailbox');

    $.ajax({
        url: '${path}/api/mails/' + currentMailbox,
        method: 'GET',
        data: { page: page },
        success: function(response) {
            // 메일 목록 업데이트
            var mailList = '';
            response.mails.forEach(function(mail) {
                mailList += '<tr>' +
                    '<td><input type="checkbox" class="mail-item-checkbox" value="' + mail.id + '"></td>' +
                    '<td>' + (currentMailbox === 'sent' ? mail.to : mail.from) + '</td>' +
                    '<td>' + mail.subject + '</td>' +
                    '<td>' + mail.date + '</td>' +
                    '</tr>';
            });
            $('#mailItems').html(mailList);

            // 페이지네이션 업데이트
            updatePagination(response.currentPage, response.totalPages);
        },
        error: function() {
            alert('페이지를 로드하는 데 실패했습니다.');
        }
    });
}

function updatePagination(currentPage, totalPages) {
    var paginationHtml = '';
    var maxPages = 5; // 한 번에 표시할 최대 페이지 수

    paginationHtml += '<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '">' +
        '<a class="page-link" href="#" data-page="' + (currentPage - 1) + '"><i class="fas fa-chevron-left"></i></a></li>';

    var startPage = Math.max(1, currentPage - Math.floor(maxPages / 2));
    var endPage = Math.min(totalPages, startPage + maxPages - 1);

    for (var i = startPage; i <= endPage; i++) {
        paginationHtml += '<li class="page-item ' + (i === currentPage ? 'active' : '') + '">' +
            '<a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
    }

    paginationHtml += '<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '">' +
        '<a class="page-link" href="#" data-page="' + (currentPage + 1) + '"><i class="fas fa-chevron-right"></i></a></li>';

    $('.pagination').html(paginationHtml);

    // 페이지 클릭 이벤트 핸들러
    $('.pagination .page-link').click(function(e) {
        e.preventDefault();
        var page = $(this).data('page');
        loadPage(page);
    });
}

// 메일 읽기 기능
$(document).on('click', '#mailItems tr', function() {
    var mailId = $(this).find('.mail-item-checkbox').val();
    loadMailContent(mailId);
});

function loadMailContent(mailId) {
    $.ajax({
        url: '${path}/api/mails/' + mailId,
        method: 'GET',
        success: function(mail) {
            var mailContent = '<div class="mail-detail">' +
                '<h2>' + mail.subject + '</h2>' +
                '<p><strong>From:</strong> ' + mail.from + '</p>' +
                '<p><strong>To:</strong> ' + mail.to + '</p>' +
                '<p><strong>Date:</strong> ' + mail.date + '</p>' +
                '<hr>' +
                '<div class="mail-body">' + mail.body + '</div>' +
                '</div>';
            $('#mailContent').html(mailContent);
        },
        error: function() {
            alert('메일 내용을 불러오는 데 실패했습니다.');
        }
    });
}

// 초기화 함수 호출
$(document).ready(function() {
    loadMailbox('inbox');
});