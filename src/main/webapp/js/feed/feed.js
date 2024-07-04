let page = 1;
const size = 10;
let loading = false;
let hasMore = true;

function loadPosts() {
    if (loading || !hasMore) return;
    loading = true;

    $.ajax({
        url: '${pageContext.request.contextPath}/community/getPosts',
        method: 'GET',
        data: { page: page, size: size },
        success: function(response) {
            $('#feed-container').append(response);
            loading = false;
            page++;
            if (!$(response).find('.post').length) {
                hasMore = false;
            }
        },
        error: function(xhr, status, error) {
            console.error("Error loading posts:", error);
            loading = false;
        }
    });
}

function likePost(feedNo) {
    console.log('좋아요: ' + feedNo);
}

function showComments(feedNo) {
    console.log('댓글 표시: ' + feedNo);
}

$(window).scroll(function() {
    if($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
        loadPosts();
    }
});

// 초기 로드
$(document).ready(function() {
    loadPosts();
});