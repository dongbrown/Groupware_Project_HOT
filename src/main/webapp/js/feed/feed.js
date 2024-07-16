$(document).ready(function() {
    loadFeeds();

    $("#feedForm").submit(function(e) {
        e.preventDefault();
        submitFeed();
    });

    $('#inviteButton').click(function() {
        const participants = getSelectedParticipants();
        if (participants.length > 0) {
            inviteParticipants(participants);
        } else {
            alert("초대할 참석자를 선택해주세요.");
        }
    });

    $('.close').click(function() {
        $('#addParticipantModal').hide();
    });

    $(window).click(function(event) {
        if (event.target == $('#addParticipantModal')[0]) {
            $('#addParticipantModal').hide();
        }
    });

    $('#participantSearch').on('input', function() {
        const searchTerm = $(this).val().toLowerCase();
        $('.tree-item').each(function() {
            const itemText = $(this).text().toLowerCase();
            $(this).toggle(itemText.includes(searchTerm));
        });
    });

    // 체크박스 클릭 이벤트 수정
    $(document).on('click', '.employee-checkbox', function(e) {
        e.stopPropagation(); // 이벤트 버블링 방지
        updateSelectedParticipants();
    });

    // 부서 클릭 이벤트 수정
    $(document).on('click', '.tree-item[data-type="department"]', function(e) {
        e.stopPropagation();
        const $childrenContainer = $(this).children('ul.employee-list');
        $childrenContainer.toggle();
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
    let menuHtml = '';
    if (isAuthor) {
        menuHtml = `
            <div class="feed-menu">
                <img src="/images/menuicon.png" class="menu-icon" onclick="toggleFeedMenu(${feed.feedNo})">
                <div class="feed-menu-options" id="feedMenu-${feed.feedNo}" style="display:none;">
                    <button class="btn btn-sm btn-outline-primary edit-btn" onclick="showEditForm(${feed.feedNo})">수정</button><br>
                    <button class="btn btn-sm btn-outline-danger" onclick="deleteFeed(${feed.feedNo})">삭제</button>
                </div>
            </div>
        `;
    }
    return `
        <div class="feed-item" id="feed-${feed.feedNo}">
            <div class="feed-header">
                <h5>${feed.employeeName}</h5>
                ${menuHtml}
            </div>
            <p class="feed-content">${feed.feedContent}</p>
            <div class="edit-form" style="display: none;">
                <input type="text" class="form-control edit-input" value="${feed.feedContent}">
                <button class="btn btn-sm btn-primary save-btn" onclick="updateFeed(${feed.feedNo})">저장</button>
                <button class="btn btn-sm btn-secondary cancel-btn" onclick="cancelEdit(${feed.feedNo})">취소</button>
            </div>
            <small class="text-muted">${feed.feedEnrollDate}</small>
        </div>
    `;
}

function toggleFeedMenu(feedNo) {
    $(`#feedMenu-${feedNo}`).toggle();
}

function getCurrentEmployeeNo() {
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
                loadFeeds();
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
    loadNonParticipants();
}

function loadNonParticipants() {
    const communityNo = $("#community-container").data("id");
    $.ajax({
        url: '/community/feed/nonParticipants',
        type: 'GET',
        data: { communityNo: communityNo },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                const nonParticipants = response.nonParticipants;
                const treeData = buildEmployeeTree(nonParticipants);
                const treeHtml = generateTreeHtml(treeData);
                $('#organizationTree').html(treeHtml);
            } else {
                console.error('비참여 사원 목록 로드 실패:', response.message);
                alert('비참여 사원 목록을 불러오는 중 오류가 발생했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error('비참여 사원 목록 로드 오류:', error);
            alert('비참여 사원 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function buildEmployeeTree(employees) {
    const departmentMap = new Map();

    employees.forEach(emp => {
        if (!departmentMap.has(emp.departmentCode)) {
            departmentMap.set(emp.departmentCode, {
                id: emp.departmentCode,
                name: emp.departmentTitle,
                type: 'department',
                children: []
            });
        }

        const dept = departmentMap.get(emp.departmentCode);
        dept.children.push({
            id: emp.employeeNo,
            name: emp.employeeName,
            type: 'employee'
        });
    });

    return Array.from(departmentMap.values());
}

function generateTreeHtml(items, level = 0) {
    let html = '<ul' + (level === 0 ? ' class="tree-root"' : '') + '>';
    items.forEach(item => {
        html += `<li class="tree-item" data-id="${item.id}" data-type="${item.type}">`;
        if (item.type === 'department') {
            html += `<span class="department-name">${'  '.repeat(level)}${item.name}</span>`;
            if (item.children && item.children.length > 0) {
                html += generateTreeHtml(item.children, level + 1);
            }
        } else {
            html += `<label>
                <input type="checkbox" class="employee-checkbox" id="emp-${item.id}" value="${item.id}">
                ${item.name}
            </label>`;
        }
        html += '</li>';
    });
    html += '</ul>';
    return html;
}

function updateSelectedParticipants() {
    const $participantList = $('#participantList');
    $participantList.empty();

    $('.employee-checkbox:checked').each(function() {
        const empId = $(this).val();
        const empName = $(this).closest('label').text().trim();
        $participantList.append(`
            <li data-id="${empId}" class="list-group-item d-flex justify-content-between align-items-center">
                ${empName}
                <button type="button" class="btn-close remove-participant" aria-label="Close"></button>
            </li>
        `);
    });
}

$(document).on('click', '.remove-participant', function() {
    const empId = $(this).parent().data('id');
    $(`#emp-${empId}`).prop('checked', false);
    $(this).parent().remove();
});

function getSelectedParticipants() {
    return $('.employee-checkbox:checked').map(function() {
        return {
            id: $(this).val(),
            name: $(this).closest('label').text().trim()
        };
    }).get();
}

function inviteParticipants(participants) {
    const communityNo = $("#community-container").data("id");
    $.ajax({
        url: '/community/feed/invite',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            communityNo: communityNo,
            participants: participants
        }),
        success: function(response) {
            if (response.success) {
                alert(response.message);
                $('#addParticipantModal').hide();
                // 여기서 참석자 목록을 갱신하는 함수 호출하기
            } else {
                alert('참석자 초대에 실패했습니다: ' + response.message);
            }
        },
        error: function(xhr, status, error) {
            console.error('참석자 초대 오류:', error);
            alert('참석자 초대 중 오류가 발생했습니다.');
        }
    });
}

$(document).click(function(event) {
    if (!$(event.target).closest('.feed-menu').length) {
        $('.feed-menu-options').hide();
    }
});