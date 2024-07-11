$(document).ready(function() {
    // 페이지 로드 시 피드 목록 불러오기
    loadFeeds();

    // 피드 작성 폼 제출 이벤트
    $("#feedForm").submit(function(e) {
        e.preventDefault();
        submitFeed();
    });

    // 트리 아이템 클릭 이벤트
    $(document).on('click', '.tree-item', function() {
        $(this).toggleClass('selected');
    });

    // 검색 기능
    $('#participantSearch').on('input', function() {
        const searchTerm = $(this).val().toLowerCase();
        $('.tree-item').each(function() {
            const itemText = $(this).text().toLowerCase();
            $(this).toggle(itemText.includes(searchTerm));
        });
    });

    // 초대 버튼 클릭 이벤트
    $('#inviteButton').click(function() {
        const selectedItems = $('.tree-item.selected');
        const invitees = selectedItems.map(function() {
            return {
                id: $(this).data('id'),
                name: $(this).text().trim(),
                type: $(this).data('type')
            };
        }).get();

        if (invitees.length > 0) {
            console.log("Selected invitees:", invitees);
            // 여기에 초대 로직을 구현합니다.
            alert(invitees.length + "명의 참석자를 초대했습니다.");
            $('#addParticipantModal').hide();
        } else {
            alert("초대할 참석자를 선택해주세요.");
        }
    });

    // 모달 닫기 기능
    $('.close').click(function() {
        $('#addParticipantModal').hide();
    });

    // 모달 외부 클릭 시 닫기
    $(window).click(function(event) {
        if (event.target == $('#addParticipantModal')[0]) {
            $('#addParticipantModal').hide();
        }
    });
});

function loadFeeds() {
    const communityNo = $("#community-container").data("id");
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
    const isAuthor = feed.employeeNo === getCurrentEmployeeNo();
    let actionsHtml = '';
    if (isAuthor) {
        actionsHtml = `
            <div class="feed-actions">
                <button class="btn btn-sm btn-outline-primary edit-btn" onclick="showEditForm(${feed.feedNo})">수정</button>
                <button class="btn btn-sm btn-outline-danger" onclick="deleteFeed(${feed.feedNo})">삭제</button>
            </div>
        `;
    }
    return `
        <div class="feed-item" id="feed-${feed.feedNo}">
            <h5>${feed.employeeName}</h5>
            <p class="feed-content">${feed.feedContent}</p>
            <div class="edit-form" style="display: none;">
                <input type="text" class="form-control edit-input" value="${feed.feedContent}">
                <button class="btn btn-sm btn-primary save-btn" onclick="updateFeed(${feed.feedNo})">저장</button>
                <button class="btn btn-sm btn-secondary cancel-btn" onclick="cancelEdit(${feed.feedNo})">취소</button>
            </div>
            <small class="text-muted">${feed.feedEnrollDate}</small>
            ${actionsHtml}
        </div>
    `;
}

function getCurrentEmployeeNo() {
    // JSP에서 설정한 전역 변수 사용
    return currentEmployeeNo;
}

function submitFeed() {
    const communityNo = $("#community-container").data("id");
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

function showEditForm(feedNo) {
    const feedElement = $(`#feed-${feedNo}`);
    feedElement.find('.feed-content').hide();
    feedElement.find('.edit-form').show();
    feedElement.find('.edit-btn').hide();
}

function cancelEdit(feedNo) {
    const feedElement = $(`#feed-${feedNo}`);
    feedElement.find('.feed-content').show();
    feedElement.find('.edit-form').hide();
    feedElement.find('.edit-btn').show();
}

function updateFeed(feedNo) {
    const feedElement = $(`#feed-${feedNo}`);
    const updatedContent = feedElement.find('.edit-input').val().trim();

    if (updatedContent === '') {
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
                feedElement.find('.feed-content').text(updatedContent).show();
                feedElement.find('.edit-form').hide();
                feedElement.find('.edit-btn').show();
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
    $('#addParticipantModal').css('display', 'block');
    loadOrganizationTree();
}

function loadOrganizationTree() {
    // 이 함수에서 서버로부터 조직도 데이터를 가져와 트리 구조를 생성합니다.
    // 예시 데이터로 대체합니다.
    const treeData = [
        { id: 1, name: "김대표 사장", type: "employee" },
        { id: 2, name: "영업본부", type: "department" },
        { id: 3, name: "사업본부", type: "department" },
        { id: 4, name: "개발본부", type: "department" },
        { id: 5, name: "경영관리본부", type: "department", children: [
            { id: 6, name: "한상우 전무", type: "employee" },
            { id: 7, name: "기획팀", type: "team", children: [
                { id: 8, name: "박현장 부장", type: "employee" },
                { id: 9, name: "김사원 과장", type: "employee" },
                { id: 10, name: "김철희 대리", type: "employee" },
                { id: 11, name: "이기술 대리", type: "employee" },
                { id: 12, name: "이더리 대리", type: "employee" },
                { id: 13, name: "전 대리", type: "employee" }
            ]}
        ]},
        { id: 14, name: "재무회계팀", type: "team" },
        { id: 15, name: "경영관리팀", type: "team" },
        { id: 16, name: "인사팀", type: "team" },
        { id: 17, name: "교육TF", type: "team" }
    ];

    const treeHtml = generateTreeHtml(treeData);
    $('#organizationTree').html(treeHtml);
}

function generateTreeHtml(items, level = 0) {
    let html = '<ul' + (level === 0 ? ' class="tree-root"' : '') + '>';
    items.forEach(item => {
        html += '<li class="tree-item" data-id="' + item.id + '" data-type="' + item.type + '">';
        html += '  '.repeat(level) + item.name;
        if (item.children) {
            html += generateTreeHtml(item.children, level + 1);
        }
        html += '</li>';
    });
    html += '</ul>';
    return html;
}