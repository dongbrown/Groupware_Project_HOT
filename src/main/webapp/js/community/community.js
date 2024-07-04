// community.js

$(document).ready(function() {
    // 모달 관련 변수
    var modal = $("#createCommunityModal");
    var btn = $("#addGroupBtn");
    var span = $(".close");

    // 모달 열기
    btn.click(function() {
        modal.css("display", "block");
    });

    // 모달 닫기 (x 버튼)
    span.click(function() {
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
            url: '/api/community/insert',
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

    // 즐겨찾기 토글
    $(".star").click(function(e) {
        e.stopPropagation(); // 이벤트 버블링 방지
        var groupId = $(this).closest('.group').data('id');
        var isFavorite = $(this).text() === "★";

        $.ajax({
            url: '/api/community/toggleFavorite',
            type: 'POST',
            data: {
                groupId: groupId,
                isFavorite: !isFavorite
            },
            success: function(response) {
                if(response.success) {
                    if(isFavorite) {
                        $(e.target).text("☆");
                    } else {
                        $(e.target).text("★");
                    }
                } else {
                    alert("즐겨찾기 설정에 실패했습니다.");
                }
            },
            error: function(xhr, status, error) {
                alert("오류가 발생했습니다. 다시 시도해주세요.");
                console.error(error);
            }
        });
    });

    // 그룹 클릭 이벤트 (그룹 상세 페이지로 이동)
    $(".group").click(function() {
        var groupId = $(this).data('id');
        window.location.href = '/community/detail/' + groupId;
    });
});