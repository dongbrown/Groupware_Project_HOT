// path 변수를 전역 범위에서 정의
var path = $('meta[name=contextPath]').attr("content");

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
            url: path + '/community/insert',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function(response) {
                if(response.success) {
                    alert("커뮤니티가 성공적으로 생성되었습니다.");
                    modal.css("display", "none");
                    location.reload();
                } else {
                    alert("커뮤니티 생성에 실패했습니다: " + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert("오류 발생");
                console.error(error);
            }
        });
    });

    // 즐겨찾기 토글 (이벤트 위임 사용)
    $(document).on('click', '.star', function(e) {
        e.stopPropagation(); // 이벤트 버블링 방지
        var $star = $(this);
        var communityNo = $star.data('community-no');
        var $community = $star.closest('.group');
        var isInBookmarkedSection = $community.parent().attr('id') === 'bookmarkedCommunities';

        $.ajax({
            url: path + '/community/toggleBookmark',
            type: 'POST',
            data: { communityNo: communityNo },
            success: function(response) {
                if(response.success) {
                    updateBookmarkStatus(communityNo, response.bookmarked, isInBookmarkedSection);
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert('북마크 변경 중 오류가 발생했습니다.');
            }
        });
    });

    // 북마크 상태 업데이트 함수
    function updateBookmarkStatus(communityNo, isBookmarked, isInBookmarkedSection) {
        var $bookmarkedSection = $('#bookmarkedCommunities');
        var $myCommunitySection = $('.group-container').not('#bookmarkedCommunities');

        var $communityInBookmarked = $bookmarkedSection.find('.group[data-community-no="' + communityNo + '"]');
        var $communityInMyCommunity = $myCommunitySection.find('.group[data-community-no="' + communityNo + '"]');

        if (isBookmarked) {
            // 즐겨찾기에 추가
            if ($communityInBookmarked.length === 0) {
                var $clonedCommunity = $communityInMyCommunity.clone(true);
                $clonedCommunity.find('.star').addClass('active').text('★');
                $bookmarkedSection.append($clonedCommunity);
            }
            $communityInMyCommunity.find('.star').addClass('active').text('★');
        } else {
            // 즐겨찾기에서 제거
            $communityInBookmarked.remove();
            $communityInMyCommunity.find('.star').removeClass('active').text('☆');

            // 즐겨찾는 커뮤니티 섹션에서 즐겨찾기 해제한 경우
            if (isInBookmarkedSection) {
                $communityInBookmarked.fadeOut(300, function() {
                    $(this).remove();
                    updateBookmarkedSectionStatus();
                });
            }
        }

        // 즐겨찾기 섹션 상태 업데이트
        updateBookmarkedSectionStatus();
    }

    // 즐겨찾기 섹션 상태 업데이트 함수
    function updateBookmarkedSectionStatus() {
        var $bookmarkedSection = $('#bookmarkedCommunities');
        if ($bookmarkedSection.children('.group').length === 0) {
            if ($bookmarkedSection.find('p').length === 0) {
                $bookmarkedSection.append('<p>즐겨찾는 커뮤니티가 없습니다.</p>');
            }
        } else {
            $bookmarkedSection.find('> p').remove();
        }
    }

    // 커뮤니티 클릭 이벤트 (피드 페이지로 이동)
    $(document).on('click', '.group', function(e) {
        if (!$(e.target).hasClass('star')) {
            var communityNo = $(this).data('community-no');
            window.location.href = path + '/community/feed?communityNo=' + communityNo;
        }
    });

    // 페이지 로드 시 즐겨찾기 상태 초기화
    function initializeBookmarkStatus() {
        $('.star').each(function() {
            var $star = $(this);
            var isBookmarked = $star.hasClass('active');
            $star.text(isBookmarked ? '★' : '☆');
        });

        // 즐겨찾기 섹션 상태 업데이트
        updateBookmarkedSectionStatus();
    }

    // 페이지 로드 시 초기화 함수 호출
    initializeBookmarkStatus();
});