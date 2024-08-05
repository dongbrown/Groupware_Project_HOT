$(document).ready(function() {
    // 가입 버튼 클릭 이벤트
    $(document).on('click', '.join-btn', function() {
        var communityId = $(this).data('community-id');
        var isPrivate = $(this).data('is-private');
        var $button = $(this);

        // AJAX 요청을 통해 가입 처리
        $.ajax({
            url: path + '/community/join',
            type: 'POST',
            data: { communityNo: communityId },
            success: function(response) {
                if(response.success) {
                    if (isPrivate === true) {
                        alert('가입 신청이 완료되었습니다. 관리자의 승인을 기다려주세요.');
                        $button.prop('disabled', true).text('신청중');
                    } else {
                        alert('커뮤니티에 가입되었습니다.');
                        // 해당 커뮤니티의 피드 페이지로 이동
                        window.location.href = path + '/community/feed?communityNo=' + communityId;
                    }
                } else {
                    alert('가입에 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('가입 처리 중 오류가 발생했습니다.');
            }
        });
    });

    // 기타 필요한 이벤트 리스너나 함수들을 여기에 추가할 수 있습니다.
});

