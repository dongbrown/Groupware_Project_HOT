// 피드 제출
function submitFeed() {
    if (!communityNo) {
        alert('커뮤니티를 선택해주세요.');
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
                alert(response.message);
                $('#feedContent').val('');
                $('#file-upload').val('');
                loadLatestFeed();
            } else {
                alert(response.message);
            }
        },
        error: function(xhr, status, error) {
            alert('피드 작성 중 오류가 발생했습니다.');
        }
    });
}

function loadLatestFeed() {
    if (!communityNo) {
        console.error('커뮤니티 번호가 설정되지 않았습니다.');
        return;
    }

    $.ajax({
        url: '/community/feed/',
        method: 'GET',
        data: { communityNo: communityNo },
        success: function(response) {
            if (response && response.length > 0) {
                const latestFeed = response[0];
                const feedHtml = createFeedHtml(latestFeed);
                $('#feed-container').prepend(feedHtml);
            }
        },
        error: function(xhr, status, error) {
            console.error('최신 피드 로딩 중 오류 발생:', error);
        }
    });
}
// 피드 HTML 생성
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

// 피드 수정
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
                alert(response.message);
                feedElement.find('p').text(updatedContent);
            } else {
                alert(response.message);
            }
        },
        error: function(xhr, status, error) {
            alert('피드 수정 중 오류가 발생했습니다.');
        }
    });
}

// 피드 삭제
function deleteFeed(feedNo) {
    if (!confirm('정말로 이 피드를 삭제하시겠습니까?')) return;

    $.ajax({
        url: '/community/feed/delete',
        method: 'DELETE',
        contentType: 'application/json',
        data: JSON.stringify({ feedNo: feedNo }),
        success: function(response) {
            if (response.success) {
                alert(response.message);
                $(`#feed-${feedNo}`).remove();
            } else {
                alert(response.message);
            }
        },
        error: function(xhr, status, error) {
            alert('피드 삭제 중 오류가 발생했습니다.');
        }
    });
}

// 참석자 추가 함수 (구현 필요)
function showAddParticipant() {
    // 참석자 추가 로직 구현
    alert('참석자 추가 기능은 아직 구현되지 않았습니다.');
}

// 페이지 로드 시 실행
$(document).ready(function() {
    // 필요한 초기화 로직
});