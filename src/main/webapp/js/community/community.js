$(document).ready(function() {
    // 모달 관련 변수
    var modal = $("#createCommunityModal");
    var btn = $("#addGroupBtn");
    var closeBtn = $("#close-btn");

    // 모달 열기
    btn.click(function() {
        modal.css("display", "block");
    });

    // 모달 닫기 (취소 버튼)
    closeBtn.click(function() {
        modal.css("display", "none");
    });

    // 모달 닫기 (모달 바깥 영역 클릭)
    $(window).click(function(event) {
        if (event.target == modal[0]) {
            modal.css("display", "none");
        }
    });

    // 커뮤니티 생성 폼 제출
    $("#createCommunityForm").submit(function(e) {
        e.preventDefault();

        var formData = {
            communityTitle: $("#communityTitle").val(),
            communityIntroduce: $("#communityIntroduce").val(),
            communityIsOpen: $("input[name='communityIsOpen']:checked").val()
        };

        $.ajax({
            url: '/community/insert',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                if(response.success) {
                    alert("커뮤니티가 성공적으로 생성되었습니다.");
                    modal.css("display", "none");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert("커뮤니티 생성에 실패했습니다: " + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert("오류가 발생했습니다. 다시 시도해주세요.");
                console.error(error);
            }
        });
    });

    // 북마크 토글
    $(".star").click(function(e) {
        e.stopPropagation(); // 이벤트 버블링 방지
        var communityNo = $(this).data('community-no');

        $.ajax({
            url: '/community/toggleBookmark',
            type: 'POST',
            data: { communityNo: communityNo },
            success: function(response) {
                if(response.success) {
                    location.reload(); // 페이지 새로고침
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert('북마크 변경 중 오류가 발생했습니다.');
            }
        });
    });

    // 커뮤니티 클릭 이벤트 (피드 페이지로 이동)
    $(".group").click(function(e) {
        if (!$(e.target).hasClass('star')) {
            var communityNo = $(this).data('community-no');
            window.location.href = '/community/feed?communityNo=' + communityNo;
        }
    });
});