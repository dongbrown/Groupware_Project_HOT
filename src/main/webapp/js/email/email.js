// email.js
$(document).ready(function() {
    const sampleMails = [
        { id: 1, sender: '김동훈', subject: 'FW: 김동훈님 아이엠사진관입니다.', date: '06.29 16:39', isRead: false, hasAttachment: true },
        { id: 2, sender: '김동훈', subject: '실습과제', date: '02.16 23:34', isRead: true, hasAttachment: false },
        { id: 3, sender: '김동훈', subject: '1~3.zip', date: '02.15 17:19', isRead: true, hasAttachment: true },
        { id: 4, sender: '김동훈', subject: '02_연산자.zip', date: '02.15 17:19', isRead: false, hasAttachment: true },
        { id: 5, sender: '김동훈', subject: 'CSS.txt', date: '02.08 16:44', isRead: true, hasAttachment: false }
    ];

    function renderMails() {
        const $mailItems = $('#mailItems');
        $mailItems.empty();
        sampleMails.forEach(mail => {
            $mailItems.append(`
                <tr class="${mail.isRead ? '' : 'fw-bold'}">
                    <td>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="${mail.id}">
                        </div>
                    </td>
                    <td>
                        <i class="fas ${mail.isRead ? 'fa-envelope-open' : 'fa-envelope'} me-2"></i>
                        ${mail.sender}
                    </td>
                    <td>
                        ${mail.subject}
                        ${mail.hasAttachment ? '<i class="fas fa-paperclip ms-2"></i>' : ''}
                    </td>
                    <td>${mail.date}</td>
                </tr>
            `);
        });
    }

    renderMails();

    // 전체 선택 체크박스 기능
    $('#select-all').change(function() {
        const isChecked = $(this).prop('checked');
        $('.form-check-input').prop('checked', isChecked);
    });

    // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
    $(document).on('change', '.form-check-input', function() {
        const allChecked = $('.form-check-input:not(#select-all)').length === $('.form-check-input:checked:not(#select-all)').length;
        $('#select-all').prop('checked', allChecked);
    });

    // 메일 쓰기 버튼 클릭 이벤트
    $('.btn-primary').click(function() {
        alert('메일 쓰기 기능은 아직 구현되지 않았습니다.');
    });

    // 툴바 버튼 클릭 이벤트
    $('.toolbar .btn').click(function() {
        const action = $(this).find('i').attr('class').split(' ')[1];
        switch(action) {
            case 'fa-trash':
                alert('선택한 메일을 삭제합니다.');
                break;
            case 'fa-reply':
                alert('선택한 메일에 답장합니다.');
                break;
            case 'fa-share':
                alert('선택한 메일을 전달합니다.');
                break;
            case 'fa-cog':
                alert('메일 설정을 엽니다.');
                break;
        }
    });

    // 검색 기능
    $('input[placeholder="메일 검색"]').on('input', function() {
        const searchTerm = $(this).val().toLowerCase();
        const filteredMails = sampleMails.filter(mail =>
            mail.subject.toLowerCase().includes(searchTerm) ||
            mail.sender.toLowerCase().includes(searchTerm)
        );
        renderFilteredMails(filteredMails);
    });

    function renderFilteredMails(mails) {
        const $mailItems = $('#mailItems');
        $mailItems.empty();
        mails.forEach(mail => {
            // 위의 renderMails 함수와 동일한 로직으로 메일 항목을 렌더링
        });
    }

    // 페이지네이션 기능
    $('.pagination .page-link').click(function(e) {
        e.preventDefault();
        const page = $(this).text();
        alert(`${page} 페이지로 이동합니다.`);
        // 실제 페이지네이션 로직 구현 필요
    });
});