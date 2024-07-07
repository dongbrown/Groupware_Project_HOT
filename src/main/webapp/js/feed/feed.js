$(document).ready(function() {
    // 페이지 로드 시 피드 목록 불러오기
    loadFeeds();

    // 피드 작성 폼 제출 이벤트
    $("#feedForm").submit(function(e) {
        e.preventDefault();
        submitFeed();
    });
});

function loadFeeds() {
    const communityNo = $("#feed-container").data("community-no");
    $.ajax({
        url: '/community/feed/list',
        method: 'GET',
        data: { communityNo: communityNo },
        success: function(response) {
            if (response.success) {
                displayFeeds(response.feeds);
            } else {
                alert('피드를 불러오는 데 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 불러오기 오류:', error);
            alert('피드를 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function displayFeeds(feeds) {
    const container = $("#feed-container");
    container.empty();
    feeds.forEach(feed => {
        container.append(createFeedHtml(feed));
    });
}

function createFeedHtml(feed) {
    return `
        <div class="feed-item" id="feed-${feed.feedNo}">
            <h5>${feed.employeeName}</h5>
            <p>${feed.feedContent}</p>
            <small class="text-muted">${feed.feedEnrollDate}</small>
            <div class="feed-actions">
                <button class="btn btn-sm btn-outline-primary" onclick="updateFeed(${feed.feedNo})">수정</button>
                <button class="btn btn-sm btn-outline-danger" onclick="deleteFeed(${feed.feedNo})">삭제</button>
            </div>
        </div>
    `;
}

function submitFeed() {
    const communityNo = $("#feed-container").data("community-no");
    const feedContent = $("#feedContent").val().trim();
    const fileInput = $("#file-upload")[0];
    const file = fileInput.files[0];

    if (!feedContent) {
        alert('피드 내용을 입력해주세요.');
        return;
    }

    const formData = new FormData();
    formData.append('feedContent', feedContent);
    formData.append('communityNo', communityNo);
    if (file) {
        formData.append('file', file);
    }

    $.ajax({
        url: '/community/feed/insert',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            if (response.success) {
                alert('피드가 성공적으로 작성되었습니다.');
                $("#feedContent").val('');
                fileInput.value = '';
                loadFeeds();  // 피드 목록 새로고침
            } else {
                alert('피드 작성에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 작성 오류:', error);
            alert('피드 작성 중 오류가 발생했습니다.');
        }
    });
}

function updateFeed(feedNo) {
    const feedElement = $(`#feed-${feedNo}`);
    const currentContent = feedElement.find('p').text();
    const updatedContent = prompt('수정할 내용을 입력하세요:', currentContent);

    if (updatedContent === null) return; // 사용자가 취소한 경우
    if (updatedContent.trim() === '') {
        alert('피드 내용을 입력해주세요.');
        return;
    }

    $.ajax({
        url: '/community/feed/update',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({ feedNo: feedNo, feedContent: updatedContent }),
        success: function(response) {
            if (response.success) {
                alert('피드가 성공적으로 수정되었습니다.');
                feedElement.find('p').text(updatedContent);
            } else {
                alert('피드 수정에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 수정 오류:', error);
            alert('피드 수정 중 오류가 발생했습니다.');
        }
    });
}

function deleteFeed(feedNo) {
    if (!confirm('정말로 이 피드를 삭제하시겠습니까?')) return;

    $.ajax({
        url: '/community/feed/delete',
        method: 'DELETE',
        contentType: 'application/json',
        data: JSON.stringify({ feedNo: feedNo }),
        success: function(response) {
            if (response.success) {
                alert('피드가 성공적으로 삭제되었습니다.');
                $(`#feed-${feedNo}`).remove();
            } else {
                alert('피드 삭제에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('피드 삭제 오류:', error);
            alert('피드 삭제 중 오류가 발생했습니다.');
        }
    });
}

function showAddParticipant() {
    // 참석자 추가 로직 구현
    alert('참석자 추가 기능은 아직 구현되지 않았습니다.');
}