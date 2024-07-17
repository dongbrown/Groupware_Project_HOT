$(document).ready(function() {
    $('.join-btn').click(function() {
        var communityId = $(this).data('community-id');
        // AJAX 요청을 통해 가입 처리
        $.ajax({
            url: '/community/join',
            type: 'POST',
            data: { communityNo: communityId },
            success: function(response) {
                if(response.success) {
                    alert('커뮤니티에 가입되었습니다.');
                    location.reload();
                } else {
                    alert('가입에 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('가입 처리 중 오류가 발생했습니다.');
            }
        });
    });
});